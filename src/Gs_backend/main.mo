import Principal "mo:base/Principal";
import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

actor TravelContract {

    // Data structure
    type TravelInfo = {
        source: Text;
        destination: Text;
        ticket_id: Text;
        distance: Text;
    };

    // State storage
    stable var travelStoreEntries : [(Principal, TravelInfo)] = [];
    var travelStore : HashMap.HashMap<Principal, TravelInfo> = HashMap.fromIter(travelStoreEntries.vals(), 10, Principal.equal, Principal.hash);

    // Store travel info
    public shared(msg) func storeTravelInfo(info: TravelInfo) : async Result.Result<Text, Text> {
        travelStore.put(msg.caller, info);
        #ok("Your journey has sucessifuly stored")
    };

    // Get travel info for the caller
    public shared(msg) func getTravelInfo() : async Result.Result<TravelInfo, Text> {
        switch (travelStore.get(msg.caller)) {
            case (?info) { #ok(info) };
            case (null) { #err("No travel info found for this user.") };
        }
    };

    // Get source
    public shared(msg) func getSource() : async Result.Result<Text, Text> {
        switch (travelStore.get(msg.caller)) {
            case (?info) { #ok(info.source) };
            case (null) { #err("No travel info found for this user.") };
        }
    };

    // Get destination
    public shared(msg) func getDestination() : async Result.Result<Text, Text> {
        switch (travelStore.get(msg.caller)) {
            case (?info) { #ok(info.destination) };
            case (null) { #err("No travel info found for this user.") };
        }
    };

    // Get ticket ID
    public shared(msg) func getTicketId() : async Result.Result<Text, Text> {
        switch (travelStore.get(msg.caller)) {
            case (?info) { #ok(info.ticket_id) };
            case (null) { #err("No travel info found for this user.") };
        }
    };

    // Get distance
    public shared(msg) func getDistance() : async Result.Result<Text, Text> {
        switch (travelStore.get(msg.caller)) {
            case (?info) { #ok(info.distance) };
            case (null) { #err("No travel info found for this user.") };
        }
    };

    // For upgrades
    system func preupgrade() {
        travelStoreEntries := Iter.toArray(travelStore.entries());
    };

    system func postupgrade() {
        travelStore := HashMap.fromIter(travelStoreEntries.vals(), 10, Principal.equal, Principal.hash);
    };
};