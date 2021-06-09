package com.model2.mvc.web.product;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		
		//Business Logic
		return productService.getProduct(prodNo);
	}
	
	
	@RequestMapping( value="json/getProductList/{currentPage}", method=RequestMethod.GET )
	public Map<String, Object> getProductList( @PathVariable int currentPage ) throws Exception{
		
		System.out.println("/product/json/getProductlist : GET");
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(3);
		
		return productService.getProductList(search);

		
	}	
	
	@RequestMapping( value="json/getProductList", method=RequestMethod.POST )
	public Map<String, Object> getProductList( @RequestBody Search search ) throws Exception{
		 
		System.out.println("/product/json/getProductlist : POST");
			
		return productService.getProductList(search);
	}
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestBody Product product ) throws Exception{
		
		System.out.println("/product/json/addProduct : POST");
		
		productService.addProduct(product);
		
		return product;
	}
	
}