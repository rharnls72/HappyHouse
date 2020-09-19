package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.dto.Client;
import com.ssafy.happyhouse.model.dto.QnA;
import com.ssafy.happyhouse.model.service.QnAService;

import io.swagger.annotations.ApiOperation;

//http://localhost:9999/happyhouse/swagger-ui.html
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/qna.do")
public class QnAController {
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private QnAService qnaService;

	@GetMapping("list")
	public ResponseEntity<List<QnA>> retrieveQnA() throws Exception {
		return new ResponseEntity<List<QnA>>(qnaService.retrieveQnA(), HttpStatus.OK);
	}

	@GetMapping("{qnaNo}")
	public ResponseEntity<Map<String, Object>> detailQnA(@PathVariable int qnaNo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Client client = (Client) session.getAttribute("userinfo");
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("qna", qnaService.selectQnAByNo(qnaNo));
		resultMap.put("userid", client.getId());
		return new ResponseEntity<Map<String, Object>>(resultMap,HttpStatus.OK);
	}

	@PostMapping
	public ResponseEntity<String> writeQnA(@RequestBody QnA qna, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Client client = (Client) session.getAttribute("userinfo");
		qna.setQnaUserid(client.getId());
		if (qnaService.insertQnA(qna)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@PutMapping("{qnaNo}")
	public ResponseEntity<String> updateQnA(@RequestBody QnA qna) {
		if (qnaService.updateQnA(qna)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@DeleteMapping("{qnaNo}")
	public ResponseEntity<String> deleteQnA(@PathVariable int qnaNo) {
		if (qnaService.deleteQnA(qnaNo)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@GetMapping
	public ModelAndView reg() {
		return new ModelAndView("qna/index");
	}
	// 삽입 삭제 수정
	@PostMapping("/reply")
	public ResponseEntity<String> writeReply(@RequestBody QnA qna) {
		qna.setReplyUserid("admin");	// 우선 admin으로 고정
		if (qnaService.insertReply(qna)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@PutMapping("/reply")
	public ResponseEntity<String> updateReply(@RequestBody QnA qna) {
		if (qnaService.updateReply(qna)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@PutMapping("/reply/{qnaNo}")
	public ResponseEntity<String> deleteReply(@PathVariable int qnaNo) {
		if (qnaService.deleteReply(qnaNo)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
}