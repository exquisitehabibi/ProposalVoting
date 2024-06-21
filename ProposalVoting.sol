// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ProposalVoting {

    struct Proposal {
        uint id;
        string description;
        uint voteCount;
        uint creationTime;
    }

    address public admin;
    uint public proposalCount;
    uint public votingPeriod;
    mapping(uint => Proposal) public proposals;
    mapping(address => mapping(uint => bool)) public votes;

    event ProposalCreated(uint indexed proposalId, string description);
    event VoteCasted(address indexed voter, uint indexed proposalId);

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin can perform this action");
        _;
    }

    modifier hasNotVoted(uint proposalId) {
        require(!votes[msg.sender][proposalId], "You have already voted for this proposal");
        _;
    }


    //When the proposals are alternatives of a certain problem.
    modifier hasNotVotedforany(uint proposalId) {
        for(uint i=1; i<= proposalCount;i++){
        require(!votes[msg.sender][i], "You have already voted for a proposal");
        }
        _;
    }
    

    modifier proposalExists(uint proposalId) {
        require(proposals[proposalId].id != 0, "Proposal does not exist");
        _;
    }

    modifier votingActive(uint proposalId) {
        require(block.timestamp <= proposals[proposalId].creationTime + votingPeriod, "Voting period has ended");
        _;
    }

    constructor(uint _votingPeriod) {
        require(_votingPeriod > 0, "voting period must be > 0");
        admin = msg.sender;
        votingPeriod = _votingPeriod;
    }

    function Create_Proposal(string memory description) public onlyAdmin {
        require(bytes(description).length > 0, "Description cannot be empty");
        proposalCount++;
        proposals[proposalCount] = Proposal(proposalCount, description, 0, block.timestamp);
        emit ProposalCreated(proposalCount, description);
    }

    function Vote(uint proposalId) public proposalExists(proposalId) hasNotVoted(proposalId) votingActive(proposalId) {
        proposals[proposalId].voteCount++;
        votes[msg.sender][proposalId] = true;
        emit VoteCasted(msg.sender, proposalId);
    }

    function getWinningProposal() public view returns (uint winningProposalId, string memory description, uint voteCount) {
        uint maxVotes = 0;
        for (uint i = 1; i <= proposalCount; i++) {
            if (proposals[i].voteCount > maxVotes) {
                maxVotes = proposals[i].voteCount;
                winningProposalId = i;
            }
        }
        assert(winningProposalId > 0); //Asserts atleast one vote to get a winning proposal
        description = proposals[winningProposalId].description;
        voteCount = proposals[winningProposalId].voteCount;
    }

    //Function to get the number of proposals a person has voted for (onlyAdmin)
    function voted(address voter) public onlyAdmin view returns(uint voted_for){
        uint j=0;
        for (uint i = 1; i <= proposalCount; i++) {
            if (votes[voter][i]) {
                j+=1;
            }
        }
        voted_for = j;
    }

    function getAllProposals() public view returns (Proposal[] memory) {
        Proposal[] memory allProposals = new Proposal[](proposalCount);
        for (uint i = 1; i <= proposalCount; i++) {
            allProposals[i - 1] = proposals[i];
            }
        return allProposals;
    }

    /*
    No need to use currently as we get proposals call due to the struct Proposal.
    function getProposal(uint proposalId) public view proposalExists(proposalId) returns (uint id, string memory description, uint voteCount, uint creationTime) {
        Proposal memory proposal = proposals[proposalId];
        return (proposal.id, proposal.description, proposal.voteCount, proposal.creationTime);
    }
    */

}

/* I could not find any use of revert statement directly in this contract but,
instead used assert which by default implements revert in case of condition failure. */
