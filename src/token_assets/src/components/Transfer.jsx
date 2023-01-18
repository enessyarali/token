import React, { useState } from "react";
import { token } from "../../../declarations/token/index";
import Principal from "@dfinity/principal";

function Transfer() {
  
  const [toID , setToID] = useState("")
  const [amount , setAmount] = useState("")
  const [isdisabled , setDisabled] = useState(false);
  const [feedback ,setFeedback] = useState("");
  const [isHidden , setHidden] = useState(false);
   
  async function handleClick() {
    setHidden(true);
    setDisabled(true);
    const recipient = Principal.fromText(toID)
    const natamount = Number(amount);
    let result = await token.transfer(recipient , natamount)
    setFeedback(result);
    setDisabled(false);
    setHidden(true)
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={toID}
                onChange = {(e) => {setToID(e.target.value)}}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => {setAmount(e.target.value)}}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled= {isdisabled}>
          Transfer
          </button>
        </p>
        <p hidden={isHidden}>{feedback}</p>
      </div>
    </div>
  );
}

export default Transfer;
