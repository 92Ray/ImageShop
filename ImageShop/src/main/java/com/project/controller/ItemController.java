package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Item;
import com.project.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemController {
	@Autowired
	private ItemService itemService;

	@Value("${upload.path}")
	private String uploadPath;
	
	// 상품 등록 페이지 
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')") 
	public String registerForm(Model model){
		model.addAttribute(new Item()); 
	} 

	
	// 상품 등록 처리 
	@GetMapping("/register") 
	@PreAuthorize("hasRole('ROLE_ADMIN')") 
	public String register(Item item, RedirectAttributes rttr) throws 
	Exception { 
	MultipartFile pictureFile = item.getPicture(); 
	MultipartFile previewFile = item.getPreview(); 
	 
	String createdPictureFilename = 
	uploadFile(pictureFile.getOriginalFilename(), pictureFile.getBytes()); 
	String createdPreviewFilename = 
	uploadFile(previewFile.getOriginalFilename(), previewFile.getBytes()); 
	 
	item.setPictureUrl(createdPictureFilename); 
	item.setPreviewUrl(createdPreviewFilename); 
	 
	itemService.register(item); 
	 
	rttr.addFlashAttribute("msg", "SUCCESS"); 
	return "redirect:/item/list"; 
	} 

}
