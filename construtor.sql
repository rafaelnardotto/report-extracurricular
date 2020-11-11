DROP TABLE NOTAS_EXTRAS;
TRUNCATE TABLE NOTAS_EXTRAS;

CREATE TABLE NOTAS_EXTRAS (
    IES VARCHAR(500),
    COURSE_ID VARCHAR(500),
    COURSE_NAME VARCHAR(500),
    USER_ID VARCHAR(500),
    JOB_TITLE VARCHAR(500),
    TITLE VARCHAR(500),
    NOTA VARCHAR(500),
    APROVA VARCHAR(500),
    ATTEMPT_DATE VARCHAR(500)
);

INSERT INTO NOTAS_EXTRAS
SELECT      DISTINCT
            DECODE(SUBSTR(U.USER_ID,0,2),
              '01','UAM',
              '02','BSP',
              '03','UNIFACS',
              '04', 'UNP',
              '05', 'UNIRITTER',
              '06', 'FMU',
              '07', 'UNN',
              '08', 'IBMR',
              '09', 'FG',
              '10', 'FPB',
              '11', 'FADERGS',
              '12', 'CEDEPE',
              '13', 'FAPA',
              '14', 'FIAMFAAM',
              '*ADM*') IES,
            CM.COURSE_ID,
            CM.COURSE_NAME,
            U.USER_ID,
            U.JOB_TITLE,
            GM.TITLE,
            AT.SCORE SCORE,
            CASE WHEN AT.SCORE > '6,9' THEN 'APROVADO' ELSE 'REPROVADO' END APROVA,
            CASE WHEN AT.STATUS IN ('7', '6', '9', '3', '8') THEN TO_CHAR(AT.ATTEMPT_DATE) ELSE '' END LAST_ATTEMPT_DATE
FROM        BBLEARN.COURSE_MAIN@BB CM
INNER JOIN  BBLEARN.COURSE_USERS@BB CU
            ON CU.CRSMAIN_PK1 = CM.PK1
            AND CU.ROLE = 'S'
INNER JOIN  BBLEARN.USERS@BB U
            ON U.PK1 = CU.USERS_PK1
INNER JOIN  BBLEARN.GRADEBOOK_MAIN@BB GM
            ON GM.CRSMAIN_PK1 = CM.PK1
            AND GM.DELETED_IND = 'N'
            AND GM.SCORE_PROVIDER_HANDLE IS NOT NULL
LEFT JOIN   BBLEARN.GRADEBOOK_GRADE@BB GG
            ON GG.GRADEBOOK_MAIN_PK1 = GM.PK1
            AND GG.COURSE_USERS_PK1 = CU.PK1
            AND GG.STATUS IS NOT NULL
LEFT JOIN   BBLEARN.ATTEMPT@BB AT
            ON AT.GRADEBOOK_GRADE_PK1 = GG.PK1
WHERE       CM.AVAILABLE_IND = 'Y'
            AND CM.COURSE_ID IN ('gd.nivelamento_proficiencia.100','gd.complementares_algebra.100','gd.complementares_algebra.20.01','gd.complementares_algebra.20.03','gd.complementares_algebra.20.04','gd.complementares_algebra.20.05','gd.complementares_algebra.20.06','gd.complementares_algebra.20.07','gd.complementares_algebra.20.08','gd.complementares_algebra.20.09','gd.complementares_algebra.20.10','gd.complementares_algebra.20.11','gd.complementares_algebra.20.13','gd.complementares_algebra.20.14','gd.complementares_comeficaz.100','gd.complementares_comeficaz.20.01','gd.complementares_comeficaz.20.03','gd.complementares_comeficaz.20.04','gd.complementares_comeficaz.20.05','gd.complementares_comeficaz.20.06','gd.complementares_comeficaz.20.07','gd.complementares_comeficaz.20.08','gd.complementares_comeficaz.20.09','gd.complementares_comeficaz.20.10','gd.complementares_comeficaz.20.11','gd.complementares_comeficaz.20.13','gd.complementares_comeficaz.20.14','gd.complementares_estatistica.100','gd.complementares_estatistica.20.01','gd.complementares_estatistica.20.03','gd.complementares_estatistica.20.04','gd.complementares_estatistica.20.05','gd.complementares_estatistica.20.06','gd.complementares_estatistica.20.07','gd.complementares_estatistica.20.08','gd.complementares_estatistica.20.09','gd.complementares_estatistica.20.10','gd.complementares_estatistica.20.11','gd.complementares_estatistica.20.13','gd.complementares_estatistica.20.14','gd.complementares_graficos.100','gd.complementares_graficos.20.01','gd.complementares_graficos.20.03','gd.complementares_graficos.20.05','gd.complementares_graficos.20.06','gd.complementares_graficos.20.07','gd.complementares_graficos.20.08','gd.complementares_graficos.20.09','gd.complementares_graficos.20.10','gd.complementares_graficos.20.11','gd.complementares_graficos.20.13','gd.complementares_graficos.20.14','gd.complementares_leitura.100','gd.complementares_leitura.20.01','gd.complementares_leitura.20.03','gd.complementares_leitura.20.04','gd.complementares_leitura.20.05','gd.complementares_leitura.20.06','gd.complementares_leitura.20.07','gd.complementares_leitura.20.08','gd.complementares_leitura.20.09','gd.complementares_leitura.20.10','gd.complementares_leitura.20.11','gd.complementares_leitura.20.13','gd.complementares_leitura.20.14','gd.complementares_prepare.100','gd.complementares_prepare.20.01','gd.complementares_prepare.20.03','gd.complementares_prepare.20.04','gd.complementares_prepare.20.05','gd.complementares_prepare.20.06','gd.complementares_prepare.20.07','gd.complementares_prepare.20.08','gd.complementares_prepare.20.09','gd.complementares_prepare.20.10','gd.complementares_prepare.20.11','gd.complementares_prepare.20.13','gd.complementares_prepare.20.14','gd.complementares_tecnicas.100','gd.complementares_tecnicas.20.01','gd.complementares_tecnicas.20.03','gd.complementares_tecnicas.20.04','gd.complementares_tecnicas.20.05','gd.complementares_tecnicas.20.06','gd.complementares_tecnicas.20.07','gd.complementares_tecnicas.20.08','gd.complementares_tecnicas.20.09','gd.complementares_tecnicas.20.10','gd.complementares_tecnicas.20.11','gd.complementares_tecnicas.20.13','gd.complementares_tecnicas.20.14','gd.estudante_ensinosuperior.100','gd.estudante_ensinosuperior.20.01','gd.estudante_ensinosuperior.20.03','gd.estudante_ensinosuperior.20.04','gd.estudante_ensinosuperior.20.05','gd.estudante_ensinosuperior.20.06','gd.estudante_ensinosuperior.20.07','gd.estudante_ensinosuperior.20.08','gd.estudante_ensinosuperior.20.09','gd.estudante_ensinosuperior.20.10','gd.estudante_ensinosuperior.20.11','gd.estudante_ensinosuperior.20.13','gd.estudante_ensinosuperior.20.14','gd.bemvindo_gestaotempo.100','gd.bemvindo_gestaotempo.20.01','gd.bemvindo_gestaotempo.20.03','gd.bemvindo_gestaotempo.20.04','gd.bemvindo_gestaotempo.20.05','gd.bemvindo_gestaotempo.20.06','gd.bemvindo_gestaotempo.20.07','gd.bemvindo_gestaotempo.20.08','gd.bemvindo_gestaotempo.20.09','gd.bemvindo_gestaotempo.20.10','gd.bemvindo_gestaotempo.20.11','gd.bemvindo_gestaotempo.20.13','gd.bemvindo_gestaotempo.20.14','gd.ensinodigital_sem_duvidas.100','gd.ensinodigital_sem_duvidas.20.01','gd.ensinodigital_sem_duvidas.20.03','gd.ensinodigital_sem_duvidas.20.04','gd.ensinodigital_sem_duvidas.20.05','gd.ensinodigital_sem_duvidas.20.06','gd.ensinodigital_sem_duvidas.20.08','gd.ensinodigital_sem_duvidas.20.09','gd.ensinodigital_sem_duvidas.20.10','gd.ensinodigital_sem_duvidas.20.11','gd.ensinodigital_sem_duvidas.20.13','gd.ensinodigital_sem_duvidas.20.14')


select * from NOTAS_EXTRAS;