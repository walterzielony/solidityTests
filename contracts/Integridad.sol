// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Integridad de archivos
 * @dev Guardar y recuperar hash de archivos
 */
contract Integridad {

    mapping (uint256 => string) private fileHashes;

    /**
     * @dev Guardar Hash para un archivo dado su Identificador
     * @param id Identificador del archivo
     * @param hash Hash del archivo
     */
    function storeHash(uint256 id, string memory hash) public {
        fileHashes[id] = hash;
    }

    /**
     * @dev Devuelve el hash de un archivo dado su Identificador
     * @return hash valor de hash para el archivo 'id'
     */
    function retrieveHash(uint256 id) public view returns (string memory){
        return fileHashes[id];
    }
}