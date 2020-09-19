package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.QnA;

@Mapper
public interface QnADAO {
		List<QnA> selectQnA();
		public QnA selectQnAByNo(int qnaNo);
		public int insertQnA(QnA qna);
		public int updateQnA(QnA qna);
		public int deleteQnA(int qnaNo);
		public int updateReply(QnA qna);
		public int deleteReply(int qnaNo);
		public int insertReply(QnA qna);
}
