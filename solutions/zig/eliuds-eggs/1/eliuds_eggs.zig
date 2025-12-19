pub fn eggCount(number: usize) usize {
    var eggs: usize = 0;
    var n: usize = number;

    while (n != 0) : (n >>= 1)
        eggs += n & 1;
    return eggs;
}
