with chain_ids as (
select distinct decoded_log:bridgeData:destinationChainId as dst_chain_ID,
                case
                  when dst_chain_ID = 1 then 'ethereum'
                  when dst_chain_ID = 8453 then 'base'
                  when dst_chain_ID = 137 then 'polygon'
                  when dst_chain_ID = 42161 then 'arbitrum'
                  when dst_chain_ID = 10 then 'optimism'
                  when dst_chain_ID = 56 then 'bnb'
                  when dst_chain_ID = 43114 then 'avalanche'
                  when dst_chain_ID = 1101 then 'pol zkevm'
                  when dst_chain_ID = 59144 then 'linea'
                  when dst_chain_ID = 100 then 'gnosis'
                  when dst_chain_ID = 250 then 'fantom'
                  when dst_chain_ID = 5000 then 'mantle'
                  when dst_chain_ID = 1313161554 then 'aurora'
                  when dst_chain_ID = 7777777 then 'zora'
                  when dst_chain_ID = 324 then 'zksync'
                  when dst_chain_ID = 1151111081099710 then 'solana'
                  when dst_chain_ID = 534352 then 'scroll'
                  when dst_chain_ID = 34443 then 'mode'
                  else 'Unknown'
                end as dst_chain

from polygon.core.ez_decoded_event_logs 
where  event_name = 'LiFiTransferStarted'
 
)
select * from chain_ids
all_chains_transfer_data as (
select * from polygon_transfer_data
 union all 
select * from bsc_bridge_data
 union all
select * from arbitrum_bridge_data
 union all
select * from optimism_bridge_data
 union all
select * from base_bridge_data
 union all
select * from avalanche_bridge_data
 union all
select * from ethereum_bridge_data
)
       