package com.anand.ta1;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Ta_Status_History_Dao
        extends JpaRepository<Ta_Status_History, Long> {
    List<Ta_Status_History> findByTaStatus_TaStatusId(Long taStatusId);
}
