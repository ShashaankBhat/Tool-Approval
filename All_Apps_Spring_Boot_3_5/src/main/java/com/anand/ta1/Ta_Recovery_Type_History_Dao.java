package com.anand.ta1;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface Ta_Recovery_Type_History_Dao
        extends JpaRepository<Ta_Recovery_Type_History, Long> {

    List<Ta_Recovery_Type_History>
    findByTaRecoveryType_TaRecoveryTypeId(Long id);
}
