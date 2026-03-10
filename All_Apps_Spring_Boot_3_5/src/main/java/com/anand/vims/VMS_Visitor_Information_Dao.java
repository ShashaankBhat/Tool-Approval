package com.anand.vims;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface VMS_Visitor_Information_Dao extends JpaRepository<VMS_Visitor_Information, Long> {
    @Query(value="select * from vms_visitor_information order by visitor_information_id desc limit 20 offset ?", nativeQuery = true)
    List<VMS_Visitor_Information> getVisitorInfoByOffset(Integer offset);

    List<VMS_Visitor_Information> findByVisitorActive(Integer visitorInfoActive);

    List<VMS_Visitor_Information> findByVisitorInformationDetailAndVisitorActive(VMS_Visitor visitorId, Integer visitorInfoActive);

    List<VMS_Visitor_Information> findByOutTimeIsNull();

    @Query(value = "select * from vms_visitor_information inner join vms_visitor on vms_visitor.visitor_id = vms_visitor_information.visitor_id where vms_visitor_information.visitor_active = 1 and vms_visitor_information.out_time is null "
    		+ " and vms_visitor.m_entity_id = ?1 and ((cast(vms_visitor.meeting_date as date) = ?2) or (?2 between cast(vms_visitor.meeting_date as date) and cast(vms_visitor.visitor_allowed_until as date)))",nativeQuery = true)
    List<VMS_Visitor_Information> findVisitorInformationByDateAndEntity(Long mEntityId, String date);
}