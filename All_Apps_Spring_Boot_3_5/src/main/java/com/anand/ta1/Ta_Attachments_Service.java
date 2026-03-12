package com.anand.ta1;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface Ta_Attachments_Service {

    String uploadAttachment(HttpServletRequest request,
                            Long toolRequestId,
                            MultipartFile file,
                            Integer section);

    byte[] downloadAttachment(Long attachmentId);

    String getAttachmentFileName(Long attachmentId);

    List<Ta_Attachments> getAttachmentListBySection(Long toolRequestId,
                                                    Integer section);

    String deleteAttachment(HttpServletRequest request,
                            Long attachmentId);

    void saveAttachments(
            Ta_Tool_Request_1 request,
            MultipartFile[] files,
            Integer section
    );
}
