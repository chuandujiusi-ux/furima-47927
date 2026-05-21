const priceInput = () => {
  const priceInput = document.getElementById("item-price");
  
  // 出品画面ではない時は、これ以降の処理を行わない（エラー防止）
  if (!priceInput) return;

  // 金額を計算して画面に表示する共通の処理
  const calculatePrice = () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 入力値が空の場合は、表示を空にする
    if (!inputValue) {
      addTaxDom.innerHTML = "";
      profitDom.innerHTML = "";
      return;
    }

    // 入力された金額の10%を計算（Math.floorで小数点以下を切り捨て）
    const taxPrice = Math.floor(inputValue * 0.1);
    // 販売利益を計算
    const profitPrice = Math.floor(inputValue - taxPrice);

    // 計算結果をそれぞれの場所に表示させる（カンマ区切り）
    addTaxDom.innerHTML = taxPrice.toLocaleString();
    profitDom.innerHTML = profitPrice.toLocaleString();
  };

  // 1. ユーザーが数値を入力した時に計算を実行する
  priceInput.addEventListener("input", calculatePrice);

  // 2. ページを開いた時点で最初から数値が入っている場合も、その場で計算を実行する
  if (priceInput.value) {
    calculatePrice();
  }
};

window.addEventListener("turbo:load", priceInput);
window.addEventListener("turbo:render", priceInput);