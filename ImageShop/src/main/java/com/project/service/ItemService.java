package com.project.service;

import java.util.List;

import com.project.domain.Item;

public interface ItemService {
	// 상품 등록 처리 
	public int register(Item item) throws Exception;

	public List<Item> list() throws Exception;

	public String getPreview(Item item) throws Exception;

	public String getPicture(Item item) throws Exception;

	public Item read(Item item) throws Exception;
}
