function dp = initializeDP(R, H)
    dp = zeros(R+1, H+1);

    dp(:,1) = 0:R;   % deletions
    dp(1,:) = 0:H;   % insertions
end