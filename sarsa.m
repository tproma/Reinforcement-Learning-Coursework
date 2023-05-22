function [v, pi,accumulated_reward] = sarsa(model, maxit, maxeps)

% initialize the value function
Q = zeros(model.stateCount, 4);
pi = ones(model.stateCount, 1);
pi_changing = ones(model.stateCount, 1);
Alpha =0.1;
accumulated_reward = zeros(maxeps, 1);
for i = 1:maxeps,
    % every time we reset the episode, start at the given startState
    s = model.startState;
   % a = 1;
    a =  e_greedy(Q(s,:));
    for j = 1:maxit,
        % PICK AN ACTION
        %     a = 1;
        p = 0;
        r = rand;
        
        for s_ = 1:model.stateCount,
            p = p + model.P(s, s_, a);
            if r <= p,
                break;
            end
        end
        
        % s_ should now be the next sampled state.
        % IMPLEMENT THE UPDATE RULE FOR Q HERE.
        %...... Q(s,a) = Q(s,a) + Alpha[ R + Gamma * Q(s_, a_)  - Q(s,a)]
        reward = model.R(s,a);
             accumulated_reward(i) = accumulated_reward(i) + model.gamma * reward;
        %...greddy for a_........................
        
        %[~, max_action_a_] = max(Q(s_,:));
        %pi_changing(s) = max_action;
        %  v_changing_s_ = Q( : ,max_action_a_);
        %..................................................
        a_ =  e_greedy(Q(s_,:));
        Q(s,a) = Q(s,a) + Alpha * [ reward + model.gamma  * Q(s_, a_)  - Q(s,a)];
        s = s_;
        a = a_;
        
        [~, max_action] = max(Q(s,:));
        pi_changing(s) = max_action;
        v_changing = Q( : ,max_action);
        
        % SHOULD WE BREAK OUT OF THE LOOP?
        
        if s == model.goalState
            break;
        end
    end
end

% REPLACE THESE
v = v_changing;
pi = pi_changing;

end

