contract;

use std::storage::StorageVec;

storage {
    all_said: StorageVec<b256> = StorageVec {},
}

abi HeSaid {
    #[storage(read, write)]
    fn say(said: b256);

    #[storage(read)]
    fn did_say(said: b256) -> bool;
}

impl HeSaid for Contract {
    #[storage(read, write)]
    fn say(said: b256) {
        storage.all_said.push(said);
    }

    #[storage(read)]
    fn did_say(said: b256) -> bool {
        let mut i = 0;
        let length = storage.all_said.len();
        while i < length {
            if(storage.all_said.get(i).unwrap() == said) {
                return true;
            }
            i = i+1;
        }
        return false;
    }
}
