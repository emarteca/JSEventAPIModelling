import javascript
import Analyze_NoAliasRemoval

from AnalyzedExtAPString accessPath, ExtEventString eventName
where correct(accessPath, eventName)
select accessPath, eventName