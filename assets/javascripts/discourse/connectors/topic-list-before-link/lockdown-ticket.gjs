import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import { i18n } from "discourse-i18n";

// Horizon renders this outlet beside its hot/solved pills, so the badge reuses their
// pill and their rule: icon only on small screens, icon and text from sm up.
export default class LockdownTicket extends Component {
  @service capabilities;
  @service siteSettings;

  <template>
    {{#if this.siteSettings.category_lockdown_enabled}}
      {{#if @outletArgs.topic.is_locked_down}}
        <span
          class="hc-topic-card__status --locked-down"
          title={{i18n "lockdown.topic_is_locked_down"}}
        >
          {{icon this.siteSettings.category_lockdown_list_icon}}
          {{! Icon only below sm, but the text stays for screen readers: aria-label on a span is not a name. }}
          <span
            class={{if
              this.capabilities.viewport.sm
              "hc-topic-card__status-text"
              "sr-only"
            }}
          >
            {{i18n "lockdown.ticket_badge"}}
          </span>
        </span>
      {{/if}}
    {{/if}}
  </template>
}
