package shop.service;

import shop.dto.User;

public interface PersistenceLoginsService {

   // 토큰 등록
   public User insert(String userid);
   
   // 토큰 조회 (아이디)
   public User select(String userid);
   
   // 토큰 조회 (토큰)
   public User selectByToken(String token);
   
   // 토큰 수정
   public User update(String userid);
   
   // 토큰 갱신 (없으면 등록, 있으면 수정)
   public User refresh(String userid);
   
   // 토큰 유효성 체크 (만료여부 확인)
   public boolean isValid(String token);
   
   //토큰 삭제
   public boolean delete(String userid);
}
