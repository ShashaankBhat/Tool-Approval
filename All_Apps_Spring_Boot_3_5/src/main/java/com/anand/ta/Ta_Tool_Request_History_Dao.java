package com.anand.ta;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Tool_Request_History_Dao
        extends JpaRepository<Ta_Tool_Request_History, Long> {
}
