document.addEventListener("turbo:load", function () {
  const display = document.getElementById("read-display");
  const stepCounter = document.getElementById("step-counter");
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
    speechSynthesis.speak(utter);
  }

  window.readMaterials = function () {
    const text = materials.join("。") + "。";
    display.innerText = "【材料】\n" + materials.map(m => "・" + m).join("\n");
    stepCounter.innerText = "材料";
    speak("本日の材料は、" + text);
    currentStep = 0;
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
    displayStep(currentStep);
    speak(steps[currentStep]);
  };

  window.repeatStep = function () {
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

  window.stopSpeech = function () {
    speechSynthesis.cancel();
  };

  // ✅ 初期：材料を読み上げ
  readMaterials();
});
