//SPDX-License-Identifier:MIT;

pragma solidity version ^0.8.19;

    /**
 * @title Escrow
 * @dev A trustless escrow service for ETH transactions
 * 
 * HOW IT WORKS:
 * 1. Seller creates an escrow specifying buyer and amount
 * 2. Seller deposits exact ETH amount
 * 3. Buyer receives goods/services off-chain
 * 4. Buyer confirms receipt → ETH released to seller
 * 5. OR if buyer doesn't confirm, seller can refund after deadline
 * 
 * REAL-WORLD USE CASE:
 * - Freelance payments
 * - Marketplace transactions
 * - Service agreements
 * 
 * NEW CONCEPTS YOU'LL LEARN:
 * - Handling ETH (receive, send)
 * - Enums (state management)
 * - Structs (complex data)
 * - Mappings with custom types
 * - Time-based logic
 * - Pull over push pattern (security)
 */

contract  Escrow{


      
    // ENUMS
    // =====
    // Enums are custom types with a fixed set of values
    // They're perfect for tracking state (like a status)
    
    /// @notice Possible states of an escrow
    /// @dev Each escrow can only be in one state at a time

    enum EscrowStatus {
        Pending,
        Diposited,
        Completed,
        Refunded
    }


    //Structs 
    //Structs gives us the ability to describe our own datatype by combining multiple 
    struct EscrowDetails{
    address payable seller;
    address buyer;
    uint amount;
    uint deadline;
    EscrowStatus status;
    }



    


    // Adding the variables 




    

      
    // ENUMS
    // =====
    // Enums are custom types with a fixed set of values
    // They're perfect for tracking state (like a status)
    
    /// @notice Possible states of an escrow
    /// @dev Each escrow can only be in one state at a time
}


