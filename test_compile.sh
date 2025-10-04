#!/bin/bash
cd /home/user/oldsdk-demo-nft/packages/snfoundry/contracts
echo "Testing compilation..."
scarb build
echo "Compilation test completed with exit code: $?"

