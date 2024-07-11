// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract SMR {
    uint rate = 100;
    uint flag = 0;

    mapping (bytes => bytes) mapOfAhToUh;
    mapping (bytes => uint) mapOfUhToRating;

    bytes[] userHashArray;

    function submitHashes(bytes memory  hash1, bytes memory hash2) public {

        mapOfAhToUh[hash1] = hash2;
        mapOfUhToRating[hash2] = 100;
        userHashArray.push(hash2);
    }
    function rateMovie(bytes memory uniqStrng,uint R) public{
        bytes memory hash = abi.encodePacked(sha256(uniqStrng));
        
        for (uint i = 0; i < userHashArray.length; i++){

                if (keccak256(hash) == keccak256(userHashArray[i])){
                    flag = 1;
                    break;
                }               
        }
        if (flag == 1) {
            mapOfUhToRating[hash]  = R;           
        }
    }
    function getRating(bytes memory  hash) public view returns(uint){
        return mapOfUhToRating[hash];
    }

    function getHash(bytes memory h) public pure returns(bytes memory){
        bytes memory hash = abi.encodePacked(sha256((h)));
        return hash;
         
    }
} 