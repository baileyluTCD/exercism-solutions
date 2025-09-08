pub fn squareRoot(n: usize) usize {
    if (n < 2) return n;

    const small_cand = squareRoot(n >> 2) << 1;
    const large_cand = small_cand + 1;

    return if (large_cand * large_cand > n)
        small_cand
    else
        large_cand;
}
