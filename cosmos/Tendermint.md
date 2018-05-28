# Tendermint

Blockchain technology is becoming **THE** technology of our time. The community is growing at an amazing pace and brilliant developers are vowing to change the world.

As an blockchain engineer, I see Tendermint protocol as the technology for creating a brighter future. In my article, I’d like to share my thoughts about Tendermint and hope you will find it useful.

### Outline

- Why do reasearchers work on consensus?
- The milestone of consensus algorithm
- Why Bitcoin and Ethereum is not enough?
- Tendermint: the protocol & the project

------

### Why do we need consensus?

Consensus is how we get something reliable out of an unreliable basis. The entropy of universe decreases when consensus leads it out of chaos. The evolution of life is a way that all the cells in the animal reach consensus about arrange of DNAs; the society reached consensus about the next move of a nation.

The need for consensus goes way back to microprocessors in aircrafts . Within an aircraft, there could be hundreds of chips, which send signals and communicate with other chips. These chips would be effected by outside interference, like radiation and low temperature, etc. The controlling system has to reach a consensus about the condition of aircraft, even though the sensors chips were sending false signals.

As the computers network began to form in 1970s, computer engineers started to face the problem of fault-tolerent-computing and they picked up the techniques of controlling aircraft to solve the problem of coordination. In the early years of research, more and more professionals started formalizing algorithm and consensus protocols.

There are two features one consensus protocol can provide, it is safety and liveliness.

- Safety means that bad things will not happen. So, everyone will agree on the same history log and there is no disagreement.
- Liveliness means that eventually something good will happen and the system can proceed.

### The milestones of development of consensus algorithm

- **The begining of distributed system consensus**

In [seminal work](https://medium.com/r/?url=http%3A%2F%2Fresearch.microsoft.com%2Fen-us%2Fum%2Fpeople%2Flamport%2Fpubs%2Fpubs.html) published in 1978, [Leslie Lamport](https://medium.com/r/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FLeslie_Lamport) came up with many of the key concepts in distributed computing, which capture chronological and causal relationships in a distributed system. First time in computing history, we began to work on how to make a network of computers work together. Then, in 1982, Lamport and others publish the paper of “The Byzantine Generals Problem”. In this paper, he describes a situation where several Byzantine generals wish to formulate a plan for attacking a Rome city. They have to decide whether “attack” or “retreat”when only messagers can communicate. Byzantine fault tolerance can be achieved if the loyal (non-faulty) generals have a majority agreement on their strategy. When the generals are not able to coodinate, then there is a “Byzantine failure”.In a peer-to-peer network, when one or more node is down or failed to function peoperly, the whole system can fail and cause a “Byzantine failure”.

- **FLP Impossible**

Afterwards, more and more engineers and researchers were trying to come up with a solution of “The Byzantine Generals Problem”. On April 1985, Fischer, Lynch and Patterson published a short paper [‘Impossibility of Distributed Consensus with One Faulty Process’](https://medium.com/r/?url=http%3A%2F%2Fcs-www.cs.yale.edu%2Fhomes%2Farvind%2Fcs425%2Fdoc%2Ffischer.pdf). The paper shows that in an asynchronous system, even only one processor crashed, there is no way that system reach consensus.The paper eventually won the Dijkstra award given to the most influential papers in distributed computing, definitively placed an upper bound on what it is possible to achieve with distributed processes in an asynchronous environment.

- **Partial Synchrony of DLS**

FLP impossible makes the researcher’s work much harder. Fortunately, the concept of partial synchrony in a distributed system is introduced in a paper “[Consensus in the presence of partial synchrony](https://medium.com/r/?url=https%3A%2F%2Fwww.google.com%2Furl%3Fsa%3Dt%26rct%3Dj%26q%3D%26esrc%3Ds%26source%3Dweb%26cd%3D1%26ved%3D2ahUKEwjzrNer183aAhUD72MKHW5dBx0QFjAAegQIABAu%26url%3Dhttps%253A%252F%252Fgroups.csail.mit.edu%252Ftds%252Fpapers%252FLynch%252Fjacm88.pdf%26usg%3DAOvVaw1byQ82jwG43uTAqzl_JbxH)”. The result is also known as DLS consensus result, after the authors: Dwork, Lynch and Stockmeyers. So, between a synchronous system and an asynchronous system, we could define a week or partial system. The partial synchronous system is set to have a upper bond of timeout. In this way, we will be able to design a feasible BFT protocol.

- **Paxos & Raft**

Leslie Lamport introduced a practical solution for having **crash-fault tolerent** consensus in asynchronous networks in 1990. Paxos comes with a reputation as being fantastically difficult to understand. Paxos was the first correct protocol which was provably resiliant in the face asynchronous networks. Paxos sacrifices liveness when the messages are not available, it waits until good behaviour is reported. Paxos is very popular and has been implemented in Zookeeper and Unix systemm.

In 2001, Leslie lamport published another paper “[Paxos Made Simple](https://medium.com/r/?url=http%3A%2F%2FPaxos%20Made%20Simple%20-%20Leslie%20Lamport)”. In this paper, he explained algorithm in some basic manner, you can find no formulas, and it’s very short.

In 2013, Diego Ongaro published his work on making Paxos understandable. In his [Raft Paper](https://medium.com/r/?url=https%3A%2F%2Fraft.github.io%2Fraft.pdf), he proved Raft is equvalent in fault-tolerance and performance. The difference is that Raft is much easily implemented. It’s decomposed into relatively independent subproblems, and it cleanly addresses all major pieces needed for practical systems. Raft has been implemented in various systems and is still popular today. You can find its implementation in different languages.

- **PBFT**

On the other hand, in Byzantine fault tolerant case, Miguel Castro and [Barbara Liskov](https://medium.com/r/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBarbara_Liskov) introduced the “Practical Byzantine Fault Tolerance” (PBFT) algorithm in 1999, which provides high-performance Byzantine state machine replication, processing thousands of requests per second with sub-millisecond increases in latency.Their solution actually solve the Byzantine General Problem in an asynchronous environment and became an industry standard.

### How does Bitcoin and Ethereum handle consensus?

- **Nakamoto Consensus**

In 2008, someone named Satoshi Nakamoto published the famous paper:Bitcoin a peer to peer electronic cash system. In this paper, a solution is presented to help settle the order of transaction. Later on, people realized that it’s actually a solution for BFT in real permissionless economic system. Nakamoto consensus has the assumption that network channels are fully synchronous (i.e. messages are instantly delivered without delays). All the participants in the system agree to construct a public ledger together, which contains all verified transactions. The protocol says that the first announced correct block containing solution to a computational puzzle is considered valid; and all other miners are to start searching for the next block after that moment. Since a certain amount of time is always required to calculate next block, so the network can always use the longest chain to help monitor the process. Then as long as the honest nodes are the majority, we can always trust the longest chain and reach a consensus.

The genius of Nakamoto Consensus is that we introduce the proof-of-work to find the solution and skip the constraints of asynchronous or deterministic protocol. Since finding the solution is rather probabilistic, we just wait long enough and in the end, there will always be a solution.

- **GHOST of Ehtereum**

Now we can understand that a long block time is key to the safety of Nakamoto consensus. The average block time is 10 miniutes, which is unacceptable in many cases. If we reduce the block time, it will damage the system security.

The Ethereum consensus protocol is “Greedy Heaviest Observed Subtree” (GHOST) protocol, which is first introduced by Yonatan Sompolinsky and Aviv Zohar in [December 2013](https://medium.com/r/?url=https%3A%2F%2Feprint.iacr.org%2F2013%2F881.pdf). The motivation behind GHOST is that blockchains with fast confirmation times currently suffer from reduced security due to a high stale rate — because blocks take a certain time to propagate through the network. In GHOST, not only the longest chain, but also the related ancestors are included in calculations. In this way, we solve the problem of centralization bias and keep a low block latency at the same time.

### Why Tendermint is so needed?

- **Drawbacks of PoW**

PoW is not an energy efficient choice, we wasted an enormous amount of energy every year. Also, the 51% attack is a potential security issue for PoW based consensus. As mining pool are growing to be more and more centralized, the risk of centralization is also very clear.

- **History of Proof-of-stake pre-Tendermint**

[Proof of Stake](https://medium.com/r/?url=https%3A%2F%2Fcointelegraph.com%2Ftags%2Fproof-of-stake) (PoS) was first introduced in a paper by Sunny King and Scott Nadal in 2012 and intended to solve the problem of Bitcoin mining’s high energy consumption. First-generation PoS protocols such as Peercoin were naively implemented but were steps in the right direction.

At the time, PoS research made a large assumption that the number of peers in the system is fixed and that it would be stable over long periods of time. It was completely unrealistic in the blockchain environment. Also PoS also has the issue that can arise is the “**nothing-at-stake**” problem, wherein block generators have nothing to lose by voting for multiple blockchain histories, thereby preventing consensus from being achieved. This makes PoS not an ideal option for a distributed consensus protocol.

**The long range attack** draws from the scenario where after an attacker withdraw his deposit, he could build up a fork from an arbitrarily long range without fear of being slashed. In this way, the attacker with >2/3 power could create a second chain and could double spend or even include some arbitrary transactions.

- **What is Tendermint protocol?**

Tendermint is when you combine traditional PBFT solution with modern blockchain technologies together. Tendermint belongs to a group of protocols which solve consensus in the partially synchronous system model. It’s a deterministic protocol, meaning it doesn’t use randomness, relying on synchrony only for termination. More precisely, it never forks in the presence of asynchrony. Unless >1/3 of voting power are owned by faulty or even Byzantine processes. Or, it might never terminate if the system doesn’t have a long enough period of synchrony. Other consensus algorithms designed for synchronous system models use bounds on process speed.

Jae Kwon’s major innovation is that he, along with Ethan Buchman, inherited the BFT research and optimized them with blockchain’s technologies, like: Merkel proof, hash link and etc. It also support dynamic validator sets and rotating leader election. Finally, they solved the problem of applying BFT research in a PoS public blockchain context and started promoted the geneius idea since 2014. More details about the proof of Tendermint protocol can be found in Ethan Buchman’s [thesis](https://medium.com/r/?url=https%3A%2F%2Ft.co%2FWNFm8PCYZE). He and Jae also built the alpha release of Tendermint software.

- **How Tendermint solve the problem of nothing-at-stake**

The “Nothing-at-stake”problem presents the following scenario: validators can break safety by voting for multiple conflicting blocks at a given block height without incurring cost for doing so. In PoW, the validators are prevented from voting on different chains because miners will suffer a loss for splitting the scare hash power. Naive PoS has no incentive to ever converge on a unique chain. The economically optimal strategy becomes voting on as many forks as you can to gain most block rewards.

Jae Kwon introduced the notion of “slashing” to solve this issue. He elaborated the slashing conditions and ideas in the original [whitepaper](https://medium.com/r/?url=https%3A%2F%2Ftendermint.com%2Fstatic%2Fdocs%2Ftendermint.pdf). In this way, the validators are encouraged to follow a unique chain, so the safety is well guarded.

- **How Tendermint solve the problem of long range attack**

The long range attack draws from the right that once security deposits are unbonded, the incentive not to vote on a long-range fork from some block height ago is removed. In this way, when more than ⅔ of the validators have unbonded, they could maliciously create a second chain. which included the past validator set, which could result in arbitrary alternative transactions.Long range attacks in PoS are rectified under the [weak subjectivity](https://medium.com/r/?url=https%3A%2F%2Fblog.ethereum.org%2F2014%2F11%2F25%2Fproof-stake-learned-love-weak-subjectivity%2F) model. Tendermint adopt a simple locking mechanism (colloquially called ‘freezing’ in Tendermint) which “locks” stake for a certain period of time (3 weeks) in order to prevent any malicious coalition of validators from violating safety.

### Post-Tendermint Era

In the post-Tendermint time, a large number of consensus algorithms (Honeybadger, Ouroboros, Tezos, Casper) popped up that all incorporate elements of previous BFT researches along with other optimization stratigies on the blockchain.

- **ABCI: A Developer Friendly Design**

Tendermint has been implemented. It’s open-source and you can find the repository on github.com/tendermint/tendermint. The first implementation is written in Go, it’s famous for handling huge thoughput. The team is working on to make Tendermint a general purpose, Byzantine fault tolerant state machine replication engine. With the help of Tendermint community, we now have the implementation on Java, C, Haskell, Erlang, Python, etc. You can expect to see more and more implementations.

To help developers write applications in whatever language they like, Tendermint introduce the idea of ABCI, the application blockchain interface. Unlike Ethereum and Bitcoin, the ABCI makes the application logic separated from consensus. The stack of Bitcoin is monolithic, so there is not much thing we can do with its scripting language. Though Ethereum Virtual Machine seems a better option, but you have to learn Solidity and this could lead to some security disaster. We don’t want to repeat what happened with Parity.

So, what Tendermint did was to expose only the application interface, which handle the state machine logics. Now the developer can build their own finite state machine then let it run on top of Tendermint. We could do a better job testing and debugging with ABCI.

- **Ethermint**

We all agree that EVM is an amazing invention, and for those developers who want to migrate their Ethereum DApp on top of Tendermint, there’s a solution called Ethermint. Ethermint is fully compatible with Ethereum’s web3 interface as well as the existing tooling around Ethereum clients via RPC endpoints. You can find more information in this official [blog](https://medium.com/r/?url=https%3A%2F%2Fblog.cosmos.network%2Fa-beginners-guide-to-ethermint-38ee15f8a6f4). For now, the code repo is not under maintenance, because the team focused on Cosmos Hub.

------

### Reference:

1. cosmos.network
2. whitepaper of Tendermint&Cosmos
3. cosmos consensus prodcast:[ Consensus Systems with Ethan Buchman http://traffic.libsyn.com/sedaily/2018_03_26_Tendermint.mp3Podcast: Play in new window | Download Consensus protocols are used to allow computers to work together. A consensus protocol lets dif… softwareengineeringdaily.com](https://medium.com/r/?url=https%3A%2F%2Ft.co%2F04NsT8MFIi)
4. [https://www.technologyreview.com/s/529631/leslie-lamport-60/](https://medium.com/r/?url=https%3A%2F%2Fwww.technologyreview.com%2Fs%2F529631%2Fleslie-lamport-60%2F)
5. [https://raft.github.io](https://medium.com/r/?url=https%3A%2F%2Fraft.github.io)
6. Analysis of bitcoin protocol, [https://eprint.iacr.org/2016/454.pdf](https://medium.com/r/?url=https%3A%2F%2Feprint.iacr.org%2F2016%2F454.pdf)
7. Ethereum Whitepaper, [https://github.com/ethereum/wiki/wiki/White-Paper#bitcoin-as-a-state-transition-system](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Fethereum%2Fwiki%2Fwiki%2FWhite-Paper%23bitcoin-as-a-state-transition-system)
8. History of proof-of-stake, [https://cointelegraph.com/news/the-history-and-evolution-of-proof-of-stake](https://medium.com/r/?url=https%3A%2F%2Fcointelegraph.com%2Fnews%2Fthe-history-and-evolution-of-proof-of-stake)