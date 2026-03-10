package com.anand.ta;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Tool_Cost_Details_Dao
        extends JpaRepository<Ta_Tool_Cost_Details, Long> {

    /* =====================================================
       FETCH COST DETAILS BY TOOL REQUEST ID
       ===================================================== */
    List<Ta_Tool_Cost_Details>
    findByToolRequest_TaToolRequestId(Long taToolRequestId);
}
