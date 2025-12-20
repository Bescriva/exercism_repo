(module
  (memory (export "mem") 1)

  ;;
  ;; Count the number of each nucleotide in a DNA string.
  ;;
  ;; @param {i32} offset - The offset of the DNA string in memory.
  ;; @param {i32} length - The length of the DNA string.
  ;;
  ;; @returns {(i32,i32,i32,i32)} - The number of adenine, cytosine, guanine, 
  ;;                                and thymine nucleotides in the DNA string
  ;;                                or (-1, -1, -1, -1) if the DNA string is
  ;;                                invalid.
  ;;
  (func (export "countNucleotides") (param $offset i32) (param $length i32) (result i32 i32 i32 i32)
    (local $char i32)
    (local $i i32)
    (local $count_A i32)
    (local $count_C i32)
    (local $count_G i32)
    (local $count_T i32)
    (local.set $i (i32.const 0))

    (block $break
      (loop $continue
        (br_if $break (i32.ge_u (local.get $i) (local.get $length)))
        (local.set $char
          (i32.load8_u (i32.add (local.get $offset) (local.get $i)))
        )
        
        (if (i32.eq (local.get $char) (i32.const 65))
          (then
            (local.set $count_A (i32.add (local.get $count_A) (i32.const 1)))
          )
          (else
            (if (i32.eq (local.get $char) (i32.const 67))
              (then
                (local.set $count_C (i32.add (local.get $count_C) (i32.const 1)))
              )
              (else
                (if (i32.eq (local.get $char) (i32.const 71))
                  (then
                    (local.set $count_G (i32.add (local.get $count_G) (i32.const 1)))
                  )
                  (else
                    (if (i32.eq (local.get $char) (i32.const 84))
                      (then
                        (local.set $count_T (i32.add (local.get $count_T) (i32.const 1)))
                      )
                      (else
                        (return
                          (i32.const -1)
                          (i32.const -1)
                          (i32.const -1)
                          (i32.const -1)
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $continue)
      )
    )
    (return 
      (local.get $count_A)
      (local.get $count_C)
      (local.get $count_G)
      (local.get $count_T)
    )
  )
)
