### A list and brief description of the data models created by your solution, including intermediate tables or views. Why did you choose these schemata? How should they be materialized, and why?
- **Core(materialized as table)**:
    I put all the tables i created in core. The reason for this was that I was not sure of what tables would be useful for which department. Ideally they would have gone to the relevant depratment folder just like the core folder.

    I configured the tables in such a way that we can find all our requirements using just these tables and filtering data. Since these tables are to be used for everyday operations by all teams, they are configured as tables

    The tables were named dim(dimension) for users and workspace since each row represented a person, or thing; the ultimate source of truth when identifying and describing entities of the organization.
    The tables were named fct(fact) for events and payments since each row represents an event stream: sessions, transactions, orders, stories, votes.


    - **dim_users**:
    Users table. Each row represents a unique user and all details regarding that user

    Can be used to find:
        - All user related stats like: created at, number of owned workspaces, distribution by source, campaign and medium of user
        - Revenue info like month wise revenue, based on campaign, medium, source
        - Stats like user signup date, day/month/year wise signups

    - **dim_workspaces**:
    Workspace table. Each row represents a unique workspace and all details regarding it.
        Can be used to find:
        - All workspace related stats like: paid workspace, source, campaign and medium of workspace, whether or not workspace has availed their trial
        - Revenue info like month wise revenue, based on campaign, medium, source
        - Stats like workspace created_at, origin country, owner

    - **fct_events**:
    Events table. Contains records for all visitors on toggle site. Including those who did not signup. Other details include whether the user requested a demo, their campaign,source etc.
        Can be used to find:
        - the number of users coming in through various campaigns, sources, mediums
        - the number of users who requested a demo, and their source, campaign, and medium
        - number of users visiting by date, source, campaign and medium

    - **fct_payments**:
    Payments table. Each row represents a unique payment from a workspace to Toggle
        Can be used to find:
        - All payment related stats like: paid workspace, source, campaign and medium of workspace, whether the subscription was a trial one
        - Revenue info like month wise revenue, based on campaign, medium, source
        - Whether the subscription payment is a new subscription or a reactivated one. Day/month/year wise payments of reactivated/new/all workspaces

- **Staging(Materialized as View)**:
    - **base(Materialized as View)**:
    Base tables represented the data sources except that the columns were cleaned and naming was changed for consistency. The were materialized as views they will rarely be directly queried.
    The tables included in this were:
        - base_ga_sessions
        - base_subscription_periods
        - base_workspaces
    Other tables didnot require cleaing or consistency and hence are not present here

    - **Intermediate tables(materialized as Table)**:
    These tables took data from base models and transformed them to make models that can be used for various other analysis too. Hence I materialized them as tables.

    Staging models take raw data, and clean and prepare them for further analysis. These models were then used to make the main core tables. These tables wont be used on their own in any analysis hence they are materialized as views.

I have added documentation for the core tables. I would host the dbt docs so that users of this data can get acquainted with the data, see how it flows and look at the descriptions to see what they can do with the data.

I would ideally sit with each department and learn about their specific requirements and then put the data tables specific to each dept in their relevant dataset. The current tables are enough to fulfill all the requirements though. Putting them into dept specific dataset would just make it easier for the depts to view just the department relevant datasets and not be concerned with the other tables.

### How does your solution deal with, for instance, source data arriving at unpredictable times, or only some source tables getting updated? What steps would you take to ensure that our revenue team knows how to work with this data? Anything in particular you would tell the team about how to work with this data? 
We would use an orchestration tool like Airflow or Prefect. These tools allow pipelines to be configured and run through trigger. By setting up trigger on these datasets, we could make the data pipeline run whenever there is a change in data.
Dbt already makes DAGS specifying dependancies between tables so whenever a particular dataset is updated, we could trigger the upstream data pipelines in the dag

To make the data team acquainted with the data, I send them the link to dbt generated doc. There they could see the documentation for tables in the revenue(containing only revenue dept relevant tables) dataset. I have also made sure to extensively document the tables and their descriptions. The descriptions also include what we can calulate using the particular table.

I would also make them aware of the validation tests on different fields in the data so that they too are aware of the rules in place.


### What would you do differently if the size of the ga_sessions dataset was 10x bigger? 1000x bigger?
If `ga_sessions` is too large, I would cluster and partition the dataset. I would partition the dataset on session date and cluster it by whatever field I think would be used to query the dataset the most.

I would also keep in mind that whenever an analysis needs to be performed on the dataset, I should filter the dataset first and then do the joins or other operations. Also for daily pipeline tasks, the dataset should be processed in chunks and batches.
