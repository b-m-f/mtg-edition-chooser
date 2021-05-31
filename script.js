const { chromium } = require("playwright");
const fs = require("fs");
const logger = fs.createWriteStream("cards-with-edition.txt", {
  flags: "a",
});

async function getEdition(page, card) {
  console.log("Choosing edition for ", card);
  await page.goto(
    `https://scryfall.com/search?as=grid&order=released&q=%21%22${encodeURIComponent(
      card
    )}%22&unique=prints)`
  );

  const waitForOverviewPage = page.waitForNavigation();

  // wait for user to choose edition
  try {
    await page.click("text=View all prints →");
    await waitForOverviewPage;
    await page.waitForNavigation();
  } catch (error) {
    console.log("Not navigated. Only one edition available");
  }

  const edition = await page.textContent(".prints-current-set-name");
  return edition.replace(/\(.*\)/, "").trim();
}

(async () => {
  const browser = await chromium.launch({ headless: false, slowMo: 50 });
  const page = await browser.newPage();
  try {
    const data = fs.readFileSync("cards.txt", "UTF-8");

    const lines = data
      .split(/\r?\n/)
      .filter((line) => (line ? true : false))
      .map((line) => {
        // capture groups for amount and name
        const regexToRemoveNumber = /(\d)\s(.*)/g;

        const match = regexToRemoveNumber.exec(line.trim());
        // match[1] is the first capture group
        return { amount: match[1], card: match[2] };
      });

    for (let line of lines) {
      // for each entry go to scryfall and search exact match
      const edition = await getEdition(page, line.card);
      logger.write(`${line.amount} ${line.card} (${edition})\n`);
    }
  } catch (err) {
    // TODO: catch wrong card name etc
    // the browser would need to crash first when no results for a card in cards.txt are found
    console.error(err);
  }

  await browser.close();
})();
