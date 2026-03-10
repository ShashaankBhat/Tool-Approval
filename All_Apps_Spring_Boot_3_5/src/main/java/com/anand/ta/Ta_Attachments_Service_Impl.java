package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Implementation of attachment service for tool requests
 */
@Service
public class Ta_Attachments_Service_Impl implements Ta_Attachments_Service {

    @Autowired
    private Ta_Attachments_Dao attachmentsDao;

    @Autowired
    private Ta_Tool_Request_Dao toolRequestDao;

    @Autowired
    private M_User_Dao mUserDao;

    private static final long MAX_FILE_SIZE_KB = 5120; // 5 MB limit

    @Override
    @Transactional
    public String uploadAttachment(Long toolRequestId,
                                   MultipartFile file,
                                   String section,
                                   HttpServletRequest request) {
        try {
            if (file == null || file.isEmpty()) {
                return "File is empty";
            }

            if (section == null ||
                (!section.equals("BACKGROUND") &&
                 !section.equals("REMARK"))) {
                return "Invalid attachment section";
            }

            long fileSizeKb = file.getSize() / 1024;
            if (fileSizeKb > MAX_FILE_SIZE_KB) {
                return "File size exceeds 5MB limit";
            }

            AttachmentSection attachmentSection =
                    AttachmentSection.valueOf(section);

            long existingSectionSize = attachmentsDao
                .findByToolRequest_TaToolRequestIdAndAttachmentSectionOrderByUploadedOnDesc(
                        toolRequestId, attachmentSection)
                .stream()
                .filter(a -> a.getAttachmentActive() != null
                          && a.getAttachmentActive() == 1)
                .mapToLong(a -> a.getFileSizeKb() != null
                        ? a.getFileSizeKb() : 0)
                .sum();

            if ((existingSectionSize + fileSizeKb) > MAX_FILE_SIZE_KB) {
                return "Section size exceeds 5MB limit";
            }

            Optional<Ta_Tool_Request> toolRequest =
                    toolRequestDao.findById(toolRequestId);

            if (!toolRequest.isPresent()) {
                return "Tool request not found";
            }

            String currentUser =
                    SecurityContextHolder.getContext()
                            .getAuthentication()
                            .getName();

            M_User user = mUserDao.findByUserLoginId(currentUser);
            if (user == null) {
                return "User not found";
            }

            Ta_Attachments attachment = new Ta_Attachments();
            attachment.setToolRequest(toolRequest.get());
            attachment.setFileName(file.getOriginalFilename());

            String originalName = file.getOriginalFilename();
            if (originalName != null && originalName.contains(".")) {
                String extension =
                        originalName.substring(originalName.lastIndexOf(".") + 1);
                attachment.setFileExtension(extension);
            }

            attachment.setFileData(file.getBytes());
            attachment.setFileSizeKb((int) fileSizeKb);
            attachment.setUploadedBy(user);
            attachment.setUploadedOn(new Date());
            attachment.setAttachmentSection(attachmentSection);

            /* ================= NEW LIFECYCLE FIELDS ================= */
            attachment.setAttachmentStatus("TEMP");
            attachment.setAttachmentActive(1);

            Ta_Attachments savedAttachment =
                    attachmentsDao.save(attachment);

            return "success:" + savedAttachment.getTaAttachmentId();

        } catch (Exception e) {
            e.printStackTrace();
            return "Error uploading file: " + e.getMessage();
        }
    }

    @Override
    public byte[] downloadAttachment(Long attachmentId) {
        Optional<Ta_Attachments> attachment =
                attachmentsDao.findByTaAttachmentId(attachmentId);

        if (attachment.isPresent()
            && attachment.get().getAttachmentActive() == 1) {
            return attachment.get().getFileData();
        }
        return null;
    }

    @Override
    public String getAttachmentFileName(Long attachmentId) {
        Optional<Ta_Attachments> attachment =
                attachmentsDao.findByTaAttachmentId(attachmentId);

        if (attachment.isPresent()
            && attachment.get().getAttachmentActive() == 1) {
            return attachment.get().getFileName();
        }
        return null;
    }

    @Override
    public List<Ta_Attachments> getAttachmentList(Long toolRequestId) {

    Ta_Tool_Request tr = toolRequestDao.findById(toolRequestId).orElse(null);
    if (tr == null) return List.of();

    String statusName = tr.getStatus().getTaStatusName();

    return attachmentsDao
            .findByToolRequest_TaToolRequestId(toolRequestId)
            .stream()
            .filter(a -> a.getAttachmentActive() != null
                      && a.getAttachmentActive() == 1)
            .filter(a -> {

                // Pending / Approved → only FINAL
                if ("Submitted".equals(statusName)
                        || "Approved".equals(statusName)) {
                    return "FINAL".equals(a.getAttachmentStatus());
                }

                // Draft / Rejected / Tool Entered / Cost Entered
                return true;
            })
            .collect(Collectors.toList());
    }

    @Override
    public List<Ta_Attachments> getAttachmentListBySection(Long toolRequestId,
                                                           String section) {

        Ta_Tool_Request tr = toolRequestDao.findById(toolRequestId).orElse(null);
        if (tr == null) return List.of();

        AttachmentSection attachmentSection =
                AttachmentSection.valueOf(section);

        String statusName = tr.getStatus().getTaStatusName();

        return attachmentsDao
                .findByToolRequest_TaToolRequestIdAndAttachmentSectionOrderByUploadedOnDesc(
                        toolRequestId, attachmentSection)
                .stream()
                .filter(a -> a.getAttachmentActive() != null
                          && a.getAttachmentActive() == 1)
                .filter(a -> {

                    // Pending / Approved → only FINAL
                    if ("Submitted".equals(statusName)
                            || "Approved".equals(statusName)) {
                        return "FINAL".equals(a.getAttachmentStatus());
                    }

                    // Draft / Rejected / Tool Entered / Cost Entered
                    return true;
                })
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public String deleteAttachment(Long attachmentId,
                                   HttpServletRequest request) {

        Optional<Ta_Attachments> attachment =
                attachmentsDao.findByTaAttachmentId(attachmentId);

        if (attachment.isPresent()) {
            Ta_Attachments att = attachment.get();
            att.setAttachmentActive(0);
            attachmentsDao.save(att);
            return "success";
        }

        return "Attachment not found";
    }

    @Override
    public Long getTotalAttachmentSize(Long toolRequestId) {

        return attachmentsDao
                .findByToolRequest_TaToolRequestId(toolRequestId)
                .stream()
                .filter(a -> a.getAttachmentActive() != null
                          && a.getAttachmentActive() == 1)
                .mapToLong(a -> a.getFileSizeKb() != null
                        ? a.getFileSizeKb() : 0)
                .sum();
    }
}
