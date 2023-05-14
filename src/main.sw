contract;

storage {
    counter: u64 = 0,
    said: b256 = 0x0000000000000000000000000000000000000000000000000000000000000000,
}

abi HeSaid {
    #[storage(read, write)]
    fn increment();

    #[storage(read, write)]
    fn say(said: b256);

    #[storage(read)]
    fn did_say(said: b256) -> bool;

    #[storage(read)]
    fn count() -> u64;
}

impl HeSaid for Contract {
    #[storage(read)]
    fn count() -> u64 {
        storage.counter
    }

    #[storage(read, write)]
    fn increment() {
        storage.counter = storage.counter + 1;
    }

    #[storage(read, write)]
    fn say(said: b256) {
        storage.said = said;
    }

    #[storage(read)]
    fn did_say(said: b256) -> bool {
        said == storage.said
    }
}
