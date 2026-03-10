package com.anand.ta;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_attachments")
public class Ta_Attachments {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ta_attachment_id", nullable = false)
	private Long taAttachmentId;

	@ManyToOne
	@JoinColumn(name = "ta_tool_request_id", nullable = false)
	private Ta_Tool_Request toolRequest;

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

	@Enumerated(EnumType.STRING)
	@Column(name = "attachment_section", nullable = false)
	private AttachmentSection attachmentSection;

	/* ================= NEW FIELDS FOR ATTACHMENT LIFECYCLE ================= */

	@Column(name = "attachment_status", nullable = false)
	private String attachmentStatus;

	@Column(name = "attachment_active", nullable = false)
	private Integer attachmentActive;

	/* ================= GETTERS & SETTERS ================= */

	public Long getTaAttachmentId() {
		return taAttachmentId;
	}

	public void setTaAttachmentId(Long taAttachmentId) {
		this.taAttachmentId = taAttachmentId;
	}

	public AttachmentSection getAttachmentSection() {
    	return attachmentSection;
	}

	public void setAttachmentSection(AttachmentSection attachmentSection) {
    	this.attachmentSection = attachmentSection;
	}

	public String getAttachmentStatus() {
		return attachmentStatus;
	}

	public void setAttachmentStatus(String attachmentStatus) {
		this.attachmentStatus = attachmentStatus;
	}

	public Integer getAttachmentActive() {
		return attachmentActive;
	}

	public void setAttachmentActive(Integer attachmentActive) {
		this.attachmentActive = attachmentActive;
	}

	public Ta_Tool_Request getToolRequest() {
		return toolRequest;
	}

	public void setToolRequest(Ta_Tool_Request toolRequest) {
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
}
