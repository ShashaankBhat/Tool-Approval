<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <title>MENTORING REPORT | EMC<%@include file="../../includeJSP/company_name_title.jsp" %>
                        </title>
                        <%@include file="../../includeJSP/cssFiles.jsp" %>
                            <%@include file="../../includeJSP/datePickerCss.jsp" %>
                    </head>

                    <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
                        <div class="wrapper">
                            <%@include file="../../includeJSP/header.jsp" %>
                                <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert ${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
                <c:if test="${css eq 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                </c:if>
                <c:if test="${css ne 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                </c:if>
              </div>
            </div>
          </section>
        </c:if>


           <h1>hhhhhhhhhhhhhhhhh</h1>  
                           <div class="content-wrapper">
									<c:set var="goalIndex" value="0" />
                                <div class="container my-4">
                                      
                                    <c:choose>

                                        <c:when test="${not empty feedbackResponse}">
                                            <div class="card shadow-sm">
                                        
                                                <!-- <div class="card-header bg-primary text-white"> -->
                                                <!-- <h5 class="mb-0">Submitted Feedback</h5> -->
                                                <!-- </div> -->
                                                <div class="card-body">
                                                    <c:forEach var="response" items="${feedbackResponse}">
                                                        <div class="mb-3">
                                                            <p class="fw-semibold"><strong>Q:</strong>
                                                                ${response.questionId.question}</p>
                                                            <p><strong>A:</strong> ${response.answer}</p>
                                                        </div>
                                                        <hr />
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:when>


                                        <c:otherwise>
                                            <div class="card  card-outline bg-card-primary-anand">

                                                <div class="card-body">
                                                    <form id="feedbackForm" method="post"
                                                        action="submitFeedback">
                                                        <input type="hidden" name="mappingId" value="${mappingId}" />'
                                                     

                                                        <c:if
                                                            test="${emcMentor eq '1' and fn:contains(programCategory, '1')}">
                                                            <c:forEach items="${questions}" var="question"
                                                                varStatus="loop">
                                                                <h1>hhhh</h1>
                                                                <div class="mb-4">
                                                                    <label class="form-label fw-semibold">
                                                                        ${loop.index + 1}. ${question.question}
                                                                    </label>
                                                                    <textarea class="form-control"
                                                                        name="question_${question.questionId}" rows="3"
                                                                        placeholder="Type your response here..."
                                                                        required></textarea>
                                                                </div>
                                                            </c:forEach>
                                                        </c:if>
                                                        <!-- <p>emcMentee: ${emcMentee}</p>
                                                        <p>programCategory: ${programCategory}</p> -->
                                                        <c:if
                                                            test="${emcMentee eq '1' and fn:contains(programCategory, '1')}">
                                                            <!-- <h1>hhhh</h1> -->
                                                            <c:forEach items="${coacheeQuestions}" var="question"
                                                                varStatus="loop">
                                                                <div class="mb-4">
                                                                    <label class="form-label fw-semibold">
                                                                        ${loop.index + 1}. ${question.question}
                                                                    </label>
                                                                    <textarea class="form-control"
                                                                        name="question_${question.questionId}" rows="3"
                                                                        placeholder="Type your response here..."
                                                                        required></textarea>
                                                                </div>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if
                                                            test="${emcMentor eq '1' and fn:contains(programCategory, '2')}">
                                                            <!-- <h1>hhhh</h1> -->
                                                            <c:forEach items="${mentorQuestions}" var="question"
                                                                varStatus="loop">
                                                                <div class="mb-4">
                                                                    <label class="form-label fw-semibold">
                                                                        ${loop.index + 1}. ${question.question}
                                                                    </label>
                                                                    <textarea class="form-control"
                                                                        name="question_${question.questionId}" rows="3"
                                                                        placeholder="Type your response here..."
                                                                        required></textarea>
                                                                </div>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if
                                                            test="${emcMentee eq '1' and fn:contains(programCategory, '2')}">

                                                            <!-- <h1>hhhh</h1> -->
                                                            <c:forEach items="${menteeQuestions}" var="question"
                                                                varStatus="loop">
                                                                <div class="mb-4">
                                                                    <label class="form-label fw-semibold">
                                                                        ${loop.index + 1}. ${question.question}
                                                                    </label>
                                                                    <textarea class="form-control"
                                                                        name="question_${question.questionId}" rows="3"
                                                                        placeholder="Type your response here..."
                                                                        required></textarea>
                                                                </div>
                                                            </c:forEach>
                                                        </c:if>


                                                        <div class="d-flex justify-content-end mt-4">
                                                            <!-- <button type="button" class="btn bg-1"
                                                                data-bs-dismiss="modal">Close</button> -->
                                                            <button type="submit" class="btn bg-1">Submit
                                                                Feedback</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                              
                                    <script
                                        src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coaching-report.js"></script>



                                    <!-- Bootstrap 5 CSS -->
                                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                                        rel="stylesheet">

                                    <!-- Bootstrap 5 JS (optional for modal/dismiss features) -->
                                    <script
                                        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                                       < %@include file="../includeJSP/footer.jsp" %>
						</div>
						<%@include file="../../includeJSP/jsFiles.jsp" %>
							<%@include file="../../includeJSP/dataTablesImport.jsp" %>
								<%@include file="../../includeJSP/datePickerJs.jsp" %>
									<script
										src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coaching-report.js"></script>
				</body>

                    </body>

                    </html>