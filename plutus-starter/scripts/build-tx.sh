cardano-cli transaction build \
--babbage-era \
--testnet-magic 1 \
--tx-in 8b00ceb5686544728bdd8f7130130f2127220436b9edd0d6977f1e13441fac7a#2 \
--tx-in-collateral 8b00ceb5686544728bdd8f7130130f2127220436b9edd0d6977f1e13441fac7a#2 \
--tx-in 8b00ceb5686544728bdd8f7130130f2127220436b9edd0d6977f1e13441fac7a#1 \
--tx-in 9e0d4f8c172bf57dd769944f11f0189d7f41ce601dbb2b25194261244dddbb69#0 \
--spending-tx-in-reference 2a6792aa47bd2ca46f6ce4190d482cecf68b83b8fc414ab84bb2874091f08fb4#0 \
--spending-plutus-script-v2 \
--spending-reference-tx-in-inline-datum-present \
--spending-reference-tx-in-redeemer-file TreasuryRedeemer.json \
--tx-out addr_test1wqrr5cvc4ecne0k49a7vkktdxtu7jlp90g53u3gd9gjt86ss0hpf6+"67000000 + 1225 fb45417ab92a155da3b31a8928c873eb9fd36c62184c736f189d334c.7447696d62616c" \
--tx-out-inline-datum-file /home/james/hd2/ppbl2023/gpte-plutus-v2/scripts/datums/datum-treasury-with-project-hashes.json \
--tx-out addr_test1wqhkgd3xwa5wp0yavkltd7fjdjrz5hqtyk02fwlgcz0w2mqhjexy7+"8000000 + 1 05cf1f9c1e4cdcb6702ed2c978d55beff5e178b206b4ec7935d5e056.3232325050424c3230323344656d6f4765726f6c616d6f + 25 fb45417ab92a155da3b31a8928c873eb9fd36c62184c736f189d334c.7447696d62616c " \
--tx-out-inline-datum-file EscrowDatum.json \
--change-address addr_test1qqnpvxraq6yemgn0ulk2a2nhce4w73r3c7qnjwpzgys8nqge36xrt9hqx3rdnz276wnptq62ylzdntq56hg2umm3a4eq3hljlj \
--protocol-params-file protocol.json \
--out-file contributor-commits-to-project.draft
