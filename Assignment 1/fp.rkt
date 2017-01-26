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

;;Tested
(define (sum-up-numbers-general L)
  (cond ((null? L) 0)
        ((not (number? (car L)))
         (cond ((not (list? (car L)))
                (+ 0 (sum-up-numbers-general (cdr L)))
                )
               (else (+ (sum-up-numbers-general (car L)) (sum-up-numbers-general (cdr L))))
          )
         )
        (else (+ (car L) (sum-up-numbers-general (cdr L))))
    )
  )
             
         