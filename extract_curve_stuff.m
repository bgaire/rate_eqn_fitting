function [my_curve_params] = extract_curve_stuff(in_times, in_data, turn_on_time, delay_for_steady_time)
    
[~, first_point] = min(in_times);

my_curve_params.bg = mean(in_data(in_times > delay_for_steady_time & in_times < turn_on_time));
my_curve_params.bg_subtracted = in_data-my_curve_params.bg;
my_curve_params.steady = mean(my_curve_params.bg_subtracted(in_times > (delay_for_steady_time + turn_on_time)));
my_curve_params.remnant = my_curve_params.bg_subtracted(first_point);

cutoff_y = my_curve_params.steady*(1-exp(-2));
cutoff_x = min(in_times(my_curve_params.bg_subtracted > cutoff_y & in_times > turn_on_time));

my_curve_params.fit_range = (in_times > turn_on_time) & (in_times <= cutoff_x);
my_curve_params.fit_x = in_times(my_curve_params.fit_range);
my_curve_params.fit_y = my_curve_params.bg_subtracted(my_curve_params.fit_range);
my_curve_params.fit_func = @(x,xdata) x(1)*(1-exp(-x(2)*(xdata-turn_on_time)));
fit_guess = [my_curve_params.steady,1/(3*(max(my_curve_params.fit_x)-turn_on_time))];
my_curve_params.fit_result = lsqcurvefit(my_curve_params.fit_func,fit_guess,my_curve_params.fit_x,my_curve_params.fit_y);

plot(in_times,my_curve_params.bg_subtracted,'*');
hold on;
plot(in_times(in_times>turn_on_time),my_curve_params.fit_func(my_curve_params.fit_result,in_times(in_times>turn_on_time)));
plot(my_curve_params.fit_x,my_curve_params.fit_y);
hold off;