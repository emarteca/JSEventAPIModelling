import javascript
import Analyze_NoAliasRemoval

from AnalyzedExtAPString accessPath, ExtEventString eventName
where knownUnknown(accessPath, eventName)
select accessPath, eventName