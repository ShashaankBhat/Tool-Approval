package com.anand.ta;

import java.util.Date;

import com.anand.ta1.Ta_Status;

import jakarta.persistence.*;

@Entity
@Table(name = "ta_request_status_log")
public class Ta_Request_Status_Log {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ta_request_status_log_id", nullable = false)
	private Long taRequestStatusLogId;

	@OneToOne
	@JoinColumn(name = "ta_tool_request_id", nullable = false)
	private Ta_Tool_Request taToolRequestId;

	@OneToOne
	@JoinColumn(name = "from_status_id", nullable = true)
	private Ta_Status fromStatusId;

	@OneToOne
	@JoinColumn(name = "to_status_id", nullable = false)
	private Ta_Status toStatusId;

	@Column(name = "changed_on")
	private Date changedOn;

	public Long getTaRequestStatusLogId() {
		return taRequestStatusLogId;
	}

	public void setTaRequestStatusLogId(Long taRequestStatusLogId) {
		this.taRequestStatusLogId = taRequestStatusLogId;
	}

	public Ta_Tool_Request getTaToolRequestId() {
		return taToolRequestId;
	}

	public void setTaToolRequestId(Ta_Tool_Request taToolRequestId) {
		this.taToolRequestId = taToolRequestId;
	}

	public Ta_Status getFromStatusId() {
		return fromStatusId;
	}

	public void setFromStatusId(Ta_Status fromStatusId) {
		this.fromStatusId = fromStatusId;
	}

	public Ta_Status getToStatusId() {
		return toStatusId;
	}

	public void setToStatusId(Ta_Status toStatusId) {
		this.toStatusId = toStatusId;
	}

	public Date getChangedOn() {
		return changedOn;
	}

	public void setChangedOn(Date changedOn) {
		this.changedOn = changedOn;
	}
}
