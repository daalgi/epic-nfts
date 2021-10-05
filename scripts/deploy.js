const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT")
    // const nftContractFactory = await hre.ethers.getContractFactory("NotMyEpicNFT")
    const nftContract = await nftContractFactory.deploy()
    await nftContract.deployed()
    console.log("Contract deployed to:", nftContract.address)
    console.log(`https://rinkeby.etherscan.io/address/${nftContract.address}`)

    let opensea = `https://testnets.opensea.io/assets/${nftContract.address}`

    let txn = await nftContract.makeAnEpicNFT()
    await txn.wait()
    console.log(`NFT minted #1: ${opensea}/0`)

    txn = await nftContract.makeAnEpicNFT()
    await txn.wait()
    console.log(`NFT minted #1: ${opensea}/1`)
}

const runMain = async () => {
    try {
        await main()
        process.exit(0)
    } catch (error) {
        console.log(error)
        process.exit(1)
    }
}

runMain()