% Plots t, original signal, and nt, white-noised version of t.

load('data.mat');

figure

subplot(2,1,1); plot(t);legend('Original Signal');
xlabel('Time (s)'); ylabel('Power (V)');

subplot(2,1,2); h1 = plot([t nt]);
h1(1).LineWidth = 3;
legend('Original Signal','Noised Signal');
xlabel('Time (s)'); ylabel('Power (V)');