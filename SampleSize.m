
n = [0,20,50,100,200,500,1000,2000,5000,10000];
phat = [0;0.05;0.1;0.15;0.2;0.25;0.3;0.35;0.4;0.45;0.5;0.55;0.6;0.65;0.7;0.75;0.8;0.85;0.9;0.95];
% rows then columns
table = zeros(size(phat,1), size(n,2));
table(1,:) = n;
table(:,1) = phat;

row = 2;
col = 2;
for sim_n = n(1,2:end)
    for sim_p = phat(2:end,1)'
        % simulate 1 million times
        table(row, col) = sim1Mil(sim_n, sim_p);
        row = row + 1;
    end
    row = 2;
    col = col + 1;
end



function avg_proportion = sim1Mil(sim_n, p)
    sum_succeeded = 0;
    for times = [1:1000000]
        zstar = 1.96;
        rp = rand();
        sigma = sqrt(rp*(1-rp)/double(sim_n));
        confidence_interval = [rp-zstar*sigma, rp+zstar*sigma];
        if isinside(p, confidence_interval)
            sum_succeeded = sum_succeeded + 1;
        end
        % capture 1 million samples and record proportion of samples
        % capturing true p
    end
    avg_proportion = double(sum_succeeded)/double(1000000);
end

function inside = isinside(number, interval)
    inside = and(number >= interval(1), number <= interval(2));
end
