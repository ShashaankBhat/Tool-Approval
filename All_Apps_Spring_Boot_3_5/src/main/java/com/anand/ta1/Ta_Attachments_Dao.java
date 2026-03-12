package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Attachments_Dao extends JpaRepository<Ta_Attachments, Long> {

    List<Ta_Attachments> findByToolRequest_TaToolRequestIdAndAttachmentActive(
            Long toolRequestId,
            Integer active);

    List<Ta_Attachments> findByToolRequest_TaToolRequestIdAndAttachmentSectionAndAttachmentActive(
            Long toolRequestId,
            Integer section,
            Integer active);
}