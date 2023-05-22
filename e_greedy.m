function a = e_greedy(Q)
e = 0.1;
actions = [1 2 3 4];
p = rand();
    if p < (1 - e)
        [~, a] = max(Q);
    else a = actions(randi(length(actions)));
    end
end