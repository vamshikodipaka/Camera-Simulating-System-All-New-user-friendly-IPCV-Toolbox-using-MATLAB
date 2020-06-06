function [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, n)

%Extract features
[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);
%Match features.
indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(1:n, 1));
matchedPoints2 = vpts2(indexPairs(1:n, 2));
end

