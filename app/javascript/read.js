document.addEventListener("turbo:load", function () {
  const display = document.getElementById("read-display");
  const stepCounter = document.getElementById("step-counter");
  const speechStatus = document.getElementById("speech-status");
  if (!display) return;

  const cleanText = (rawText) => {
    return (rawText || "")
      .replace(/\\n/g, "\n")
      .split(/\r?\n/)
      .map(line => line.trim())
      .filter(line => line.length > 0);
  };

  const materials = cleanText(display.dataset.materials);
  const steps = cleanText(display.dataset.steps);
  let currentStep = 0;

  function speak(text) {
    if (!("speechSynthesis" in window)) {
      alert("このブラウザは音声読み上げに対応していません");
      return;
    }

    speechSynthesis.cancel();
    const utter = new SpeechSynthesisUtterance(text);
    utter.lang = "ja-JP";
    utter.rate = 0.95;
    utter.onstart = () => { if (speechStatus) speechStatus.innerText = "読み上げ中"; };
    utter.onend = () => { if (speechStatus) speechStatus.innerText = "再生終了"; };
    utter.onerror = () => { if (speechStatus) speechStatus.innerText = "再生できませんでした"; };
    speechSynthesis.speak(utter);
  }

  function showMaterials(shouldSpeak = true) {
    const text = materials.join("。") + "。";
    display.innerText = "【材料】\n" + materials.map(m => "・" + m).join("\n");
    stepCounter.innerText = "材料";
    if (speechStatus) speechStatus.innerText = "再生待ち";
    if (shouldSpeak) speak("本日の材料は、" + text);
    currentStep = 0;
  }

  window.readMaterials = function () {
    showMaterials(true);
  };

  function displayStep(index) {
    if (steps[index]) {
      display.innerText = steps[index];
      stepCounter.innerText = `ステップ ${index + 1} / ${steps.length}`;
    } else {
      display.innerText = "ステップがありません";
      stepCounter.innerText = "";
    }
  }

  window.startCooking = function () {
    currentStep = 0;
    displayStep(currentStep);
    if (steps[currentStep]) speak(steps[currentStep]);
  };

  window.repeatStep = function () {
    if (steps[currentStep]) speak(steps[currentStep]);
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

  window.stopSpeech = function () {
    speechSynthesis.cancel();
    if (speechStatus) speechStatus.innerText = "停止しました";
  };

  // 初期表示では自動再生せず、利用者の操作後に読み上げる
  showMaterials(false);

  // ✅ ページを離れるときに読み上げを止める
  window.addEventListener("beforeunload", () => {
    speechSynthesis.cancel();
  });

// ✅ Turboナビゲーションでのページ遷移時にも止める
  document.addEventListener("turbo:before-visit", () => {
    speechSynthesis.cancel();
  });

});
