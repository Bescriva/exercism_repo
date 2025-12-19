(module
  (global $balance(mut i32) (i32.const 0))
  (global $open(mut i32) (i32.const 0))
  ;;
  ;; Set the state of the bank account to open.
  ;;
  ;; @return {i32} 0 on success, -1 on failure
  ;;
  (func (export "open") (result i32)
    (if (result i32)
      (i32.eq (global.get $open) (i32.const 1))
      (then (i32.const -1))
      (else
        (global.set $open (i32.const 1))
        (i32.const 0)
      )
    )
  )

  ;;
  ;; Set the state of the bank account to closed.
  ;;
  ;; @return {i32} 0 on success, -1 on failure
  ;;
  (func (export "close") (result i32)
    (if (result i32)
      (i32.eqz (global.get $open))
      (then (i32.const -1))
      (else
        (global.set $open (i32.const 0))
        (global.set $balance (i32.const 0))
        (i32.const 0)
      )
    )
  )

  ;;
  ;; Deposit the given amount into the bank account.
  ;;
  ;; @param {i32} amount - The amount to deposit
  ;;
  ;; @return {i32} 0 on success, -1 if account closed, -2 if amount negative
  ;;
  (func (export "deposit") (param $amount i32) (result i32)
    (if (result i32)
      (i32.eqz (global.get $open))
      (then (i32.const -1))
      (else
        (if (result i32)
          (i32.lt_s (local.get $amount) (i32.const 0))
          (then (i32.const -2))
          (else
            (global.set $balance
              (i32.add (global.get $balance) (local.get $amount))
            )
            (i32.const 0)
          )
        )
      )
    )
  )

  ;;
  ;; Withdraw the given amount from the bank account.
  ;;
  ;; @param {i32} amount - The amount to withdraw
  ;;
  ;; @return {i32} 0 on success, -1 if account closed, -2 if amount invalid
  ;;
  (func (export "withdraw") (param $amount i32) (result i32)
    (if (result i32)
      (i32.eqz (global.get $open))
      (then (i32.const -1))
      (else
        (if (result i32)
          (i32.or
            (i32.lt_s (local.get $amount) (i32.const 0))
            (i32.gt_s (local.get $amount) (global.get $balance))
          )
          (then (i32.const -2))
          (else
            (global.set $balance
              (i32.sub (global.get $balance) (local.get $amount))
            )
            (i32.const 0)
          )
        )
      )
    )
  )

  ;;
  ;; Get the current balance of the bank account.
  ;;
  ;; @return {i32} balance on success, -1 if account closed
  ;;
  (func (export "balance") (result i32)
    (if (result i32)
      (i32.eqz (global.get $open))
      (then (i32.const -1))
      (else (global.get $balance))
    )
  )
)
