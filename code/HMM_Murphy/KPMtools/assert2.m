function assert2(pred, str)
% ASSERT Raise an error if the predicate is not true.
% assert2(pred, string)

if nargin<2, str = ''; end

if ~pred
  s = sprintf('assert2ion violated: %s', str);
  error(s);
end
