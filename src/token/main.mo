import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap"
import Iter "mo:base/Iter";

actor token {

    var owner : Principal = Principal.fromText("nwjwh-nzsko-5uikr-lqxt6-5nn2j-bpt52-okuqg-mgbwy-yspfs-mhz2p-7ae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "LAT";

    private stable var balanceEntries : [(Principal , Nat)] = [];

    private var balances = HashMap.HashMap<Principal,Nat>(1, Principal.equal, Principal.hash);

    if(balances.size < 1){
         balances.put(owner, totalSupply);
    }
   
    public query func balanceOf(who : Principal) : async Nat {

        let balance : Nat = switch (balances.get(who)) { //the return value is a Option (similar to swifts optional its a typesafe null) this switch statement helps identify it.
            case null 0;
            case(?result) result;
        };

        return balance;  
    }

    public query func getSymbol() : async Text {
         return symbol ; 
    }

    public shared(msg) func payOut() : async Text {
        let amount = 10000;
        if(balances.get(msg.caller) == null){
        let result =  await transfer(msg.caller ,amount);
            return result;
        }else{
            return  "Already Claimed"
        }
    };

    public  shared(msg) func transfer(to : Principal , amount : Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller); 
        if(fromBalance > amount ) {

            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller , newFromBalance)

            let toBalance  = balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to , newToBalance);

             return "Success";
        }else{
            return "Insufficient Funds"
        }

    }

    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entries());
    }

    system func postupgrade() {
        balances := HashMap.fromIter<Principal,Nat>(balanceEntries.val(),Principal.equal() , Principal.hash());
        if(balances.size < 1){
         balances.put(owner, totalSupply);
        }
    }
}
