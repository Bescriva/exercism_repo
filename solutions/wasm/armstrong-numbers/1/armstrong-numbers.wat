(module
  ;; 
  ;; Determine if a number is an Armstrong number.
  ;;
  ;; @param {i32} candidate - The number to check.
  ;;
  ;; @return {i32} 1 if the number is an Armstrong number, 0 otherwise.
  ;;
  (func (export "isArmstrongNumber") (param $candidate i32) (result i32)
    (local $len i32)
    (local $sum i32)
    (local $num i32)
    (local $digit i32)
    (local $pow i32)
    (local $l i32)
    
    (local.set $len (i32.const 0))
    (local.set $num (local.get $candidate))
    (local.set $sum (i32.const 0))
    (local.set $pow (i32.const 1))

    (block $break_len
      (loop $continue_len
        (local.set $len (i32.add (local.get $len) (i32.const 1)))
        (local.set $num(i32.div_u (local.get $num) (i32.const 10)))
        
        (br_if $break_len (i32.eqz (local.get $num)))
        (br $continue_len)
      )
    )
    
    (local.set $num (local.get $candidate))
    
    (block $break_sum
      (loop $continue_sum
        (local.set $digit (i32.rem_u (local.get $num) (i32.const 10)))
        (local.set $pow (i32.const 1))
        (local.set $l (local.get $len))
        
        (block $break_pow
          (loop $continue_pow
            (br_if $break_pow (i32.eqz (local.get $l)))
        
            (local.set $pow (i32.mul (local.get $pow) (local.get $digit)))
            (local.set $l (i32.sub (local.get $l) (i32.const 1)))
        
            (br $continue_pow)
          )
        )
    
        (local.set $sum (i32.add (local.get $sum) (local.get $pow)))
        (local.set $num(i32.div_u (local.get $num) (i32.const 10)))
    
        (br_if $break_sum(i32.eqz (local.get $num)))
        (br $continue_sum)
      )
    )
    
    (i32.eq (local.get $sum) (local.get $candidate))
  )
)
