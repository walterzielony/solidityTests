// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Udemy002 {

    // made public only for testing purposes
    address payable public owner;

    // modifier to check for ownership
    // '_' tells at which point the modified function's code will be run.
    modifier isOwner {
        require(msg.sender == owner, "eh, vo no so el ouner!");
        _; // this will be 'replaced' by the modified funtion's code
        
        /* *** Si el _ esta antes del codigo del modifier, y la funcion
        modificada hace un return, el codigo del modifier NO SE EJECUTARA
        */
    }

    constructor () {
        // Owner of smart contract will be the address that deploys it
        owner = payable(msg.sender);
    }

    function sendMoney () public payable {
        // no more needed for the contract to receive money
    }

    // custom modifier 'isOwner' is defined above, and will execute always
    function dameTodo (address payable _to) public isOwner {
        //require(msg.sender == owner, "eh, vo no so el ouner!");
        _to.transfer (address(this).balance); // sending all to _to
    }

}