function out_tmd = make_trans_mtx_desc()

out_tmd.states = cell(1,0);
out_tmd.trans = struct('init',cell(1,0),'final',cell(1,0),'rate',cell(1,0),'driven',cell(1,0),'visible',cell(1,0));

out_tmd.states{end+1} = 'GroundStrong';
out_tmd.states{end+1} = 'GroundWeak';
out_tmd.states{end+1} = 'FiveHalves';
out_tmd.states{end+1} = 'MS1';
out_tmd.states{end+1} = 'MS2';

% rates here are defaults/initial guesses

% Pumping 7/2 -> 5/2
out_tmd.trans(end+1) = struct(  'init','GroundStrong',...
                                'final','FiveHalves',...
                                'rate',7.54,...
                                'driven',1,...
                                'visible',0);
                            
out_tmd.trans(end+1) = struct(  'init','GroundWeak',...
                                'final','FiveHalves',...
                                'rate',7.52,...
                                'driven',1,...
                                'visible',0);

% Spontaneous decay 5/2 -> 7/2                            
out_tmd.trans(end+1) = struct(  'init','FiveHalves',...
                                'final','GroundStrong',...
                                'rate',111.1,...
                                'driven',0,...
                                'visible',0);

% Relaxation between the ground states
out_tmd.trans(end+1) = struct(  'init','GroundWeak',...
                                'final','GroundStrong',...
                                'rate',1.73,...
                                'driven',0,...
                                'visible',0);

out_tmd.trans(end+1) = struct(  'init','GroundStrong',...
                                'final','GroundWeak',...
                                'rate',5.05,...
                                'driven',0,...
                                'visible',0);

% Direct fluorescence after excitation pumping
out_tmd.trans(end+1) = struct(  'init','FiveHalves',...
                                'final','GroundStrong',...
                                'rate',2.18,...
                                'driven',1,...
                                'visible',1);

% Leakage into metastables after excitation pumping
out_tmd.trans(end+1) = struct(  'init','FiveHalves',...
                                'final','MS1',...
                                'rate',0.23,...
                                'driven',1,...
                                'visible',0);

out_tmd.trans(end+1) = struct(  'init','FiveHalves',...
                                'final','MS2',...
                                'rate',0.54,...
                                'driven',1,...
                                'visible',0);                           
                            
% Metastable fluorescence
out_tmd.trans(end+1) = struct(  'init','MS1',...
                                'final','GroundStrong',...
                                'rate',206,...
                                'driven',0,...
                                'visible',1);

out_tmd.trans(end+1) = struct(  'init','MS2',...
                                'final','GroundStrong',...
                                'rate',11.3,...
                                'driven',0,...
                                'visible',1);

% also a guess
out_tmd.scale = 112710;
out_tmd.offset = 706;
                            
end