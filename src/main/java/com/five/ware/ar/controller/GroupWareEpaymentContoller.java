package com.five.ware.ar.controller;

import java.io.BufferedReader;

import java.io.BufferedReader; 

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.text.SimpleDateFormat;

import java.util.ArrayList;

import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.five.ware.erp.human.member.MemberDTO;
import com.five.ware.file.FileDTO;
import com.five.ware.groupware.epayment.EpaymentDTO;
import com.five.ware.groupware.epayment.EpaymentLeaveDTO;
import com.five.ware.groupware.epayment.EpaymentLeaveService;
import com.five.ware.groupware.epayment.EpaymentService;
import com.five.ware.groupware.epayment.FormListDTO;
import com.five.ware.groupware.epayment.FormListService;
import com.five.ware.util.ListData;

@Controller
@RequestMapping(value="GroupWare/epayment/**")
public class GroupWareEpaymentContoller {

	@Inject
	FormListService formListService;
	@Inject
	EpaymentService epaymentService;
	@Inject
	EpaymentLeaveService epaymentLeaveService;
	
	// 전체 결재함
	@RequestMapping(value="epaymentTotalList")
	public String totalList(String state, Model model) throws Exception{
		List<EpaymentDTO> ar = epaymentLeaveService.totalList(state);
		
		model.addAttribute("list", ar);
		model.addAttribute("title", state+"함");
		
		return "GroupWare/epayment/epaymentReceive";
	}
	
	//수신함
		@RequestMapping(value="epaymentReceive")
		public String myepaymentList(@RequestParam(defaultValue="0", required=false)int statenum,String code,HttpSession session, Model model) throws Exception{
			MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
			code = memberDTO.getCode();
			
			String title = "";
			
			if(statenum==0){
				title="수신함";
			}else if(statenum==1){
				title="기결함";
			}else if(statenum== -1){
				title="반려함";
			}
			
			epaymentLeaveService.myepaymentList(statenum, code,model);
			
			model.addAttribute("type", statenum);
			model.addAttribute("title", title);
			
			return "GroupWare/epayment/epaymentReceive";
		}
	
	@RequestMapping(value="epaymentContents")
	public String epaymentContents(String docunum, Model model) throws Exception{
		
		epaymentLeaveService.epaymentContents(docunum, model);
		
		return "GroupWare/epayment/epaymentView";
	}
	
	/*//내가 올린 결재문서만 보기
	@RequestMapping(value="epaymentDispatch")
	public ModelAndView epaymentDispatch(ListData listData){
		
		
		ModelAndView mv=null;
	
		
		try {
			mv=epaymentService.myEpaymentList(listData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("GroupWare/epayment/epaymentDispatch");
		
		return mv;

	}*/
	
	@RequestMapping(value="stampok")
	public String stampok(EpaymentLeaveDTO epaymentLeaveDTO, String ranking, String approvalcode, HttpSession session,RedirectAttributes rd) throws Exception{
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		epaymentLeaveDTO.setApprovalcode(memberDTO.getCode());
		
		epaymentLeaveDTO.setRanking(ranking);
		epaymentLeaveDTO.setApprovalcode(approvalcode);
		
		String message = epaymentLeaveService.stampok(epaymentLeaveDTO);
		
		rd.addFlashAttribute("message", message);
		
		return "redirect:./epaymentReceive";
	}
	
	
	//반려함에서 삭제
	@RequestMapping(value="epaymentDelete")
	@ResponseBody
	public String epaymentDelete(String num){
		
		int result=0;
		try {
			result=epaymentService.epaymentDelete(num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String message="fail";
		if(result>0){
			message="success";
		}
		
		return message;
	}
	
	//상세보기
	@RequestMapping(value="epaymentView")
	@ResponseBody
	public EpaymentDTO epaymentView(String num){
		
		EpaymentDTO epaymentDTO = null;
		try {
			epaymentDTO = epaymentService.epaymentView(num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return epaymentDTO;
	}
	
	//pendency 미결함
	@RequestMapping(value="epaymentPendency")
	public ModelAndView epaymentPendency(ListData listData){

		ModelAndView mv=null;
		listData.setResult("미결");
		
		try {
			mv=epaymentService.epaymentList(listData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("GroupWare/epayment/epaymentPendency");
		
		return mv;
		
		
	}
	
	//determine 기결함
	@RequestMapping(value="epaymentDetermine")
	public ModelAndView epaymentDetermine(ListData listData){
		ModelAndView mv=null;
		listData.setResult("기결");
		
		try {
			mv=epaymentService.epaymentList(listData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("GroupWare/epayment/epaymentDetermine");
		
		return mv;
		
	}
	
	//return 반려함
	@RequestMapping(value="epaymentReturn")
	public ModelAndView epaymentReturn(ListData listData){
		ModelAndView mv=null;
		listData.setResult("반려");
		
		try {
			mv=epaymentService.epaymentList(listData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("GroupWare/epayment/epaymentReturn");
		
		return mv;
		
	}
	
	
	
	@RequestMapping(value="formList")
	public ModelAndView formList(String search) throws Exception{
		List<FormListDTO> ar = formListService.formList(search);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("listnum", ar.size());
		mv.addObject("formList", ar);
		mv.setViewName("GroupWare/epayment/formList");
		
		return mv;
	}
	
	@RequestMapping(value="explanatory")
	public ModelAndView explanatory(HttpSession session) throws Exception{
		Calendar ca = Calendar.getInstance();
		
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		
		String sysdate = sd.format(ca.getTime());
		
		
		////////////////////////////// 문서 번호
		String filePath = session.getServletContext().getRealPath("/resources/code");
		String fileName= "docunum";
		
		File f= new File(filePath, fileName);
		
		FileReader fr = new FileReader(f);
		
		BufferedReader br = new BufferedReader(fr);
		
		fileName=br.readLine();
		
		String code = fileName;
		char codeChar=code.charAt(0);
		
		code=code.substring(1);
		int num = Integer.parseInt(code);
		
		num++;
		
		code=String.valueOf(num);
		String codeNum="";
		
		for(int i=0; i<3-code.length(); i++){
			codeNum = "0"+codeNum;
		}
		
		
		code=codeChar+codeNum+code;
		
		FileWriter fw = new FileWriter(f);
		
		fw.write(code);
		
		fw.flush();
		
		fw.close();
		br.close();
		fr.close();
///////////////////////////////////////////////		
		ModelAndView mv = new ModelAndView();
		System.out.println("결과"+code);
		mv.addObject("sysdate", sysdate);
		mv.addObject("docunum", code);
		mv.setViewName("GroupWare/epayment/explanatory");
		
		return mv;
	}
	
/*	@RequestMapping(value="epaymentInsert", method=RequestMethod.POST)
	public ModelAndView epaymentInsert(EpaymentDTO epaymentDTO, String [] approvalcode, String [] approvalname, String [] approvaltemp, String [] approvalrank) throws Exception{
		
		for(int i=0; i<approvalcode.length; i++){
			System.out.println(approvalcode[i]);
			System.out.println(approvalname[i]);
			System.out.println(approvaltemp[i]);
			System.out.println(approvalrank[i]);
		}
		ModelAndView mv = new ModelAndView();
		
		
		mv.setViewName("common/result");
		
		return mv;
	}*/
	@RequestMapping(value="epaymentStorageList")
	public ModelAndView storageList(String code, String state, HttpSession session) throws Exception{
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		
		code = memberDTO.getCode();
		
		List<EpaymentDTO> ar = epaymentLeaveService.storageList(code, state);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("list", ar);
		
		mv.setViewName("GroupWare/epayment/epaymentStorageList");
		
		return mv;
		
	}
	
	@RequestMapping(value="epaymentInsert", method=RequestMethod.POST)
	public ModelAndView epaymentInsert(EpaymentDTO epaymentDTO, MultipartFile [] oriname, HttpSession session,String state, EpaymentLeaveDTO epaymentLeaveDTO) throws Exception{
		
		System.out.println("들어옴");
		System.out.println(oriname.length);
		
		FileDTO fileDTO = new FileDTO();
		
		//file
		String filePath=session.getServletContext().getRealPath("resources/epayment");
		
		File file=new File(filePath);
		
		if(!file.exists()){
			file.mkdirs();
		}
		
		int result3 = 0;
		
		fileDTO.setCode(epaymentDTO.getDocunum());
		
		for(MultipartFile f2 : oriname){			
			String fileName=f2.getOriginalFilename();
			fileDTO.setOriname(fileName);
			fileName=fileName.substring(fileName.lastIndexOf("."));
			
			String name=UUID.randomUUID().toString();
			fileName=name+fileName;
			
			file=new File(filePath, fileName);
			System.out.println(filePath);
			
			fileDTO.setFilename(fileName);
			
			
			result3 = epaymentLeaveService.epaymentFile(fileDTO);
			
			f2.transferTo(file);		
		}
		//////////////////////////////////////
		
		epaymentDTO.setState(state);
		
		int result = epaymentService.epaymentInsert(epaymentDTO);
		int result2 = epaymentLeaveService.approvalInsert(epaymentLeaveDTO);
	
		String message = "결재 요청 실패";
		
		if(result>0 && result2>0 && result3>0){
			if(state.equals("임시저장")){
				message="임시저장 되었습니다.";				
			}else{
				message="결재 요청되었습니다.";
			}
		}
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("message", message);
		mv.addObject("addr", "formList");
		mv.setViewName("common/result");
		
		return mv;
	}
	
	@RequestMapping(value="explanatory_modal")
	public void epaymentModal() throws Exception{
		System.out.println("들어오냐?");
	}
	
	@RequestMapping(value="signData")
	@ResponseBody
	public List<Object> signData() throws Exception{
		List<String> temps = epaymentService.tempList();
		List<Object> ar = new ArrayList<Object>();
		
		ar.add(temps);
		
		return ar;
	}
	
	@RequestMapping(value="tempMember")
	@ResponseBody
	public List<MemberDTO> tempMember(String temp) throws Exception{
		List<MemberDTO> members=epaymentService.tempMember(temp);
		
		return members;
	}
	
	@RequestMapping(value="memberSelect")
	@ResponseBody
	public MemberDTO memberSelect(String code) throws Exception{
		MemberDTO memberDTO = epaymentService.memberSelect(code);
		
		return memberDTO;
	}
	
	@RequestMapping(value="epaymentViewUpdate")
	public String epaymentViewUpdate(String docunum, Model model) throws Exception{
		EpaymentDTO epaymentDTO = epaymentLeaveService.viewOneModal(docunum);
		
		model.addAttribute("docuC", epaymentDTO);
		
		return "GroupWare/epayment/epaymentViewUpdate";
	}
	
	@RequestMapping(value="myEpayment")
	public ModelAndView sendEpaymentList(String code, HttpSession session) throws Exception{
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		code = memberDTO.getCode();
		
		List<EpaymentDTO> ar = epaymentLeaveService.sendEpaymentList(code);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("list", ar);
		mv.setViewName("GroupWare/epayment/myEpayment");
		
		return mv;
	}
}
