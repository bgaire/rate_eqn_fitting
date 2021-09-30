load ../'October 2020'/'October 16'/neon_data_7mw.mat
p7 = data_toSave;
load ../'October 2020'/'October 16'/neon_data2mW.mat
p2 = data_toSave;
load ../'October 2020'/'October 16'/neon_data750uW.mat
p07 = data_toSave;clear data_toSave;

[true_time, sort_order] = sort((0.5+circshift(p7.time_delays,1))*2000/1980);

p7d = mean(p7.datas(:,sort_order),1);
p2d = mean(p2.datas(:,sort_order),1);
p07d = mean(p07.datas(:,sort_order),1);

p7par = extract_curve_stuff(true_time,p7d,999*2000/1980,600) %#ok<NOPTS>
p2par = extract_curve_stuff(true_time,p2d,999*2000/1980,600) %#ok<NOPTS>
p07par = extract_curve_stuff(true_time,p07d,999*2000/1980,600) %#ok<NOPTS>
