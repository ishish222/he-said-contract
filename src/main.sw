contract;

use std::{
    storage::StorageMap,
    auth::msg_sender,
};

storage {
    all_said: StorageMap<Identity,Vec<b256>> = StorageMap {},
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
        let new_user_said : Vec<b256> = Vec::new();
        
        let user_said_option : Option<Vec<b256>> = storage.all_said.get(user);
        
        match user_said_option {
            Option::Some(user_said) => {
                user_said.push(said);
                storage.all_said.insert(user, user_said);
            }
            Option::None => {
                new_user_said.push(said);
                storage.all_said.insert(user, new_user_said);
            }
        }
    }

    #[storage(read)]
    fn did_say(said: b256) -> bool {
        let user = msg_sender().unwrap();
        let user_said_option = storage.all_said.get(user);

        match user_said_option {
            Option::Some(user_said) => {
                let mut i = 0;
                let length = user_said.len();
                while i < length {
                    if(user_said.get(i).unwrap() == said) {
                        return true;
                    }
                    i = i+1;
                }
                return false;
            }
            Option::None => {
                return false;
            }
        }
    }
}
