# ProposalVoting

This Solidity contract implements a proposal voting system, designed to demonstrate the functionalities and best practices of smart contract development on the Ethereum blockchain. The contract allows an administrator to create proposals, and users to cast their votes on these proposals, ensuring the integrity and proper handling of the voting process.

## Description

The ProposalVoting contract is a decentralized application (dApp) that facilitates the creation of proposals and then voting on them. Key features of the contract include:

- **Admin Management**: Only the admin can create new proposals.
- **Proposal Tracking**: Each proposal has a unique ID, description, vote count, and creation time.
- **Voting Management**: Users can vote on proposals, with safeguards to prevent multiple votes on the same proposal or multiple votes on alternative proposals.
- **Voting Period**: Each proposal has a limited voting period, after which votes are no longer accepted.
- **Winning Proposal**: The contract can identify and return the proposal with the highest vote count.
- **Voter Tracking**: The admin can track the number of proposals a specific user has voted on.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.
Then Follow these steps to get started:

1. **Create a New File**: On the Remix website, click on the "+" icon in the left-hand sidebar and save the file with a `.sol` extension (e.g., `ProposalVoting.sol`).
2. **Copy the Solidity Code**: Copy and paste the provided Solidity code into the new file.
3. **Compile the Code**: Click on the "Solidity Compiler" tab in the left-hand sidebar. Ensure the "Compiler" option is set to "0.8.19" (or another compatible version), then click on the "Compile ProposalVoting.sol" button.
4. **Deploy the Contract**: Navigate to the "Deploy & Run Transactions" tab. Select the `ProposalVoting` contract from the dropdown menu, and click on the "Deploy" button.
5. **Interact with the Contract**: Once deployed, you can interact with the contract by calling its functions such as `Create_Proposal`, `Vote`, and `getWinningProposal`.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Authors

Arun Thakur
@exquisitehabibi
