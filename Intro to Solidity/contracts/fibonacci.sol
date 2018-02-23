pragma solidity 0.4.19;


contract Fibonacci {
    /* Carry out calculations to find the nth Fibonacci number */
    // function fibRecur(uint n) public pure returns (uint) {
    // }

    /* Carry out calculations to find the nth Fibonacci number */
	function fibIter(uint n) public returns (uint) {
        if (n == 1) {
            return 1;
        }
        uint counter = 2;
        uint first = 1;
        uint second = 1;
        while (counter < n) {
            uint temp = first + second;
            first = second;
            second = temp;
            counter = counter + 1;
        }
        return second;
    }
}
