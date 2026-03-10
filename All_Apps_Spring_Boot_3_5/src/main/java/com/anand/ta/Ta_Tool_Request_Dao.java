package com.anand.ta;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.anand.masters.M_User;
import com.anand.ta1.Ta_Status;

@Repository
public interface Ta_Tool_Request_Dao extends JpaRepository<Ta_Tool_Request, Long> {

    List<Ta_Tool_Request> findByInitiatedBy(M_User user);

    List<Ta_Tool_Request> findByStatus(Ta_Status status);

    List<Ta_Tool_Request> findByRequestActive(Integer active);
}
