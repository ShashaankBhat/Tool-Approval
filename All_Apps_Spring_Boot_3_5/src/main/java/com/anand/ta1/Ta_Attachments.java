package com.anand.ta1;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_attachments")
public class Ta_Attachments implements Comparable<Ta_Attachments> {

    @Override
    public int compareTo(Ta_Attachments o) {
        return o.getTaAttachmentId().compareTo(this.taAttachmentId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_attachment_id")
    private Long taAttachmentId;

    @ManyToOne
    @JoinColumn(name = "ta_tool_request_id", nullable = false)
    private Ta_Tool_Request_1 toolRequest;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_extension")
    private String fileExtension;

    @Lob
    @Column(name = "file_data")
    private byte[] fileData;

    @Column(name = "file_size_kb")
    private Integer fileSizeKb;

    @ManyToOne
    @JoinColumn(name = "uploaded_by")
    private M_User uploadedBy;

    @Column(name = "uploaded_on")
    private Date uploadedOn;

    @Column(name = "attachment_section")
    private Integer attachmentSection;

    @Column(name = "attachment_active")
    private Integer attachmentActive;

    @Transient
    private String actionForList;

    public static final int SECTION_BACKGROUND = 1;
    public static final int SECTION_REMARK = 2;

    public static final int ACTIVE = 1;
    public static final int INACTIVE = 0;
    public static final Integer MAX_ATTACHMENTS_PER_SECTION = 3;

    public Long getTaAttachmentId() {
        return taAttachmentId;
    }

    public void setTaAttachmentId(Long taAttachmentId) {
        this.taAttachmentId = taAttachmentId;
    }

    public Ta_Tool_Request_1 getToolRequest() {
        return toolRequest;
    }

    public void setToolRequest(Ta_Tool_Request_1 toolRequest) {
        this.toolRequest = toolRequest;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileExtension() {
        return fileExtension;
    }

    public void setFileExtension(String fileExtension) {
        this.fileExtension = fileExtension;
    }

    public byte[] getFileData() {
        return fileData;
    }

    public void setFileData(byte[] fileData) {
        this.fileData = fileData;
    }

    public Integer getFileSizeKb() {
        return fileSizeKb;
    }

    public void setFileSizeKb(Integer fileSizeKb) {
        this.fileSizeKb = fileSizeKb;
    }

    public M_User getUploadedBy() {
        return uploadedBy;
    }

    public void setUploadedBy(M_User uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public Date getUploadedOn() {
        return uploadedOn;
    }

    public void setUploadedOn(Date uploadedOn) {
        this.uploadedOn = uploadedOn;
    }

    public Integer getAttachmentSection() {
        return attachmentSection;
    }

    public void setAttachmentSection(Integer attachmentSection) {
        this.attachmentSection = attachmentSection;
    }

    public Integer getAttachmentActive() {
        return attachmentActive;
    }

    public void setAttachmentActive(Integer attachmentActive) {
        this.attachmentActive = attachmentActive;
    }

    public String getActionForList() {
        return actionForList;
    }

    public void setActionForList(String actionForList) {
        this.actionForList = actionForList;
    }
}
