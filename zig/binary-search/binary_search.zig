pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    var lower: usize = 0;
    var upper: usize = items.len;
    var mid: usize = items.len / 2;

    return while (lower < upper) : (mid = (upper + lower) / 2) {
        if (target == items[mid])
            break mid
        else if (items[mid] < target)
            lower = mid + 1
        else
            upper = mid;
    } else null;
}
