pragma solidity >=0.4.16 <0.9.0;

//keeps track of information for active games
contract GameManager {

    event NewGame(uint gameId, address player1);
    event JoinedGame(uint gameId);
    event NewWager(uint amount);

    //represents a game being played
    struct Game {
        address player1;
        address player2;
        uint wager;
        bool bothReady;
    }

    //maps game ID to game & stores active games
    mapping (uint => Game) public activeGames; 
    
    //takes values for proposed player2 to create new game with msg.sender as player1  
    function newGame(address _player2) external {
        uint _gameId = uint(keccak256(abi.encodePacked(msg.sender, _player2)));
        activeGames[_gameId] = Game(msg.sender, _player2, 0, false);
        emit NewGame(_gameId, _player1);
    } 

    modifier onlyPlayer1(_gameId){
        require(msg.sender == activeGames[_gameId].player1);
        _;
    }

    modifier onlyPlayer2(_gameId){
        require(msg.sender == activeGames[_gameId].player2);
        _;
    }

    //player 2 calls to confirm game
    function joinGame(uint _gameId) external onlyPlayer2(_gameId) {
        activeGames[_gameId].bothReady = true;
        emit JoinedGame(_gameId, _player2);
    }

    //player 1 calls to set wager
    function newWager(uint _amount, uint _gameId) private payable onlyPlayer1(_gameId) {
        activeGames[_gameId].wager = _amount;
        emit NewWager(_amount);
    }

    //player2 calls to join wager
    function joinWager(uint _gameId) private payable onlyPlayer2(_gameId) {
        _amount = activeGames[_gameId].wager;
        
    }
}