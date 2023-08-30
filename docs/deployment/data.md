# Data Management

## Soft-deletion and Purging
When records are deleted in Zep, they are initially marked as soft-deleted by updating their `deleted_at` field with the deletion datetime. These records remain in the database but are considered deleted for application purposes.
By default, Zep executes a purge process every 60 minutes to perform hard deletes on these soft-deleted records. This means that soft-deleted records will be permanently removed from the `MessageStore`.

## Purge Configuration
Administrators can modify the purge interval or disable the purge process entirely by editing `config.yaml` or setting the `ZEP_DATA_PURGE_EVERY` [environment variable](config.md).

* Set `purge_every` to the desired number of minutes between each purge. For example, to change the interval to 120 minutes, set the purge_every value to 120.
* To disable the process altogether, set `purge_every` to 0 or leave undefined. In this case, the purging process will not run, and soft-deleted records will not be hard-deleted automatically.