function [out_rates, out_scale, out_offset, out_fit] = fit_rate_eqn(in_tmd, in_drive_level, in_off_time, in_on_time, in_times, in_data, full_guess)
% in_tmd - transition matrix description
% in_drive_level - the excitation power (in scaled units)
% in_off_time - time the excitation is off for
% in_on_time - time the excitation is on for
% in_times - vector of times to evalute the signal at
% in_data - data to fit

in_load_mtx = make_trans_loading_mtx(in_tmd);

rate_guess = [in_tmd.trans.rate];

if ~exist('full_guess','var') || isempty(full_guess)
    full_guess = [rate_guess in_tmd.scale in_tmd.offset];
end

fit_func = @(x,xdata) x(end)+predict_curve(x(1:numel(rate_guess)),x(end-1),in_load_mtx,in_tmd, in_drive_level, in_off_time, in_on_time, xdata);

my_opts = optimset('Display','iter','TolFun',1E-8,'MaxFunEvals',12000);
fit_result = lsqcurvefit(fit_func,full_guess,in_times,in_data,[],[],my_opts);

out_rates = fit_result(1:numel(rate_guess));
out_scale = fit_result(end-1);
out_offset = fit_result(end);
out_fit = fit_func(fit_result,in_times);