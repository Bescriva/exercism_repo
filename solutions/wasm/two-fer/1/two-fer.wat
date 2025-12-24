(module
  (memory (export "mem") 1)
  (data (i32.const 0) "One for ")
  (data (i32.const 8) "you")
  (data (i32.const 11) ", one for me.")

  ;;
  ;; Given a string X, return a string that says "One for X, one for me."
  ;; If the X is empty, return the string "One for you, one for me."
  ;;
  ;; @param {i32} $offset - The offset of the name in linear memory.
  ;; @param {i32} $length - The length of the name in linear memory.
  ;; 
  ;; @return {(i32,i32)} - The offset and length the resulting string in linear memory.
  ;;
  (func (export "twoFer") (param $offset i32) (param $length i32) (result i32 i32)
    (local $write_ptr i32)
    (local $result_len i32)
  
    (local.set $write_ptr (i32.const 100))
    (if (i32.eqz (local.get $length))
      (then
        (local.set $offset (i32.const 8))
        (local.set $length (i32.const 3))
      )
    )
    
    (memory.copy
      (local.get $write_ptr)
      (i32.const 0)
      (i32.const 8)
    )
    (local.set $write_ptr
      (i32.add (local.get $write_ptr) (i32.const 8))
    )
        
    (memory.copy
      (local.get $write_ptr)
      (local.get $offset)
      (local.get $length)
    )
    (local.set $write_ptr
      (i32.add (local.get $write_ptr) (local.get $length))
    )
        
    (memory.copy
      (local.get $write_ptr)
      (i32.const 11)
      (i32.const 13)
    )
    (local.set $write_ptr
      (i32.add (local.get $write_ptr) (i32.const 13))
    )
    
    (local.set $result_len
      (i32.sub (local.get $write_ptr) (i32.const 100))
    )
    (return (i32.const 100) (local.get $result_len))
  )
)
