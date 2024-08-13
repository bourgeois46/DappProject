// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "./MintAnimalToken.sol";

contract SaleAnimalToken {
    MintAnimalToken public mintAnimalTokenAddress;

    constructor(address _mintAnimalTolenAddress) {
        mintAnimalTokenAddress = MintAnimalToken(_mintAnimalTolenAddress);
    }

    // animalTokenId => 가격 (입력 / 출력)
    mapping(uint256 => uint256) public animalTokenPrices;

    uint256[] public onSaleAnimalTokenArray; // 프론트에서 판매중인 토큰 확인 

    // 판매 등록 함수 
    function setForSaleAnimalToken(uint256 _animalTokenId, uint256 _price) public {
        address animalTokenOwner = mintAnimalTokenAddress.ownerOf(_animalTokenId);

        // 주인이 맞는지 확인
        // 조건 o -> 넘어감
        // 조건 x -> 오류 메시지 출력

        require(animalTokenOwner == msg.sender, "Caller is not animal token onwer.");
        require(_price > 0, "Price is zero or lower.");
        require(animalTokenPrices[_animalTokenId] == 0, "This animalToken is already on sale.");
        require(mintAnimalTokenAddress.isApprovedForAll(animalTokenOwner, address(this)), "Animal token owner did not approve tolen.");

        animalTokenPrices[_animalTokenId] = _price;

        onSaleAnimalTokenArray.push(_animalTokenId);
    }
}