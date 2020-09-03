        IDENTIFICATION DIVISION.
        PROGRAM-ID. PRACTICE.
        AUTHOR. Jon Strassel.
        DATE-WRITTEN.April 23rd 2020
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
               SELECT InputFile ASSIGN TO Arguments
                   ORGANIZATION IS LINE SEQUENTIAL
                   ACCESS IS SEQUENTIAL.
        DATA DIVISION.
        FILE SECTION.
        FD InputFile.
        01 Person.
           02 FirstName PIC X(30).
           02 LastName PIC X(30).
           02 Age PIC Z(3).
        WORKING-STORAGE SECTION.
        01 VAL_LENGTH CONSTANT AS 3.
        01 Username PIC X(30) VALUE ZEROS.
        01 Val1 PIC 9(VAL_LENGTH)V99 VALUE ZEROS.
        01 Val2 PIC 9(VAL_LENGTH)V99 VALUE ZEROS.
        01 Total PIC 9(4)V99 VALUE 0.
        01 TotalNoZero PIC ZZZZ.99.
        01 UserInput PIC X(512).
        01 Command PIC X(4).
        01 Parameters PIC X(10).
        01 Arguments PIC X(498).
        01 WSPerson.
           02 WSFirstName PIC X(30).
           02 WSLastName PIC X(30).
           02 WSAge PIC Z(3).
 
        PROCEDURE DIVISION.
        PERFORM ParseCmd WITH TEST AFTER UNTIL UserInput = "End"
            STOP RUN.

        ParseCmd.
           DISPLAY "Enter a Input: " WITH NO ADVANCING.
           ACCEPT UserInput.
           IF UserInput <> "End" THEN
               UNSTRING UserInput DELIMITED BY SPACE
                   INTO Command, Parameters, Arguments
               END-UNSTRING
               DISPLAY " "
               EVALUATE TRUE
                   WHEN Command = "cf"
                       DISPLAY "Create File " Arguments
                       OPEN OUTPUT InputFile
                           DISPLAY "First Name: " WITH NO ADVANCING
                           ACCEPT WSFirstName
                           DISPLAY "Last Name: " WITH NO ADVANCING
                           ACCEPT WSLastName
                           DISPLAY "Age: " WITH NO ADVANCING
                           ACCEPT WSAge
                           MOVE WSPerson TO Person
                           WRITE Person
                           END-WRITE 
                        CLOSE InputFile

                   WHEN Command = "pf"
                       DISPLAY "Print File"
    
                   WHEN UserInput = "cd"
                       DISPLAY "Change Directory"
                   
                   WHEN Command = "wf"
                       DISPLAY "Write File"
    
                   WHEN OTHER
                       DISPLAY 'INVALID COMMAND'
               END-EVALUATE
               DISPLAY " "
           END-IF.
