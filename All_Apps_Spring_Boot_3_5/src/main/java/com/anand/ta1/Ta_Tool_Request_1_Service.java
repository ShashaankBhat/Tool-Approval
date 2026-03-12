package com.anand.ta1;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface Ta_Tool_Request_1_Service {

	/*List<Ta_Tool_Request_1> getTaToolRequestList(HttpServletRequest request, Integer offset);

    List<Ta_Tool_Request_1> getTaToolRequestByActiveTaToolRequest(Integer active);*/

    String saveTaToolRequestDetails(HttpServletRequest request, Ta_Tool_Request_1 TaToolRequest);

    void saveTaToolRequestDetails(
            Ta_Tool_Request_1 taToolRequest,
            MultipartFile[] backgroundAttachments,
            MultipartFile[] remarkAttachments
    );

    Ta_Tool_Request_1 getTaToolRequestDetail(HttpServletRequest request);

    /*String getTaToolRequestDetails(HttpServletRequest request);

    List<Ta_Tool_Request_1> getTaToolRequestHistoryByTaToolRequestId(Long taTaToolRequestId);*/
}
