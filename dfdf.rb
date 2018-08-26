      if @user_msg == "예약하기"
          @text = "예약을 원하시나요?"
          @msg = {
            message: {
              text: @text
            },
            keyboard: {
              type: "buttons",
              buttons: ["네","아니오"]
            }
          }
          render json: @msg
      elsif @user_msg == "예약 확인"
          @text = (1..45).to_a.sample(6).sort.to_s
          @msg = {
            message: {
              text: @text
            },
            keyboard: {
              type: "buttons",         #text가 오면 사용자가 직접치는것 type: "text"
              buttons: ["메뉴","로또","고양이"]
            }
            
          }
          
          render json: @msg
      elsif @user_msg == "예약 수정"
          @text = "저도 고양이 키우고시퍼요ㅠㅠㅠ 무슨 색 고양이 좋아하세요?"
          @color1 = Cat.find(1).title
          @color2 = Cat.find(2).title
           @msg = {
            message: {
              text: @text
            },
            keyboard: {
              type: "buttons",
              buttons: [@color1,@color2]
            }
            
          }
          
          render json: @msg
      elsif @user_msg == "예약 취소"
      end
      
    if @user_msg == "네"
      t=(Time.now + 9.hours).to_s[5..9].gsub!(/-/,"/")
      t1=(Time.now + 9.hours+1.days).to_s[5..9].gsub!(/-/,"/")
      t2=(Time.now + 9.hours+2.days).to_s[5..9].gsub!(/-/,"/")
      t3=(Time.now + 9.hours+3.days).to_s[5..9].gsub!(/-/,"/")
      t4=(Time.now + 9.hours+4.days).to_s[5..9].gsub!(/-/,"/")
      t5=(Time.now + 9.hours+5.days).to_s[5..9].gsub!(/-/,"/")
      t6=(Time.now + 9.hours+6.days).to_s[5..9].gsub!(/-/,"/")
      t7=(Time.now + 9.hours+7.days).to_s[5..9].gsub!(/-/,"/")
      @msg = {
        message:{
          text: "#영업시간\n\n평일 : 10:00~19:00\n주말 : 11:00~20:00\n휴무일 : 월요일\n\n\n예약을 원하시는 날짜를 선택해주세요!(예약은 현재 시각으로부터 일주일 이내 날짜만 가능합니다.)"
        },
        keyboard: {
          type: "buttons",
          buttons: [t,t1,t2,t3,t4,t5,t6,t7]
        }
      }
      
      render json: @msg
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
  
 