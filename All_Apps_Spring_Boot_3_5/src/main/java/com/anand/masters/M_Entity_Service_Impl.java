package com.anand.masters;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.common.FilterModal;
import com.anand.common.InputValidation;
import com.google.gson.Gson;

@Service
public class M_Entity_Service_Impl implements M_Entity_Service {

	@Autowired private M_Entity_Dao mEntityDao;
	@Autowired private M_Entity_History_Dao mEntityHistoryDao;
	@Autowired private M_Location_Dao mLocationDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputValidationService;

	@Override
	public List<M_Entity> getEntityList(HttpServletRequest request, Integer offset) {
		List<M_Entity> entityListFinal = new ArrayList<M_Entity>();
		try {
			List<M_Entity> entityList = new ArrayList<M_Entity>();
			HttpSession session = request.getSession(true);
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				entityList.addAll(mEntityDao.findAll());
			} else {
				Pageable pageable = PageRequest.of(offset/20, 20);
				entityList.addAll(mEntityDao.findAll(pageable).toList());
				pageable = null;
			}
			for(M_Entity entity : entityList) {
				entity.setActionForList("");
				if((session.getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+session.getAttribute("admin"))) == 0)
					|| (session.getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+session.getAttribute("itAdmin"))) == 0)) {
					entity.setActionForList("<a href='#' title='Edit Entity' onclick='editEntity("+entity.getmEntityId()+");'><i class='fas fa-edit'></i></a>");
				}
				Integer addFlag = 1;
				Integer filterCheck = -1;
				if(request.getParameter("parentEntityFilter") != null && filterCheck.compareTo(Integer.parseInt(""+request.getParameter("parentEntityFilter"))) != 0) {
					System.out.println("1");
					if(entity.getEntitySource() == null) {
						if(entity.getmEntityId().compareTo(Long.parseLong(""+request.getParameter("parentEntityFilter"))) != 0) {
							addFlag = 0;
						}
					} else if(entity.getEntitySource().getmEntityId().compareTo(Long.parseLong(""+request.getParameter("parentEntityFilter"))) != 0) {
						addFlag = 0;
					}
				}
				if(request.getParameter("locationFilter") != null && filterCheck.compareTo(Integer.parseInt(""+request.getParameter("locationFilter"))) != 0) {
					System.out.println("2");
					if(entity.getLocationId() == null) {
						addFlag = 0;
					}
					if(entity.getLocationId() != null && entity.getLocationId().getmLocationId().compareTo(Long.parseLong(""+request.getParameter("locationFilter"))) != 0) {
						addFlag = 0;
					}
				}
				if(addFlag.compareTo(1) == 0) {
					entityListFinal.add(entity);
				}
				addFlag = null; filterCheck = null;
			}
			activenessCheck = null;
			Collections.sort(entityListFinal);
			session = null;
			entityList.clear(); entityList = null;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityListFinal;
	}

	@Override
	public List<M_Entity> getEntityByActiveStatus(Integer entityActive) {
		List<M_Entity> entityList = null;
		try {
			entityList = mEntityDao.findByEntityActive(entityActive);
			System.out.println(entityList.size());
			Collections.sort(entityList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityList;
	}

	@Override
	public List<M_Entity> getActiveParentEntityByStatus(Integer entityActive) {
		List<M_Entity> entityList = null;
		try {
			entityList = mEntityDao.findByEntitySourceAndEntityActive(null, entityActive);
			Collections.sort(entityList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityList;
	}

	@Override
	public List<M_Entity> getActiveChildEntityByStatus(Integer entityActive) {
		List<M_Entity> entityList = null;
		try {
			entityList = mEntityDao.findByEntityActiveAndEntitySourceIsNotNull(entityActive);
			Collections.sort(entityList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityList;
	}

	@Override
	public List<M_Entity> getActiveChildEntityForAppointmentBooking(Integer entityActive, HttpServletRequest request) {
		List<M_Entity> entityList = null;
		try {
			Integer activenessCheck = 1;
			M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
			if((request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0) ||
				(request.getSession(true).getAttribute("vimsAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsAdmin"))) == 0)) {
				entityList = new ArrayList<M_Entity>();
				for(M_User_Entity_Map userEntityMap: user.getUserInfoForEntity()) {
					if(userEntityMap.getUserEntityActive().compareTo(1) == 0) {
						entityList.add(userEntityMap.getEntityInfoForUsers());
					}
				}
				for(M_Entity entity: mEntityDao.findByEntitySourceAndEntityActive(user.getmEntityId().getEntitySource(),1)) {
					if(!entityList.stream().anyMatch(en -> en.getmEntityId().equals(entity.getmEntityId()))) {
						entityList.add(entity);
					}
				}
			} else if(request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0){
				entityList = mEntityDao.findByEntityActiveAndEntitySourceIsNotNull(entityActive);
			} else {
				entityList = mEntityDao.findByEntitySourceAndEntityActive(user.getmEntityId().getEntitySource(),1);
			}
			user = null; activenessCheck = null;
			Collections.sort(entityList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityList;
	}

	@Override
	@Transactional
	public String saveEntityDetails(HttpServletRequest request, M_Entity entity) {
		StringBuilder response = new StringBuilder();
		if(!inputValidationService.stringOnlyValidation(entity.getEntityName())) {
			System.out.println("name");
			response.append("error");
		}
		if(!inputValidationService.stringOnlyValidation(entity.getEntityShortName())) {
			System.out.println("name");
			response.append("error");
		}
		if(!inputValidationService.stringOnlyValidation(entity.getEntityAcronym())) {
			System.out.println("name");
			response.append("error");
		}
		if(response.toString().contains("error")) {
			response.setLength(0);
			response.append("error");
			return response.toString();
		}
		M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		if(entity.getmEntityId() != null) {
			M_Entity currEntity = mEntityDao.findById(Long.parseLong(""+entity.getmEntityId())).get();
			Integer proceedFlag = 0;
			List<M_Entity> entityExists = null;
			if(entity.getParentEntityId() != null && entity.getParentEntityId().compareTo(0) != 0) {
				entityExists = mEntityDao.findByEntitySourceAndLocationId(mEntityDao.findById(Long.parseLong(""+entity.getParentEntityId())).get(), mLocationDao.findById(Long.parseLong(""+entity.getLoationIdTemp())).get());
				if(entityExists != null && entityExists.size() != 0) {
					for(M_Entity entityDetails : entityExists) {
						if(currEntity.getEntityName().equalsIgnoreCase(entityDetails.getEntityName()) && 
							currEntity.getmEntityId().compareTo(entityDetails.getmEntityId()) != 0 &&
							currEntity.getLocationId().getmLocationId().compareTo(entityDetails.getLocationId().getmLocationId()) == 0) {
							proceedFlag = 1;
							response.append("entityLocationExists");
						}
					}
				}
			} else {
				entityExists = mEntityDao.findByEntityName(entity.getEntityName());
				if(entityExists != null && entityExists.size() != 0) {
					for(M_Entity entityDetails : entityExists) {
						if(entity.getEntityName().equalsIgnoreCase(entityDetails.getEntityName()) && currEntity.getmEntityId().compareTo(entityDetails.getmEntityId()) != 0) {
							proceedFlag = 1;
							response.append("entityExists");
						}
					}
				}
			}
			entityExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				M_Entity_History entityHistory = new M_Entity_History();
				entityHistory.setParentEntityId(currEntity);
				entityHistory.setEntityActive(currEntity.getEntityActive());
				entityHistory.setEntityName(currEntity.getEntityName());
				entityHistory.setEntityShortName(currEntity.getEntityShortName());
				entityHistory.setEntityAcronym(currEntity.getEntityAcronym());
				if(currEntity.getEntitySource() != null) {
					entityHistory.setEntitySource(currEntity.getEntitySource());
				} else {
					entityHistory.setEntitySource(null);
				}
				if(currEntity.getLocationId() != null) {
					entityHistory.setLocationId(currEntity.getLocationId());
				} else {
					entityHistory.setLocationId(null);
				}
				entityHistory.setmUserId(user);
				if(currEntity.getUpdatedOn() != null) {
					entityHistory.setCreatedOn(currEntity.getUpdatedOn());
				} else {
					entityHistory.setCreatedOn(currEntity.getCreatedOn());
				}
				mEntityHistoryDao.save(entityHistory);
				entityHistory = null;

				currEntity.setEntityName(entity.getEntityName());
				currEntity.setEntityShortName(entity.getEntityShortName());
				currEntity.setEntityAcronym(entity.getEntityAcronym());
				if(entity.getParentEntityId() != null && entity.getParentEntityId().compareTo(0) != 0) {
					currEntity.setEntitySource(mEntityDao.findById(Long.parseLong(""+entity.getParentEntityId())).get());
				} else {
					currEntity.setEntitySource(null);
				}
				if(entity.getLoationIdTemp() != null && entity.getLoationIdTemp().compareTo(-1) != 0) {
					currEntity.setLocationId(mLocationDao.findById(Long.parseLong(""+entity.getLoationIdTemp())).get());
				} else {
					currEntity.setLocationId(null);
				}
				currEntity.setEntityActive(entity.getEntityActive());
				currEntity.setmUserIdUpdated(user);
				currEntity.setUpdatedOn(currDate);
				mEntityDao.save(currEntity);
				currEntity = null;
				response.append("edit");
			}
			proceedFlag = null;
		} else {
			Integer proceedFlag = 0;
			List<M_Entity> entityExists = null;
			if(entity.getParentEntityId() != null && entity.getParentEntityId().compareTo(0) != 0) {
				entityExists = mEntityDao.findByEntityNameAndEntitySourceAndLocationId(entity.getEntityName(), mEntityDao.findById(Long.parseLong(""+entity.getParentEntityId())).get(), mLocationDao.findById(Long.parseLong(""+entity.getLoationIdTemp())).get());
				if(entityExists != null && entityExists.size() != 0) {
					proceedFlag = 1;
				}
				response.append("entityLocationExists");
			} else {
				entityExists = mEntityDao.findByEntityName(entity.getEntityName());
				if(entityExists != null && entityExists.size() != 0) {
					proceedFlag = 1;
				}
				response.append("entityExists");
			}
			if(proceedFlag.compareTo(0) == 0) {
				if(entity.getParentEntityId() != null && entity.getParentEntityId().compareTo(0) != 0) {
					entity.setEntitySource(mEntityDao.findById(Long.parseLong(""+entity.getParentEntityId())).get());
				} else {
					entity.setEntitySource(null);
				}
				if(entity.getLoationIdTemp() != null && entity.getLoationIdTemp().compareTo(-1) != 0) {
					entity.setLocationId(mLocationDao.findById(Long.parseLong(""+entity.getLoationIdTemp())).get());
				} else {
					entity.setLocationId(null);
				}
				entity.setmUserId(user);
				entity.setCreatedOn(currDate);
				mEntityDao.save(entity);
				response.append("add");
			}
			entityExists = null;
		}
		currDate = null; user = null;
		return response.toString();
	}

	@Override
	public String getEntityDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> entityDetails = new HashMap<String, String>();
		try {
			/*M_Entity entity = mEntityDao.getOne(Integer.parseInt(""+request.getParameter("mEntityId")));*/
			M_Entity entity = mEntityDao.findById(Long.parseLong(""+request.getParameter("mEntityId"))).get();
			entityDetails.put("entityName", entity.getEntityName());
			entityDetails.put("entityShortName", entity.getEntityShortName());
			entityDetails.put("entityActive", ""+entity.getEntityActive());
			entityDetails.put("entityAcronym", entity.getEntityAcronym());
			if(entity.getEntitySource() != null) {
				entityDetails.put("parentEntityId", ""+entity.getEntitySource().getmEntityId());
			} else {
				entityDetails.put("parentEntityId", "0");
			}
			if(entity.getLocationId() != null) {
				entityDetails.put("loationIdTemp", ""+entity.getLocationId().getmLocationId());
			} else {
				entityDetails.put("loationIdTemp", "-1");
			}
			Gson gson = new Gson();
			response = gson.toJson(entityDetails);
			gson = null; entity = null; entityDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@Override
	public List<M_Entity> getActiveParentEntityByStatusAndFilter(Integer entityActive, FilterModal filterModal) {
		List<M_Entity> entityList = null;
		try {
			entityList = mEntityDao.findByEntitySourceAndEntityActive(null, entityActive);
			if(filterModal.getParentEntityId() != null && filterModal.getParentEntityId().compareTo(-1l) != 0) {
				entityList.stream().filter(parentEntity -> parentEntity.getmEntityId().compareTo(filterModal.getParentEntityId()) == 0).collect(Collectors.toList());
			}
			Collections.sort(entityList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityList;
	}

	@Override
	public List<M_Entity> getActiveChildEntityByStatusAndFilter(Integer entityActive, FilterModal filterModal) {
		List<M_Entity> entityList = null;
		try {
			entityList = mEntityDao.findByEntityActiveAndEntitySourceIsNotNull(entityActive);
			if(filterModal.getParentEntityId() != null && filterModal.getParentEntityId().compareTo(-1l) != 0) {
				entityList = entityList.stream().filter(parentEntity -> parentEntity.getEntitySource().getmEntityId().compareTo(filterModal.getParentEntityId()) == 0).collect(Collectors.toList());
			}
			if(filterModal.getChildEntityId() != null && filterModal.getChildEntityId().compareTo(-1l) != 0) {
				System.out.println("came here 1: "+entityList.size());
				entityList = entityList.stream().filter(parentEntity -> parentEntity.getmEntityId().compareTo(filterModal.getChildEntityId()) == 0).collect(Collectors.toList());
				System.out.println("came here 1: "+entityList.size());
			}
			Collections.sort(entityList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return entityList;
	}
}