      SUBROUTINE POSFL (IUNIT,ILINE,ISTAT)
      CHARACTER *1 CLINE
      REWIND IUNIT
      IF (ILINE.GT.1) THEN
         DO 10 I=1,ILINE-1
            READ (IUNIT,'(A)',ERR=90,IOSTAT=ISTAT) CLINE
 10      CONTINUE
      ENDIF
C
 90   CONTINUE
      RETURN
      END

