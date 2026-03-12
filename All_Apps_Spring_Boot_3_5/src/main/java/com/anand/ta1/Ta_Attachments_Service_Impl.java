package com.anand.ta1;

import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;

@Service
public class Ta_Attachments_Service_Impl implements Ta_Attachments_Service {

    @Autowired
    private Ta_Attachments_Dao attachmentsDao;

    @Autowired
    private Ta_Tool_Request_Dao_1 toolRequestDao;

    @Autowired
    private M_User_Dao mUserDao;

    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    /* =====================================================
       UPLOAD ATTACHMENT
       ===================================================== */

    @Override
    @Transactional
    public String uploadAttachment(HttpServletRequest request,
                                   Long toolRequestId,
                                   MultipartFile file,
                                   Integer section) {

        try {

            /* ---------- BASIC VALIDATION ---------- */

            if (file == null || file.isEmpty()) {
                return "error";
            }

            if (file.getSize() > MAX_FILE_SIZE) {
                return "sizeError";
            }

            /* ---------- TOOL REQUEST FETCH ---------- */

            Optional<Ta_Tool_Request_1> toolRequestOpt =
                    toolRequestDao.findById(toolRequestId);

            if(!toolRequestOpt.isPresent()) {
                return "error";
            }

            Ta_Tool_Request_1 toolRequest = toolRequestOpt.get();

            if (toolRequest == null) {
                return "error";
            }

            if(toolRequest == null ||
                    toolRequest.getRequestActive() == null ||
                    toolRequest.getRequestActive().compareTo(1) != 0){
                return "error";
            }

            /* ---------- LOGGED IN USER ---------- */

            Authentication authentication =
                    SecurityContextHolder.getContext().getAuthentication();
            if(authentication == null || authentication.getName() == null){
                return "error";
            }
            String loginId = authentication.getName();

            M_User user =
                    mUserDao.findByUserLoginId(
                            loginId);

            if (user == null) {
                return "error";
            }

            /* ---------- BUILD ATTACHMENT ENTITY ---------- */

            List<Ta_Attachments> existingAttachments =
                    attachmentsDao.findByToolRequest_TaToolRequestIdAndAttachmentSectionAndAttachmentActive(
                            toolRequestId,
                            section,
                            Ta_Attachments.ACTIVE);
            if(existingAttachments != null && existingAttachments.size() >= Ta_Attachments.MAX_ATTACHMENTS_PER_SECTION){
                return "limitExceeded";
            }

            Ta_Attachments attachment = new Ta_Attachments();

            attachment.setToolRequest(toolRequest);

            String originalName = file.getOriginalFilename();
            if(originalName == null || originalName.trim().isEmpty()){
                originalName = "attachment_" + System.currentTimeMillis();
            }

            String extension = "";
            if(originalName.contains(".")){
                extension = originalName.substring(originalName.lastIndexOf(".")+1)
                        .toLowerCase();
            }
            List allowedExtensions =
                    Arrays.asList("pdf","doc","docx","xls","xlsx","png","jpg","jpeg");
            if(!allowedExtensions.contains(extension)){
                return "error";
            }

            attachment.setFileName(originalName);

            if (originalName != null && originalName.contains(".")) {

                attachment.setFileExtension(extension);
            }

            attachment.setFileData(file.getBytes());

            attachment.setFileSizeKb((int) (file.getSize() / 1024));

            attachment.setAttachmentSection(section);

            attachment.setAttachmentActive(1);

            attachment.setUploadedBy(user);

            attachment.setUploadedOn(new Date());

            /* ---------- SAVE ---------- */

            attachmentsDao.save(attachment);

            return "success";

        } catch (Exception e) {

            e.printStackTrace();

            return "error";
        }
    }

    /* =====================================================
       DOWNLOAD ATTACHMENT
       ===================================================== */

    @Override
    public byte[] downloadAttachment(Long attachmentId) {

        byte[] fileData = null;

        try {

            Optional<Ta_Attachments> attachmentOpt =
                    attachmentsDao.findById(attachmentId);

            if(!attachmentOpt.isPresent()) {
                return null;
            }

            Ta_Attachments attachment = attachmentOpt.get();

            if(attachment.getToolRequest() == null ||
                    attachment.getToolRequest().getRequestActive() == null ||
                    attachment.getToolRequest().getRequestActive().compareTo(1) != 0){
                return null;
            }

            if (attachment != null &&
                    attachment.getAttachmentActive().compareTo(1) == 0) {

                fileData = attachment.getFileData();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return fileData;
    }

    /* =====================================================
       GET FILE NAME
       ===================================================== */

    @Override
    public String getAttachmentFileName(Long attachmentId) {

        String fileName = "";

        try {

            Optional<Ta_Attachments> attachmentOpt =
                    attachmentsDao.findById(attachmentId);

            if(!attachmentOpt.isPresent()) {
                return null;
            }

            Ta_Attachments attachment = attachmentOpt.get();

            if(attachment.getToolRequest() == null ||
                    attachment.getToolRequest().getRequestActive() == null ||
                    attachment.getToolRequest().getRequestActive().compareTo(1) != 0){
                return null;
            }

            if (attachment != null &&
                    attachment.getAttachmentActive().compareTo(1) == 0) {

                fileName = attachment.getFileName();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return fileName;
    }

    /* =====================================================
       GET ATTACHMENTS BY SECTION
       ===================================================== */

    @Override
    public List<Ta_Attachments> getAttachmentListBySection(Long toolRequestId,
                                                           Integer section) {

        List<Ta_Attachments> attachmentList = null;

        try {

            attachmentList =
                    attachmentsDao
                            .findByToolRequest_TaToolRequestIdAndAttachmentSectionAndAttachmentActive(
                                    toolRequestId,
                                    section,
                                    1);

            if (attachmentList != null) {

                for(Ta_Attachments attachment : attachmentList){
                    attachment.setFileData(null);
                }

                for (Ta_Attachments attachment : attachmentList) {

                    attachment.setActionForList(
                            "<button type='button' class='btn btn-sm btn-link text-muted delete-attachment'>" +
                                    "<i class='fas fa-times'></i></button>");
                }

                Collections.sort(attachmentList);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return attachmentList;
    }

    /* =====================================================
       DELETE ATTACHMENT (SOFT DELETE)
       ===================================================== */

    @Override
    @Transactional
    public String deleteAttachment(HttpServletRequest request,
                                   Long attachmentId) {

        try {

            Optional<Ta_Attachments> attachmentOpt =
                    attachmentsDao.findById(attachmentId);

            if(!attachmentOpt.isPresent()) {
                return "error";
            }

            Ta_Attachments attachment = attachmentOpt.get();

            if(attachment.getToolRequest() == null ||
                    attachment.getToolRequest().getRequestActive() == null ||
                    attachment.getToolRequest().getRequestActive().compareTo(1) != 0){
                return "error";
            }

            if (attachment == null) {
                return "error";
            }

            /* ---------- SOFT DELETE ---------- */

            attachment.setAttachmentActive(0);

            attachment.setFileData(null);

            attachmentsDao.save(attachment);

            return "success";

        } catch (Exception e) {

            e.printStackTrace();

            return "error";
        }
    }

	@Override
	@Transactional
	public void saveAttachments(
			Ta_Tool_Request_1 request,
			MultipartFile[] files,
			Integer section){

		try{

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();

			if(auth == null || auth.getName() == null){
				return;
			}

			M_User user = mUserDao.findByUserLoginId(auth.getName());

			for(MultipartFile file : files){

				if(file == null || file.isEmpty()){
					continue;
				}

				String originalName = file.getOriginalFilename();

				if(originalName == null || originalName.trim().isEmpty()){
					originalName = "attachment";
				}

				String extension = "";

				int dotIndex = originalName.lastIndexOf('.');

				if(dotIndex > 0){
					extension = originalName.substring(dotIndex + 1).toLowerCase();
				}

				Ta_Attachments attachment = new Ta_Attachments();

				attachment.setToolRequest(request);
				attachment.setFileName(originalName);
				attachment.setFileExtension(extension);
				attachment.setFileData(file.getBytes());
				attachment.setFileSizeKb((int)(file.getSize() / 1024));
				attachment.setUploadedBy(user);
				attachment.setUploadedOn(new Date());
				attachment.setAttachmentSection(section);
				attachment.setAttachmentActive(1);

				attachmentsDao.save(attachment);

			}

		}catch(Exception e){
			e.printStackTrace();
		}

	}
}
