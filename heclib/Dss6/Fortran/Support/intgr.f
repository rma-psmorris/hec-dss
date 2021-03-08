      FUNCTION INTGR ( CLINE, NBEG, NLEN, IERR)
C
C     CONVERT A NUMERIC STRING OF CHARACTERS TO AN INTEGER NUMBER
C
C     INPUT:
C         NBEG - BEGINNING CHARACTER LOCATION
C         NLEN - NUMBER OF CHARACTERS TO BE CONVERTED
C         IERR - STATUS; 0 = OK, -1 = ERROR OCCURED
C
C     OUTPUT:
C         INTGR - INTEGER NUMBER FOUND (-1 IF ERROR)
C
C
      CHARACTER CLINE*(*), CFORMT*8
      INTEGER INTGR
C
C
      IERR = 0
C
C     CHECK FOR ERROR CONDITION
      IF ((NBEG.LE.0).OR.(NLEN.LE.0).OR.(NLEN.GT.50)) GO TO 900
C
      CFORMT = ' '
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
      READ ( CLINE(NBEG:NEND), CFORMT, ERR=900) INTGR
      RETURN
C
 900  CONTINUE
      IERR = -1
      INTGR = -1
      RETURN
      END

