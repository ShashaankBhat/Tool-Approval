package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import com.anand.common.FilterModal;

public interface M_Entity_Service {

	List<M_Entity> getEntityList(HttpServletRequest request, Integer offset);

	List<M_Entity> getEntityByActiveStatus(Integer entityActive);

	List<M_Entity> getActiveParentEntityByStatus(Integer entityActive);

	List<M_Entity> getActiveChildEntityByStatus(Integer entityActive);

	List<M_Entity> getActiveChildEntityForAppointmentBooking(Integer entityActive, HttpServletRequest reqeust);

	String saveEntityDetails(HttpServletRequest request, M_Entity entity);

	String getEntityDetails(HttpServletRequest request);

	List<M_Entity> getActiveParentEntityByStatusAndFilter(Integer entityActive, FilterModal filterModal);

	List<M_Entity> getActiveChildEntityByStatusAndFilter(Integer entityActive, FilterModal filterModal);
}
