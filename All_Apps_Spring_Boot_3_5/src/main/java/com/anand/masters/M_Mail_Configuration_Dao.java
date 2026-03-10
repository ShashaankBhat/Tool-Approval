package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Mail_Configuration_Dao extends JpaRepository<M_Mail_Configuration, Long> {

	/*@Query(value="select * from m_mail_configuration order by m_mail_configuration_id desc limit 20 offset ?", nativeQuery = true)
	List<M_Mail_Configuration> getMailConfigurationWithOffset(Integer offset);*/

	List<M_Mail_Configuration> findByActive(Integer active);

	List<M_Mail_Configuration> findByMailId(String mailId);
}