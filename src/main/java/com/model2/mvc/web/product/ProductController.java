package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음

	public ProductController() {
		System.out.println(this.getClass());
	}

	// ==> classpath:config/common.properties , classpath:config/commonservice.xml
	// 참조 할것
	// ==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	// @RequestMapping("/addProductView.do")
	// public String addProductView() throws Exception {
	@RequestMapping(value = "addProduct", method = RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");

		return "redirect:/product/addProductView.jsp";
	}

	// @RequestMapping("/addProduct.do")
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product, Model model) throws Exception {

		System.out.println("/product/addProduct : POST");
		// Business Logic
		productService.addProduct(product);
		model.addAttribute("product", product);

		return "forward:/product/addProduct.jsp";
	}

	// @RequestMapping("/getProduct.do")
	@RequestMapping(value = "getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model)
			throws Exception {

		System.out.println("/product/getProduct : GET");
		// Business Logic
		System.out.println(menu);
		if (menu.equals("manage")) {
			return "/product/updateProduct?prodNo=" + prodNo;
		}
		Product product = productService.getProduct(prodNo);

		// Model 과 View 연결
		model.addAttribute("product", product);

		return "forward:/product/getProduct.jsp";
	}

	// @RequestMapping("/updateProductView.do")
	// public String updateProductView(@RequestParam("prodNo") int prodNo, Model
	// model) throws Exception {
	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

		System.out.println("/product/updateProductView : GET");
		// Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);

		return "forward:/product/updateProductView.jsp";
	}

	// @RequestMapping("/updateProduct.do")
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/product/updateProduct : POST");
		// Business Logic
		productService.updateProduct(product);

		// int prodNo = product.getProdNo();
		System.out.println("return전");
		return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=search";
	}

	/*
	 * String sessionId=((Product)session.getAttribute("product")).getProdNo();
	 * if(sessionId.equals(product.getProdNo())){ session.setAttribute("product",
	 * product); }
	 */

	/*
	 * //@RequestMapping("/loginView.do") public String loginView() throws
	 * Exception{
	 * 
	 * System.out.println("/loginView.do");
	 * 
	 * return "redirect:/user/loginView.jsp"; }
	 * 
	 * //@RequestMapping("/login.do") public String login(@ModelAttribute("user")
	 * User user , HttpSession session ) throws Exception{
	 * 
	 * System.out.println("/login.do"); //Business Logic User
	 * dbUser=userService.getUser(user.getUserId());
	 * 
	 * if( user.getPassword().equals(dbUser.getPassword())){
	 * session.setAttribute("user", dbUser); }
	 * 
	 * return "redirect:/index.jsp"; }
	 * 
	 * @RequestMapping("/logout.do") public String logout(HttpSession session )
	 * throws Exception{
	 * 
	 * System.out.println("/logout.do");
	 * 
	 * session.invalidate();
	 * 
	 * return "redirect:/index.jsp"; }
	 */

	/*
	 * @RequestMapping("/checkDuplication.do") public String
	 * checkDuplication( @RequestParam("prodNo") String userId , Model model )
	 * throws Exception{
	 * 
	 * System.out.println("/checkDuplication.do"); //Business Logic boolean
	 * result=productService.checkDuplication(prodNo); // Model 과 View 연결
	 * model.addAttribute("result", new Boolean(result));
	 * model.addAttribute("userId", userId);
	 * 
	 * return "forward:/user/checkDuplication.jsp"; }
	 */

	// @RequestMapping("/listProduct.do")
	@RequestMapping(value = "listProduct")
	public String listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request)
			throws Exception {

		System.out.println("/product/listProduct : GET / POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}
}