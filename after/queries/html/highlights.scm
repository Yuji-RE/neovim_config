; extends

;; HTML のタグ名（<br>, <div>, ... の "br", "div" 部分）すべて
((tag_name) @tag
 (#set! "priority" 130))

; extends

;; タグ名そのもの（<br>, <div> の br/div 部分）
((tag_name) @tag
 (#set! "priority" 130))

;; タグの区切り文字（<, </, >, /> など）
("<"  @tag.delimiter
 (#set! "priority" 130))
("</" @tag.delimiter
 (#set! "priority" 130))
(">"  @tag.delimiter
 (#set! "priority" 130))
("/>" @tag.delimiter
 (#set! "priority" 130))
