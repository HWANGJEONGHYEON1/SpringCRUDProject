
### SpringCRUDProject
- 도커 - 오라클연동 
- 기본적인 웹 게시물 관리 (CRUD)
  1. 화면처리
  2. 오라클 데이터베이스 페이징처리(인덱스 이용한 정렬)
  3. MyBatis 검색
- Rest 방식을 통한 댓글처리
  1. RestController 방식
  2. 다양한 전송방식
- AOP / 트랜적션
  1. 서비스 호출 전 로그 처리
  2. 해당 메서드 호출 시 파라메터 확인
  3.  게시물 삭제 혹은 등록 시 트랜잭션 처리
- 파일 업로드 
  1.  ajax 이용 업로드
  2.  썸네일 처리
  3.  첨부파일 다운로드
  4.  잘못된 파일 삭제
  5. Quartz 라이브러리 설정
  6.  cron 설정과 파일 삭제처리
- Spring security (로그인, 로그아웃)
  1.  로그인 / 로그아웃 처리
  2.  remember-me 자동로그인 처리
  3.  CSRF 공격 방어
  4.  UserDetailsService 상속받아 재처리
  5.  각 유저별 권한을 통해 페이지 접근 처리 또는 수정 삭제 불가 처리 


<b> 개발환경</b>
```
Java version: 1.8
Spring version: 5.0.7
Lombok version: 1.18.16
MyBatis 3.4.6
Default Encoding: UTF-8
Default SCM : git
Tool : SourceTree, Intellij
Docker ( Oracle 연동 )
```


<b>스프링 폴더구조</b>
```sh
├── README.md
├── build
│   ├── classes
│   │   └── java
│   │       ├── main
│   │       │   └── org
│   │       │       ├── sample
│   │       │       │   ├── controller
│   │       │       │   │   └── SampleController.class
│   │       │       │   └── domain
│   │       │       │       ├── SampleVO.class
│   │       │       │       └── TicketVO.class
│   │       │       └── zerock
│   │       │           ├── aop
│   │       │           │   └── LogAdvice.class
│   │       │           ├── controller
│   │       │           │   ├── BoardController.class
│   │       │           │   ├── CommonController.class
│   │       │           │   ├── ReplyController.class
│   │       │           │   └── UploadController.class
│   │       │           ├── domain
│   │       │           │   ├── AttaachFileDTO.class
│   │       │           │   ├── AuthVO.class
│   │       │           │   ├── BoardAttachVO.class
│   │       │           │   ├── BoardVO.class
│   │       │           │   ├── Criteria.class
│   │       │           │   ├── MemberVO.class
│   │       │           │   ├── PageDTO.class
│   │       │           │   ├── ReplyPageDTO.class
│   │       │           │   └── ReplyVO.class
│   │       │           ├── exception
│   │       │           │   └── CommonExceptionAdvice.class
│   │       │           ├── mapper
│   │       │           │   ├── BoardAttachMapper.class
│   │       │           │   ├── BoardMapper.class
│   │       │           │   ├── MemberMapper.class
│   │       │           │   └── ReplyMapper.class
│   │       │           ├── security
│   │       │           │   ├── CustomAccessDeniedHandler.class
│   │       │           │   ├── CustomLoginSuccessHandler.class
│   │       │           │   ├── CustomNoOpPasswordEncoder.class
│   │       │           │   ├── CustomUserDetailsService.class
│   │       │           │   └── domain
│   │       │           │       └── CustomerUser.class
│   │       │           ├── service
│   │       │           │   ├── BoardService.class
│   │       │           │   ├── BoardServiceImpl.class
│   │       │           │   ├── ReplyService.class
│   │       │           │   └── ReplyServiceImpl.class
│   │       │           └── task
│   │       │               └── FileCheckTask.class
│   │       └── test
│   │           └── org
│   │               └── zerock
│   │                   ├── controller
│   │                   │   ├── BoardControllerTests.class
│   │                   │   ├── ReplyControllerTests.class
│   │                   │   └── TicketControllerTest.class
│   │                   ├── mapper
│   │                   │   ├── BoardMapperTests.class
│   │                   │   ├── MemberMapperTests.class
│   │                   │   └── ReplyMapperTests.class
│   │                   ├── persistence
│   │                   │   ├── DataSourceTest.class
│   │                   │   └── JDBCTests.class
│   │                   ├── security
│   │                   │   └── MemberTests.class
│   │                   └── service
│   │                       └── BoardServiceTest.class
│   ├── generated
│   │   └── sources
│   │       ├── annotationProcessor
│   │       │   └── java
│   │       │       ├── main
│   │       │       └── test
│   │       └── headers
│   │           └── java
│   │               ├── main
│   │               └── test
│   ├── libs
│   │   └── SpringCRUD-1.0-SNAPSHOT.war
│   ├── reports
│   │   └── tests
│   │       └── test
│   │           ├── classes
│   │           │   └── org.zerock.mapper.MemberMapperTests.html
│   │           ├── css
│   │           │   ├── base-style.css
│   │           │   └── style.css
│   │           ├── index.html
│   │           ├── js
│   │           │   └── report.js
│   │           └── packages
│   │               └── org.zerock.mapper.html
│   ├── resources
│   │   └── main
│   │       ├── log4j.properties
│   │       ├── log4jdbc.log4j2.properties
│   │       └── org
│   │           └── zerock
│   │               └── mapper
│   │                   ├── BoardAttachMapper.xml
│   │                   ├── BoardMapper.xml
│   │                   ├── MemberMapper.xml
│   │                   └── ReplyMapper.xml
│   ├── test-results
│   │   └── test
│   │       ├── TEST-org.zerock.mapper.MemberMapperTests.xml
│   │       └── binary
│   │           ├── output.bin
│   │           ├── output.bin.idx
│   │           └── results.bin
│   └── tmp
│       ├── compileJava
│       ├── compileTestJava
│       └── war
│           └── MANIFEST.MF
├── build.gradle
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── lib
│   ├── aopalliance-1.0.jar
│   ├── commons-logging-1.2.jar
│   ├── ojdbc6.jar
│   ├── spring-aop-5.2.3.RELEASE.jar
│   ├── spring-aspects-5.2.3.RELEASE.jar
│   ├── spring-beans-5.2.3.RELEASE.jar
│   ├── spring-context-5.2.3.RELEASE.jar
│   ├── spring-context-support-5.2.3.RELEASE.jar
│   ├── spring-core-5.2.3.RELEASE.jar
│   ├── spring-expression-5.2.3.RELEASE.jar
│   ├── spring-instrument-5.2.3.RELEASE.jar
│   ├── spring-jdbc-5.2.3.RELEASE.jar
│   ├── spring-jms-5.2.3.RELEASE.jar
│   ├── spring-messaging-5.2.3.RELEASE.jar
│   ├── spring-orm-5.2.3.RELEASE.jar
│   ├── spring-oxm-5.2.3.RELEASE.jar
│   ├── spring-test-5.2.3.RELEASE.jar
│   └── spring-tx-5.2.3.RELEASE.jar
├── settings.gradle
├── src
│   ├── main
│   │   ├── java
│   │   │   └── org
│   │   │       ├── sample
│   │   │       │   ├── controller
│   │   │       │   │   └── SampleController.java
│   │   │       │   └── domain
│   │   │       │       ├── SampleVO.java
│   │   │       │       └── TicketVO.java
│   │   │       └── zerock
│   │   │           ├── aop
│   │   │           │   └── LogAdvice.java
│   │   │           ├── controller
│   │   │           │   ├── BoardController.java
│   │   │           │   ├── CommonController.java
│   │   │           │   ├── ReplyController.java
│   │   │           │   └── UploadController.java
│   │   │           ├── domain
│   │   │           │   ├── AttaachFileDTO.java
│   │   │           │   ├── AuthVO.java
│   │   │           │   ├── BoardAttachVO.java
│   │   │           │   ├── BoardVO.java
│   │   │           │   ├── Criteria.java
│   │   │           │   ├── MemberVO.java
│   │   │           │   ├── PageDTO.java
│   │   │           │   ├── ReplyPageDTO.java
│   │   │           │   └── ReplyVO.java
│   │   │           ├── exception
│   │   │           │   └── CommonExceptionAdvice.java
│   │   │           ├── mapper
│   │   │           │   ├── BoardAttachMapper.java
│   │   │           │   ├── BoardMapper.java
│   │   │           │   ├── MemberMapper.java
│   │   │           │   └── ReplyMapper.java
│   │   │           ├── security
│   │   │           │   ├── CustomAccessDeniedHandler.java
│   │   │           │   ├── CustomLoginSuccessHandler.java
│   │   │           │   ├── CustomNoOpPasswordEncoder.java
│   │   │           │   ├── CustomUserDetailsService.java
│   │   │           │   └── domain
│   │   │           │       └── CustomerUser.java
│   │   │           ├── service
│   │   │           │   ├── BoardService.java
│   │   │           │   ├── BoardServiceImpl.java
│   │   │           │   ├── ReplyService.java
│   │   │           │   └── ReplyServiceImpl.java
│   │   │           └── task
│   │   │               └── FileCheckTask.java
│   │   ├── resources
│   │   │   ├── log4j.properties
│   │   │   ├── log4jdbc.log4j2.properties
│   │   │   └── org
│   │   │       └── zerock
│   │   │           └── mapper
│   │   │               ├── BoardAttachMapper.xml
│   │   │               ├── BoardMapper.xml
│   │   │               ├── MemberMapper.xml
│   │   │               └── ReplyMapper.xml
│   │   └── webapp
│   │       ├── WEB-INF
│   │       │   ├── spring
│   │       │   │   ├── appServlet
│   │       │   │   │   └── servlet-context.xml
│   │       │   │   ├── root-context.xml
│   │       │   │   └── security-context.xml
│   │       │   ├── views
│   │       │   │   ├── accessError.jsp
│   │       │   │   ├── board
│   │       │   │   │   ├── get.jsp
│   │       │   │   │   ├── list.jsp
│   │       │   │   │   ├── modify.jsp
│   │       │   │   │   └── register.jsp
│   │       │   │   ├── custom404.jsp
│   │       │   │   ├── customLogin.jsp
│   │       │   │   ├── customLogout.jsp
│   │       │   │   ├── error_page.jsp
│   │       │   │   └── includes
│   │       │   │       ├── footer.jsp
│   │       │   │       └── header.jsp
│   │       │   └── web.xml
│   │       ├── index.jsp
│   │       └── resources
│   │           ├── LICENSE
│   │           ├── README.md
│   │           ├── bower.json
│   │           ├── data
│   │           │   ├── flot-data.js
│   │           │   └── morris-data.js
│   │           ├── dist
│   │           │   ├── css
│   │           │   │   ├── sb-admin-2.css
│   │           │   │   └── sb-admin-2.min.css
│   │           │   └── js
│   │           │       ├── sb-admin-2.js
│   │           │       └── sb-admin-2.min.js
│   │           ├── gulpfile.js
│   │           ├── img
│   │           │   ├── undraw_posting_photo.svg
│   │           │   ├── undraw_profile.svg
│   │           │   ├── undraw_profile_1.svg
│   │           │   ├── undraw_profile_2.svg
│   │           │   ├── undraw_profile_3.svg
│   │           │   └── undraw_rocket.svg
│   │           ├── index.html
│   │           ├── js
│   │           │   ├── reply.js
│   │           │   └── sb-admin-2.js
│   │           ├── less
│   │           │   ├── mixins.less
│   │           │   ├── sb-admin-2.less
│   │           │   └── variables.less
│   │           ├── package.json
│   │           ├── pages
│   │           │   ├── blank.html
│   │           │   ├── buttons.html
│   │           │   ├── flot.html
│   │           │   ├── forms.html
│   │           │   ├── grid.html
│   │           │   ├── icons.html
│   │           │   ├── index.html
│   │           │   ├── login.html
│   │           │   ├── morris.html
│   │           │   ├── notifications.html
│   │           │   ├── panels-wells.html
│   │           │   ├── tables.html
│   │           │   └── typography.html
│   │           └── vendor
│   │               ├── bootstrap
│   │               │   ├── css
│   │               │   │   ├── bootstrap.css
│   │               │   │   └── bootstrap.min.css
│   │               │   ├── fonts
│   │               │   │   ├── glyphicons-halflings-regular.eot
│   │               │   │   ├── glyphicons-halflings-regular.svg
│   │               │   │   ├── glyphicons-halflings-regular.ttf
│   │               │   │   ├── glyphicons-halflings-regular.woff
│   │               │   │   └── glyphicons-halflings-regular.woff2
│   │               │   └── js
│   │               │       ├── bootstrap.js
│   │               │       └── bootstrap.min.js
│   │               ├── bootstrap-social
│   │               │   ├── bootstrap-social.css
│   │               │   ├── bootstrap-social.less
│   │               │   └── bootstrap-social.scss
│   │               ├── datatables
│   │               │   ├── css
│   │               │   │   ├── dataTables.bootstrap.css
│   │               │   │   ├── dataTables.bootstrap.min.css
│   │               │   │   ├── dataTables.bootstrap4.css
│   │               │   │   ├── dataTables.bootstrap4.min.css
│   │               │   │   ├── dataTables.foundation.css
│   │               │   │   ├── dataTables.foundation.min.css
│   │               │   │   ├── dataTables.jqueryui.css
│   │               │   │   ├── dataTables.jqueryui.min.css
│   │               │   │   ├── dataTables.material.css
│   │               │   │   ├── dataTables.material.min.css
│   │               │   │   ├── dataTables.semanticui.css
│   │               │   │   ├── dataTables.semanticui.min.css
│   │               │   │   ├── dataTables.uikit.css
│   │               │   │   ├── dataTables.uikit.min.css
│   │               │   │   ├── jquery.dataTables.css
│   │               │   │   ├── jquery.dataTables.min.css
│   │               │   │   └── jquery.dataTables_themeroller.css
│   │               │   ├── images
│   │               │   │   ├── Sorting\ icons.psd
│   │               │   │   ├── favicon.ico
│   │               │   │   ├── sort_asc.png
│   │               │   │   ├── sort_asc_disabled.png
│   │               │   │   ├── sort_both.png
│   │               │   │   ├── sort_desc.png
│   │               │   │   └── sort_desc_disabled.png
│   │               │   └── js
│   │               │       ├── dataTables.bootstrap.js
│   │               │       ├── dataTables.bootstrap.min.js
│   │               │       ├── dataTables.bootstrap4.js
│   │               │       ├── dataTables.bootstrap4.min.js
│   │               │       ├── dataTables.foundation.js
│   │               │       ├── dataTables.foundation.min.js
│   │               │       ├── dataTables.jqueryui.js
│   │               │       ├── dataTables.jqueryui.min.js
│   │               │       ├── dataTables.material.js
│   │               │       ├── dataTables.material.min.js
│   │               │       ├── dataTables.semanticui.js
│   │               │       ├── dataTables.semanticui.min.js
│   │               │       ├── dataTables.uikit.js
│   │               │       ├── dataTables.uikit.min.js
│   │               │       ├── jquery.dataTables.js
│   │               │       ├── jquery.dataTables.min.js
│   │               │       └── jquery.js
│   │               ├── datatables-plugins
│   │               │   ├── dataTables.bootstrap.css
│   │               │   ├── dataTables.bootstrap.js
│   │               │   ├── dataTables.bootstrap.min.js
│   │               │   └── index.html
│   │               ├── datatables-responsive
│   │               │   ├── dataTables.responsive.css
│   │               │   ├── dataTables.responsive.js
│   │               │   └── dataTables.responsive.scss
│   │               ├── flot
│   │               │   ├── excanvas.js
│   │               │   ├── excanvas.min.js
│   │               │   ├── jquery.colorhelpers.js
│   │               │   ├── jquery.flot.canvas.js
│   │               │   ├── jquery.flot.categories.js
│   │               │   ├── jquery.flot.crosshair.js
│   │               │   ├── jquery.flot.errorbars.js
│   │               │   ├── jquery.flot.fillbetween.js
│   │               │   ├── jquery.flot.image.js
│   │               │   ├── jquery.flot.js
│   │               │   ├── jquery.flot.navigate.js
│   │               │   ├── jquery.flot.pie.js
│   │               │   ├── jquery.flot.resize.js
│   │               │   ├── jquery.flot.selection.js
│   │               │   ├── jquery.flot.stack.js
│   │               │   ├── jquery.flot.symbol.js
│   │               │   ├── jquery.flot.threshold.js
│   │               │   ├── jquery.flot.time.js
│   │               │   └── jquery.js
│   │               ├── flot-tooltip
│   │               │   ├── jquery.flot.tooltip.js
│   │               │   ├── jquery.flot.tooltip.min.js
│   │               │   └── jquery.flot.tooltip.source.js
│   │               ├── font-awesome
│   │               │   ├── HELP-US-OUT.txt
│   │               │   ├── css
│   │               │   │   ├── font-awesome.css
│   │               │   │   ├── font-awesome.css.map
│   │               │   │   └── font-awesome.min.css
│   │               │   ├── fonts
│   │               │   │   ├── FontAwesome.otf
│   │               │   │   ├── fontawesome-webfont.eot
│   │               │   │   ├── fontawesome-webfont.svg
│   │               │   │   ├── fontawesome-webfont.ttf
│   │               │   │   ├── fontawesome-webfont.woff
│   │               │   │   └── fontawesome-webfont.woff2
│   │               │   ├── less
│   │               │   │   ├── animated.less
│   │               │   │   ├── bordered-pulled.less
│   │               │   │   ├── core.less
│   │               │   │   ├── extras.less
│   │               │   │   ├── fixed-width.less
│   │               │   │   ├── font-awesome.less
│   │               │   │   ├── icons.less
│   │               │   │   ├── larger.less
│   │               │   │   ├── list.less
│   │               │   │   ├── mixins.less
│   │               │   │   ├── path.less
│   │               │   │   ├── rotated-flipped.less
│   │               │   │   ├── screen-reader.less
│   │               │   │   ├── spinning.less
│   │               │   │   ├── stacked.less
│   │               │   │   └── variables.less
│   │               │   └── scss
│   │               │       ├── _animated.scss
│   │               │       ├── _bordered-pulled.scss
│   │               │       ├── _core.scss
│   │               │       ├── _extras.scss
│   │               │       ├── _fixed-width.scss
│   │               │       ├── _icons.scss
│   │               │       ├── _larger.scss
│   │               │       ├── _list.scss
│   │               │       ├── _mixins.scss
│   │               │       ├── _path.scss
│   │               │       ├── _rotated-flipped.scss
│   │               │       ├── _screen-reader.scss
│   │               │       ├── _spinning.scss
│   │               │       ├── _stacked.scss
│   │               │       ├── _variables.scss
│   │               │       └── font-awesome.scss
│   │               ├── jquery
│   │               │   ├── jquery.js
│   │               │   └── jquery.min.js
│   │               ├── metisMenu
│   │               │   ├── metisMenu.css
│   │               │   ├── metisMenu.js
│   │               │   ├── metisMenu.min.css
│   │               │   └── metisMenu.min.js
│   │               ├── morrisjs
│   │               │   ├── morris.css
│   │               │   ├── morris.js
│   │               │   └── morris.min.js
│   │               └── raphael
│   │                   ├── raphael.js
│   │                   └── raphael.min.js
│   └── test
│       ├── java
│       │   └── org
│       │       └── zerock
│       │           ├── controller
│       │           │   ├── BoardControllerTests.java
│       │           │   ├── ReplyControllerTests.java
│       │           │   └── TicketControllerTest.java
│       │           ├── mapper
│       │           │   ├── BoardMapperTests.java
│       │           │   ├── MemberMapperTests.java
│       │           │   └── ReplyMapperTests.java
│       │           ├── persistence
│       │           │   ├── DataSourceTest.java
│       │           │   └── JDBCTests.java
│       │           ├── security
│       │           │   └── MemberTests.java
│       │           └── service
│       │               └── BoardServiceTest.java
│       └── resources
└── upload
```
