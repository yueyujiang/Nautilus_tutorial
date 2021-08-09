raxml-ng --msa data/gene10.fa --model GTR+G --prefix result/raxml -threads 2
iqtree -s data/gene10.fa --model GTR+G --seed 1234 -T 2 --prefix result/iqtree
compareTrees/compareTrees.missingBranch data/tree.nwk result/raxml.raxml.bestTree --simplify
compareTrees/compareTrees.missingBranch data/tree.nwk result/iqtree.treefile --simplify
