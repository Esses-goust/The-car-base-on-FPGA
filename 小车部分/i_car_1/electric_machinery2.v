module electric_machinery2(forward,back,clk,f_pwm,b_pwm,turn,start2);//电机驱动模块，这里的时钟信号要分频一下，电机不能有过高的频率
input forward,back,clk,turn,start2;	//启动信号，前进，后退信号，时钟信号，转弯信号
output reg f_pwm,b_pwm;	//控制电机正转，反转的pwm波

reg [10:0]count;

initial 
begin
count <= 0;
end

always@(posedge clk)	
begin
if(start2)
begin
	f_pwm<=0;
	b_pwm<=0;
end
else
begin
	if(turn)	//转弯时占空比调到5%
	begin
		if(forward)//前进时，前进的pwm波给，后退设为0
		begin
		b_pwm<=0;
		if(count==90)
		begin
			f_pwm<=1;
			count<=count+1;
		end
		else if(count==100)
		begin
			f_pwm<=0;
			count<=0;
		end
		else
		begin
			count<=count+1;
		end
		end
		else if(back)//后退时，只给b_pwm。
		begin
		f_pwm<=0;
		if(count==90)
		begin
			b_pwm<=1;
			count<=count+1;
		end
		else if(count==100)
		begin
			b_pwm<=0;
			count<=0;
		end
		else
		begin
			count<=count+1;
		end
		end
		else//如果没有前进后退信号，就停止
		begin
		f_pwm<=0;
		b_pwm<=0;
		end
	end
	
	
	else		//不转弯，占空比10%
	begin
		if(forward)//前进时，前进的pwm波给，后退设为0
		begin
		b_pwm<=0;
		if(count==82)
		begin
			f_pwm<=1;
			count<=count+1;
		end
		else if(count==100)
		begin
			f_pwm<=0;
			count<=0;
		end
		else
		begin
		count<=count+1;
		end
		end
	else if(back)//后退时，只给b_pwm。
	begin
		f_pwm<=0;
		if(count==82)
		begin
			b_pwm<=1;
			count<=count+1;
		end
		else if(count==100)
		begin
			b_pwm<=0;
			count<=0;
		end
		else
		begin
			count<=count+1;
		end
	end
	else//如果没有前进后退信号，就停止
	begin
		f_pwm<=0;
		b_pwm<=0;
	end
	end
end

end

endmodule