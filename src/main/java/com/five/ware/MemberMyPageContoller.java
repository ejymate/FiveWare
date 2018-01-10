package com.five.ware;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.five.ware.erp.human.member.MemberDTO;
import com.five.ware.erp.human.member.MemberService;

@Controller
@RequestMapping(value="/member/**")
public class MemberMyPageContoller {

	@Inject
	MemberService memberService;
	
	
	
	//logout
	@RequestMapping(value="memberLogout")
	public String memberLogout(HttpSession session) throws Exception{
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	//update
	@RequestMapping(value="memberUpdate")
	public String memberMyPageUpdate(RedirectAttributes rd,MemberDTO memberDTO, HttpSession session){
		
		int result=0;
		try {
			result=memberService.myPageUpdate(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String message="fail";
		if(result>0){
			message="success";
			try {
				memberDTO = memberService.memberOne(memberDTO.getCode());
				session.setAttribute("member", memberDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		rd.addFlashAttribute("message", message);
		
		return "redirect:./memberMyPage";
	}
	
	
	//myPage
	@RequestMapping(value="memberMyPage")
	public String memberMyPage(HttpSession session)throws Exception{
		
		
		return  "/myPage/memberMyPage";
	}
	
	
	
	//login
	@RequestMapping(value="memberLogin")
	public String memberLogin(MemberDTO memberDTO,HttpSession session,RedirectAttributes rd){
		System.out.println("code : "+memberDTO.getCode());
		System.out.println("pw : "+memberDTO.getPw());
		
		String message="";
		
		 try {
			memberDTO=memberService.login(memberDTO);
		} catch (Exception e) {
			memberDTO=null;
			e.printStackTrace();
		}
		 if(memberDTO !=null){
			 session.setAttribute("member", memberDTO);
			 message=memberDTO.getName()+"님 환영합니다";
		 }else{
			 message="아이디와 비밀번호를 확인해주세요.";
		 }
		 
		 rd.addFlashAttribute("message", message);
		 
		 
		 return "redirect:/";
	}
	
}
