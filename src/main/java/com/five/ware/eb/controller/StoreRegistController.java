package com.five.ware.eb.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.five.ware.erp.storeRegist.StoreRegistDTO;
import com.five.ware.erp.storeRegist.StoreRegistService;

@Controller
@RequestMapping(value="/erp/**")
public class StoreRegistController {
	
	@Inject
	private StoreRegistService storeRegistService;
	

	
	
	//storeRegist
	@RequestMapping(value="storeRegist")
	public ModelAndView selectList() throws Exception{
		ModelAndView mv=null;
		
		mv=storeRegistService.selectList();
		
		return mv;
	}
	
	
	//insert
	@RequestMapping(value="storeRegistWrite" ,method=RequestMethod.POST)
	public String insert(StoreRegistDTO storeRegistDTO , RedirectAttributes rd){
		
		
		int result=0;
		 
		try {
			result=storeRegistService.insert(storeRegistDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String message="fail";
		if(result>0){
			message="success";
		}
		
		rd.addFlashAttribute("message", message);
		
		
		return "redirect:./erp/storeRegist";
		
	}
	
	
	
	
	
 }



