signature EITHER_CONS =
  sig
    datatype ('left, 'right) either = INL of 'left | INR of 'right
end
