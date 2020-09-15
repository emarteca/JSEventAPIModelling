import javascript
import Analyze_NoAliasRemoval

from AnalyzedExtAPString accessPath, ExtEventString eventName
where incorrect(accessPath, eventName)
select accessPath, eventName