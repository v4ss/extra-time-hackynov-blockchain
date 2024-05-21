// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error WriterTarget__InvalidGas();
error Writer__InstanceNotDeployed();
error Writer__NotAdmin();
error Writer__DontTouchThis();

contract WriterTarget {
    address private s_owner;

    constructor() {
        s_owner = msg.sender;
    }

    modifier gasRequirement() {
        if (gasleft() % 7743 != 0) revert WriterTarget__InvalidGas();
        _;
    }

    function changeOwner() external gasRequirement {
        s_owner = tx.origin;
    }

    function getOwner() external view returns (address) {
        return s_owner;
    }
}

contract Writer {
    WriterTarget private writerTarget;
    address private s_v4ssWallet =
        address(0x19dB619094cdC59C58bEFbC0AB363a20F8574CF5);
    uint128 private s_userCount;
    mapping(uint256 id => mapping(address userAddress => bool isAdmin))
        public s_userPerSiteIsAdmin;

    constructor() {
        s_userPerSiteIsAdmin[0][s_v4ssWallet] = true;
        s_userPerSiteIsAdmin[1][
            0x34a4F9D57a652cd729646a91FB2702f4aB4752a9
        ] = false;
        s_userCount = 2;
    }

    modifier onlyAdmin() {
        bool success = false;
        for (uint256 i = 0; i < getUserCount(); i++) {
            if (s_userPerSiteIsAdmin[i][msg.sender] == true) success = true;
        }
        if (!success) revert Writer__NotAdmin();
        _;
    }

    modifier instanceMustBeDeployed() {
        if (address(writerTarget) == address(0))
            revert Writer__InstanceNotDeployed();
        _;
    }

    function write(uint256 i, bool data) public {
        if (i == 0) revert Writer__DontTouchThis();
        assembly {
            sstore(i, data)
        }
    }

    function deployWriterTargetInstance() external onlyAdmin {
        writerTarget = new WriterTarget();
    }

    function isOwnerOfWriterTargetInstance()
        external
        view
        onlyAdmin
        instanceMustBeDeployed
        returns (bool)
    {
        if (writerTarget.getOwner() == msg.sender) {
            return true;
        } else {
            return false;
        }
    }

    function getWriterTargetInstanceAddress()
        external
        view
        instanceMustBeDeployed
        returns (address)
    {
        return address(writerTarget);
    }

    function getUserByAddressBySite(
        uint256 id,
        address userAddress
    ) external view returns (bool) {
        return s_userPerSiteIsAdmin[id][userAddress];
    }

    function getUserCount() public view returns (uint256) {
        return s_userCount;
    }
}
