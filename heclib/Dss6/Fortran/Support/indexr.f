      INTEGER FUNCTION INDEXR ( CSTRA, CSTR2)
C
C     REVERSE INDEX
C     SEARCHES CHARACTER STRING CSTRA FOR STRING CSTR2
C     GOING BACKWARDS (I.E. FROM END OF CSTRA)
C     IF FOUND, INDEXR WILL BE THE POSITION OF THE LEFT MOST
C     CHARACTER IN THE MATCH OF THE LAST OCCURANCE OF CSTR2
C     IF NOT FOUND, INDEXR WILL BE ZERO
C
      CHARACTER CSTRA*(*), CSTR2*(*)
C
      IEND1 = LEN (CSTRA)
      IEND2 = LEN (CSTR2)
C
      INDEXR = 0
C     IS THE STRING TO MATCH TOO LONG?
      IF (IEND2.GT.IEND1) RETURN
C
      N = IEND1 - IEND2 + 1
      IB = N
      IE = IEND1
C
      DO 10 I=1,N
      IF (CSTR2(1:IEND2).EQ.CSTRA(IB:IE)) THEN
      INDEXR = IB
      RETURN
      ENDIF
C     NEXT CHARACTER BACKWARDS
      IB = IB - 1
      IE = IE - 1
 10   CONTINUE
C
      RETURN
      END

