// SPDX-License-Identifier: MIT

//pragma solidity >=0.7.0 <0.9.0; // mejor y mas seguro es dejarlo lockeado a una version
pragma solidity ^0.8.6;

contract Udemy001 {
    
    /*

    OWNERSHIP of a contract

    */
    address public owner;
    constructor () public {
        owner = msg.sender;
    }

    function amIOwner () public view returns(bool) {
        require(owner == msg.sender, "You not the owna.");
        return msg.sender == owner;
    }


    /*


    BASIC datatypes


    */

    string public saludo = "hola";

    uint256 public entero;

    bool public flag;

    function setEntero (uint _val) public {
        entero = _val;
    }

    function setFlag (bool _val) public {
        flag = _val;
    }

    address public myAddress;

    function setAddress (address _address) public {
        myAddress = _address;
    }

    function getBalance () public view returns (uint) {
        return myAddress.balance;
    }

    string public myString = "";

    function setMyString (string memory _myString) public {
        myString = _myString;
    }


    /*


    Transactions, withdrawals


    */


    //
    uint public lockedUntil;

    uint public balanceReceived;
    function recieveMoney() public payable {
        balanceReceived+=msg.value;
        // guardo el timestamp DEL MINADO DEL BLOQUE mas cierto tiempo
        lockedUntil = block.timestamp + 5 seconds;
    }

    function getContractBalance () public view returns(uint) {
        return address(this).balance;
    }

    function withdraw () public {
        if (lockedUntil < block.timestamp) {
            address payable to = payable(msg.sender);
            to.transfer (this.getContractBalance());
        }
    }

    function withdrawAll (address payable _to) public {
        if (lockedUntil < block.timestamp) {
            require (msg.sender == owner, "You are not the owner");
            require (!paused, "Contract is Paused");
            _to.transfer (this.getContractBalance());
        }
    }

    function transferTo (address payable _to) public payable {
        address payable to = _to;
        to.transfer (msg.value);
    }

    function withdrawTo (address payable _to, uint amt) public {
        /*if (amt < this.getBalance()) {
            to.transfer (amt);
        }*/
        if (amt < address(this).balance) {
            _to.transfer(amt);
        }
    }

    function sendTo () public payable {
        // Sends money to the Smart Contract
    }

    /*
    Start Stop
    */

    bool public paused; // initialized false
    function setPaused (bool _val) public {
        require (msg.sender == owner, "You are not the owner");
        paused = _val;
    }

    //_address: direccion que recibira los fondos restantes del contrato
    function destroySmartContract (address payable _to) public {
        require (msg.sender == owner, "You are not the owner, cannot destroy");
        selfdestruct (_to);
    }


}
