import { hash } from "@ember/helper";
import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "discourse/tests/helpers/component-test";
import LockdownTicket from "discourse/plugins/discourse-category-lockdown-nautas/discourse/connectors/topic-list-before-link/lockdown-ticket";

module(
  "Discourse Category Lockdown | Integration | Component | lockdown-ticket",
  function (hooks) {
    setupRenderingTest(hooks);

    hooks.beforeEach(function () {
      this.siteSettings.category_lockdown_enabled = true;
    });

    test("keeps the label in the DOM for locked topics", async function (assert) {
      const topic = { is_locked_down: true };

      await render(<template>
        <LockdownTicket @outletArgs={{hash topic=topic}} />
      </template>);

      // Icon-only on narrow screens, so the text is the only accessible name.
      assert
        .dom(".hc-topic-card__status.--locked-down")
        .includesText("Enter with a ticket");
    });

    test("renders nothing for unlocked topics", async function (assert) {
      const topic = { is_locked_down: false };

      await render(<template>
        <LockdownTicket @outletArgs={{hash topic=topic}} />
      </template>);

      assert.dom(".hc-topic-card__status.--locked-down").doesNotExist();
    });
  }
);
