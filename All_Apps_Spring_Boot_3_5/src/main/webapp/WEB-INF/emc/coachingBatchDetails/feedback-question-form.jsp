<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

				<!DOCTYPE html>
				<html lang="en">

				<head>
					<title>MENTEE LIST | EMC<%@include file="../../includeJSP/company_name_title.jsp" %>
					</title>
					<%@include file="../../includeJSP/cssFiles.jsp" %>
						<%@include file="../../includeJSP/datePickerCss.jsp" %>
				</head>

				<body>



					<c:if test="${not empty regMsg }">
						<section class="content content-margin">
							<div class="container-fluid">
								<div class="alert ${css } alert-dismissible">
									<button type="button" title="CLose Alert Box" class="close" data-dismiss="alert"
										aria-hidden="true"><i class="fas fa-times"></i></button>
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
					<section class="content content-margin">
					
						<div class="container-fluid">
							<div class="row justify-content-center">
								<div class="col-md-10 col-lg-9 col-xl-8">
									
										

                                    <div id="content">
										<c:choose>

	
											<c:when test="${not empty coachfeedbackResponse 
               or not empty mentorfeedbackResponse 
               or not empty coacheefeedbackResponse 
               or not empty menteefeedbackResponse}">

												<div class="card shadow border-0 rounded-4 mt-5">
													<div
														class="card-header bg-success text-white rounded-top-4 py-3 px-4">
														<h5 class="mb-0"><i class="bi bi-check-circle me-2"></i>
															Feedback Submitted jhjjhjhjh</h5>
														<p class="mb-0 small">Here are your previous responses:</p>
													</div>
													<div class="card-body px-4 py-3">


														<c:if
															test="${emcMentor eq '1' and fn:contains(programCategory, '1')}">
															<c:forEach var="response" items="${coachfeedbackResponse}">
																<div class="mb-4">
																	<p class="fw-semibold mb-1 text-primary">
																		<strong>Q:</strong>
																		${response.questionId.question}</p>
																	<p class="mb-0"><strong>A:</strong>
																		${response.answer}</p>
																</div>
																<hr />
															</c:forEach>
														</c:if>

														<c:if
															test="${emcMentor eq '1' and fn:contains(programCategory, '2')}">
															<c:forEach var="response" items="${mentorfeedbackResponse}">
																<div class="mb-4">
																	<p class="fw-semibold mb-1 text-primary">
																		<strong>Q:</strong>
																		${response.questionId.question}</p>
																	<p class="mb-0"><strong>A:</strong>
																		${response.answer}</p>
																</div>
																<hr />
															</c:forEach>
														</c:if>

														
														<c:if
															test="${emcMentee eq '1' and fn:contains(programCategory, '1')}">
															   <h1>hhhhhhhhhhhhhhhhh</h1>  
															<c:forEach var="response"
																items="${coacheefeedbackResponse}">
																<div class="mb-4">
																	<p class="fw-semibold mb-1 text-primary">
																		<strong>Q:</strong>
																		${response.questionId.question}</p>
																	<p class="mb-0"><strong>A:</strong>
																		${response.answer}</p>
																</div>
																<hr />
															</c:forEach>
														</c:if>
														<c:if
															test="${emcMentee eq '1' and fn:contains(programCategory, '2')}">
															<c:forEach var="response" items="${menteefeedbackResponse}">
																<div class="mb-4">
																	<p class="fw-semibold mb-1 text-primary">
																		<strong>Q:</strong>
																		${response.questionId.question}</p>
																	<p class="mb-0"><strong>A:</strong>
																		${response.answer}</p>
																</div>
																<hr />
															</c:forEach>
														</c:if>

													</div>
												</div>
											</c:when>


											<c:otherwise>

												<div
													class="card border-0 shadow-lg rounded-4 mt-5 mb-4 position-relative">


													<div class="card-body px-5 py-4">
														<form id="feedbackForm" method="post"
															action="submitFeedback">
															<input type="hidden" name="mappingId"
																value="${mappingId}" />
																<!-- <h1>hhhhh</h1>
                                                               <p>emcMentee: ${emcMentee}</p>
                                                        <p>programCategory: ${programCategory}</p> -->

															<c:if
																test="${emcMentor eq '1' and fn:contains(programCategory, '1') || emcAdmin eq 1}">
																<h5 class="mb-4 text-primary"><i
																		class="bi bi-person-workspace me-2"></i> </h5>
																<c:forEach items="${questions}" var="question"
																	varStatus="loop">
																	<div class="mb-4">
																		<label
																			class="form-label fw-semibold">${loop.index
																			+ 1}. ${question.question}</label>
																		<textarea
																			class="form-control shadow-sm rounded-3 feedback-textarea"
																			name="question_${question.questionId}"
																			rows="3"
																			placeholder="Type your response here..."
																			required></textarea>
																	</div>
																</c:forEach>
															</c:if>



															<c:if
																test="${emcMentee eq '1' and fn:contains(programCategory, '1')}">
																<h5 class="mb-4 text-success"><i
																		class="bi bi-person-badge me-2"></i></h5>
																<c:forEach items="${coacheeQuestions}" var="question"
																	varStatus="loop">
																	<div class="mb-4">
																		<label
																			class="form-label fw-semibold">${loop.index
																			+ 1}. ${question.question}</label>
																		<textarea
																			class="form-control shadow-sm rounded-3 feedback-textarea"
																			name="question_${question.questionId}"
																			rows="3"
																			placeholder="Type your response here..."
																			required></textarea>
																	</div>
																</c:forEach>
															</c:if>


															<c:if
																test="${emcMentor eq '1' and fn:contains(programCategory, '2')}">
																<h5 class="mb-4 text-primary"><i
																		class="bi bi-person-video2 me-2"></i> </h5>
																<c:forEach items="${mentorQuestions}" var="question"
																	varStatus="loop">
																	<div class="mb-4">
																		<label
																			class="form-label fw-semibold">${loop.index
																			+ 1}. ${question.question}</label>
																		<textarea
																			class="form-control shadow-sm rounded-3 feedback-textarea"
																			name="question_${question.questionId}"
																			rows="3"
																			placeholder="Type your response here..."
																			required></textarea>
																	</div>
																</c:forEach>
															</c:if>


															<c:if
																test="${emcMentee eq '1' and fn:contains(programCategory, '2')}">

																<h5 class="mb-4 text-success"><i
																		class="bi bi-person-circle me-2"></i> </h5>
																<c:forEach items="${menteeQuestions}" var="question"
																	varStatus="loop">
																	<div class="mb-4">
																		<!-- hjhj<c:out value ="${menteeQuestions}" /> -->
																		<label
																			class="form-label fw-semibold">${loop.index
																			+ 1}. ${question.question}</label>
																		<textarea
																			class="form-control shadow-sm rounded-3 feedback-textarea"
																			name="question_${question.questionId}"
																			rows="3"
																			placeholder="Type your response here..."
																			required></textarea>
																	</div>
																</c:forEach>
															</c:if>


															<div class="d-flex justify-content-end mt-5 gap-3">

																<button type="submit" class="btn bg-1"> Submit Feedback</button>
															</div>
														</form>
													</div>
												</div>
											</c:otherwise>

										</c:choose>
									
									</div>
								</div>
							</div>
						</div>
					</section>





					<!-- <%@include file="../includeJSP/footer.jsp" %> -->
					</div>
					<!-- <%@include file="../../includeJSP/jsFiles.jsp" %> -->
					<%@include file="../../includeJSP/dataTablesImport.jsp" %>
						<%@include file="../../includeJSP/datePickerJs.jsp" %>
							<script
								src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/feedback-form.js"></script>


							<script>
								function handleClose() {
									// Hides the feedback card
									document.querySelector(".card").style.display = "none";
								}
							</script>


				</body>

				</html>