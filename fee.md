* 区块抵押奖励：

	* 发放频率： 每小时

	* 获益人：除了在unbonded队列中的，都会收到provision

全局的fee pool：

* 验证人费用：

	* 提出区块奖励: 在1%至4%间波动 

	proposerReward = feesCollected * (0.01 + 0.04*sumOfVotingPowerOfPrecommitValidators / gs.BondedShares)

    * 系统管理费用 reserveTaxed = feesCollected * params.ReserveTax

    * 分配的奖励 = feesCollected - proposerReward - reserveTaxed

	SumFeesReceived会在validator和delegator之间分配

