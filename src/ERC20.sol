// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    uint256 private totalSupply_;

    string private name_;
    string private symbol_;

    constructor(string memory _name, string memory _symbol, uint _totalSupply) {
         name_ = _name;
         symbol_ = _symbol;
         totalSupply_ = _totalSupply;    
         balances[msg.sender] = _totalSupply;
    }

    // Metadata
    function name() public view virtual override returns (string memory) {
        return name_;
    }

     function symbol() public view virtual override returns (string memory) {
        return symbol_;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    // Methods
    function totalSupply() public view virtual override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _account) public view virtual override returns (uint256) {
        return balances[_account];
    }
    
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    // internal
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        /*
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            balances[from] = fromBalance - amount;
            balances[to] += amount;
        }

        emit Transfer(from, to, amount);
       */
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

     function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

}
