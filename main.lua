
--------------------------------------------------------------------------------
--                                   ��ʱ���жϺ���
--------------------------------------------------------------------------------
--[[
��ʱ���жϺ�����׼������״̬��ÿ500msִ��һ��
--]]
function blink_OnOff_led()
	write(81, 13, 2)
end

--[[
��ʱ���жϺ�������ͣģʽʱÿ500msִ��һ��
--]]
function onPause()
	TimeBlink = not TimeBlink
end

--[[
��ʱ���жϺ������ػ���60sֹͣ����
--]]
function powerOffFan()
	NeedFan = false
	write(20, 2, false) --ֹͣ���ȷ��ȹ�
end


--����ʱ����
function workerEvery1Sec()
	if ModePause then return end
	
	--�޹���ʾ
	if STime % 3 == 0 then
		local Ptemp,Ppan_exists,Pno_pan_1min,Pan_type = read(20)
		if not Ppan_exists then write(70, 2) end --�޹���
	end
	
	STime = STime - 1
end

--����ʱ����
function workerEvery1Min()
	if ModePause then return end

	TotalTime = TotalTime - 1
end
--------------------------------------------------------------------------------

--[[
��������
--]]
function wifienvent() 
	local wificmd = read(140)
	if wificmd == 0 then 
		return
	elseif wificmd == 13 then --�ػ�
		poweroff()
	elseif wificmd == 1 then 	--���ʼ�
		if DisPow < 10 then DisPow = DisPow + 1 write(70, 1) end
		ActPow = DisPow
	elseif wificmd == 2 then 	--���ʼ�
		if DisPow > 1 then DisPow = DisPow - 1 write(70, 1) end
		ActPow = DisPow
	elseif wificmd == 3 then 	--ʱ���
		if TotalTime < 599 then TotalTime = TotalTime + 1 write(70, 1) end
	elseif wificmd == 4 then	--ʱ���
		if TotalTime > 1 then TotalTime = TotalTime - 1 write(70, 1) end
	elseif wificmd == 5 then	--����
		poweron()
		mode_switch(5, setting_steam)
	elseif wificmd == 6 then	--���
		poweron()
		mode_switch(6, setting_hot_pot)	
	elseif wificmd == 7 then	--����
		poweron()
		mode_switch(7, setting_congee)	
	elseif wificmd == 8 then 	--����
		poweron()
		mode_switch(8, setting_stir_fry)	
	elseif wificmd == 18 then	--��ͣ
		pauseCtrl(true)
	elseif wificmd == 19 then	--ȡ����ͣ
		pauseCtrl(false)
	elseif wificmd >= 100 and wificmd <= 111 then
		DisPow = wificmd - 100
		ActPow = DisPow
	elseif wificmd >= 1000 and wificmd <  3900 then
		TotalTime = wificmd - 1000
	end
end

--[[
�������¼�
--]]
function keyevent()
	local key, lp = read(60)
	if key == 13 and not lp then  powerOnOff() return end 	--���ػ�����
	if key == KeyMask then return end				--���ΰ���
	
	if KeyOpt and not lp and ((key >= 1 and key <=4) or (key >= 65 and key < 75)) then 
		ModeManual = true		--�ֶ�ģʽ
		TimeBar = true
		--write(70, 1) 			--������
		if key == 1 then 		--���ʼ�
			if DisPow < 10 then DisPow = DisPow + 1 write(70, 1) end
		elseif key == 2 then 	--���ʼ�
			if DisPow > 1 then DisPow = DisPow - 1 write(70, 1) end
		elseif key == 3 then 	--ʱ���
			if TotalTime < 599 then TotalTime = TotalTime + 1 write(70, 1) end
		elseif key == 4 then 	--ʱ���
			if TotalTime > 1 then TotalTime = TotalTime - 1 write(70, 1) end
		elseif key >= 65 and key <= 75 then		--����
			DisPow = key - 64
			write(70, 1)
		end
		ActPow = DisPow		--����ͬ��
	end

	if KeyOpt and lp and ((key >= 1 and key <=4) or (key >= 65 and key < 75)) then 
		ModeManual = true		--�ֶ�ģʽ
		TimeBar = true
		--write(70, 1) 			--������
		if key == 1 then 		--���ʼ�
			if DisPow < 10 then DisPow = DisPow + 1 write(70, 1) end
		elseif key == 2 then 	--���ʼ�
			if DisPow > 2 then DisPow = DisPow - 1 write(70, 1) end
		elseif key == 3 then 	--ʱ���
			if TotalTime < 590 then TotalTime = TotalTime + 10 write(70, 1) end
		elseif key == 4 then 	--ʱ���
			if TotalTime > 10 then TotalTime = TotalTime - 10 write(70, 1) end
		end
		ActPow = DisPow		--����ͬ��
	end
	
	if not lp and KeyFunc and key >= 5 and key <= 18 then 
		if key ~= 13 then  KeyMask = key end --���ذ�������ֹ
		write(70, 1) 			--������
		if key == 18 then 		--18��ͣ
			pauseCtrl(not ModePause)
		elseif key == 5 then 	--5����
			mode_switch(key, setting_steam)
		elseif key == 6 then 	--6���
			mode_switch(key, setting_hot_pot)
		elseif key == 7 then 	--7����
			mode_switch(key, setting_congee)
		elseif key == 8 then 	--8����
			mode_switch(key, setting_boil_soup)
		elseif key == 13 then 	--���ذ���
			powerOnOff()
		elseif key == 14 then 	--14��ˮ
			mode_switch(key, setting_boil_water)
		elseif key == 17 then 	--17����
			mode_switch(key, setting_stir_fry)
		end
	end
end


--[[
���ػ��л�
--]]
function powerOnOff()
	if OnOff then 
		--�ػ�
		poweroff()
	else
		poweron()
	end
end

function poweron()
	OnOff = true
	--����
	KeyFunc = true	--ʹ�ܹ��ܰ���
	KeyOpt = false	--��ֹ�ǹ��ܰ���
	KeyMask = 18	--��ֹ��ͣ����
	write(70, 1) --������
	TimerCrtl(0, 30*1000, false, powerOnOff)	--30s��ػ�
	TimerCrtl(1, 500, true, blink_OnOff_led)	--500ms��˸
end

--[[
�ػ�
--]]
function poweroff()
	local write = write
	OnOff = false
	TimerCrtl() --�ر����ж�ʱ��
	
	KeyFunc = false
	KeyOpt = false
	KeyMask = 0

	ModeFunc = 0
	ModePause = false
	
	TimeBlink = false
	TimeBar = false
	
	write(70, 0)		--�ػ�����
	write(80, false)	--�ر�������ʾ
	write(20, 2, NeedFan) --ֹͣ���ȷ��ȿ�
	TimerCrtl(0, 60*1000, false, powerOffFan)
end

--[[
ϵͳ������ʼ��
--]]
function start()
	local write = write
	write(70, 0) 	--������
	write(80, true) --����������ʾ
	write(84, true, true) 	--����������
	write(120, 1000) 		--��ʱ1s
	write(80) 	--Ϩ��������ʾ
	write(84)	--Ϩ�������
end


--[[
��ͣ����
state������ true��ͣ�� falseȡ����ͣ
--]]
function pauseCtrl(state)
	if state then 
		ModePause = true
	else 
		ModePause = false
	end
	
	if ModePause then 
		KeyOpt = false
		KeyMask = 0
		TimerCrtl(2, 60*1000, false, powerOnOff)
		TimerCrtl(3, 500, true, onPause)
	else
		KeyMask = ModeFunc
		KeyOpt = true
		TimerCrtl(2)
		TimerCrtl(3)
	end
	write(81, key, ModePause)
end


--[[
ģʽ�л�
--]]
function mode_switch(menu, setting)
	local write = write
	write(81, 0, 3)
	write(81, menu, true)
	ModeFunc = menu
	ModeInit = false
	ModeSet = setting
	ModeManual = false
	ModePause = false
end

function configNextStep()
	local localSTime = ModeSet(Mstep)
	if localSTime == nil then 
		STime = TotalTime * 60
	else 
		STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype = ModeSet(Mstep)
		write(70, 2)	--�׶α仯����
	end
end

--[[
��������
--]]
function worker()
	local write = write
	if ModePause then 
		write(20, 1, 0, Htype)	--��ͣ����
		write(82, TotalTime, TimeBar, TimeBlink)
		write(83, 0)
		return 
	end
	
	if ModeFunc > 0 then
		--ģʽ��ʼ��
		if not ModeInit then
			ModeInit = true
			ModeManual = false
			ModePause = false
			TimeBar = false
			KeyOpt = true
			Mstep = 0
			STime,Temp,LTemp,HTemp,DisPow,ActPow,Duty,Cycle,Htype,TotalTime = ModeSet(Mstep)
			TimerCrtl()	--�ر����ж�ʱ��
			TimerCrtl(0, 1000, true, workerEvery1Sec)
			TimerCrtl(1, 60*1000, true, workerEvery1Min)
			write(20, 0, ActPow, Htype)	--���ȳ�ʼ��
			NeedFan = true --��־�ػ���Ҫ������
		end

		--��ȡ��Ϣ
		local Ptemp,Ppan_exists,Pno_pan_1min,Pan_type = read(20)
		
		--�ػ�
		if TotalTime <= 0 or Pno_pan_1min then  return powerOnOff() end
		
		
		if not ModeManual then
			
			--ʱ��Ǩ��
			if STime <= 0 then 
				Mstep = Mstep + 1
				configNextStep()
			end
			
			--TODO: �¶�Ǩ��
			if Temp > 0 then 
				if Ptemp > Temp then 
					Mstep = Mstep + 1
					configNextStep()
				end
			else
				if Ptemp > HTemp then
					Mstep = Mstep + 1
					configNextStep()
				elseif Ptemp < LTemp then 
					Mstep = Mstep - 1
					configNextStep()
				end
			end
			
			--duty cycle
			if Duty < Cycle then 
				local cycletime = STime % Cycle
				if cycletime < Duty then 
					--����
					OnDuty = true
				else 
					OnDuty = false				
				end
			end
		end
		
		if not ModeManual and not OnDuty then 
			write(20, 1, 0, Htype)	--��ͣ����
		else
			write(20, 1, ActPow, Htype)	--����
		end
		write(81, ModeFunc, true)
		write(81, 13, true)
		write(82, TotalTime, TimeBar)
		write(83, DisPow)	
	end
end

-----------------------------------------------------------------------------------
--                                      ȫ�ֱ���
-----------------------------------------------------------------------------------

--���ػ���־
OnOff = false

--��������
KeyOpt = false	--ʹ�ܷǹ��ܰ���
KeyFunc = false	--���ܰ���
KeyMask = 0	--��ֹĳһ����

--ģʽ����
ModeFunc = 0		--��ǰģʽ
ModeInit = false	--��ʼ����־
ModeSet = nil		--ģʽ���ú���
ModeManual = false	--�ֶ�ģʽ
ModePause = false	--��ͣģʽ

NeedFan = false		--�ػ�������Ƿ�Ҫ����30s

TimeBlink = false	--�Ƿ���ʾʱ������ܵġ� ����
TimeBar = false		--�Ƿ���ʾtimebar

-----------------------------------------------------------------------------------



-----------------------------------------------------------------------------------
--                                     main entry
-----------------------------------------------------------------------------------
do
	local sleepdev = 120 --���ߣ��ó�cpu
	local maintimer = 1
	local write = write
	local read = read

	start()
	
	while true do
		--������ʱʱ��
		write(maintimer, 100)
		
		--�������¼�
		keyevent()
		
		--����wifi�¼�
		wifienvent()
		
		--��ʱ������
		TimerUpdate()
		
		--��������
		worker()
		
		--����ʣ��ʱ��
		do
			local sleepMs = read(maintimer)
			--write(83, sleepMs, true) --��ʾ˯��ʱ��
			if sleepMs <= 100 then write(sleepdev, sleepMs) end
		end
	end
end
