// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "https://github.com/aakash-kumar-gorai/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{
    using SafeMath for uint;
    event AllowanceChanged(address indexed _byWhom, address indexed _forWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;

    function addAllowance (address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_msgSender(), _who, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    // function isOwner()public view returns(bool){
    //     return _msgSender() == owner();
    // }

    modifier ownerOrAllowed(uint _amount) {
        
        require(isOwner() || allowance[_msgSender()] >= _amount,"You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal{
        emit AllowanceChanged(_msgSender(), _who, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who]=allowance[_who].sub(_amount);
    }
}