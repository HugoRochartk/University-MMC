x = [0; 2; 3; 5; 8; 11; 12; 15];
y = [50; 56; 60; 72; 85; 100; 110; 125];

%aproximação dos mínimos quadrados (reta)
A_reta  = [ones(size(x)) x];
c_reta = A_reta \ y; % resolver sistema vandermonde

%aproximação dos mínimos quadrados (parábola)
A_parabola = [ones(size(x)), x, x.^2];
c_parabola = A_parabola \ y; % resolver sistema vandermonde


%gráfico dos dados
plot(x, y, 'ko', 'DisplayName', 'dados');
hold on;

%reta aproximada
y_reta = c_reta(1) + c_reta(2)*x;
plot(x, y_reta, 'b-', 'DisplayName', 'reta aproximada');

%parábola aproximada
y_parabola = c_parabola(1) + c_parabola(2)*x + c_parabola(3)*(x.^2);
plot(x, y_parabola, 'p-', 'DisplayName', 'parábola aproximada');

%legendas
xlabel('x');
ylabel('y');
legend('location', 'best');

