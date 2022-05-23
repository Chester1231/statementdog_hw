# README

#### 當實作時遇到有多種做法的部分時，請針對該部分在 readme 文件中說明你為何選擇此種做法

1. 實作排序功能時，後端常見 gem 排序有兩種：

- [acts_as_list](https://github.com/brendon/acts_as_list)
- [ranked-model](https://github.com/brendon/ranked-model)

因為是同個作者的關係，兩種作法在使用上幾乎都大同小異，提供的方法也大致相同，只是名字上略有差異，唯一相差的地方在 `ranked-model` 存的排序欄位會是隨機的數字，所以會有負數 ~ 正數的情況，當數值越小代表優先權越高。

而會選擇 `ranked-model` 的原因我認為在更新 `row_order_position` 非常直覺，透過 update `row_order_position` 給 `up` / `down` / `fisrt` / `last` symbol 就可以更新排序的順序，在前端 link 顯示上也非常乾淨，前顯易懂就知道是在做什麼功能，所以選擇這個 gem 來實作。

2. 新增追蹤股[頁面](https://www.notion.so/Rails-Take-home-Project-3b661abe45ec46de967f6f52fa04f95b#841951d62e8447f481a3269c44e686d1)中，有判斷 `股票不存在` & `股票已經加入該清單` 兩者情況會需要顯示錯誤畫面。在實作中，認為有幾種可以顯示錯誤畫面的方法：

- modal 視窗
- alert
- notice

認為這邊需要看實際前端的需求為主，目前採用 `notice` 的方式作為實作方法，既不會像是 `alert` 來的醜，也不會需要額外的 UI 來顯示 `modal` 視窗，可以快速又馬上顯示在頁面上。

---

#### 自行決定哪些操作需要加上自動化測試，並簡單解釋選擇寫此測試 & 不寫此測試的考量有哪些

1. 一般來說，如果時程上的因素導致需要趕上線時，會將 CRUD 不撰寫 controller rspec，但因為本次實作中有 `切換使用者` 的 spec，所以在各個 controller#action 測試中，都有加上 使用者 `登入/登出` context 進行測試。

2. 個人認為 model 的測試為必寫的項目，原因在 model 作為與 DB 的連結，必須驗證此層的測試上都沒有問題，避免發生有產生錯誤資料的情況。 

3. 排序功能中，雖然由 `ranked-model` 提供排序功能，但基於不確定此 gem 是否會有突然壞掉的情況，或者開發其他功能、其餘因素導致 gem 發生壞掉情況，透過這個 rspec 就可以馬上知道是否有發生問題，認為有撰寫的必要性，也可以參考此 [comment](https://github.com/Chester1231/statementdog_hw/pull/6#issuecomment-1134768087)。

#### coding style 的選擇

1. rspec 撰寫的方式上，也可以將各個預期的 response 拆多個 `it` 來讓 rspec 錯誤時，很直接明白的知道是哪個部分有錯誤，但因目前的 spec 需求都不太複雜，也很好直接理解，這邊認為不拆成多個 it 也很清楚，例如：[範例](https://github.com/Chester1231/statementdog_hw/blob/fb64821fd225bff8491893b7b18e93d3ebebe138/spec/controllers/portfolio_stocks_controller_spec.rb#L12) 

2. rails linter 也以大宗的 rubocop 進行基本的要求，認為統一撰寫方式，可以有效化的提升團隊協作能力，以及工作效率。

3. commit message 的方式以 [此篇](https://wadehuanglearning.blogspot.com/2019/05/commit-commit-commit-why-what-commit.html) 為主，兼具 why & what，看到 message 可以更快知道實際處理內容。
