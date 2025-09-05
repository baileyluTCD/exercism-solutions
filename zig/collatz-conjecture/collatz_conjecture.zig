pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) anyerror!usize {
    if (number == 0) return ComputationError.IllegalArgument;

    var taken: usize = 0;

    var curr = number;
    while (curr != 1) : (taken += 1) if (curr % 2 == 0) {
        curr /= 2;
    } else {
        curr = (curr * 3) + 1;
    };

    return taken;
}
