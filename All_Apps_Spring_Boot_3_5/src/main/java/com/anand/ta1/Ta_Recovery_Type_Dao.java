package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Recovery_Type_Dao extends JpaRepository<Ta_Recovery_Type, Long> {

    List<Ta_Recovery_Type> findByTaRecoveryTypeActive(Integer active);

    List<Ta_Recovery_Type> findByTaRecoveryTypeName(String name);

    List<Ta_Recovery_Type> findByTaRecoveryTypeNameAndTaRecoveryTypeActive(String name, Integer active);

    Long countByTaRecoveryTypeActive(Integer active);
}
