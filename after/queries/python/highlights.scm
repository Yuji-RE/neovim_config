; extends

;; Python の docstring (expression_statement の string) に
;; 強めの @string.documentation を付ける
((expression_statement
   (string) @string.documentation)
 (#set! "priority" 120))

;; uplifting the priority of delimiters
("," @punctuation.delimiter
 (#set! "priority" 105))

("." @punctuation.delimiter
 (#set! "priority" 105))

(";" @punctuation.delimiter
(#set! "priority" 105))

(":" @punctuation.delimiter
(#set! "priority" 105) )
