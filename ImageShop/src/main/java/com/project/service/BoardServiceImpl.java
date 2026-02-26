package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.common.domain.PageRequest;
import com.project.domain.Board;
import com.project.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardMapper mapper;

	
	// 게시글 등록 처리
	@Transactional
	@Override
	public int register(Board board) throws Exception {
		return mapper.register(board);
	}
	// 게시글 목록 페이지
	//@Override
	//public List<Board> list() throws Exception {
	//	return mapper.list();
	//}
	@Override
	public Board read(Board board) throws Exception {
	 return mapper.read(board);
	}
	
	@Transactional
	@Override
	public int modify(Board board) throws Exception {
		return mapper.modify(board);
		
	}
	@Override
	public int remove(Board board) throws Exception {
		return mapper.modify(board);
		
	}
	@Override
	public int count() throws Exception {
		return mapper.count(mapper);
	}
	@Override
	public List<Board> list(PageRequest pagerequest) throws Exception {
		return mapper.list(pagerequest);
	}
	
	

}






