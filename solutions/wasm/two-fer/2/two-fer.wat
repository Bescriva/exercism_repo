(module
  (memory (export "mem") 1)
  (data (i32.const 0) "One for you, one for me.")

  (func (export "twoFer") (param $offset i32) (param $length i32) (result i32 i32)
    (local $write_ptr i32)
    (local $result_len i32)
  
    (local.set $write_ptr (i32.const 100))
    (if (i32.eqz (local.get $length))
      (then
        (return (i32.const 0) (i32.const 24))
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
