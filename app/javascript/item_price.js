const priceInput = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // 出品・編集ページ以外では動かさない

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 入力された金額から、手数料（10%）と利益を計算
    const taxPrice = Math.floor(inputValue * 0.1);
    const profitPrice = inputValue - taxPrice;

    // 画面の「円」の前に数値を表示させる
    addTaxDom.innerHTML = taxPrice;
    profitDom.innerHTML = profitPrice;
  });
};

// Rails 7の画面遷移（Turbo）でも正常に動かすための記述
window.addEventListener("turbo:load", priceInput);
window.addEventListener("turbo:render", priceInput);
