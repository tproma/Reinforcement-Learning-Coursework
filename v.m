function [v, pi] = v(model, maxit)

% initialize the value function
v = zeros(model.stateCount, 1);
theta = 1.0000e-22;

for i = 1:maxit,
    % initialize the policy and the new value function
    pi = ones(model.stateCount, 1);
    v_ = zeros(model.stateCount, 1);

    % perform the Bellman update for each state
    for s = 1:model.stateCount,
        % COMPUTE THE VALUE FUNCTION AND POLICY
        % YOU CAN ALSO COMPUTE THE POLICY ONLY AT THE END
        p1 = reshape(model.P(s,:,:), model.stateCount, 4);
        [v_(s,:), action] = max(model.R(s,:) + (model.gamma * p1' * v)');
        pi(s,:) = action;
    end
    v1 = v;
    v = v_;
    
    % exit early
    if v - v1 <= theta
        % CHANGE THE IF-STATEMENT
%        fprintf('i = %d', i);
        disp(i);
        break;
    end
end

