package com.harang.tour.dao;

import java.util.List;

import com.harang.vo.TourVO;

public interface ITourDAO {

	/**
	 *  TourVO객체에 
	 *  airport_id 공항코드
		tour_name 여행지 명
		tour_phrase 내용
		tour_file 사진파일을 받아서 저장한다.
	 * @param tourVo
	 * @return 추가 성공 : 양수(게시글갯수+1) , 실패 : 음수
	 */
	public int insertTourRecomm(TourVO tourVo);
	
	/**
	 * DB에 저장된 추천여행지 목록을 전부 가져오는 메서드
	 * @return List<TourVO>
	 */
	public List<TourVO> getTourList();

	/**
	 * 주어진 번호에 해당하는 여행지 정보를 가져오는 메서드
	 * 
	 * @param tourNum 정보를 가져올 여행지 번호
	 * @return 여행지 정보가 담긴 TourVO
	 */
	public TourVO getTour(int tour_num);
	
	/**
	 *  tour_num을 통해 DB에 저장된 추천 여행지를 삭제한다.
	 * @param tour_num 값을 받아서 삭제한다.
	 * @return
	 */
	public int deleteTour(int tour_num);
	
	/**
	 * 추천 여행지 내용 수정 메서드
	 * @param tourVo객체 안에 담아서 수정한다.
	 * @return
	 */
	public int updateTour(TourVO tourVo);
}
