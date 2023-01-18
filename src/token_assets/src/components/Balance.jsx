import React, { useState } from "react";
import { Principal } from '@dfinity/principal'
import { token } from "../../../declarations/token/index";

function Balance() {
  
    const [inputValue, setinput] = useState("");
    const [balanceResult, setBalance] = useState("");
    const [cryptoSymbol ,setSymbol] = useState("")
    const [ishidden, sethidden] = useState(true)

    async function handleClick() {
    const principal = Principal.fromText(inputValue);
    const balance = await token.balanceOf(principal);
    setBalance(balance.toLocaleString())
    const symbol =  await  token.getSymbol();
    setSymbol(symbol);
    sethidden(false);
  }


  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={inputValue}
          onChange={(e) => {setinput(e.target.value)}}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
        >
          Check Balance
        </button>
      </p>
      <p hidden={ishidden} >This account has a balance of {balanceResult} {cryptoSymbol}.</p>
    </div>
  );
}

export default Balance;
