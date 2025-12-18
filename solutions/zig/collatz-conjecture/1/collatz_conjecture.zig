pub const ComputationError = error{
    IllegalArgument,
};

pub fn collatz(n: usize) usize {
    if (n % 2 == 0)
        return (n / 2);
    return ((n * 3) + 1);
}

pub fn steps(number: usize) anyerror!usize {
    if (number <= 0)
        return ComputationError.IllegalArgument;
    var stps: usize = 0;
    var n = number;
    while (n != 1) : (n = collatz(n))
        stps += 1;
    return stps;
}
