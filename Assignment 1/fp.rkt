;;Question 1.
;;This function is used to reverse all the item in the list L.
;; including its sublists as well.
(define (reverse-general L)
  (cond ((null? L) '()) ;;This checks to see if list is null and if true returns empty list.
        ((list? L) ;;This checks to see if it is list.
         (append (reverse-general (cdr L)) ;;If true it appends the character to the back of the reversed list.
                 (list (reverse-general (car L))) ;;With a list version of the character at that point.
          )
         )
        (else L) ;;Else it just return the character at that point in list.
   )
 )

;;Question 2.
;;This function is used to get the some of numbers in the list,
;;excluding those that are in sublist however, so only the numbers,
;;in the main list.
(define (sum-up-numbers-simple L)
  (cond ((null? L) 0) ;;This checks to see if the list is empty then return 0 if true.
        ((number? (car L)) ;;Checcks to make the first character in the list is a number.
         (+ (car L) (sum-up-numbers-simple (cdr L))) ;;Then adds it to our total.
         )
        (else (+ 0 (sum-up-numbers-simple (cdr L)))) ;;else it adds zero to the total.
   )
 )

;;Question 3.
;;This function adds up all the number contains in the list L whether these numbers,
;;are in a sublist or not once its in the list it is summed.
(define (sum-up-numbers-general L)
  (cond ((null? L) 0) ;;This checks to see if the list is empty and returns zero if true.
        ((not (number? (car L))) ;;This tests whether the first member of the list is not a number.
         (cond ((not (list? (car L))) ;;If true then it checks to see if it is not a list.
                (+ 0 (sum-up-numbers-general (cdr L))) ;;If that is true it adds zero to sum and calls the rest of list.
                )
               (else (+ (sum-up-numbers-general (car L)) (sum-up-numbers-general (cdr L)))) ;;Else it call the sum function on that sublist plus the remainder of the list.
          )
         )
        (else (+ (car L) (sum-up-numbers-general (cdr L)))) ;;If it is a number it is add to the total.
    )
  )

;;Question 4.
;;This is a helper funtion.
;;Assumption the list has numbers great 90000,
;;Also if 90000 is returned then the list has no numbers in it.
;;This function finds the min number in a given list with the assumptions above.
(define (min-of-list L min)
  (cond ((null? L) min) ;;This checks to see if list is null and if true returns the old min.
        ((number? (car L)) ;;This checks to see if the first member is anumber.
         (cond ((< min (car L)) ;;If above true it checks to see if min is smaller than that number.
                (min-of-list (cdr L) min) ;;if true it callsthe function again with the rest of list and same min 
                )
               (else (min-of-list (cdr L) (car L))) ;;else it updates min and calls function with the rest of the list.
          )
         )
        (else (min-of-list (cdr L) min)) ;;Else it just call rest of list ingoring the none number.
   )
 )

;;This is a helper function.
;;It returns all the number in list 1 that are greater that the min number in list two.
(define (min-L1>L2-min L L2min L1new)
  (cond ((null? L) L1new) ;;This  checks if list is null and returns the new list if it is.
        ((not (number? (car L))) (min-L1>L2-min (cdr L) L2min L1new)) ;;This checks if the first member is not a number and if true it calls the function with the rest of the list ingoring that character.
        ((> (car L) L2min) ;;This checks to see if character is greater that list 2 min.
         (min-L1>L2-min (cdr L) L2min (append L1new (list (car L)))) ;;If true it calls the function again with this number appends to the new list of number greater than L2 min.
         )
        (else (min-L1>L2-min (cdr L) L2min L1new) ;;Else it calls the function again without adding the number to new list.
         )
   )
 )
        
;;This is the actual function that bring everything together.
;;It determines which number is the min nmber in List 1 that is greater than the min number in L2 if any.
(define (min-above-min L1 L2)
  (cond ((null? L1) #F) ;;This checks if list 1 is null if true it return false.
        ((null? L2) ;;This checks if lsit 2 is null.
         (cond ((not (= (min-of-list L1 90000) 90000)) ;;If true it checks that there is a min number in list 1.
                (min-of-list L1 90000) ;;If true it reutrns that number as it would be the min number greater than the min number in list 2.
                )
               (else #F) ;;If it doesn't have a min number then it retuns false.
          )
         )
        (else (cond ((= (min-of-list L1 90000) 90000) #f) ;;If list 2 is not false this checks to see if there is a min number in list one if false it returns false.
                    ((= (min-of-list L2 90000) 90000) ;;If true then it checks that there is in fact a min number in list two.
                     (min-of-list L1 90000) ;;If it doesn't then this line returns the min number of list 1 as we already know that it in fact has one from two lines above.
                     )
                    (else (cond ((null? (min-L1>L2-min L1 (min-of-list L2 90000) '())) #f) ;;If list 2 does have a min number this line checks to find that there is a list of numbers from list 1 that are actually biggeer than list two's min. If false it returns false.
                                (else (min-of-list (min-L1>L2-min L1 (min-of-list L2 90000) '()) 90000) ;;If true then this line find the min number of that new list of numbera that are greater than list two's min. It then returns this number.
                                 )
                           )
                     )
               )
         )
    )
  )
               