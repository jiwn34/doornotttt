###doornotttt
DoOrNot iOS App (MapKit + GPT 기반 장소 추천)

📱 프로젝트 개요

DoOrNot은 사용자의 감정 상태와 함께할 인원 수, 그리고 현재 위치를 기반으로 OpenAI의 GPT API를 활용해 어울리는 장소를 추천해주는 iOS 앱입니다. 추천된 장소는 지도에 표시되며, 즐겨찾기로 저장하여 나중에 다시 확인할 수 있는 기능도 제공합니다.

주요 기능

1. 로그인 및 회원가입 ()

이메일/비밀번호 기반 로그인 및 회원가입 기능 제공

로그인 성공 시 감정 선택 화면으로 전환

회원가입은 별도의 화면으로 이동하여 이메일/비밀번호 등록 가능

2. 감정 및 인원 선택

사용자가 현재 느끼는 감정을 버튼 형태로 선택

Stepper를 통해 함께할 인원 수를 선택

선택된 감정과 인원 수를 다음 화면으로 전달

3. GPT 기반 장소 추천

OpenAI GPT API에 감정 + 인원 수 정보를 전달하여 텍스트 기반 장소 목록 요청

GPT 프롬프트 예시:

오늘 기분은 기쁘고, 3명이 함께할 거예요. 현재 위치 근처에서 어울리는 장소 8개를 추천해줘. 장소 이름만 콤마(,)로 구분해서 한 줄로 알려줘.

응답된 문자열을 파싱하여 버튼으로 구성하고, 선택 시 해당 장소를 지도에 표시

4. MapKit을 활용한 지도 뷰

추천 장소 버튼을 클릭하면 해당 키워드로 장소 검색 후 마커 추가

초기 위치는 "평택대학교"로 설정

마커 클릭 없이도 지도에 시각적으로 장소 확인 가능

5. 즐겨찾기 기능 (UserDefaults 기반)

추천된 장소를 즐겨찾기로 저장

저장 시 이름, 위도, 경도 정보를 구조체로 인코딩하여 UserDefaults에 저장

즐겨찾기 화면에서 테이블 뷰와 지도 마커로 저장된 장소들을 다시 확인 가능

6. 즐겨찾기 화면 (FavoritesViewController)

지도(MapKit)와 테이블 뷰를 함께 표시하여 시각적 + 리스트 형태 제공

저장된 장소들의 마커를 지도에 표시

장소 이름 리스트는 UITableView로 구현

  주요 화면 구성

ViewController

역할

연결된 기능

LoginViewController

로그인 및 회원가입 화면

<img width="303" alt="스크린샷 2025-06-17 오전 3 11 53" src="https://github.com/user-attachments/assets/191eb797-ee86-4d3b-86df-0d0c9a31d524" />

<img width="306" alt="스크린샷 2025-06-17 오전 3 12 04" src="https://github.com/user-attachments/assets/ca519cce-1129-417a-9381-983a80995519" />

<img width="428" alt="스크린샷 2025-06-17 오전 3 48 35" src="https://github.com/user-attachments/assets/0a55107b-173e-44a5-8ef5-183d9301469d" />

화면 전환

SignUpViewController

회원가입 처리 화면

이메일/비밀번호 입력

EmotionSelectViewController

<img width="448" alt="스크린샷 2025-06-17 오전 6 44 01" src="https://github.com/user-attachments/assets/e755c0f0-ffab-4f44-8d3d-b710aa5bcc1c" />

감정 선택 화면

감정 선택 → 다음으로 전환

PeopleCountViewController

인원 수 선택

<img width="434" alt="스크린샷 2025-06-17 오전 6 44 25" src="https://github.com/user-attachments/assets/5122ca9e-162d-4d55-976d-fb7343b9f589" />
<img width="429" alt="스크린샷 2025-06-17 오전 6 44 51" src="https://github.com/user-attachments/assets/e99682f8-0397-49ed-abac-c5580e6f876a" />

Stepper 이용, 다음으로 전환

PlaceRecommendViewController

<img width="427" alt="스크린샷 2025-06-17 오전 6 56 41" src="https://github.com/user-attachments/assets/34a769a0-99f9-4a2e-886d-7decbced60d8" />
<img width="418" alt="스크린샷 2025-06-17 오전 6 56 21" src="https://github.com/user-attachments/assets/777b9243-7f7f-414f-bb8f-1ebea691c20a" />

장소 추천 결과 + 지도 뷰

GPT API 호출, 지도 마커 표시, 즐겨찾기 버튼 포함


FavoritesViewController

즐겨찾기 확인 화면

<img width="249" alt="스크린샷 2025-06-17 오전 7 32 32" src="https://github.com/user-attachments/assets/67931ca9-b0fa-42e1-8de0-84abe07a78cd" />

MapKit 마커 + 테이블 리스트 제공


<img width="873" alt="스크린샷 2025-06-17 오전 11 18 32" src="https://github.com/user-attachments/assets/8e02d6e3-5a1f-465d-bf4f-87886e22648f" />



🛠 기술 스택

언어: Swift 5

UI 프레임워크: UIKit + Storyboard

지도: MapKit (Apple 내장 지도 사용)

AI 추천: OpenAI GPT API (gpt-3.5-turbo)

데이터 저장: UserDefaults + Codable 구조체


 실행 방법

Xcode에서 프로젝트 열기

GoogleService-Info.plist 파일을 프로젝트 루트에 추가 (Firebase 사용 시)

PlaceRecommendViewController.swift 내 OpenAI API 키 입력

시뮬레이터 또는 실제 디바이스에서 실행

 향후 개발 아이디어 / 개선사항

실시간 이미지 연동

사용자 맞춤형 추천 강화

푸시 알림, 다크모드 지원 등

제작자 정보

개발자: 스마트콘텐츠학과 3학년 김지원

감사합니다

