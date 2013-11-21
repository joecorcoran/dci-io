Bank := Object clone do(
  Account := Object clone do(
    init := method(self balance := 100)
  )

  WithdrawingAccount := Object clone do(
    canWithdraw := method(amount, balance >= amount)
    withdraw := method(amount, balance = balance - amount)
  )

  DepositingAccount := Object clone do(
    deposit := method(amount, balance = balance + amount)
  )

  transfer := method(amount, from, to,
    from appendProto(WithdrawingAccount)
    to appendProto(DepositingAccount)

    if(from canWithdraw(amount)) then(
      from withdraw(amount)
      to deposit(amount)
    ) else(
      message := "Cannot transfer #{amount}, balance is #{from balance}"
      Exception raise(message interpolate)
    )

    from removeProto(WithdrawingAccount)
    to removeProto(DepositingAccount)

    list(from, to)
  )
)

a ::= Bank Account clone
b ::= Bank Account clone

Bank transfer(10, a, b) print
Bank transfer(115, b, a) print
