pragma solidity 0.4.18;


contract Betting {
    /* Constructor function, where owner and outcomes are set */
    function Betting(uint[] _outcomes) public {
        owner = msg.sender;
        for (uint counter = 0; counter < _outcomes.length; counter++) {
            outcomes[counter] = _outcomes[counter];
        }
    }

    /* Fallback function */
    function() public payable {
        revert();
    }

    /* Standard state variables */
    address public owner;
    address public gamblerA;
    address public gamblerB;
    address public oracle;

    /* Structs are custom data structures with self-defined parameters */
    struct Bet {
        uint outcome;
        uint amount;
        bool initialized;
    }

    /* Keep track of every gambler's bet */
    mapping (address => Bet) bets;
    /* Keep track of every player's winnings (if any) */
    mapping (address => uint) winnings;
    /* Keep track of all outcomes (maps index to numerical outcome) */
    mapping (uint => uint) public outcomes;

    /* Add any events you think are necessary */
    event BetMade(address gambler);
    event BetClosed();

    /* Uh Oh, what are these? */
    modifier ownerOnly() {
        require(msg.sender == owner);
        _;}
    modifier oracleOnly() {
        require(msg.sender == oracle);
        _;}
    modifier outcomeExists(uint outcome) {
        require(outcomes[outcome] != 0);
        _;}

    /* Owner chooses their trusted Oracle */
    function chooseOracle(address _oracle) public ownerOnly() returns (address) {
        oracle = _oracle;
        return oracle;
    }

    /* Gamblers place their bets, preferably after calling checkOutcomes */
    function makeBet(uint _outcome) public payable returns (bool) {
        /* first check if they already bet */
        if (msg.sender == owner) {
            return false;
        }
        if (msg.sender == oracle) {
            return false;
        }
        if (bets[msg.sender].initialized == false) {
            
            if (gamblerA == 0) {
                gamblerA = msg.sender;
            } else if (gamblerB == 0) {
                gamblerB = msg.sender;
            } else {
                return false; /* gamblers are already in */
            }

            bets[msg.sender] = Bet(_outcome, msg.value, true);
            BetMade(msg.sender);
            return true;
        } else {
            return false;
        }
    }

    /* The oracle chooses which outcome wins */
    function makeDecision(uint _outcome) public oracleOnly() outcomeExists(_outcome) {
        if (bets[gamblerA].outcome == _outcome && bets[gamblerA].outcome == _outcome) {
            winnings[gamblerA] += bets[gamblerA].amount;
            winnings[gamblerB] += bets[gamblerB].amount;
        } else if (bets[gamblerA].outcome != _outcome && bets[gamblerA].outcome != _outcome) {
            winnings[oracle] += bets[gamblerA].amount;
            winnings[oracle] += bets[gamblerB].amount;
        } else if (bets[gamblerA].outcome == _outcome) {
            winnings[gamblerA] += bets[gamblerA].amount;
        } else if (bets[gamblerB].outcome == _outcome) {
            winnings[gamblerB] += bets[gamblerB].amount;
        } else {
            return; /* redundant but whatever */
        }

        /* reset */
        gamblerA = 0;
        gamblerB = 0;
    }

    /* Allow anyone to withdraw their winnings safely (if they have enough) */
    function withdraw(uint withdrawAmount) public returns (uint) {
        if (winnings[msg.sender] >= withdrawAmount) {
            /* decrease beforehand!! */
            winnings[msg.sender] -= withdrawAmount;
            if (msg.sender.send(withdrawAmount)) {
                return 1;
            } else {
                /* payment failed let's give it back to their balance*/
                winnings[msg.sender] += withdrawAmount;
                return 0;
            }

        } else {
            return 0;
        }
    }
    
    /* Allow anyone to check the outcomes they can bet on */
    function checkOutcomes(uint outcome) public view returns (uint) {
        return outcomes[outcome];
    }
    
    /* Allow anyone to check if they won any bets */
    function checkWinnings() public view returns(uint) {
        return winnings[msg.sender];
    }

    /* Call delete() to reset certain state variables. Which ones? That's upto you to decide */
    function contractReset() public ownerOnly() {
        delete(gamblerA);
        delete(gamblerB);
        delete(oracle);
        BetClosed();
    }
}
