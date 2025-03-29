document.addEventListener("turbo:load", function () {

  const stepElement = document.getElementById('step-display');
  if (!stepElement) return;

  // ---------- ステップデータ取得 ----------
  const stepsData = stepElement.dataset.steps;
  let steps = [];

  try {
    steps = JSON.parse(stepsData);
  } catch (e) {
    console.error("❌ JSON.parse(steps) エラー:", e);
    return;
  }

  let currentStep = 0;

  function displayStep(index) {
    const counter = document.getElementById('step-counter');
    if (steps[index]) {
      stepElement.innerText = steps[index];
      counter.innerText = `ステップ ${index + 1} / ${steps.length}`;
    } else {
      stepElement.innerText = "ステップがありません";
      counter.innerText = "";
    }
  }

  function speak(text) {
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(text);
      utterance.lang = 'ja-JP';
      speechSynthesis.cancel();
      speechSynthesis.speak(utterance);
    }
  }

  // ---------- 材料読み上げ ----------
  window.speakIngredients = function () {
    const ingredientsElement = document.getElementById("ingredients-data");
    if (!ingredientsElement) return;

    const data = ingredientsElement.dataset.ingredients;
    let ingredients = [];

    try {
      ingredients = JSON.parse(data);
    } catch (e) {
      console.error("❌ JSON.parse(ingredients) エラー:", e);
      return;
    }

    const text = ingredients.join("。");
    if (text) {
      const message = "本日の材料は、" + text + "です。";
      speak(message);
    }
  };

  // ---------- グローバル関数 ----------
  window.speakCurrentStep = function () {
    speak(steps[currentStep]);
  };

  window.nextStep = function () {
    if (currentStep < steps.length - 1) {
      currentStep++;
      displayStep(currentStep);
      speak(steps[currentStep]);
    }
  };

  window.prevStep = function () {
    if (currentStep > 0) {
      currentStep--;
      displayStep(currentStep);
      speak(steps[currentStep]);
    }
  };

  // ---------- 初期表示＆読み上げ：本日の材料 ----------
  const ingredientsElement = document.getElementById("ingredients-data");
  if (ingredientsElement) {
    const data = ingredientsElement.dataset.ingredients;
    let ingredients = [];

    try {
      ingredients = JSON.parse(data);
    } catch (e) {
      console.error("❌ JSON.parse(ingredients) エラー:", e);
    }

    const display = document.getElementById("step-display");
    const counter = document.getElementById("step-counter");

    const textList = ingredients.map(i => `・${i}`).join("\n");
    display.innerText = "【材料】\n" + textList;
    counter.innerText = "材料";

    const speakText = ingredients.join("、");
    speak("本日の材料は、" + speakText + "です。");
  }
});
