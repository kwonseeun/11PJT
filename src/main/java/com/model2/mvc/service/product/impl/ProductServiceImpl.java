package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;


@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	
	//Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	
	public void addProduct(Product product) throws Exception {
		
		
		// new를 만뜨는 이유: vo에 데이터를 담기위해서 vo를 썡썽한따
		// 끈뗴 front에서 데이터를 받아왔기 때문에 지금 product예는 뗴이터까 이미 잇따
		
		String a = product.getManuDate();
		a = a.replace("-", "");
		product.setManuDate(a);
		
		 productDao.addProduct(product);
		
	}

	
	public Product getProduct(int ProdNo) throws Exception {
		return productDao.getProduct(ProdNo);
	}

	
	public Map<String, Object> getProductList(Search search) throws Exception {
		List <Product> list = productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", totalCount );
		return map;
	}

	
	public void updateProduct(Product product) throws Exception {
		
		productDao.updateProduct(product);
		
	}


}