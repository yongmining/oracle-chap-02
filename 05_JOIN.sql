-- 조인(JOIN)
-- JOIN : 두 개의 테이블을 하나로 합쳐서 결과를 조회한다.

-- 오라클 전용 구문
-- FROM절에 ','로 구분하여 사용할 테이블을 다 기술한다.
-- WHERE절에 합치기에 사용할 컬럼을 이용하여 조건을 기술한다.

-- 연결에 사용할 두 컬럼명이 다른 경우
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , DEPT_TITLE
   FROM EMPLOYEE
      , DEPARTMENT
  WHERE DEPT_CODE = DEPT_ID;
  
SELECT
        EMP_ID
      , EMP_NAME
      , EMPLOYEE.JOB_CODE
      , JOB_NAME
   FROM EMPLOYEE
      , JOB
  WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
  
-- 테이블에 별칭 이용
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.JOB_CODE
      , J.JOB_NAME
   FROM EMPLOYEE E
      , JOB J
  WHERE E.JOB_CODE = J.JOB_CODE;

-- ANSI 표준 구문
-- 연결에 사용할 컬럼명이 같은 경우 USING(컬럼명)
SELECT
        EMP_ID
      , EMP_NAME
      , JOB_CODE
      , JOB_NAME
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);

-- 연결에 사용할 컬럼명이 다른 경우 ON()을 사용
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , DEPT_TITLE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
   
-- 컬럼명이 같은 경우에도 ON()을 사용할 수 있다.
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.JOB_CODE
      , J.JOB_NAME
   FROM EMPLOYEE E
   JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 부서 테이블과 지역 테이블을 조인하여 테이블의 모든 데이터를 조회하세요
-- ANSI 표준
SELECT
       D.*
     , L.*
   FROM DEPARTMENT D
   JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 오라클 전용
SELECT
        D.*
      , L.*
   FROM DEPARTMENT D
       , LOCATION L
  WHERE D.LOCATION_ID = L.LOCAL_CODE;
  
-- 조인의 기본이 EQUAL JOIN이다. (EQU JOIN 이라고도 함) (등가조인)
-- 일치하는 값이 없는 행은 조인에서 제외하는 것을 INNER JOIN 이라고 한다. (NULL값은 조인에서 제외)

-- JOIN의 기본은 INNER JOIN& EQUAL JOIN 이다.

-- OUTER JOIN : 두 테이블의 지정하는 컬럼 값이 일치하지 않는 행도(NULL값을 가진 행)
--              조인 결과에 포함시킴
--              OUTER JOIN임을 명시해야 한다.

-- 1. LEFT OUTER JOIN : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 행의 수를 기준으로 JOIN
-- 2. RIGHT OUTER JOIN : 합치기에 사용한 두 테이블중 오른편에 기술된 테이블의 행의 수를 기준으로 JOIN
-- 3. FULL OUTER JOIN : 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함시켜 JOIN
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
   
-- LEFT OUTER JOIN
-- ANSI 표준
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
-- LEFT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
   LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ORACLE 전용
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
      , DEPARTMENT
  WHERE DEPT_CODE = DEPT_ID(+);
  
-- RIGHT OUTER JOIN
-- ANSI
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
-- RIGHT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
   RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ORACLE
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
      , DEPARTMENT
  WHERE DEPT_CODE(+) = DEPT_ID;
  
-- FULL OUTER JOIN
-- ANSI
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
   FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE
-- 오라클 전용 구문으로는 FULL OUTER JOIN을 하지 못한다.
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
      , DEPARTMENT
  WHERE DEPT_CODE(+) = DEPT_ID(+);
  
-- CROSS JOIN : 카테이션곱
--              조인되는 테이블의 각 형들이 모두 매핑된 데이터가 검색되는 방식
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
  CROSS JOIN DEPARTMENT;
  
SELECT
        EMP_NAME
      , DEPT_TITLE
   FROM EMPLOYEE
      , DEPARTMENT;

-- NON EQUAL JOIN (NON EQU JOIN - 비등가 조인)
-- : 지정한 컬럼의 값이 일치하는 경우가 아닌 값의 범위에 포함되는 행들을 연결하는 방식
-- ANSI
SELECT
        EMP_NAME
      , SALARY
      , E.SAL_LEVEL
      , S.SAL_LEVEL
   FROM EMPLOYEE E
   JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
   
--ORACLE
SELECT
        EMP_NAME
      , SALARY
      , E.SAL_LEVEL
      , S.SAL_LEVEL
   FROM EMPLOYEE E
      , SAL_GRADE S
  WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
  
-- SELF JOIN : 동일한 테이블을 조인하는 것(자가조인)
-- 오라클 전용
SELECT
        E1.EMP_ID
      , E1.EMP_NAME
      , E1.DEPT_CODE
      , E1.MANAGER_ID
      , E2.EMP_NAME 관리자이름
   FROM EMPLOYEE E1
      , EMPLOYEE E2
  WHERE E1.MANAGER_ID = E2.EMP_ID;

-- ANSI표준
SELECT
        E1.EMP_ID
      , E1.EMP_NAME 사원명
      , E1.DEPT_CODE
      , E1.MANAGER_ID
      , E2.EMP_NAME 관리자이름
   FROM EMPLOYEE E1
   JOIN EMPLOYEE E2 ON (E1.MANAGER_ID = E2.EMP_ID);

-- 다중 조인 : 여러 개 테이블 조인
-- ANSI
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , DEPT_TITLE
      , LOCAL_NAME
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
   JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- ORACLE
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , DEPT_TITLE
      , LOCAL_NAME
   FROM EMPLOYEE
      , DEPARTMENT
      , LOCATION
  WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;
    
-- 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회 시에는 모든 컬럼에 테이블 별칭을 붙여서 조회한다.)

-- ANSI 표준
SELECT
        E.EMP_ID 사번
      , E.EMP_NAME 이름
      , J.JOB_NAME 직급명
      , D.DEPT_TITLE 부서명
      , L.LOCAL_NAME 근무지역명
      , E.SALARY 급여
   FROM EMPLOYEE E
   JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
   JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
  WHERE J.JOB_NAME = '대리'
    AND L.LOCAL_NAME LIKE 'ASIA%';

-- 오라클 전용
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , J.JOB_NAME
      , D.DEPT_TITLE
      , L.LOCAL_NAME
      , E.SALARY 급여
   FROM EMPLOYEE E
      , DEPARTMENT D
      , JOB J
      , LOCATION L 
  WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND J.JOB_NAME = '대리'
    AND L.LOCAL_NAME LIKE 'ASIA%';