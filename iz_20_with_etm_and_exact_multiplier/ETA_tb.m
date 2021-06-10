res = [];
range = 1:5.320005:127;
t = 0;
for i = range
    t = t + 1;
    res = [res ETA(i,i,13,9,12)];
    plot(res)
hold on;
end
plot(res)
hold on;
% plot(2*range);
% hold off;
