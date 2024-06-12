"""pip install flipside"""
from flipside import Flipside

"""Initialize Flipside with your API Key / API Url"""
flipside = Flipside("<YOUR_API_KEY>", "https://api-v2.flipsidecrypto.xyz")
sql = """-- forked from octavionotpunk / Jumper Source Chain
--  @ https://flipsidecrypto.xyz/octavionotpunk/q/JIUX5KquZLfu/jumper-source-chainselect 
```sql

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
  and block_timestamp > current_timestamp - interval '1 day'
),

  
polygon_raw_bridge_data as (
              select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                     decoded_log:bridgeData:bridge as bridge,
                     decoded_log:bridgeData:integrator as integrator,
                     tx_hash
              from polygon.core.ez_decoded_event_logs
              where event_name =  'LiFiTransferStarted'
                and block_timestamp > current_timestamp - interval '30 days'
),
polygon_bridge_data as (
  select 'polygon' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        polygon_raw_bridge_data r 
        using
        (dst_chain_id)
),
bsc_raw_bridge_data as (
          select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                 decoded_log:bridgeData:bridge as bridge,
                 decoded_log:bridgeData:integrator as integrator,
                 tx_hash
          from bsc.core.ez_decoded_event_logs
          where event_name =  'LiFiTransferStarted'
            and block_timestamp > (current_timestamp - interval '30 days')
),
bsc_bridge_data as (
  select 'bsc' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        bsc_raw_bridge_data r 
        using
        (dst_chain_id)
),
arbitrum_raw_bridge_data as (
          select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                 decoded_log:bridgeData:bridge as bridge,
                 decoded_log:bridgeData:integrator as integrator,
                 tx_hash
          from arbitrum.core.ez_decoded_event_logs
          where event_name =  'LiFiTransferStarted'
            and block_timestamp > current_timestamp - interval '30 days'
),
arbitrum_bridge_data as (
  select 'arbitrum' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        arbitrum_raw_bridge_data r 
        using
        (dst_chain_id)
),
optimism_raw_bridge_data as (
          select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                 decoded_log:bridgeData:bridge as bridge,
                 decoded_log:bridgeData:integrator as integrator,
                 tx_hash
          from optimism.core.ez_decoded_event_logs
          where event_name =  'LiFiTransferStarted'
            and block_timestamp > current_timestamp - interval '30 days'
),
optimism_bridge_data as (
  select 'optimism' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        optimism_raw_bridge_data r 
        using
        (dst_chain_id)
),
base_raw_bridge_data as (
          select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                 decoded_log:bridgeData:bridge as bridge,
                 decoded_log:bridgeData:integrator as integrator,
                 tx_hash
          from base.core.ez_decoded_event_logs
          where event_name =  'LiFiTransferStarted'
            and block_timestamp > current_timestamp - interval '30 days'
),
base_bridge_data as (
  select 'base' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        base_raw_bridge_data r 
        using
        (dst_chain_id)
),
avalanche_raw_bridge_data as (
          select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                 decoded_log:bridgeData:bridge as bridge,
                 decoded_log:bridgeData:integrator as integrator,
                 tx_hash
          from avalanche.core.ez_decoded_event_logs
          where event_name =  'LiFiTransferStarted'
            and block_timestamp > current_timestamp - interval '30 days'
),
avalanche_bridge_data as (
  select 'avalanche' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        avalanche_raw_bridge_data r 
        using
        (dst_chain_id)
),
ethereum_raw_bridge_data as (
          select decoded_log:bridgeData:destinationChainId as dst_chain_id,
                 decoded_log:bridgeData:bridge as bridge,
                 decoded_log:bridgeData:integrator as integrator,
                 tx_hash
          from ethereum.core.ez_decoded_event_logs
          where event_name =  'LiFiTransferStarted'
            and block_timestamp > current_timestamp - interval '30 days'
),
ethereum_bridge_data as (
  select 'ethereum' as source_chain,
         c.dst_chain,
         r.bridge,
         r.integrator,
         r.tx_hash
  from chain_ids c
        left join 
        ethereum_raw_bridge_data r 
        using
        (dst_chain_id)
),


all_chains_bridge_data as (
select * from polygon_bridge_data
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
select * from all_chains_bridge_data
-- select count(*) from all_chains_bridge_data -- 669230
-- select source_chain, count(*) from all_chains_bridge_data group by 1
```











"""
"""Run the query against Flipside's query engine and await the results"""
query_result_set = flipside.query(sql)
print(query_result_set)