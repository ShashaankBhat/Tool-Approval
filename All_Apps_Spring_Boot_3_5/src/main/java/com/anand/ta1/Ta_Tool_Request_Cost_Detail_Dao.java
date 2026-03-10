package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Tool_Request_Cost_Detail_Dao extends JpaRepository<Ta_Tool_Request_Cost_Detail, Long> {
}
