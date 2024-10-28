inputStr = 'shesellsseashellsbytheseashore';
huffmanTree = buildAndPlotHuffmanTree(inputStr);

function huffmanTree = buildAndPlotHuffmanTree(inputStr)
    
    uniqueChars = unique(inputStr);
    freqTable = arrayfun(@(c) sum(inputStr == c), uniqueChars);
    
    
    nodes = {};
    for i = 1:length(uniqueChars)
        nodes{end+1} = struct('char', uniqueChars(i), 'freq', freqTable(i), 'left', [], 'right', []);
    end
    
    
    while length(nodes) > 1
        
        nodes = sortNodes(nodes);
        
        leftNode = nodes{1};
        rightNode = nodes{2};
        nodes(1:2) = [];
        
        newNode = struct('char', [], 'freq', leftNode.freq + rightNode.freq, 'left', leftNode, 'right', rightNode);
        
        nodes{end+1} = newNode;
    end
    
    huffmanTree = nodes{1};
    
    figure;
    axis off;
    hold on;
    plotHuffmanTree(huffmanTree, 0, 0, 0.2);
    hold off;
end

function sortedNodes = sortNodes(nodes)
    
    [~, idx] = sort(cellfun(@(node) node.freq, nodes));
    sortedNodes = nodes(idx);
end

function plotHuffmanTree(node, x, y, dx)
    
    if isempty(node)
        return;
    end
    
    
    if isempty(node.char)
        text(x, y, num2str(node.freq), 'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', 'FontSize', 10, 'BackgroundColor', 'w');
    else
        text(x, y, sprintf('%s: %d', node.char, node.freq), 'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', 'FontSize', 10, 'BackgroundColor', 'w');
    end
    
   
    if ~isempty(node.left)
        line([x, x - dx], [y, y - 1], 'Color', 'k', 'LineWidth', 1);
        plotHuffmanTree(node.left, x - dx, y - 1, dx / 2);
    end
    
    if ~isempty(node.right)
        line([x, x + dx], [y, y - 1], 'Color', 'k', 'LineWidth', 1);
        plotHuffmanTree(node.right, x + dx, y - 1, dx / 2);
    end
end

