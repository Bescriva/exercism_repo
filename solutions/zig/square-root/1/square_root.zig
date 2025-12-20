pub fn squareRoot(radicand: usize) usize {
    var i: usize = 0;
    while (i * i < radicand)
        i += 1;
    return i;
}
