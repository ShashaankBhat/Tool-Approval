package com.anand.vims;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.anand.masters.M_Entity;
import com.anand.masters.M_User;

import java.util.Date;
import java.util.List;

public interface VMS_Visitor_Dao extends JpaRepository<VMS_Visitor, Long>{
    @Query(value="select * from vms_visitor order by visitor_id desc limit 20 offset ?", nativeQuery = true)
    List<VMS_Visitor> getVisitorWithOffset(Integer offset);

    List<VMS_Visitor> findByVisitorName(String visitorName);

    List<VMS_Visitor> findByVisitorActive(Integer visitorActive);

    List<VMS_Visitor> findByVisitingLocation(M_Entity visitingLocation);

    List<VMS_Visitor> findByVisitingLocationAndMeetingDate(M_Entity visitingLocation, Date meetingDate);

    List<VMS_Visitor> findByVisitingLocationAndMeetingDateAndHostName(M_Entity visitingLocation, Date meetingDate, M_User hostName);

    @Query(value = "select * from vms_visitor where m_entity_id = ?1 and ((cast(meeting_date as date) = ?2) or (?2 between cast(meeting_date as date) and cast(visitor_allowed_until as date)))",nativeQuery = true)
    List<VMS_Visitor> getVisitorWithDateAndEntityId(Long mEntityId, String Date);

    /* Get Appointment List For Employee */
    @Query(value = "select * from vms_visitor where m_user_id = ?1 and (cast(meeting_date as date) = ?2) or (?2 between cast(meeting_date as date) and cast(visitor_allowed_until as date))", nativeQuery = true)
    List<VMS_Visitor> getVisitorWithCurrentDate(Long userId, String date);

    /* Get Appointment List For Receptionist with entity & host */
    @Query(value = "select * from vms_visitor where m_entity_id = ?1 and m_user_id = ?3 and ((cast(meeting_date as date) = ?2) or (?2 between cast(meeting_date as date) and cast(visitor_allowed_until as date)))",nativeQuery = true)
    List<VMS_Visitor> getVisitorWithDateAndEntityIdAndUserID(Long mEntityId, String Date, Long userId);
}
