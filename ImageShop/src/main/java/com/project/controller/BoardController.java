package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.common.domain.PageRequest;
import com.project.common.domain.Pagination;
import com.project.common.security.domain.CustomUser;
import com.project.domain.Board;
import com.project.domain.Member;
import com.project.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService service;

	// 게시글 등록 페이지
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public void registerForm(Model model, Authentication authentication) throws Exception {
		// Authentication 자체가 로그인을 해야만 한다는 것.
		// 로그인한 사용자 정보 획득
		CustomUser user = (CustomUser) authentication.getPrincipal();
		Member member = customUser.getMember();

		Board board = new Board();
		// 로그인한 사용자 아이디를 등록 페이지에 표시
		board.setWriter(member.getUserId());

		model.addAttribute(board);
	}

	// 게시글 등록 처리
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String register(Board board, RedirectAttributes rttr) throws Exception {
		int count = service.register(board);

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAILED");
		}
		return "redirect:/board/list";
	}

	// 게시글 목록 페이지
	@GetMapping("/list")
	public void list(@ModelAttribute("pgrq") PageRequest pagerequest , Model model ) throws Exception {
//		if(pagerequest.getPage() == 0) {
//			pagerequest = new PageRequest();
//		}
		// 4페이지를 보여주는 기능 / 요청하는 페이지가 4페이지라면 DB에 가서 31-40를 가져온다.(페이지당 10개라고 했을 때)
		model.addAttribute("list", service.list(pagerequest));
		// 페이지를 보여주는 기능([prev] 1, 2, 3, [4], 5, 6, 7, 8, 9, 10 [next])
		Pagination pagination = new Pagination();
		// 현재페이지 4, 한 페이지당 보여주는 갯수가 10개로 세팅되어있음.
		pagination.setPageRequest(pagerequest);
		// List의 전체갯수를 할당하고 다시 계산.
		pagination.setTotalCount(service.count());
		// 화면에 페이지를 보여주는 정보를 제공.
		model.addAttribute("pagination", pagination);
	}

	// 게시글 상세 페이지
	@GetMapping("/read")
	public void read(Board board, @ModelAttribute("pgrq") PageRequest pagerequest, Model model) throws Exception {
		model.addAttribute(service.read(board));
	}
	
	// 게시글 수정 페이지 
	@GetMapping("/modify") 
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')") 
	public void modifyForm(Board board, @ModelAttribute("pgrg") PageRequest pagerequest, Model model) throws Exception 
	{ model.addAttribute(service.read(board)); 
	} 
	 
	// 게시글 수정 처리 
	@PostMapping("/modify") 
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')") 
	public String modify(Board board, PageRequest pagerequest, RedirectAttributes rttr) throws Exception {
	int count = service.modify(board);
	
	// RedirectAttributes 객체에 일회성 데이터를 지정하여 전달한다.
	rttr.addAttribute("page", pagerequest.getPage()); 
	rttr.addAttribute("sizePerPage", pagerequest.getSizePerPage()); 
	if (count != 0) {
		rttr.addFlashAttribute("msg", "SUCCESS");
	} else {
		rttr.addFlashAttribute("msg", "FAILED");
	}
	return "redirect:/board/list";
	 
	} 
	
	
	// 게시글 삭제 처리 
	@GetMapping("/remove") 
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')") 
	public String remove(Board board, PageRequest pagerequest, RedirectAttributes rttr) throws Exception { 
	int count = service.remove(board); 
	rttr.addAttribute("page", pagerequest.getPage()); 
	rttr.addAttribute("sizePerPage", pagerequest.getSizePerPage());
	if (count != 0) {
		rttr.addFlashAttribute("msg", "SUCCESS");
	} else {
		rttr.addFlashAttribute("msg", "FAILED");
	}
	return "redirect:/board/list";
	 
	} 

}
