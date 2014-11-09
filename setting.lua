
------------------------------------------------------------------------------------
--                                 ����ģʽ����
------------------------------------------------------------------------------------
--[[
StepInfo boil_soup[7] = {//����
	{120, 0xE6, 0, 0, 0x07, 0x07, 20, 20},
	{240, 0xFF, 0, 0, 0x07, 0x07, 20, 20},
	{240, 0xFF, 0, 0, 0x06, 0x06, 20, 20},
	{600, 0xFF, 0, 0, 0x05, 0x05, 10, 20},
	{2400, 0xFF, 0, 0, 0x05, 0x05, 6, 20},
	{2400, 0xFF, 0, 0, 0x05, 0x05, 4, 20},
	{5400, 0xFF, 0, 0, 0x05, 0x05, 2, 20},
};
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup(Mstep)
--]]
function setting_boil_soup(step)
	local heat_type = 1 --��������
	local totaltime = 180 --��ʱ��min
	if step == 0 then
		return 120, 0xE6, 0, 0, 0x07, 0x07, 20, 20, heat_type, totaltime
	elseif step == 1 then 
		return 240, 0xFF, 0, 0, 0x07, 0x07, 20, 20, heat_type, totaltime
	elseif step == 2 then 
		return 240, 0xFF, 0, 0, 0x06, 0x06, 20, 20, heat_type, totaltime
	elseif step == 3 then 
		return 600, 0xFF, 0, 0, 0x05, 0x05, 10, 20, heat_type, totaltime
	elseif step == 4 then 
		return 2400, 0xFF, 0, 0, 0x05, 0x05, 6, 20, heat_type, totaltime
	elseif step == 5 then 
		return 2400, 0xFF, 0, 0, 0x05, 0x05, 4, 20, heat_type, totaltime
	elseif step == 6 then 
		return 5400, 0xFF, 0, 0, 0x05, 0x05, 2, 20, heat_type, totaltime
	end
end

--[[
���
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup_test(Mstep)
--]]
function setting_hot_pot(step)
	local heat_type = 4 --��������
	local totaltime = 3*60 --��ʱ��min
	if step == 0 then
		return 120, 0xc0, 0, 0, 0xa0, 0xa0, 20, 20, heat_type, totaltime
	end
end
--------------------------------------------------------------------------------


--[[
����
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup_test(Mstep)
--]]
function setting_stir_fry(step)
	local heat_type = 4 --��������
	local totaltime = 3*60 --��ʱ��min
	if step == 0 then
		return 120, 0xB0, 0, 0, 0x0A, 0x0A, 3, 5, heat_type, totaltime
	end
end
--------------------------------------------------------------------------------

--[[
����
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup_test(Mstep)
--]]
function setting_steam(step)
	local heat_type = 2 --��������
	local totaltime = 3*60 --��ʱ��min
	if step == 0 then
		return 300, 0xFF, 0, 0, 0x0A, 0x0A, 20, 20, heat_type, totaltime
	elseif step == 1 then 
		return 180, 0xFF, 0, 0, 0x06, 0x06, 20, 20, heat_type, totaltime
	elseif step == 2 then 
		return 600, 0xFF, 0, 0, 0x05, 0x05, 20, 20, heat_type, totaltime
	end
end
--------------------------------------------------------------------------------

--[[
��ը
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup_test(Mstep)
--]]
function setting_fry(step)
	local heat_type = 1 --��������
	local totaltime = 3*60 --��ʱ��min
	if step == 0 then
		return 120, 0xCA, 0, 0, 0x06, 0x06, 2, 5, heat_type, totaltime
	end
end
--------------------------------------------------------------------------------

--[[
��ˮ
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup_test(Mstep)
--]]
function setting_boil_water(step)
	local heat_type = 4 --��������
	local totaltime = 3*60 --��ʱ��min
	if step == 0 then
		return 480, 0xA0, 0, 0, 0x0A, 0x0A, 20, 20, heat_type, totaltime
	end
end
--------------------------------------------------------------------------------

--[[
����
����ֵ��ʱ��s,Ǩ���¶�,����,����,��ʾ����,ʵ�ʹ���,�����ڼ���ʱ��s,��������s,��������,��ʱ��min
STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = setting_boil_soup_test(Mstep)
--]]
function setting_congee(step)
	local heat_type = 1 --��������
	local totaltime = 3*60 --��ʱ��min
	if step == 0 then
		return 120, 0xFF, 0, 0, 0x05, 0x05, 20, 20, heat_type, totaltime
	elseif step == 1 then 
		return 240, 0xFF, 0, 0, 0x08, 0x08, 20, 20, heat_type, totaltime
	elseif step == 2 then 
		return 240, 0xFF, 0, 0, 0x06, 0x06, 20, 20, heat_type, totaltime
	elseif step == 3 then 
		return 600, 0xFF, 0, 0, 0x05, 0x05, 10, 20, heat_type, totaltime
	elseif step == 4 then 
		return 2400, 0xFF, 0, 0, 0x05, 0x05, 6, 20, heat_type, totaltime
	elseif step == 5 then 
		return 3000, 0xFF, 0, 0, 0x05, 0x05, 2, 20, heat_type, totaltime
	end
end
--------------------------------------------------------------------------------
