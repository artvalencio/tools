function x=mpneuron(tslength,w,threshold)
%MPNEURON Generates the time-series of a McCulloch-Pitts neuron model
%--------------------------------------------------------------------
%refs:
%1 - Breakspear, M. & Jirsa, V.K. (2007) Neuronal dynamics and brain
%connectivity. In: V.K. Jirsa & A.R. McIntosh Handbook of brain activity.
%Berlin: Springer.
%2 - McCulloch, W.S. & Pitts, W.(1943) A logical calculus of the ideas immanent
%in nervous activity. Bull Math Biophys, 5, 115-133.
%--------------------------------------------------------------------
%Inputs:
%   -tslength: time-series length
%   -w: weighted adjacency matrix (synapses)
%   -threshold: neuron threshold level for spiking
%--------------------------------------------------------------------
%Output:
%   -x: time-series of neurons (5000 points transient removed)
%--------------------------------------------------------------------
%   Equation:  x(i,t+1)=step(sum(A(i,j)*x(j,t))-threshold(i))
%--------------------------------------------------------------------
%Example usage:
%
% - Creating circular adjacency matrix where one neuron connects to next 3:
%   A=zeros(100,100); for i=1:100 for k=1:100 if k>i&&k<=i+3 A(i,k)=1; end;
%   end; end; A(98,1)=1; A(99,1:2)=1; A(100,1:3)=1; clear i j;
%
% - Simulating McCulloch-Pitts neuron:
%   x=mpneuron(100,A,1.5);
%--------------------------------------------------------------------
% (CC-BY-4.0) Arthur Valencio, 16 May 2019
%     Institute of Computing, State University of Campinas (Unicamp)
%     *AV is supported by FAPESP grant #2018/09900-8. Part of the activities 
%      of FAPESP  Research, Innovation and Dissemination Center for 
%      Neuromathematics (grant #2013/ 07699-0, S.Paulo Research Foundation).

n_neurons=length(w(1,:));
if length(threshold)==1
    threshold(1:n_neurons)=threshold;
end

%random initial condition
for i=1:n_neurons
    x(i,1)=rand();
end

%run through time
for t=1:5000+tslength
    for i=1:n_neurons
        sumterm=0;
        idx=find(w(i,:));
        for j=idx
          sumterm=sumterm+w(i,j)*x(j,t);
        end
        if sumterm-threshold(i)<0
            x(i,t+1)=0;
        else
            x(i,t+1)=1;
        end
    end
end

x=x(:,5002:end);

end