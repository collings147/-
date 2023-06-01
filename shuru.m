function [dmodel, perf]=shuru(data)
S=data(:,1:2);
M=data(:,3);
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
end