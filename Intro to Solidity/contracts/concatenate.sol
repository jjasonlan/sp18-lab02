pragma solidity 0.4.19;


contract Concatenate {
    function concatWithoutImport(string _a, string _b) public returns (string) {
    	bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory abcde = new string(_ba.length + _bb.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) {
            babcde[k++] = _ba[i];
        }
        for (i = 0; i < _bb.length; i++) {
            babcde[k++] = _bb[i];
        return string(babcde);
        }
    }

    /* BONUS */
    //function concatWithImport(string s, string t) public returns (string) {
    //}
}
