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

;;This is a helper funtion. Assumption the list has numbers great 90000
;;Also if 90000 is returned then the list has no numbers in it.
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

;;This is helper.
(define (min-L1>L2-min L L2min L1new)
  (cond ((null? L) L1new)
        ((not (number? (car L))) (min-L1>L2-min (cdr L) L2min L1new)) 
        ((> (car L) L2min)
         (min-L1>L2-min (cdr L) L2min (append L1new (list (car L))))
         )
        (else (min-L1>L2-min (cdr L) L2min L1new)
         )
   )
 )
        
;;Final function
(define (min-above-min L1 L2)
  (cond ((null? L1) #F)
        ((null? L2)
         (cond ((not (= (min-of-list L1 90000) 90000))
                (min-of-list L1 90000)
                )
               (else #F)
          )
         )
        (else (cond ((= (min-of-list L1 90000) 90000) #f)
                    ((= (min-of-list L2 90000) 90000)
                     (min-of-list L1 90000)
                     )
                    (else (cond ((null? (min-L1>L2-min L1 (min-of-list L2 90000) '())) #f)
                                (else (min-of-list (min-L1>L2-min L1 (min-of-list L2 90000) '()) 90000)
                                 )
                           )
                     )
               )
         )
    )
  )
               