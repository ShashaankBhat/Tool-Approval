package com.anand.ta;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface Ta_Attachments_Dao extends JpaRepository<Ta_Attachments, Long> {

    /* ================= BASIC FETCH ================= */

    List<Ta_Attachments>
    findByToolRequest_TaToolRequestId(Long requestId);

    List<Ta_Attachments>
    findByToolRequest_TaToolRequestIdAndAttachmentSectionOrderByUploadedOnDesc(
            Long toolRequestId,
            AttachmentSection attachmentSection);

    Optional<Ta_Attachments>
    findByTaAttachmentId(Long attachmentId);

    List<Ta_Attachments>
    findByFileNameContainingIgnoreCase(String fileName);

    /* ================= TEMP → FINAL CONVERSION ================= */

    @Modifying
    @Query("UPDATE Ta_Attachments a " +
           "SET a.attachmentStatus = 'FINAL' " +
           "WHERE a.toolRequest.taToolRequestId = :toolRequestId " +
           "AND a.attachmentStatus = 'TEMP' " +
           "AND a.attachmentActive = 1")
    void finalizeTempAttachments(@Param("toolRequestId") Long toolRequestId);
}
