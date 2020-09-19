package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.QnA;


public interface QnAService {
	List<QnA> retrieveQnA();
	public QnA selectQnAByNo(int qnaNo);
	public boolean insertQnA(QnA qna);
	public boolean updateQnA(QnA qna);
	public boolean deleteQnA(int qnaNo);
	public boolean updateReply(QnA qna);
	public boolean deleteReply(int qnaNo);
	public boolean insertReply(QnA qna);
}
