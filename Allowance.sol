// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Allowance is Ownable{
    
    event AllowanceChanged(address indexed _byWhom, address indexed _forWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;

    function addAllowance (address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_msgSender(), _who, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function isOwner()public view returns(bool){
        return _msgSender() == owner();
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[_msgSender()] >= _amount,"You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal{
        emit AllowanceChanged(_msgSender(), _who, allowance[_who], allowance[_who]-(_amount));
        allowance[_who]=allowance[_who]-(_amount);
    }
}
