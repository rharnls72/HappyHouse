package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.QnADAO;
import com.ssafy.happyhouse.model.dto.QnA;


@Service
public class QnAServiceImpl implements QnAService {
	@Autowired
	private QnADAO dao;
	@Override
	public List<QnA> retrieveQnA() {
		return dao.selectQnA();
	}
	public QnA selectQnAByNo(int qnaNo) {
		return dao.selectQnAByNo(qnaNo);
	}
	public boolean insertQnA(QnA qna) {
		return dao.insertQnA(qna) == 1;
	}
	public boolean updateQnA(QnA qna) {
		return dao.updateQnA(qna) == 1;
	}
	public boolean deleteQnA(int qnaNo) {
		return dao.deleteQnA(qnaNo) == 1;
	}
	public boolean updateReply(QnA qna) {
		return dao.updateReply(qna) == 1;
	}
	public boolean deleteReply(int qnaNo) {
		return dao.deleteReply(qnaNo) == 1;
	}
	public boolean insertReply(QnA qna) {
		return dao.insertReply(qna) == 1;
	}
}
