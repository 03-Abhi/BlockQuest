// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Music_Royalty{
    address public admin;
    address public user;
    mapping(string=> address payable ) public add_Songs;
    struct artists{
        address Writer;
        address Composer;
        address Singer;
        uint256 Song_Cost;
    }

    mapping(string=>artists)public List_of_artists;
    mapping(string=>uint256)public usage;
    constructor(){
        admin=msg.sender;
    }


    modifier onlyAdmin(){
        require(admin==msg.sender,"Only admin can access this feature");
        _;
    }


    function addArtist(string memory song,address Writer,address Composer,address Singer,uint256 Song_Cost)public{ 
      require(msg.sender==add_Songs[song],"Only owner of song can access this feature");
      List_of_artists[song]=artists(Writer,Composer,Singer,Song_Cost);
    }


    function Song_Registration(string memory song,address payable owner)private onlyAdmin{ 
        add_Songs[song]= owner;
    }


    function withdraw(string memory song) public payable{
        usage[song]=usage[song]+1;
        require((List_of_artists[song].Song_Cost)==msg.value,"Insufficient Royalty to use this Song");
        uint256 payment=msg.value;
        add_Songs[song].transfer(payment);
    }
}