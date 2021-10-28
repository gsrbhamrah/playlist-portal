const main = async () => {
    const plistContractFactory = await hre.ethers.getContractFactory('PlaylistPortal');
    const plistContract = await plistContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await plistContract.deployed();
    console.log('Contract address:', plistContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(
        plistContract.address
    );
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );

    const plistTxn = await plistContract.plist('This is playlist #1');
    await plistTxn.wait();

    const plistTxn2 = await plistContract.plist('This is playlist #2');
    await plistTxn2.wait();

    contractBalance = await hre.ethers.provider.getBalance(plistContract.address);
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allPlists = await plistContract.getAllPlists();
    console.log(allPlists);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    }   catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();