package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/**
 * Service for handling Tool Request attachments (upload, download, list, delete)
 */
public interface Ta_Attachments_Service {
    
    /**
     * Upload a file attachment for a tool request
     * @param toolRequestId ID of the tool request
     * @param file The file to upload
     * @param request HTTP request for security context
     * @return Saved attachment ID or error message
     */
    String uploadAttachment(Long toolRequestId,
                            MultipartFile file,
                            String section,
                            HttpServletRequest request);
    
    /**
     * Download attachment file by ID
     * @param attachmentId ID of the attachment
     * @return Byte array of file data, or null if not found
     */
    byte[] downloadAttachment(Long attachmentId);
    
    /**
     * Get file name for attachment
     * @param attachmentId ID of the attachment
     * @return File name with extension
     */
    String getAttachmentFileName(Long attachmentId);
    
    /**
     * Get list of all attachments for a tool request
     * @param toolRequestId ID of the tool request
     * @return List of attachment records
     */
    List<Ta_Attachments> getAttachmentList(Long toolRequestId);

    List<Ta_Attachments> getAttachmentListBySection(Long toolRequestId,
                                                    String section);
    
    /**
     * Delete an attachment
     * @param attachmentId ID of the attachment to delete
     * @param request HTTP request for security/audit
     * @return Success or error message
     */
    String deleteAttachment(Long attachmentId, HttpServletRequest request);
    
    /**
     * Get total attachment size for a tool request (in KB)
     * @param toolRequestId ID of the tool request
     * @return Total size in KB
     */
    Long getTotalAttachmentSize(Long toolRequestId);
}
