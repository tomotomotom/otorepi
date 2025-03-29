document.addEventListener("turbo:load", function () {
  console.log("🟢 read.js loaded!");

  const stepElement = document.getElementById('step-display');
  if (!stepElement) return;

  const stepsData = stepElement.dataset.steps;
  if (!stepsData) {
    console.warn("⚠️ data-steps が存在しません");
    return;
  }

  let steps = [];

  try {
    steps = JSON.parse(stepsData);
  } catch (e) {
    console.error("❌ JSON.parse エラー:", e);
    return;
  }

  if (steps.length === 0) {
    stepElement.innerText = "ステップが登録されていません";
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
      speechSynthesis.cancel(); // 既存の発話を止める
      speechSynthesis.speak(utterance);
    }
  }

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

  // 初期表示＆読み上げ
  displayStep(currentStep);
  speak(steps[currentStep]);
});
