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