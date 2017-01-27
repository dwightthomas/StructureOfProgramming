;;Question 1
;;This function is used to reverse all the item in the list L
;; including its sublists as well.
(define (reverse-general L)
  (cond ((null? L) '())
        ((list? L)
         (append (reverse-general (cdr L))
                 (list (reverse-general (car L)))
          )
         )
        (else L)
   )
 )

;;This function is used to get the some of numbers in the list
;;excluding those that are in sublist however, so only the numbers
;;in the main list
(define (sum-up-numbers-simple L)
  (cond ((null? L) 0) ;;this checks to see if the list is empty then return 0 if true
        ((number? (car L)) ;;checcks to make the first character in the list is a number
         (+ (car L) (sum-up-numbers-simple (cdr L))) ;;then adds it to our total
         )
        (else (+ 0 (sum-up-numbers-simple (cdr L)))) ;;else it adds zero to the total.
   )
 )

;;This function adds up all the number contains in the list L whether these numbers
;;are in a sublist or not once its in the list it is summed.
(define (sum-up-numbers-general L)
  (cond ((null? L) 0) ;;this checks to see if the list is empty and returns zero if true
        ((not (number? (car L))) ;;this tests whether the first member of the list is not a number
         (cond ((not (list? (car L))) ;;if true then it checks to see if it is not a list.
                (+ 0 (sum-up-numbers-general (cdr L))) ;; if that is true it adds zero to sum and calls the rest of list
                )
               (else (+ (sum-up-numbers-general (car L)) (sum-up-numbers-general (cdr L)))) ;;else it call the sum function on that sublist plus the remainder of the list
          )
         )
        (else (+ (car L) (sum-up-numbers-general (cdr L)))) ;;if it is a number it is add to the total.
    )
  )

;;This is a helper funtion.
(define (min-of-list L min)
  (cond ((null? L) min)
        ((number? (car L))
         (cond ((< min (car L))
                (min-of-list (cdr L) min)
                )
               (else (min-of-list (cdr L) (car L)))
          )
         )
        (else (min-of-list (cdr L) min))
   )
  )
             
         