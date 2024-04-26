%%Recover a DCT-2 by manually adjusting FFT output. Compare with matlab's
%%built in DCT-2

%Define a function between 0 and 1
x=linspace(0,1,128);
N=length(x);
x=cos(2*pi*x)+cos(2*2*pi*x)-cos(3*2*pi*x)-cos(4*2*pi*x);
%Analytical gradient (for later use)
grad=(-2*pi*sin(2*pi*x))-(4*pi*sin(2*2*pi*x))+(6*pi*sin(3*2*pi*x))+(8*pi*sin(4*2*pi*x));

%Extend and mirror x to 2*x
x2 = flip(x);
data = zeros(2*N, 1);
datahat = zeros(2*N,1);
data = [x x2];
%Take FFT of x + mirrored x
datahat = fft(data);
%throw away 2nd half of the data
datahat = ((datahat(1:N)));
%rescale data equal to matlab's DCT
datahat(1)=datahat(1)*(0.5*sqrt(1/N));
datahat(2:N)=datahat(2:N)*(0.5*sqrt(2/N));

%Perform phase shift of FFT->DCT
k=0:N-1;
datahat=(exp(-j.* pi.*k./(2*N)).*datahat(1:N));

%Take the real component only
datahat=real(datahat);

%Do the matlab DCT as comparison
mdct=dct(x,'type',2);

%Plot the difference
plot(mdct-datahat)
legend('Error magnitude');


%plot(xc)

