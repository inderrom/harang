package com.harang.tour.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.harang.facility.service.FacilityServiceImpl;
import com.harang.facility.service.IFacilityService;
import com.harang.tour.service.ITourService;
import com.harang.tour.service.TourServiceImpl;
import com.harang.vo.AirportVO;
import com.harang.vo.TourVO;

/**
 * Servlet implementation class TourController
 */
@WebServlet("/tour.do")
@MultipartConfig // 데이터 저장을 위한
public class TourController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ITourService tourService;
	private IFacilityService facilityService;
	
	@Override
	public void init() throws ServletException {
		tourService = TourServiceImpl.getInstance();
		facilityService = FacilityServiceImpl.getInstance();
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String job = request.getParameter("job");
		
		switch (job) {
		case "upload":
			getUpload(request,response);
			break;
		case "list":
			getList(request,response);
			break;
		case "delete":
			tourDelete(request,response);
			break;
		case "modify":
			tourModify(request,response);
			break;
		case "listAdmin":
			getListAdmin(request, response);
			break;
		}
	}
	
	
	// 여행지 수정 -- 테스트용
	private void tourModify(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int tour_num= Integer.parseInt(request.getParameter("Tour_id"));
		ITourService service = TourServiceImpl.getInstance();
		
		List<TourVO> tourList = service.getTourList();
		
		for(TourVO tourvo : tourList) {
			if(tourvo.getTour_num()==tour_num) {
				request.setAttribute("tourvo",tourvo );
			}
		}
		
//		response.sendRedirect(request.getContextPath()+"/tourModifyTest.jsp");
		request.getRequestDispatcher("tourModifyTest.jsp").forward(request, response);
	}

	// 여행지 삭제 -- 테스트용
	private void tourDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int tour_num = Integer.parseInt(request.getParameter("tour_num"));
		
		// 여행지 정보를 가져와 파일명을 지정한다.
		TourVO tourVo = tourService.getTour(tour_num);
		String tour_file = tourVo.getTour_file();
		
		String filePath = getProjectPath() + File.separator + tour_file;
		
		// 해당 파일이 존재하면 파일을 삭제한다.
		File file = new File(filePath);
		if(file.exists()) file.delete();
		
		// DB에서 여행지 정보를 삭제한다.
		int result = tourService.deleteTour(tour_num);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		if(result > 0) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 여행지 추가 -- 테스트용
	private void getUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/fileUploadTest.jsp");
	}
	
	// 관리자 화면에서의 여행지 리스트
	private void getListAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<TourVO> tourList = tourService.getTourList();
		List<AirportVO> airportList = facilityService.getAirportList(); // 여행지 추가에서 사용할 공항 목록
		
		request.setAttribute("tourList", tourList);
		request.setAttribute("airportList", airportList);
		request.getRequestDispatcher("/view/admin/adminTour.jsp").forward(request, response);
		
	}
	
	// 메인화면 여행지 리스트 
	private void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// null 체크를 하지 않기 위한 처리
		List<TourVO> tourList = new ArrayList<>();
		List<TourVO> tempList = tourService.getTourList();
		for(TourVO tourVo : tempList) {
			tourList.add(tourVo);
		}
		
		//화면에 원하는 showCount갯수만큼 리스트에 담음
		int showCount = Integer.parseInt(request.getParameter("showCount"));
		
		// 화면에 출력할 여행지를 랜덤으로 정한다.
		Random random = new Random();
		Set<Integer> rndSet = new HashSet<>(); // 여행지 번호가 중복되지 않도록 Set 객체에 번호를 저장한다.
		
		// 실제 출력될 여행지를 담을 List 객체
		List<TourVO> showList = new ArrayList<TourVO>(); 
		
		// 등록된 여행지의 수가 보여주고자하는 여행지 수보다 작을 경우
		if(showCount > tourList.size()) {
			
			showCount = tourList.size();
			
			for (int i = 0; i < tourList.size(); i++) {
				showList.add(tourList.get(i));
			}
			
		} else {
			
			// 보여주고자하는 여행지가 0 이하이거나
			// 등록된 여행지가 없을 경우
			if (showCount <= 0 || tourList.size() == 0) {
				return;
			}
			
			// 보여주고자하는 여행지 수만큼 showList에 여행지를 랜덤으로 추가한다.
			while (rndSet.size() != showCount ) {
				int rnd = random.nextInt(tourList.size());
				rndSet.add(rnd);
			}
			
			// 추첨한 숫자에 해당하는 여행지를 출력 리스트에 저장
			for (int num : rndSet) {
				showList.add(tourList.get(num));
			}
		}
		
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		String jsonData = gson.toJson(showList);
		response.getWriter().write(jsonData);
		response.flushBuffer();
		
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String job = request.getParameter("job");
		
		switch (job) {
		case "insert":
			insertTour(request,response);
			break;
		case "update":
			updateTour(request,response);
			break;
		}
	}

	// 여행지 수정
	private void updateTour(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//하랑 폴더 상대, 절대 주소
//		String uploadPath = "D:/A_TeachingMaterial/03_HighJava/workspace/harang/WebContent/images/tour";
		
		String uploadPath = getProjectPath();
		
		int tour_num = Integer.parseInt(request.getParameter("tour_num"));
		String airport_id = request.getParameter("airport_id");
		String tour_name = request.getParameter("tour_name");
		String tour_phrase = request.getParameter("tour_phrase");
		
		//파일 객체 생성
		File newFile = new File(uploadPath);
		if(!newFile.exists()) newFile.mkdirs(); // 경로가 없을 경우 생성
		
		// 변경되는 여행지 정보 설정
		TourVO newTourVo= new TourVO();
		newTourVo.setTour_num(tour_num);
		newTourVo.setAirport_id(airport_id);
		newTourVo.setTour_name(tour_name);
		newTourVo.setTour_phrase(tour_phrase);
		
		Part tour_file = request.getPart("tour_file"); // Part 객체 생성
		 
		String fileName = "";
		if(tour_file != null) {
			fileName = extractFilename(tour_file);  // 파일명 구하기
		}
		
		// 업로드된 파일이 존재할 경우
		if(!fileName.equals("")) {
			
			String saveFileName =UUID.randomUUID().toString().replace("-", "") + "_" + fileName;// 파일 명을 uuid값으로 변환 하기위한 준비
			
			//파일 저장
			try {
				
				tour_file.write(uploadPath + File.separator + saveFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
//				_DebugHarang.logger.error("updateTour() 메서드 파일 저장 에러");
			}
			
			
			// 새로 저장한 파일명을 VO에 추가
			newTourVo.setTour_file(saveFileName);
			
			// 기존에 저장되어있던 파일명을 가져온다.
			TourVO oldTourVo = tourService.getTour(tour_num);
			String deleteTarget = oldTourVo.getTour_file();
			
			// 기존 파일이 존재하면 삭제한다.
			if(deleteTarget != null) {
				File deleteFile = new File(uploadPath + File.separator + deleteTarget);
				if(deleteFile.exists()) deleteFile.delete();
			}
		}
		
		// 수정 내용 업데이트
		int result = tourService.updateTour(newTourVo);
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath()+"/tour.do?job=listAdmin");
			return;
		}
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print("<script> alert('잠시 후 다시 시도해주세요.'); location.href='" + request.getContextPath() + "/tour.do?job=listAdmin' </script>");
		
	}
	
	// 여행지 추가
	private void insertTour(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//업로드된 파일이 저장될 폴더 설정
		String airport_id = request.getParameter("airport_id");
		String tour_name = request.getParameter("tour_name");
		String tour_phrase = request.getParameter("tour_phrase");
		
		String uploadPath = getProjectPath();
		
		// 파일이 저장될 경로
		File file = new File(uploadPath);
		if(!file.exists()) file.mkdirs(); // 경로가 없을 경우 폴더 생성
		
		
		// 추가할 여행지 정보 설정
		TourVO tourVo = new TourVO();
		tourVo.setAirport_id(airport_id);
		tourVo.setTour_name(tour_name);
		tourVo.setTour_phrase(tour_phrase);
		
		// Part 객체 생성
		Part tour_file = request.getPart("tour_file");
		
		String fileName = "";
		if(tour_file != null) {
			fileName = extractFilename(tour_file);  // 파일명 구하기
		}
		
		// 파일이 존재할 경우
		if(!fileName.equals("")) {
		
			String saveFileName = UUID.randomUUID().toString().replace("-", "") + "_" + fileName;// 파일 명을 uuid값으로 변환 하기위한 준비
		
			//파일 저장
			try { 
				
				tour_file.write(uploadPath + File.separator + saveFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
//				_DebugHarang.logger.error("insertTour() 메서드 파일 저장 에러");
			}
			
			// 파일명 설정
			tourVo.setTour_file(saveFileName);
			
		}//if문 종료
		
		int result = tourService.insertTourRecomm(tourVo);
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath()+"/tour.do?job=listAdmin");
			return;
		}
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print("<script> alert('잠시 후 다시 시도해주세요.'); location.href='" + request.getContextPath() + "/tour.do?job=listAdmin' </script>");
	}

	// 파일명.형식 분리(파일명 추출) 메서드
	private String extractFilename(Part part) {
		String fileName="";
		
		String contentDisposition = part.getHeader("content-disposition");
		String[] items = contentDisposition.split(";");
		
		for(String item : items) {
			if(item.trim().startsWith("filename")) { 
				fileName = item.substring(item.indexOf("=")+2, item.length()-1);
			}
		}
		
		return fileName;
	}
	
	// 사진을 저장할 경로를 가져오는 메서드
	private String getProjectPath() {
		
		// 경로 : .../workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/harang/images/tour
		
		// 현재 이 클래스의 경로를 가져온다.
		String uploadPath = getClass().getResource("").getPath();
		
		uploadPath = uploadPath.replace("%20", " "); // 띄어쓰기를 공백으로 변경
		uploadPath = uploadPath.substring(0, uploadPath.indexOf("WEB-INF"));
		uploadPath += "images/tour"; // 어쩌구저쩌구.../harang/images/tour
//		uploadPath = uploadPath.substring(0, uploadPath.indexOf(".metadata"));
//		uploadPath += "harang/WebContent/images/tour";
		
		return uploadPath;
	}
}
