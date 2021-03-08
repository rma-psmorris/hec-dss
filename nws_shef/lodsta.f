      SUBROUTINE LODSTA ( CSFILE,LFNOUT )
C
C      <LODSTA>  READS A FILE CONTAINING A TABLE OF RELATIONSHIPS
C      BETWEEN DSS A AND B PATHNAME LABELS <DSSID> AND SHEF-RELATED
C      STATION IDENTIFIERS <SHEFID>.  IF NO ENTRY IS PRESENT IN THE
C      TABLE, IT IS ASSUMED THAT THE FIRST EIGHT NON-BLANK CHARACTERS
C      OF THE DSS PATHNAME PART B ARE A PROPER SHEF ID.
C                                  DENNIS HUFF 25 FEB 86
C
      CHARACTER CSFILE*(*)
C
      INCLUDE 'pstbls.h'
C
      INCLUDE 'shfids.h'
C
C     LOCAL VARIABLES
      CHARACTER LINE*80,CRLF*2
      LOGICAL LPOPT
      DATA LFNIN/40/
C
      CALL TASG( LFNOUT,LFNIN,CSFILE )
C
      CRLF = CHAR(13)//CHAR(10)
      NSTA = 0
   10 CONTINUE
      READ ( LFNIN,'(A)',IOSTAT=IOS ) LINE
C     WRITE ( LFNOUT,* ) 'LODSTA: ',LINE
      IF ( IOS.EQ.0 ) THEN
         IF ( LINE(1:1).EQ.'*') THEN
            GO TO 10
         ELSE IF ( LINE(1:10).EQ.' ' ) THEN
            GO TO 10
C
         ELSE
            NSTA = NSTA + 1
C           WRITE ( LFNOUT,* ) 'NSTA =',NSTA
            DSSID(NSTA) = LINE(34:49)
            SHEFID(NSTA)=LINE(1:8)
            IF ( NSTA.LT.MAXSTA ) THEN
               GO TO 10
            ELSE
               WRITE ( LFNOUT,* ) 'MAX SHEFIDS LOADED'
            ENDIF
         ENDIF
      ELSE IF ( IOS.GT.0 ) THEN
         WRITE ( LFNOUT,* )'ERROR ',IOS,' IN READING SHFDSSS '
      ELSE
      ENDIF
      CLOSE (LFNIN)
C     IF ( LPOPT('E') ) THEN
C        DO 20 I=1,NSTA
C           WRITE(LFNOUT,30) I,SHEFID(I),DSSID(I)
C  30       FORMAT ( I3,1X,A10,A32 )
C  20    CONTINUE
C     ENDIF
C
      RETURN
C
      END
