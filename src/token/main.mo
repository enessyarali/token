import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap"

actor token {

    var owner : Principal = Principal.fromText("nwjwh-nzsko-5uikr-lqxt6-5nn2j-bpt52-okuqg-mgbwy-yspfs-mhz2p-7ae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "LAT"

    var balances = HashMap.HashMap<Principal,>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);

    public query func balanceOf(who : Principal) : async Nat {

        let balance : Nat = switch (balances.get(who)) { //the return value is a Optional this switch statement helps identify it.
            case null 0;
            case(?result) result;
        };

        return balance;  
    }
}
