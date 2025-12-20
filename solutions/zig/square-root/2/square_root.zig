pub fn squareRoot(radicand: usize) usize {
    var left: usize = 0;
    var right: usize = radicand + 1;

    while (left < right) {
        const mid = left + (right - left) / 2;
        const square = mid * mid;

        if (square == radicand) return (mid)
        else if (square < radicand) left = mid + 1
        else right = mid;
    }
    return 0;
}
