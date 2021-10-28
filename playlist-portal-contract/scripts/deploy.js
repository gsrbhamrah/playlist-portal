const main = async () => {
    const plistContractFactory = await hre.ethers.getContractFactory('PlaylistPortal');
    const plistContract = await plistContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.001'),
    });

    await plistContract.deployed();

    console.log('PlaylistPortal address: ', plistContract.address);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    }   catch (error) {
        console.error(error);
        process.exit(1);
    }
};

runMain();