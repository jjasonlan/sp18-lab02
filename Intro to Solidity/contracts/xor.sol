pragma solidity 0.4.19;


contract XOR {
    function xor(uint a, uint b) public pure returns (uint) {
    	if (a == 1 && b == 1) {
    		return 0;
    	}
    	if (a == 1 && b == 0) {
    		return 1;
    	}
    	if (a == 0 && b == 1) {
    		return 1;
    	}
    	if (a == 0 && b == 0) {
    		return 0;
    	}
    }
}
