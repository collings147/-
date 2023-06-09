function  S = gridsamp(range, q)
%GRIDSAMP  n-dimensional grid over given range 给定范围内的 n 维网格
%
% Call:    S = gridsamp(range, q)
%
% range :  2*n matrix with lower and upper limits     2*n矩阵，带下限和上限
% q     :  n-vector, q(j) is the number of points      n向量，q（j）是点数
%          in the j'th direction.                     在第 j 方向。
%          If q is a scalar, then all q(j) = q        如果 q 是标量，则所有 q（j） = q
% S     :  m*n array with points, m = prod(q)         带点的 m*n 数组，m = prod（q）

% hbn@imm.dtu.dk  
% Last update June 25, 2002

[mr n] = size(range);    dr = diff(range);
if  mr ~= 2 | any(dr < 0)
  error('range must be an array with two rows and range(1,:) <= range(2,:)')
end 
sq = size(q);
if  min(sq) > 1 | any(q <= 0)
  error('q must be a vector with non-negative elements')
end
p = length(q);   
if  p == 1,  q = repmat(q,1,n); 
elseif  p ~= n
  error(sprintf('length of q must be either 1 or %d',n))
end 

% Check for degenerate intervals
i = find(dr == 0);
if  ~isempty(i),  q(i) = 0*q(i); end

% Recursive computation
if  n > 1
  A = gridsamp(range(:,2:end), q(2:end));  % Recursive call
  [m p] = size(A);   q = q(1);
  S = [zeros(m*q,1) repmat(A,q,1)];
  y = linspace(range(1,1),range(2,1), q);
  k = 1:m;
  for  i = 1 : q
    S(k,1) = repmat(y(i),m,1);  k = k + m;
  end
else    
  S = linspace(range(1,1),range(2,1), q).';
end