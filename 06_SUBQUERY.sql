-- SUBQUERY(서브쿼리)
-- 사원명이 노옹철인 사람의 부서 조회
SELECT
        E.DEPT_CODE
   FROM EMPLOYEE E
  WHERE E.EMP_NAME = '노옹철';
  
-- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
SELECT
        E.EMP_NAME
   FROM EMPLOYEE E
  WHERE E.DEPT_CODE = (SELECT E2.DEPT_CODE
                        FROM EMPLOYEE E2
                         WHERE E2.EMP_NAME = '노옹철'
                        );
        
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.JOB_CODE
      , E.SALARY
   FROM EMPLOYEE E
  WHERE E.SALARY > (SELECT AVG(E2.SALARY)
                    FROM EMPLOYEE E2
                    );
  
SELECT
        AVG(E.SALARY)
   FROM EMPLOYEE;
   
-- 서브쿼리의 유형
-- 단일행 서브쿼리
-- 다중행 서브쿼리
-- 다중열 서브쿼리
-- 다중행 다중열 서브쿼리

-- 서브쿼리 유형에 따라 서브쿼리 앞에 붙는 연산자가 다르다
-- 단일행 서브쿼리 앞에는 일반 비교 연산자 사용 가능
-- >, <, >=, <=, =,  !=/<>/^=

-- 노옹철 사원의 급여보다 많은 급여를 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회하세요
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.DEPT_CODE
      , E.JOB_CODE
      , E.SALARY
   FROM EMPLOYEE E
  WHERE E.SALARY > (SELECT E2.SALARY
                     FROM EMPLOYEE E2
                    WHERE E2.EMP_NAME = '노옹철'
                    );

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY 절에서 사용 가능하다.
-- 부서별 급여의 합계 중 가장 큰 부서의 부서명 급여 합계를 구하세요
SELECT
        D.DEPT_TITLE
      , SUM(E.SALARY)
   FROM EMPLOYEE E
   LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  GROUP BY D.DEPT_TITLE
 HAVING SUM(E.SALARY) = (SELECT MAX(SUM(E2.SALARY))
                          FROM EMPLOYEE E2
                         GROUP BY DEPT_CODE
                         );
                         
-- 다중행 서브쿼리
-- 다중행 서브쿼리 앞에는 일반 비교연산자 사용하지 못함
-- IN / NOT IN 연산자 : 여러 개 결과값 중에서 한 개라도 일치하는 값이 있다면 TRUE / FALSE
-- > ANY, <ANY : 여러 개의 결과 값 중에서 한 개라도 큰/작은 경우
--               가장 작은 값 보다 크냐? / 가장 큰 값 보다 작냐?
-- > ALL, <ALL : 모든 값 보다 큰 / 작은 경우
--               가장 큰 값 보다 크냐? / 가장 작은 값 보다 작냐?
-- EXISTS / NOT EXISTS : 값이 존재하냐? 존재하지 않느냐?

-- 부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT
        E.DEPT_CODE
      , MAX(E.SALARY)
   FROM EMPLOYEE E
  GROUP BY E.DEPT_CODE;
  
SELECT
        E.EMP_NAME
      , E.JOB_CODE
      , E.DEPT_CODE
      , E.SALARY
   FROM EMPLOYEE E
  WHERE E.SALARY IN (SELECT MAX(E2.SALARY)
                       FROM EMPLOYEE E2
                      GROUP BY E2.DEPT_CODE
                      );
                    

-- 대리 직급의 직원들 중 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급명, 급여를 조회하세요
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , J.JOB_NAME
      , E.SALARY
   FROM EMPLOYEE E
   JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  WHERE J.JOB_NAME = '과장';
  
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , J.JOB_NAME
      , E.SALARY
   FROM EMPLOYEE E
   JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  WHERE J.JOB_NAME = '대리'
    AND E.SALARY > ANY (SELECT E2.SALARY
                          FROM EMPLOYEE E2
                          JOIN JOB J2 ON(E2.JOB_CODE = J2.JOB_CODE)
                         WHERE J2.JOB_NAME = '과장'
                         );

-- 차장 직급의 급여의 가장 큰 값 보다 많이 받는 과장 직급의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ALL 혹은 < ALL 연산자를 이용
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , J.JOB_CODE
      , E.SALARY
   FROM EMPLOYEE E
   JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  WHERE J.JOB_NAME = '과장'
    AND E.SALARY > ALL (SELECT E2.SALARY
                          FROM EMPLOYEE E2
                          JOIN JOB J2 ON (E2.JOB_CODE = J2.JOB_CODE)
                          WHERE J.JOB_NAME = '차장'
                          );
                          
SELECT
        E.*
   FROM EMPLOYEE E
  WHERE EXISTS (SELECT E2.*
                  FROM EMPLOYEE E2
                 WHERE E2.EMP_ID = '200'
                );

-- 자기 직급이 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요 (TRUNC(컬럼명, -5)
SELECT
        E.JOB_CODE
      , TRUNC(AVG(E.SALARY),-5)
   FROM EMPLOYEE E
  GROUP BY E.JOB_CODE;

SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.JOB_CODE
      , E.SALARY
   FROM EMPLOYEE E
  WHERE E.SALARY IN (SELECT TRUNC(AVG(E2.SALARY),-5)
                       FROM EMPLOYEE E2
                       GROUP BY E.JOB_CODE
                         );

-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의
-- 이름, 직급, 부서, 입사일 조회
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.JOB_CODE
      , E.DEPT_CODE
   FROM EMPLOYEE E
  WHERE SUBSTR(E.EMP_NO,8,1) = '2'
    AND E.ENT_YN = 'Y';
    
SELECT
        E.EMP_NAME
      , E.JOB_CODE
      , E.DEPT_CODE
      , E.HIRE_DATE
   FROM EMPLOYEE E
  WHERE (E.DEPT_CODE, E.JOB_CODE) IN (SELECT E2.DEPT_CODE
                                           , E2.JOB_CODE
                                        FROM EMPLOYEE E2
                                       WHERE SUBSTR(E2.EMP_NO, 8, 1) = '2'
                                         AND ENT_YN = 'Y'
                                        )
    AND E.EMP_ID NOT IN (SELECT E3.EMP_ID
                           FROM EMPLOYEE E3
                          WHERE SUBSTR(E3.EMP_NO, 8, 1) = '2' 
                            AND ENT_YN = 'Y'
                        );
 
-- FROM 절에 서브쿼리를 사용할 수 있다.
-- 인라인 뷰(INLINE VIEW)라고 함
SELECT
        E.EMP_NAME
      , J.JOB_NAME
      , E.SALARY
   FROM (SELECT E2.JOB_CODE
              , TRUNC(AVG(E2.SALARY), -5) AS JOBAVG
           FROM EMPLOYEE E2
          GROUP BY E2.JOB_CODE
        ) V
   JOIN EMPLOYEE E ON(V.JOBAVG = E.SALARY AND E.JOB_CODE = V.JOB_CODE)
   JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  ORDER BY J.JOB_NAME;

SELECT
        V.EMP_NAME
      , V.부서명
      , V.직급이름
  FROM (SELECT EMP_NAME
             , DEPT_TITLE 부서명
             , JOB_NAME 직급이름
          FROM EMPLOYEE E
          LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
          JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
        ) V
  WHERE V.부서명 = '인사관리부';

-- 인라인뷰를 활용한 TOP-N 분석
SELECT
        ROWNUM  -- 가상 컬럼
      , E.EMP_NAME
      , E.SALARY
   FROM EMPLOYEE E
  ORDER BY E.SALARY;
  
SELECT
        ROWNUM
      , V.EMP_NAME
      , V.SALARY
   FROM (SELECT E.*
            FROM EMPLOYEE E
         ORDER BY E.SALARY DESC
         ) V
    WHERE ROWNUM <= 5;
    
SELECT
        V2.RNUM
      , V2.EMP_NAME
      , V2.SALARY
   FROM (SELECT ROWNUM RNUM
              , V.EMP_NAME
              , V.SALARY
           FROM (SELECT E.EMP_NAME
                      , E.SALARY
                   FROM EMPLOYEE E
                  ORDER BY E.SALARY DESC
                ) V
            )V2
 WHERE RNUM BETWEEN 6 AND 10;
 
 -- STOPKEY 활용
 SELECT
        V2.RNUM
      , V2.EMP_NAME
      , V2.SALARY
   FROM (SELECT ROWNUM RNUM
              , V.EMP_NAME
              , V.SALARY
           FROM (SELECT E.EMP_NAME
                      , E.SALARY
                   FROM EMPLOYEE E
                  ORDER BY E.SALARY DESC
                ) V
            WHERE ROWNUM <11
        )V2
    WHERE RNUM > 5;

-- 급여 평균 3위 안에 드는 부서의
-- 부서코드, 부서명, 평균급여를 조회하세요
SELECT 
         V.DEPT_CODE
       , V.DEPT_TITLE
       , V.평균급여
     FROM(SELECT E.DEPT_CODE
               , D.DEPT_TITLE
               , AVG(E.SALARY) 평균급여
            FROM EMPLOYEE E
            JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID) 
           GROUP BY E.DEPT_CODE, D.DEPT_TITLE
           ORDER BY AVG(E.SALARY) DESC
        ) V
    
    WHERE ROWNUM <= 3;

SELECT 
         V.DEPT_CODE
       , D.DEPT_TITLE
       , V.평균급여
     FROM(SELECT E.DEPT_CODE        
               , AVG(E.SALARY) 평균급여
            FROM EMPLOYEE E
           GROUP BY E.DEPT_CODE
           ORDER BY AVG(E.SALARY) DESC
        ) V
     JOIN DEPARTMENT D ON (V.DEPT_CODE = D.DEPT_ID) 
    WHERE ROWNUM <= 3;
    
-- RANK () : 동일한 순위 이후의 등수를 동일한 인원 수 만큼 건너뛰고 순위를 계산하는 방식
-- DENSE_RANK() : 중복되는 순위 이후의 등수를 이후 등수로 처리하는 방식
SELECT
        E.EMP_NAME
      , E.SALARY
      , RANK() OVER(ORDER BY E.SALARY DESC)순위
   FROM EMPLOYEE E;

SELECT
        E.EMP_NAME
      , E.SALARY
      , DENSE_RANK() OVER(ORDER BY E.SALARY DESC) 순위
   FROM EMPLOYEE E;

SELECT
        V.*
    FROM (SELECT E.EMP_NAME
               , E.SALARY
               , RANK() OVER(ORDER BY E.SALARY DESC)순위
            FROM EMPLOYEE E
        ) V
    WHERE V.순위 BETWEEN 10 AND 19;
    
-- 상[호연]관 서브쿼리
-- 메인쿼리의 값이 변경되는거에 따라 서브쿼리에 영향을 미치고
-- 서브쿼리가 만들어진 값을 메인쿼리가 사용하는 상호 연관되어 있는 서브쿼리

-- 관리자 사번에 EMPLOYEE 테이블에 존재하는 직원에 대한 정보 조회
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.DEPT_CODE
      , E.MANAGER_ID
   FROM EMPLOYEE E
  WHERE EXISTS (SELECT E2.EMP_ID
                  FROM EMPLOYEE E2
                 WHERE E.MANAGER_ID = E2.EMP_ID
                );

-- 스칼라 서브쿼리
-- 단일행 서브쿼리 + 상관쿼리
SELECT
        E.EMP_NAME
      , E.JOB_CODE
      , E.SALARY
   FROM EMPLOYEE E
  WHERE E.SALARY > (SELECT TRUNC(AVG(E2.SALARY), -5)
                      FROM EMPLOYEE E2
                     WHERE E.JOB_CODE = E2.JOB_CODE
                    );
                    
-- SELECT절에서 스칼라 서브쿼리 이용
-- 모든 사원의 사번, 이름, 관리자사번, 관리자명을 조회
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.MANAGER_ID
      , NVL((SELECT E2.EMP_NAME
               FROM EMPLOYEE E2
              WHERE E.MANAGER_ID = E2.EMP_ID
            ), '없음')
   FROM EMPLOYEE E
  ORDER BY 1;
  
-- ORDER BY 절에서 스칼라 서브쿼리 이용
-- 모든 직원의 사번, 이름, 소속부서 조회
-- 단 부서명 내림차순 정렬
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.DEPT_CODE
   FROM EMPLOYEE E
  ORDER BY (SELECT D.DEPT_TITLE
              FROM DEPARTMENT D
             WHERE E.DEPT_CODE = D.DEPT_ID
            ) DESC NULLS LAST;
    