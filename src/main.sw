contract;

use std::{
    storage::StorageMap,
    auth::msg_sender,
};

storage {
    all_said: StorageMap<b256, Identity> = StorageMap {},
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
        let user = msg_sender().unwrap();

        storage.all_said.insert(said, user);

    }

    #[storage(read)]
    fn did_say(said: b256) -> bool {
        let user = msg_sender().unwrap();

        let user_said_option = storage.all_said.get(said);

        match user_said_option {
            Option::Some(user_) => {
                user_ == user
            }
            Option::None => {
                false
            }
        }
    }
}
