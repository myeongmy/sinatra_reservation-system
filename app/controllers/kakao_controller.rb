class KakaoController < ApplicationController
  def keyboard #처음에 들어갔을 때 밑에 뜨는 키보드
    @msg = {
      type: "buttons",
      buttons: ["시작하기"]
    }
    
    render json: @msg
  end
  

  def message
    @user_msg = params[:content]
    
    if @user_msg.include? "요일"
      @@day = params[:content]            #골뱅이 두 개는 전역변수(값 그대로 저장)
    elsif @user_msg.include? ":"
      @@time = params[:content]
    end
    
    @user_key = params[:user_key]
    @user = Reservation.find_or_create_by(password: @user_key)
    
    if @user_msg == "시작하기"
        @msg = {
            message: {
              text: "안녕하세요 고객님(하트뿅)\n무엇을 도와드릴까요?"
            },
            keyboard: {
              type: "buttons",
              buttons: ["예약하고 싶어요","예약을 확인하고 싶어요"]
            }
          }
          
        render json: @msg
        
    else
      if @user_msg == "예약하고 싶어요" or @user_msg =="아닙니다"
          @msg = {
            message: {
              text: "(별)영업시간(별)\n평일(월 ~ 금)\n9:00~18:00\n\n예약자 성함을 입력해주세요"
            },
            keyboard: {
              type: "text"
            }
            
          }
          
          render json: @msg
      elsif @user_msg == "예약을 확인하고 싶어요"
            @msg = {
            message: {
              text: "(별)#{@user.name}님의 예약 현황(별)\n요일 : #{@user.day}\n시간 : #{@user.time}"
            },
            keyboard: {
              type: "buttons",
              buttons: ["시작하기"]
            }
          }
          
          render json: @msg
      elsif @user_msg.include? "요일"
          @msg = {
            message: {
              text: "예약시간을 선택해주세요"
            },
            keyboard: {
              type: "buttons",
              buttons: ["9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00"]
            }
          }
          
          render json: @msg
      elsif @user_msg.include? ":"
          count = 0
          @db_data = Reservation.all
          @db_data.each do |i|
            if i.day == @@day and i.time == @@time
              count += 1
            end
          end
          
          if count >= 1
            @msg = {
            message: {
              text: "이미 예약되어있는 시간입니다(눈물) 다시 선택해주세요"
            },
            keyboard: {
              type: "buttons",
              buttons: ["시간 다시 선택하기"]
            }
          }
          
          render json: @msg
         else
           @user.day = @@day
           @user.time = @@time
           @user.save
            @msg = {
            message: {
              text: "(별)예약 진행(별)\n이름 : #{@user.name}님\n날짜 : #{@user.day}\n시간 : #{@user.time}\n\n다음과 같이 예약을 진행하겠습니다.위 사항이 맞습니까?"
            },
            keyboard: {
              type: "buttons",
              buttons: ["맞습니다","아닙니다"]
            }
          }
          
          render json: @msg
        end
      elsif @user_msg == "맞습니다"
        @msg = {
            message: {
              text: "예약이 완료되었습니다!감사합니다"
            },
            keyboard: {
              type: "buttons",
              buttons: ["시작하기"]
            }
          }

          render json: @msg
          
      elsif @user_msg == "시간 다시 선택하기"
      
        weekday = ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"]
        t=(Time.now + 9.hours).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours).wday-1]+")"
        t1=(Time.now + 9.hours+1.days).to_s[5..9].gsub!(/-/,"/") + "("+weekday[(Time.now + 9.hours+1.days).wday-1]+")"
        t2=(Time.now + 9.hours+2.days).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours+2.days).wday-1]+")"
        t3=(Time.now + 9.hours+3.days).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours+3.days).wday-1]+")"
        t4=(Time.now + 9.hours+4.days).to_s[5..9].gsub!(/-/,"/")+"("+weekday[(Time.now + 9.hours+4.days).wday-1]+")"
        t5=(Time.now + 9.hours+5.days).to_s[5..9].gsub!(/-/,"/")+"("+ weekday[(Time.now + 9.hours+5.days).wday-1]+")"
        t6=(Time.now + 9.hours+ 6.days).to_s[5..9].gsub!(/-/,"/")+"("+ weekday[(Time.now + 9.hours+6.days).wday-1]+")"
        t7=(Time.now + 9.hours+ 7.days).to_s[5..9].gsub!(/-/,"/")+"("+weekday[(Time.now + 9.hours+7.days).wday-1]+")"
        t8=(Time.now + 9.hours+8.days).to_s[5..9].gsub!(/-/,"/") + "(" + weekday[(Time.now + 9.hours+8.days).wday-1]+")"
        
        @date = [t,t1,t2,t3,t4,t5,t6,t7,t8]
        @date.each do |d|
          if d.include? "토요일"or d.include? "일요일"
            @date = @date - [d]
          end
        end
     
         @msg = {
              message: {
                text: "예약하고 싶은 날짜 선택해주세요"
              },
              keyboard: {
                type: "buttons",
                buttons: @date
              }
            }
            render json: @msg
            
      else
        @user.name = @user_msg
        @user.save
        weekday = ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"]
        
        t=(Time.now + 9.hours).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours).wday-1]+")"
        t1=(Time.now + 9.hours+1.days).to_s[5..9].gsub!(/-/,"/") + "("+weekday[(Time.now + 9.hours+1.days).wday-1]+")"
        t2=(Time.now + 9.hours+2.days).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours+2.days).wday-1]+")"
        t3=(Time.now + 9.hours+3.days).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours+3.days).wday-1]+")"
        t4=(Time.now + 9.hours+4.days).to_s[5..9].gsub!(/-/,"/") +"("+weekday[(Time.now + 9.hours+4.days).wday-1]+")"
        t5=(Time.now + 9.hours+5.days).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours+5.days).wday-1]+")"
        t6=(Time.now + 9.hours+6.days).to_s[5..9].gsub!(/-/,"/") +"("+ weekday[(Time.now + 9.hours+6.days).wday-1]+")"
        t7=(Time.now + 9.hours+7.days).to_s[5..9].gsub!(/-/,"/") +"("+weekday[(Time.now + 9.hours+7.days).wday-1]+")"
        t8=(Time.now + 9.hours+8.days).to_s[5..9].gsub!(/-/,"/") + "(" + weekday[(Time.now + 9.hours+8.days).wday-1]+")"
        
        @date = [t,t1,t2,t3,t4,t5,t6,t7,t8]
        @date.each do |d|
          if d.include? "토요일" or d.include? "일요일"
            @date = @date - [d]
          end
        end
        
        
        @msg = {
            message: {
              text: "예약하고 싶은 날짜를 선택해주세요"
            },
            keyboard: {
              type: "buttons",
              buttons: @date
            }
            
          }
          render json: @msg
      end

    end
        
    # @return_msg = {text: @text }
    # @return_keyboard = {type: "buttons", buttons: ["메뉴","로또","고양이"]}
    
    # @result = {
    #   message: @return_msg,
    #   keyboard: @return_keyboard
    # }
    
    # render json: @result
    
    
      # @msg = {
      #   message: {
      #     text: @text,
      #     photo: {
      #       url: "/img/120_shop1_732843.jpg",
      #       width: 640,
      #       height: 480
      #     },
      #     message_button: {
      #       label: "네이버 검색",
      #       url: "https://www.naver.com"
      #     }
      #   },
      #   keyboard: {
      #     type: "buttons",
      #     buttons: ["메뉴","로또","고양이"]
      #   }
   #   }
  
 
  end
end
 
