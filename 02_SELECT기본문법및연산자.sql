--SELECT 기본 문법 및 연산자

-- EMPLOYEE 테이블의 모든 정보 조회
SELECT
    *
  FROM EMPLOYEE;

-- 특정 컬럼 조희
-- EMPLOYEE 테이블의 사번, 이름 조회

SELECT
        EMP_ID
     ,  EMP_NAME
 FROM   EMPLOYEE;
 
 -- 원하는 행 조회
 -- EMPLOYEE 테이블에서 부서코드가 D9인 사원 조회
 SELECT
        *
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
 
 -- EMPLOYEE 테이블에서 직급코드가 J1인 사원 조회
 
SELECT
        *
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J1';
 
 -- 원하는 행과 컬럼 조회
 -- EMPLOYEE 테이블에서 급여가 300만원 이상인 사원의
 -- 사번, 이름, 부서코드, 급여를 조회하세요
 
 SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , SALARY
 FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 컬럼에 별칭 짓기
-- AS + 별칭을 기술하여 별칭을 지을 수 있다.
-- 단, 숫자, 특수문자 등이 들어가는 별칭을 이용하는 경우 ""로 별칭을 감싸야 한다.
-- AS 생략 가능함

SELECT
        EMP_NAME AS 이름
      , SALARY * 12 AS "1년급여"
      , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "보너스를포함연봉"
 FROM EMPLOYEE;
 
-- 임의로 지정한 문자열을 SELECT절에서 사용할 수 있다.
SELECT
        EMP_ID
      , EMP_NAME
      , SALARY
      , '원' AS 단위
    FROM EMPLOYEE;
    
-- DISTINCT 키워드는 중복된 컬럼값을 제거하여 조회한다.
SELECT
        DISTINCT JOB_CODE
    FROM EMPLOYEE;
-- DISTINCT 키워드는 SELECT 절에서 딱 한 번만 사용 가능하다.
-- 여러 개 컬럼을 묶어서 중복을 제외시킨다.
SELECT
        DISTINCT JOB_CODE
      , /* DISTINCT */ DEPT_CODE
 FROM EMPLOYEE;
 
 -- WHERE 절
 -- 테이블에서 조건을 만족하는 행을 골라낼 때 사용한다.
 -- 조건이 다중인 경우 AND 혹은 OR를 사용할 수 있다.
 
 -- 부서코드가 D6이고 급여를 200만원보다 많이 받는 직원으
 -- 이름, 부서코드, 급여 조회
 SELECT
         EMP_NAME
       , DEPT_CODE
       , SALARY
    FROM EMPLOYEE
   WHERE DEPT_CODE = 'D6' 
     AND SALARY >= 2000000;
     
-- 보너스를 지급받지 않는 사원의
-- 사번, 이름, 급여, 보너스를 조회하세요

SELECT  
        EMP_ID
      , EMP_NAME
      , SALARY
      , BONUS
   FROM EMPLOYEE
--  WHERE BONUS is NOT NULL;
  WHERE NOT BONUS IN NULL;
  
-- 연결연산자를 이용하여 여러 컬럼의 값을 하나의 컬럼의 값인 것 처럼 연결할 수 있다.
SELECT
        EMP_ID || EMP_NAME || SALARY
   FROM EMPLOYEE;

SELECT
        EMP_NAME || '의 월급은' || SALARY || '원 입니다.'
   FROM EMPLOYEE;
   
-- 비교연산자
-- = 같냐?, > 크냐? < 작냐? , >= 크거나 같냐?, <= 작거나 같냐?
-- !=, ^=, <> 같지 않냐?

SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
   FROM EMPLOYEE
 -- WHERE DEPT_CODE != 'D9';
 -- WHERE DEPT_CODE ^= 'D9';  
  WHERE DEPT_CODE <> 'D9';
  
-- EMPLOYEE 테이블에서 퇴사여부가 N인 직원(퇴사하지 않은 직원)을 조회하고
-- 근무여부를 별칭으로 재직중 이라는 문자열을 결과집합에 포함하여 조회
-- 사번, 이름, 입사일, 근무여부 를 조회하세요

SELECT
        EMP_ID
      , EMP_NAME
      , HIRE_DATE
      , '재직중' 근무여부
   FROM EMPLOYEE
  WHERE ENT_YN = 'N';
  
-- EMPLOYEE 테이블에서 급여를 350만원 이상
-- 550만원 이하를 받는
-- 직원의 사번, 이름, 급여, 부서코드, 직급코드를 조회하세요

SELECT
        EMP_ID
      , EMP_NAME
      , SALARY
      , DEPT_CODE
      , JOB_CODE
   FROM EMPLOYEE
  WHERE SALARY >= 3500000
    AND SALARY <= 5500000;
    
    
-- BETWEEN AND 연산자
-- 컬럼명 BETWEEN 하한값 AND 상한값
-- : 하한값 이상, 상한값 이하의 값
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , JOB_CODE
   FROM EMPLOYEE
--  WHERE NOT SALARY  BETWEEN 3500000 AND 5500000;
  WHERE SALARY > 5500000
     OR SALARY < 3500000;

-- LIKE 연산자 : 문자 패턴이 일치하는 값을 조회할 때 사용
-- 컬럼명 LIKE '문자패턴'
-- 문자패턴 : '문자%' (문자로 시작하는 값)
--          '%문자%' ( 문자를 포함하는 값)
--          '%문자' (문자로 끝나는 값)

-- EMPLOYEE 테이블에서 성이 김씨인 직원의
-- 사번, 이름, 입사일 조회

SELECT
        EMP_ID
      , EMP_NAME
      , HIRE_DATE
   FROM EMPLOYEE
--  WHERE EMP_NAME LIKE '김%';
 WHERE  EMP_NAME NOT LIKE '김%';

-- EMPLOYEE 테이블에서 '하'가 이름에 포함된 직원의
-- 이름, 주민번호, 부서코드 조회

SELECT
        EMP_NAME
      , EMP_NO
      , DEPT_CODE
   FROM EMPLOYEE
  WHERE EMP_NAME LIKE '%하%';
  
-- % (0개 이상의 글자) _(글자 한 자리)

-- EMPLOYEE 테이블에서 전화번호 국번이 9로 시작하는 직원의
-- 사번, 이름, 전화번호를 조회하세요

SELECT 
      EMP_ID
   ,  EMP_NAME
   ,  PHONE
 FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMPLOYEE 테이블에서 전화번호 국번이 4자리이면서
-- 9로 시작하는 직원으  사번, 이름, 전화번호를 조회하세요

SELECT
        EMP_ID
      , EMP_NAME
      , PHONE
   FROM EMPLOYEE
  WHERE PHONE LIKE '___9_______';
  
-- EMPLOYEE 테이블에서 이메일 주소의 _ 앞글자가 3자리인 이메일 주소를 가진
-- 사원의 사번, 이름, 이메일주소 조회

SELECT
        EMP_ID
      , EMP_NAME
      , EMAIL
   FROM EMPLOYEE
  WHERE EMAIL LIKE '___@_%' ESCAPE '@';
  
-- 부서코드가 'D6'이거나 'D8'인 직원의
-- 이름, 부서, 급여를 조회하세요
-- IN 연산자 : 비교하려는 값 목록에 일치하는 값이 있는지 확인

SELECT
        EMP_NAME
      , DEPT_CODE
      , SALARY
   FROM EMPLOYEE
  WHERE DEPT_CODE IN('D6','D8');
  
-- 연산자 우선순위
/*
1. 산술연산자
2. 연결연산자
3. 비교연산자
4. IS NULL/IS NOT NULL, LIKE/NOT LIKE, IN/NOT IN
5. BETWEEN AND/NOT BETWEEN AND
6. NOT
7. AND
8. OR
*/

-- J7 직급이거나 J2 직급인 직원들 중
-- 급여가 200만원 이상인 직원의
-- 이름, 급여, 직급코드를 조회하세요

-- J2 직급의 급여 200만원 이상 받는 지원이거나
-- J7 직급인 직원의 이름, 급여, 직급코드 조회
SELECT
        EMP_NAME
      , SALARY
      , JOB_CODE
   FROM EMPLOYEE
  WHERE (JOB_CODE = 'J7'
     OR JOB_CODE = 'J2')
    AND SALARY >= 2000000;
  
  