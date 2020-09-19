package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.dto.PageBean;
@Mapper
public interface NoticeDao {

	public void writeArticle(NoticeDto noticeDto) throws SQLException;
	public List<NoticeDto> listArticle(PageBean pageBean) throws SQLException;
	public NoticeDto getArticle(int Noticeno) throws SQLException;
	public void modifyArticle(NoticeDto noticeDto) throws SQLException;
	public void deleteArticle(int Noticeno) throws SQLException;
	public int getTotalCount(@Param("key") String key, @Param("word") String word) throws SQLException;
	
}
