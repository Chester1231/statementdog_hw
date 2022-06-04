# README

#### 當實作時遇到有多種做法的部分時，請針對該部分在 readme 文件中說明你為何選擇此種做法

1. 常見將相同的邏輯透過繼承 or include concern 的方式來處理

以 `ApplicationController` 中的 [methods](https://github.com/Chester1231/statementdog_hw/blob/main/app/controllers/application_controller.rb) 為例，可以將裡面的 methods 寫成另一個 concern，優點在維護上更為方便，使需要的 controller 才 include，避免繼承到不必要的方法，缺點在必須在各個 controller 都加入 include 的 code。

而選擇繼承的原因：現階段的需求都必須使用這些方法，所以認為透過繼承的方式，直接讓所有 controller 都有這些方法會是更直覺也方便的做法。

2. 新增追蹤股[頁面](https://www.notion.so/Rails-Take-home-Project-3b661abe45ec46de967f6f52fa04f95b#841951d62e8447f481a3269c44e686d1)中，有判斷 `股票不存在` & `股票已經加入該清單` 兩者情況會需要顯示錯誤畫面。在實作中，認為有幾種可以顯示錯誤畫面的方法：

- modal 視窗
- alert
- notice

認為這邊需要看實際前端的需求為主，目前採用 `notice` 的方式作為實作方法，既不會像是 `alert` 來的醜，也不會需要額外的 UI 來顯示 `modal` 視窗，可以快速又馬上顯示在頁面上。

---

#### 自行決定哪些操作需要加上自動化測試，並簡單解釋選擇寫此測試 & 不寫此測試的考量有哪些

1. 一般來說，如果時程上的因素導致需要趕上線時，會將 CRUD 不撰寫 controller rspec，但因為本次實作中有 `切換使用者` 的 spec，所以在各個 controller#action 測試中，都有加上 使用者 `登入/登出` context 進行測試。

2. 個人認為 model 的測試為必寫的項目，原因在 model 作為與 DB 的連結，必須驗證此層的測試上都沒有問題，避免發生有產生錯誤資料的情況。 

#### coding style 的選擇

1. rspec 撰寫的方式上，也可以將各個預期的 response 拆多個 `it` 來讓 rspec 錯誤時，很直接明白的知道是哪個部分有錯誤，但因目前的 spec 需求都不太複雜，也很好直接理解，這邊認為不拆成多個 it 也很清楚，例如：[範例](https://github.com/Chester1231/statementdog_hw/blob/fb64821fd225bff8491893b7b18e93d3ebebe138/spec/controllers/portfolio_stocks_controller_spec.rb#L12) 

2. rails linter 也以大宗的 rubocop 進行基本的要求，認為統一撰寫方式，可以有效化的提升團隊協作能力，以及工作效率。

3. commit message 的方式以 [此篇](https://wadehuanglearning.blogspot.com/2019/05/commit-commit-commit-why-what-commit.html) 為主，兼具 why & what，看到 message 可以更快知道實際處理內容。
