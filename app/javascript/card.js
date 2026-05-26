const pay = () => {
  const paymentForm = document.getElementById('payment-form-data');
  if (!paymentForm) return;
  
  const publicKey = paymentForm.dataset.publicKey;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber', {placeholder: 'カード番号'});
  const expiryElement = elements.create('cardExpiry', {placeholder: '有効期限'});
  const cvcElement = elements.create('cardCvc', {placeholder: 'セキュリティコード'});

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        form.submit();
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='order_address[token]' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        
        form.submit();
      }
    });
  });
};

// Rails 7の画面遷移（Turbo）に対応させるための記述です
window.addEventListener("turbo:load", pay);