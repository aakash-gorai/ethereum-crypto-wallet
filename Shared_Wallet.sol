// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./Allowance.sol";

contract simpleWallet is Allowance{
    event BalanceChanged(address indexed _transactionAc,uint _newBalance);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance,"There is not enough fund available");
        if(!isOwner()){
            reduceAllowance(_msgSender(),_amount);
        }
        emit BalanceChanged(_to,_amount);
        _to.transfer(_amount);
    }

    fallback () external payable {
    emit BalanceChanged(_msgSender(),msg.value);
    }
    receive() external payable {}
}
