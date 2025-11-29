//SPDX License Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage{
    ///@notice The stored number that can be updated
    /// @dev Private means only this contract can access directly

    uint256 private storedNumber;
    /// @notice Address of the contract owner
    /// @dev Public automatically creates a getter function
    address public owner;


    // Events:
    /// @notice Emitted when the stored number is updated
    /// @param oldValue The previous value
    /// @param newValue The new value
    /// @param updatedBy Address that made the update 

    event NumberUpdated(uint indexed oldValue, uint indexed newValue, address indexed updatedBy);


    /// @notice Emitted when ownership is transferred
    /// @param oldOwner The old owner
    /// @param newOwner The new owner

    event OwnerShipTransferred(address indexed oldOwner, address indexed newOwner);

    //Errors

    //Custom Errors are more gas efficient than require strings 
    ///@notice Throws when non Ownr tries to call the owner-only function 
    error NotOwner();
    ///@notice Thrown when trying to transfer ownership to zero address
    error InvalidAddress();


    // MODIFIERS
    // =========
    
    /// @notice Restricts function access to only the owner
    /// @dev This modifier checks if msg.sender is the owner

    modifier onlyOnwer(){
        if(msg.sender!=owner){
            revert NotOwner();
        }
        _;// This is where the function body gets inserted
    }

    constructor(){
        // Yaha prr contructor values initialize krta jabhi contract deploy hota hai 
        owner= msg.sender;
        storedNumber=0;
        emit OwnerShipTransferred(address(0),msg.sender);
    }


    // EXTERNAL FUNCTIONS
    // ==================
    // External functions can only be called from outside the contract
    // They're more gas efficient than public for external calls
    
    /// @notice Updates the stored number (owner only)
    /// @param _newNumber The new number to store
    /// @dev Only owner can call this due to onlyOwner modifier

    function updateNumber(uint _newNumber)external onlyOnwer{
        uint256 oldNumber=storedNumber;
        storedNumber=_newNumber;

        emit NumberUpdated(oldNumber,_newNumber,msg.sender);
    }



    function transferOwnership(address _newOwner) external onlyOnwer{
        address oldOwner= owner;
        owner =_newOwner;

        emit OwnerShipTransferred(oldOwner,_newOwner);
    }



    // PUBLIC/EXTERNAL VIEW FUNCTIONS
    // ==============================
    // View functions don't modify state, so they're free to call
    
    /// @notice Returns the currently stored number
    /// @return The stored number value
    /// @dev Anyone can call this - it's a public read

    function getNumber() external view returns(uint256){
        return storedNumber;
    }
}