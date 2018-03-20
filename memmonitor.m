function mem = memmonitor()
%monitor the total used memory, in Gb
%Usage:
%
%       memtic=memmonitor;
%           --do stuff
%       memtoc=memmonitor-memtic



[~,w] = unix('free | grep Mem');
stats = str2double(regexp(w, '[0-9]*', 'match'));
clear w
mem = (stats(2)-stats(6))/(1024*1024);

end