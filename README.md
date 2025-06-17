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

Firebase Auth 연동, 화면 전환

SignUpViewController

회원가입 처리 화면

이메일/비밀번호 입력

EmotionSelectViewController
https://github.com/jiwn34/doornotttt/blob/main/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202025-06-17%20%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB%203.11.09.png
감정 선택 화면

감정 선택 → 다음으로 전환

PeopleCountViewController

인원 수 선택

Stepper 이용, 다음으로 전환

PlaceRecommendViewController

장소 추천 결과 + 지도 뷰

GPT API 호출, 지도 마커 표시, 즐겨찾기 버튼 포함


FavoritesViewController

즐겨찾기 확인 화면

MapKit 마커 + 테이블 리스트 제공

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

