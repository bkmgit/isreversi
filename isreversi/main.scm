;; SPDX identifier BSD-3-Clause


;; -1 empty
;;  1 white
;;  0 black
(define board-state
  `(-1 -1 -1 -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1 -1 -1 -1
    -1 -1 -1  1  0 -1 -1 -1
    -1 -1 -1  0  1 -1 -1 -1
    -1 -1 -1 -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1 -1 -1 -1))

(define buttons
  `(#f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f
    #f #f #f #f #f #f #f #f))

(define download-books-button #f)

(define gui #f)
(define reversi-display #f)
(define reversi-subdisplay #f)
(define egaroucid-version-display #f)
(define playing #f)
(define square-width 40)
(define square-border 2)
(define inner-square-width (- square-width (* square-border 2)))

(define (xind button-number)
  (fxremainder button-number 8))

(define (yind button-number)
  (fxquotient button-number 8))

(define (set-colors g b)
  (glgui-widget-set! g b 'button-normal-color DarkGreen)
  (glgui-widget-set! g b 'solid-color #t))

(define (create-button button-number)
  (cond
    ((= (list-ref board-state button-number) -1)
         (list-set! buttons button-number
		    (glgui-button gui (+ (* (xind button-number) square-width)
                                         2)
                                      (- (glgui-height-get)
                                         (+ 120 (* square-width (yind button-number))))
                                      inner-square-width
                                      inner-square-width
                                      empty.img
                                      button-callback)))
    ((= (list-ref board-state button-number) 0)
         (list-set! buttons button-number
		    (glgui-button gui (+ (* (xind button-number) square-width)
                                         2)
                                      (- (glgui-height-get)
                                         (+ 120 (* square-width (yind button-number))))
                                      inner-square-width
                                      inner-square-width
                                      black.img
                                      button-callback)))
    (else
         (list-set! buttons button-number
		    (glgui-button gui (+ (* (xind button-number) square-width)
                                         2)
                                      (- (glgui-height-get)
                                         (+ 120 (* square-width (yind button-number))))
                                      inner-square-width
                                      inner-square-width
                                      white.img
                                      button-callback))))
  (set-colors gui (list-ref buttons button-number)))

(define (get-button-x x)
  (+ (fxquotient x square-width) 1))

(define (get-button-y y)
  (- 11 (fxquotient y square-width) 1))

(define (get-button-id x y)
 (string-append (string (integer->char (+ (get-button-x x) 96)))
		(number->string (get-button-y y))))

(define (button-callback gui b t x y)
  (glgui-widget-set! gui reversi-subdisplay 'label (get-button-id x y))
  (set! b (glgui-button gui (+ (* (- (get-button-x x) 1) square-width) 2)
			    (- (glgui-height-get) (+ 80 (* square-width (get-button-y y))))
			    inner-square-width
			    inner-square-width
			    white.img
			    button-callback))
  )

;(define book-moves (string-append (system-directory) (system-pathseparator) "book.egbk3"))
;(define eval-function (string-append (system-directory) (system-pathseparator) "eval.egev2"))
;(define end-game (string-append (system-directory) (system-pathseparator) "eval_move_ordering_end.egev"))


(define (download-books)
  (glgui-widget-set! gui reversi-subdisplay 'label "Downloading books")
;  (download-getfile "raw.githubusercontent.com"
;		    "/Nyanyan/Egaroucid/3b1c6ad380209162c2ad07aefe5c1fc6fd8072cb/bin/resources/book.egbk3"
;		    "book.egbk3")
;  (download-getfile "raw.githubusercontent.com"
;		    "/Nyanyan/Egaroucid/3b1c6ad380209162c2ad07aefe5c1fc6fd8072cb/bin/resources/eval.egev2"
;		    "eval.egev2")
;  (download-getfile "raw.githubusercontent.com"
;		    "/Nyanyan/Egaroucid/3b1c6ad380209162c2ad07aefe5c1fc6fd8072cb/bin/resources/eval_move_ordering_end.egev"
;		    "eval_move_ordering_end.egev")
  (glgui-widget-set! gui reversi-subdisplay 'label "Download done"))



(main
;; initialization
  (lambda (w h)
    (make-window 320 480)
    (glgui-orientation-set! GUI_PORTRAIT)
    (set! gui (make-glgui))
    (let* ((w (glgui-width-get))
           (h (glgui-height-get)))
      (set! reversi-subdisplay (glgui-label gui 0 (- h 75) w  30
					    "Press a square to play" ascii_14.fnt Orange))
      (glgui-widget-set! gui reversi-subdisplay 'align GUI_ALIGNLEFT)
      (set! reversi-display (glgui-label gui 0 (- h 45) w 40 "isREVERsi" ascii_18.fnt White))
      (glgui-widget-set! gui reversi-display 'align GUI_ALIGNCENTER)
      (set! egaroucid-version-display (glgui-label gui 0 5 w 40
						   (string-append "Egaroucid engine " (egaroucid-version))
						   ascii_14.fnt DarkGreen))
      (glgui-widget-set! gui egaroucid-version-display 'align GUI_ALIGNCENTER)
      ;; Download books
      (set! download-books-button (glgui-button-string gui 90 50 140 15 "Download books" ascii_14.fnt
           (lambda (un . used) (download-books))))
      (glgui-widget-set! gui download-books-button 'align GUI_ALIGNCENTER)
      (glgui-widget-set! gui download-books-button 'solid-color #t)
      ;; Initialize Egaroucid
      ;(set! egaroucid-initialized (egaroucid-init (string-append (system-directory) (system-pathseparator) "resources")))
      ;; Create board
      (let loop((button-number 64))
	(if (= button-number 0)
	  (set! button-number 0) ;; exit
	  (begin (create-button (- button-number 1))
		 (loop (- button-number 1)))))

    ))
 
;; events
  (lambda (t x y)
    (if (= t EVENT_KEYRELEASE)
      (cond
        ((= x EVENT_KEYESCAPE)     (terminate))
     ))
    (glgui-event gui t x y))

;; termination
  (lambda ()
;    (egaroucid::destroy engine)
    #t)
;; suspend
  (lambda () (glgui-suspend))
;; resume
  (lambda () (glgui-resume))
)

;; eof
