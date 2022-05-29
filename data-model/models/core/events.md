{% docs dim_users %}

Users table. Each row represents a unique user and all details regarding that user

Can be used to find:
    - All user related stats like: created at, number of owned workspaces, distribution by source, campaign and medium of user
    - Revenue info like month wise revenue, based on campaign, medium, source
    - Stats like user signup date, day/month/year wise signups

{% enddocs %}
{% docs dim_workspaces %}
Workspace table. Each row represents a unique workspace and all details regarding it.
    Can be used to find:
      - All workspace related stats like: paid workspace, source, campaign and medium of workspace, whether or not workspace has availed their trial
      - Revenue info like month wise revenue, based on campaign, medium, source
      - Stats like workspace created_at, origin country, owner
{% enddocs %}
{% docs fct_events %}
Events table. Contains records for all visitors on toggle site. Including those who did not signup. Other details include whether the user requested a demo, their campaign,source etc.
    Can be used to find:
      - the number of users coming in through various campaigns, sources, mediums
      - the number of users who requested a demo, and their source, campaign, and medium
      - number of users visiting by date, source, campaign and medium

{% enddocs %}
{% docs fct_payments %}
Payments table. Each row represents a unique payment from a workspace to Toggle
    Can be used to find:
      - All payment related stats like: paid workspace, source, campaign and medium of workspace, whether the subscription was a trial one
      - Revenue info like month wise revenue, based on campaign, medium, source
      - Whether the subscription payment is a new subscription or a reactivated one. Day/month/year wise payments of reactivated/new/all workspaces
{% enddocs %}