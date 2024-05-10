use starknet::{ContractAddress, ClassHash};
use alexandria_math::sha256;

#[starknet::interface]
trait IERC20<TContractState> {
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn decimals(self: @TContractState) -> u8;
    fn total_supply(self: @TContractState) -> u256;
    fn balance_of(self: @TContractState, account: ContractAddress) -> u256;
    fn allowance(self: @TContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(ref self: TContractState, recipient: ContractAddress, amount: u256) -> bool;
    fn transferFrom(
        ref self: TContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256
    ) -> bool;
    fn approve(ref self: TContractState, spender: ContractAddress, amount: u256) -> bool;
}  



#[starknet::interface]
trait IAtomicStark<TContractState> {

    fn get_alice(self: @TContractState) ->  ContractAddress;
    fn get_caller(ref self: TContractState) ->  ContractAddress;
    fn get_bob(self: @TContractState) ->  ContractAddress;
    fn get_locktime(self: @TContractState) ->  u64;
    fn get_hash(self: @TContractState) ->  Array<u8>;
    fn calculate_hash(self: @TContractState,secret:  Array<u8>) ->   bool;
    fn calculate_hash_test(self: @TContractState,secret:  Array<u8>) ->  Array<u8>;
    fn bob_claim(ref self: TContractState,hash:Array<u8>) -> bool;
    fn alice_withdraw(ref self: TContractState) -> bool;
    
   

}

#[starknet::interface]
trait IAtomicStarkFactory<TContractState> {
    fn create(ref self: TContractState, ContractClassHash:ClassHash,
            _alice:ContractAddress, _bob:ContractAddress,_token: ContractAddress,_locktime:u64,_amount:u128,
            hash_1:u8,
            hash_2:u8,
            hash_3:u8,
            hash_4:u8,
            hash_5:u8,
            hash_6:u8,
            hash_7:u8,
            hash_8:u8,
            hash_9:u8,
            hash_10:u8,
            hash_11:u8,
            hash_12:u8,
            hash_13:u8,
            hash_14:u8,
            hash_15:u8,
            hash_16:u8,
            hash_17:u8,
            hash_18:u8,
            hash_19:u8,
            hash_20:u8,
            hash_21:u8,
            hash_22:u8,
            hash_23:u8,
            hash_24:u8,
            hash_25:u8,
            hash_26:u8,
            hash_27:u8,
            hash_28:u8,
            hash_29:u8,
            hash_30:u8,
            hash_31:u8,
            hash_32:u8) -> ContractAddress;
}

#[starknet::contract]
mod AtomicStark {
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::ContractAddress;
    use starknet::get_block_number;
    use starknet::get_block_timestamp;
    use alexandria_math::sha256;

    use super::{IERC20Dispatcher, IERC20DispatcherTrait};

    #[storage]
    pub struct Storage {
        token: IERC20Dispatcher,
        alice:ContractAddress,
        bob:ContractAddress,
        locktime:u64,
        amount: u128,

        hash_0:u8,
        hash_1:u8,
        hash_2:u8,
        hash_3:u8,
        hash_4:u8,
        hash_5:u8,
        hash_6:u8,
        hash_7:u8,
        hash_8:u8,
        hash_9:u8,
        hash_10:u8,
        hash_11:u8,
        hash_12:u8,
        hash_13:u8,
        hash_14:u8,
        hash_15:u8,
        hash_16:u8,
        hash_17:u8,
        hash_18:u8,
        hash_19:u8,
        hash_20:u8,
        hash_21:u8,
        hash_22:u8,
        hash_23:u8,
        hash_24:u8,
        hash_25:u8,
        hash_26:u8,
        hash_27:u8,
        hash_28:u8,
        hash_29:u8,
        hash_30:u8,
        hash_31:u8,
        hash_32:u8,

    }

    #[derive(Drop, Serde, starknet::Store)]
    struct Hash {
        hash_0:u8,
        hash_1:u8,
        hash_2:u8,
        hash_3:u8,
        hash_4:u8,
        hash_5:u8,
        hash_6:u8,
        hash_7:u8,
        hash_8:u8,
        hash_9:u8,
        hash_10:u8,
        hash_11:u8,
        hash_12:u8,
        hash_13:u8,
        hash_14:u8,
        hash_15:u8,
        hash_16:u8,
        hash_17:u8,
        hash_18:u8,
        hash_19:u8,
        hash_20:u8,
        hash_21:u8,
        hash_22:u8,
        hash_23:u8,
        hash_24:u8,
        hash_25:u8,
        hash_26:u8,
        hash_27:u8,
        hash_28:u8,
        hash_29:u8,
        hash_30:u8,
        hash_31:u8,
    }

    #[constructor]
    fn constructor(ref self: ContractState,
     _alice:ContractAddress, _bob:ContractAddress,_token: ContractAddress,_locktime:u64,_amount:u128,
        hash_1:u8,
        hash_2:u8,
        hash_3:u8,
        hash_4:u8,
        hash_5:u8,
        hash_6:u8,
        hash_7:u8,
        hash_8:u8,
        hash_9:u8,
        hash_10:u8,
        hash_11:u8,
        hash_12:u8,
        hash_13:u8,
        hash_14:u8,
        hash_15:u8,
        hash_16:u8,
        hash_17:u8,
        hash_18:u8,
        hash_19:u8,
        hash_20:u8,
        hash_21:u8,
        hash_22:u8,
        hash_23:u8,
        hash_24:u8,
        hash_25:u8,
        hash_26:u8,
        hash_27:u8,
        hash_28:u8,
        hash_29:u8,
        hash_30:u8,
        hash_31:u8,
        hash_32:u8,
    ) {
        self.token.write(super::IERC20Dispatcher{contract_address: _token});
        self.alice.write(_alice);
        self.bob.write(_bob);
        self.locktime.write(_locktime);
        self.amount.write(_amount);
       
        self.hash_0.write(0x20);
        self.hash_1.write(hash_1);
        self.hash_2.write(hash_2);
        self.hash_3.write(hash_3);
        self.hash_4.write(hash_4);
        self.hash_5.write(hash_5);
        self.hash_6.write(hash_6);
        self.hash_7.write(hash_7);
        self.hash_8.write(hash_8);
        self.hash_9.write(hash_9);
        self.hash_10.write(hash_10);
        self.hash_11.write(hash_11);
        self.hash_12.write(hash_12);
        self.hash_13.write(hash_13);
        self.hash_14.write(hash_14);
        self.hash_15.write(hash_15);
        self.hash_16.write(hash_16);
        self.hash_17.write(hash_17);
        self.hash_18.write(hash_18);
        self.hash_19.write(hash_19);
        self.hash_20.write(hash_20);
        self.hash_21.write(hash_21);
        self.hash_22.write(hash_22);
        self.hash_23.write(hash_23);
        self.hash_24.write(hash_24);
        self.hash_25.write(hash_25);
        self.hash_26.write(hash_26);
        self.hash_27.write(hash_27);
        self.hash_28.write(hash_28);
        self.hash_29.write(hash_29);
        self.hash_30.write(hash_30);
        self.hash_31.write(hash_31);
        self.hash_32.write(hash_32);
    }


    #[abi(embed_v0)]
    impl AtomicStark of super::IAtomicStark<ContractState> {

        fn get_alice(self: @ContractState) ->  ContractAddress{
           self.alice.read()
        }
        
        fn get_bob(self: @ContractState) ->  ContractAddress{
           self.bob.read()
        }

         fn get_caller(ref self: ContractState) ->  ContractAddress{
          get_caller_address()
        }

        fn get_locktime(self: @ContractState) ->  u64{
         self.locktime.read()
        }

        fn get_hash(self: @ContractState) ->  Array<u8>{
            let mut input: Array<u8> = array![
                    self.hash_0.read(),
                    self.hash_1.read(),
                    self.hash_2.read(),
                    self.hash_3.read(),
                    self.hash_4.read(),
                    self.hash_5.read(),
                    self.hash_6.read(),
                    self.hash_7.read(),
                    self.hash_8.read(),
                    self.hash_9.read(),
                    self.hash_10.read(),
                    self.hash_11.read(),
                    self.hash_12.read(),
                    self.hash_13.read(),
                    self.hash_14.read(),
                    self.hash_15.read(),
                    self.hash_16.read(),
                    self.hash_17.read(),
                    self.hash_18.read(),
                    self.hash_19.read(),
                    self.hash_20.read(),
                    self.hash_21.read(),
                    self.hash_22.read(),
                    self.hash_23.read(),
                    self.hash_24.read(),
                    self.hash_25.read(),
                    self.hash_26.read(),
                    self.hash_27.read(),
                    self.hash_28.read(),
                    self.hash_29.read(),
                    self.hash_30.read(),
                    self.hash_31.read(),
                    self.hash_32.read(),
            ];
           input
        }

        fn calculate_hash( self: @ContractState,secret: Array<u8>) ->  bool{
            let  result = sha256::sha256(secret);
            assert(*result[0] == self.hash_1.read(), 'invalid result');
            assert(*result[1] == self.hash_2.read(), 'invalid result');
            assert(*result[2] == self.hash_3.read(), 'invalid result');
            assert(*result[3] == self.hash_4.read(), 'invalid result');
            assert(*result[4] == self.hash_5.read(), 'invalid result');
            assert(*result[5] == self.hash_6.read(), 'invalid result');
            assert(*result[6] == self.hash_7.read(), 'invalid result');
            assert(*result[7] == self.hash_8.read(), 'invalid result');
            assert(*result[8] == self.hash_9.read(), 'invalid result');
            assert(*result[9] == self.hash_10.read(), 'invalid result');
            assert(*result[10] == self.hash_11.read(), 'invalid result');
            assert(*result[11] == self.hash_12.read(), 'invalid result');
            assert(*result[12] == self.hash_13.read(), 'invalid result');
            assert(*result[13] == self.hash_14.read(), 'invalid result');
            assert(*result[14] == self.hash_15.read(), 'invalid result');
            assert(*result[15] == self.hash_16.read(), 'invalid result');
            assert(*result[16] == self.hash_17.read(), 'invalid result');
            assert(*result[17] == self.hash_18.read(), 'invalid result');
            assert(*result[18] == self.hash_19.read(), 'invalid result');
            assert(*result[19] == self.hash_20.read(), 'invalid result');
            assert(*result[20] == self.hash_21.read(), 'invalid result');
            assert(*result[21] == self.hash_22.read(), 'invalid result');
            assert(*result[22] == self.hash_23.read(), 'invalid result');
            assert(*result[23] == self.hash_24.read(), 'invalid result');
            assert(*result[24] == self.hash_25.read(), 'invalid result');
            assert(*result[25] == self.hash_26.read(), 'invalid result');
            assert(*result[26] == self.hash_27.read(), 'invalid result');
            assert(*result[27] == self.hash_28.read(), 'invalid result');
            assert(*result[28] == self.hash_29.read(), 'invalid result');
            assert(*result[29] == self.hash_30.read(), 'invalid result');
            assert(*result[30] == self.hash_31.read(), 'invalid result');
            assert(*result[31] == self.hash_32.read(), 'invalid result');
            true
        }





        fn calculate_hash_test(self: @ContractState,secret:Array<u8>) ->  Array<u8>{
            sha256::sha256(secret)
        }

        
        fn bob_claim(ref self: ContractState,hash:Array<u8>) -> bool{
            let (caller,this) = self.getImportantAddresses();
            assert(caller == self.bob.read(), 'not bob');
            assert( self.verifyHash(hash)  == true ,'secret wrong' );

            
            let _balance = self.token.read().balance_of(this);

            self.token.read().transfer(caller,_balance.into());
            true

         }


        
        fn alice_withdraw(ref self: ContractState) -> bool{
            let (caller,this) = self.getImportantAddresses();
            assert(caller == self.alice.read(), 'not alice');
            assert(self.locktime.read() <= get_block_timestamp().into(), 'too short');
            let _balance = self.token.read().balance_of(this);
            self.token.read().transfer(caller,_balance.into());
            true
         }


       
      



    }





    #[generate_trait]
    impl Private of PrivateTrait {
       
        fn getImportantAddresses(self: @ContractState) -> (ContractAddress, ContractAddress) {
            let caller: ContractAddress = get_caller_address();
            let this: ContractAddress = get_contract_address();
            (caller, this)
        }

         fn verifyHash(self: @ContractState,secret: Array<u8>) ->  bool{
            let  result = sha256::sha256(secret);
            assert(*result[0] == self.hash_1.read(), 'invalid result');
            assert(*result[1] == self.hash_2.read(), 'invalid result');
            assert(*result[2] == self.hash_3.read(), 'invalid result');
            assert(*result[3] == self.hash_4.read(), 'invalid result');
            assert(*result[4] == self.hash_5.read(), 'invalid result');
            assert(*result[5] == self.hash_6.read(), 'invalid result');
            assert(*result[6] == self.hash_7.read(), 'invalid result');
            assert(*result[7] == self.hash_8.read(), 'invalid result');
            assert(*result[8] == self.hash_9.read(), 'invalid result');
            assert(*result[9] == self.hash_10.read(), 'invalid result');
            assert(*result[10] == self.hash_11.read(), 'invalid result');
            assert(*result[11] == self.hash_12.read(), 'invalid result');
            assert(*result[12] == self.hash_13.read(), 'invalid result');
            assert(*result[13] == self.hash_14.read(), 'invalid result');
            assert(*result[14] == self.hash_15.read(), 'invalid result');
            assert(*result[15] == self.hash_16.read(), 'invalid result');
            assert(*result[16] == self.hash_17.read(), 'invalid result');
            assert(*result[17] == self.hash_18.read(), 'invalid result');
            assert(*result[18] == self.hash_19.read(), 'invalid result');
            assert(*result[19] == self.hash_20.read(), 'invalid result');
            assert(*result[20] == self.hash_21.read(), 'invalid result');
            assert(*result[21] == self.hash_22.read(), 'invalid result');
            assert(*result[22] == self.hash_23.read(), 'invalid result');
            assert(*result[23] == self.hash_24.read(), 'invalid result');
            assert(*result[24] == self.hash_25.read(), 'invalid result');
            assert(*result[25] == self.hash_26.read(), 'invalid result');
            assert(*result[26] == self.hash_27.read(), 'invalid result');
            assert(*result[27] == self.hash_28.read(), 'invalid result');
            assert(*result[28] == self.hash_29.read(), 'invalid result');
            assert(*result[29] == self.hash_30.read(), 'invalid result');
            assert(*result[30] == self.hash_31.read(), 'invalid result');
            assert(*result[31] == self.hash_32.read(), 'invalid result');
            true
        }

    }



}


#[starknet::contract]
mod AtomicStarkFactory {
    use starknet::ContractAddress;
    use starknet::syscalls::deploy_syscall;
    use starknet::ClassHash;
    use core::serde::Serde;
    use core::starknet::event::EventEmitter;
    use core::traits::Into;
    use super::{IERC20Dispatcher, IERC20DispatcherTrait};
    use starknet::get_caller_address;
    
     #[storage]
    pub struct Storage {
        TokenClassHash:ClassHash
    }

    #[constructor]
    fn constructor(ref self: ContractState,_TokenClassHash:ClassHash) {
        self.TokenClassHash.write(_TokenClassHash);
    }


   #[abi(embed_v0)]
    impl AtomicStarkFactory of super::IAtomicStarkFactory<ContractState> {
        fn create(ref self: ContractState,ContractClassHash:ClassHash,
            _alice: ContractAddress, _bob:ContractAddress,_token: ContractAddress,_locktime:u64,_amount:u128,
            hash_1:u8,
            hash_2:u8,
            hash_3:u8,
            hash_4:u8,
            hash_5:u8,
            hash_6:u8,
            hash_7:u8,
            hash_8:u8,
            hash_9:u8,
            hash_10:u8,
            hash_11:u8,
            hash_12:u8,
            hash_13:u8,
            hash_14:u8,
            hash_15:u8,
            hash_16:u8,
            hash_17:u8,
            hash_18:u8,
            hash_19:u8,
            hash_20:u8,
            hash_21:u8,
            hash_22:u8,
            hash_23:u8,
            hash_24:u8,
            hash_25:u8,
            hash_26:u8,
            hash_27:u8,
            hash_28:u8,
            hash_29:u8,
            hash_30:u8,
            hash_31:u8,
            hash_32:u8
         ) -> ContractAddress {

            let mut constructor_calldata = ArrayTrait::new();
            _alice.serialize(ref constructor_calldata);
            _bob.serialize(ref constructor_calldata);
            _token.serialize(ref constructor_calldata);
            _locktime.serialize(ref constructor_calldata);
            _amount.serialize(ref constructor_calldata);
            hash_1.serialize(ref constructor_calldata);
            hash_2.serialize(ref constructor_calldata);
            hash_3.serialize(ref constructor_calldata);
            hash_4.serialize(ref constructor_calldata);
            hash_5.serialize(ref constructor_calldata);
            hash_6.serialize(ref constructor_calldata);
            hash_7.serialize(ref constructor_calldata);
            hash_8.serialize(ref constructor_calldata);
            hash_9.serialize(ref constructor_calldata);
            hash_10.serialize(ref constructor_calldata);
            hash_11.serialize(ref constructor_calldata);
            hash_12.serialize(ref constructor_calldata);
            hash_13.serialize(ref constructor_calldata);
            hash_14.serialize(ref constructor_calldata);
            hash_15.serialize(ref constructor_calldata);
            hash_16.serialize(ref constructor_calldata);
            hash_17.serialize(ref constructor_calldata);
            hash_18.serialize(ref constructor_calldata);
            hash_19.serialize(ref constructor_calldata);
            hash_20.serialize(ref constructor_calldata);
            hash_21.serialize(ref constructor_calldata);
            hash_22.serialize(ref constructor_calldata);
            hash_23.serialize(ref constructor_calldata);
            hash_24.serialize(ref constructor_calldata);
            hash_25.serialize(ref constructor_calldata);
            hash_26.serialize(ref constructor_calldata);
            hash_27.serialize(ref constructor_calldata);
            hash_28.serialize(ref constructor_calldata);
            hash_29.serialize(ref constructor_calldata);
            hash_30.serialize(ref constructor_calldata);
            hash_31.serialize(ref constructor_calldata);
            hash_32.serialize(ref constructor_calldata);


            let (deployed_address, _) = deploy_syscall(
                self.TokenClassHash.read(), 0, constructor_calldata.span(), false
            ).expect('failed deploy');
            

            deployed_address
        }
    }

}



