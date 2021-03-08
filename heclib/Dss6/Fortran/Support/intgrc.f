      SUBROUTINE INTGRC ( NUMB, CLINE, NBEG, NLEN)
C
C  PURPOSE:  TO CONVERT AN INTEGER TO A CHARACTER STRING. THIS PROVIDES
C            A MACHINE TRANSPORTABLE ALTERNATIVE TO ENCODE.
C
C  INPUTS:  NUMB - INTEGER NUMBER TO BE CONVERTED TO CHARACTER STRING
C           NBEG - BEGINNING CHARACTER POSITION OF CLINE WHICH TO PLACE
C                STRING
C          NLEN - MAXIMUM NUMBER OF CHARACTERS THAT MAY BE PUT IN STRING
C
C  OUTPUTS:  CLINE- CHARACTER STRING THAT CONTAINS THE CONVERTED INTEGER
C                  THE RESULTS WILL BE RIGHT JUSTIFIED WITH BLANK FILL.
C                  CLINE IS SET TO ASTERICKS IF ERROR OCCURS.
C
C  SUBROUTINES REFERENCED: NONE
C
      CHARACTER CLINE*(*), CFORMT*5
C
C
C     CHECK FOR ERROR CONDITION
      IF ((NBEG.LE.0).OR.(NLEN.LT.0).OR.(NLEN.GT.99)) GO TO 900
C
      IF (NLEN.LT.10) THEN
      WRITE ( CFORMT, 10, ERR=900) NLEN
 10   FORMAT (I3)
      ELSE
      WRITE ( CFORMT, 20, ERR=900) NLEN
 20   FORMAT (I4)
      ENDIF
      CFORMT(1:2) = '(I'
      CFORMT(5:5) = ')'
C
      NEND = NBEG + NLEN - 1
      WRITE ( CLINE(NBEG:NEND), CFORMT, ERR=900) NUMB
      RETURN
C
 900  CONTINUE
      IF (NLEN.GE.1) CALL CHRFIL ( CLINE(NBEG:NBEG+NLEN-1), '*')
      RETURN
      END

