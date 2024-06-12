with chain_ids as (
select distinct decoded_log:bridgeData:destinationChainId as dst_chain,
                case
                  when dst_chain = 1 then 'ethereum'
                  when dst_chain = 8453 then 'base'
                  when dst_chain = 137 then 'polygon'
                  when dst_chain = 42161 then 'arbitrum'
                  when dst_chain = 10 then 'optimism'
                  when dst_chain = 56 then 'bnb'
                  when dst_chain = 43114 then 'avalanche'
                  when dst_chain = 1101 then 'pol zkevm'
                  when dst_chain = 59144 then 'linea'
                  when dst_chain = 100 then 'gnosis'
                  when dst_chain = 250 then 'fantom'
                  when dst_chain = 5000 then 'mantle'
                  when dst_chain = 1313161554 then 'aurora'
                  when dst_chain = 7777777 then 'zora'
                  when dst_chain = 324 then 'zksync'
                  when dst_chain = 1151111081099710 then 'solana'
                  when dst_chain = 534352 then 'scroll'
                  when dst_chain = 34443 then 'mode'
                  else 'Unknown'
                end as chain

from polygon.core.ez_decoded_event_logs 
where  event_name = 'LiFiTransferStarted'
 
)
select * from chain_ids
       