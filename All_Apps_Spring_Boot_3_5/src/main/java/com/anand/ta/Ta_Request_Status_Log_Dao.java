package com.anand.ta;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Request_Status_Log_Dao extends JpaRepository<Ta_Request_Status_Log, Long> {
}
