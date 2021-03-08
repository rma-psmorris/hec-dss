      SUBROUTINE GETINT ( SHFDUR,SINTL,TYPE,TSTYPE,INTL,ZTYPE,ERRMSG )
C
C     GETINT FINDS THE APPROPRIATE DSS TIME-SERIES FORMAT <TSTYPE>,
C     GIVEN THE SHEF DURATION CODE <SHFDUR>, AN OPTIONAL,
C     USER-SUPPLIED TIME INTERVAL FOR INSTANTANEOUS DATA <SINTL>,
C     AND THE USER-SPECIFIED DSS DATA TYPE <TYPE>.
C     IF ERRORS ARE ENCOUNTERED, AN ERROR MESSAGE IS
C     RETURNED.
C
C
C
C     EXTERNAL VARIABLES
      CHARACTER SHFDUR*(*),TSTYPE*(*),ERRMSG*(*)
      CHARACTER TYPE*(*),ZTYPE*(*)
	EXTERNAL INTGR
C
C     LOCAL VARIABLES
C     INTEGER SINTL                                                     H
      INTEGER*4 INTL, KINTL, SINTL, IFACT                               M
      LOGICAL SAME
      DIMENSION IFACT(7)
C               MINUTES HOURS DAYS MONTHS  YEARS  UNDEF  UNDEF
      DATA IFACT /    1,  60, 1440, 43200, 525600,   -1,    -1 /
C
      ERRMSG = ' '
C     WRITE ( 21,* ) 'SHFDUR =',SHFDUR
      ND = INTGR ( SHFDUR,2,3,ISTAT )
C     WRITE ( 21,* ) 'ND =',ND
      IF ( ISTAT.NE.0 ) THEN
         ERRMSG = 'ERROR IN INTERPRETING DURATION CODE -- DATA IGNORED'
         GO TO 90
      ENDIF
      IDUR = 1 + INTGR (SHFDUR,1,1,ISTAT )
C     WRITE ( 21,* ) 'IDUR =',IDUR
      IF ( ISTAT.NE.0 ) THEN
         ERRMSG = 'ERROR IN INTERPRETING DURATION CODE -- DATA IGNORED'
         GO TO 90
      ENDIF
      IF ( IDUR.LE. 7 ) THEN
         KINTL = ND*IFACT(IDUR)
      ELSE
         KINTL = -1
      ENDIF
      IF ( KINTL.LT.-1 ) KINTL = -1
C     WRITE ( 21,* ) 'KINTL =',KINTL
      IF ( KINTL.EQ.0 ) THEN
C        INSTANTANEOUS
         IF ( SINTL.EQ.0 ) THEN
            TSTYPE = 'IR'
         ELSE
            TSTYPE = 'RG'
            INTL = SINTL
         ENDIF
         ZTYPE = TYPE
C        WRITE ( 21,* ) 'ZTYPE =',ZTYPE,'  TSTYPE=',TSTYPE
      ELSE IF ( KINTL.GT.0 ) THEN
C        RECOGNIZED DURATIONS > 0
         TSTYPE = 'RG'
         INTL = KINTL
         IF ( TYPE(6:8).EQ.'VAL' ) THEN
            ZTYPE = 'PER-AVER'
         ELSE IF ( TYPE(6:8).EQ.'CUM' ) THEN
            ZTYPE = 'PER-CUM'
         ELSE
            ZTYPE = TYPE
         ENDIF
      ELSE IF ( KINTL.LT.0 ) THEN
C        UNRECOGNIZED DURATIONS
         ERRMSG = 'DURATION NOT RECOGNIZED BY DSS -- DATA IGNORED'
      ELSE
      ENDIF
   90 CONTINUE
C
      RETURN
C
      END
