Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01135C8CE
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366951; cv=none; b=WqwtgXuwh52OuKE6Uywd/1EkxAkbBLjjbo0FkSd1quwWUAzadxZazTRXezW7DTmr1OcbJPNYSWQleUglu4ClrNpGFmz3zYfXSmCntxP1qvrEp5j0UOUP/bFf5LqBjyd7Xyr6hS7qzD1GWQDivpK5CLx/IFgs0Ni8XHdtRe+7lKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366951; c=relaxed/simple;
	bh=ycHxFGeOJVpMcMMG+JIs1Hal0KMDdGArcJxJTUHpfuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6K2RPYq3FexzEXdo/+rMd2DGuCU96tygit21WkZU4yGRAeV70vq5CIvLztTgPJAKsa76Uu9d0PyK5xWb17F9lF4S//xzILdGgmM2BJUIxAReY83H8aDbzBh8vT94da0J8a/62ltPWQHJkYTEbBkKRErSokitLInKOIBLyM0cPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djS0m6XqBzJ467k;
	Fri,  2 Jan 2026 23:14:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8913440565;
	Fri,  2 Jan 2026 23:15:44 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:15:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu v2 1/5] qapi: cxl: Refactor CXL event injection for common commands arguments
Date: Fri, 2 Jan 2026 15:15:08 +0000
Message-ID: <20260102151512.460766-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

From: Shiju Jose <shiju.jose@huawei.com>

Refactor CXL event injection to use struct for common command
arguments.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index eeddb58d1d..d5b86159f1 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -31,11 +31,10 @@
  }
 
 ##
-# @cxl-inject-general-media-event:
+# @CXLCommonEventBase:
 #
-# Inject an event record for a General Media Event (CXL r3.0
-# 8.2.9.2.1.1).  This event type is reported via one of the event logs
-# specified via the log parameter.
+# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
+# Table 8-42 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -44,6 +43,16 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# Since: 8.1
+##
+{ 'struct': 'CXLCommonEventBase',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
+
+##
+# @CXLGeneralMediaEvent:
+#
+# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
 #     Media Event Record, Physical Address.
@@ -74,26 +83,29 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-general-media-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLGeneralMediaEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
             '*device': 'uint32', '*component-id': 'str' } }
 
 ##
-# @cxl-inject-dram-event:
-#
-# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
-# This event type is reported via one of the event logs specified via
-# the log parameter.
+# @cxl-inject-general-media-event:
 #
-# @path: CXL type 3 device canonical QOM path
+# Inject an event record for a General Media Event (CXL r3.0
+# 8.2.9.2.1.1).  This event type is reported via one of the event
+# logs specified via the log parameter.
 #
-# @log: Event log to add the event to
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-general-media-event',
+  'data': 'CXLGeneralMediaEvent' }
+
+##
+# @CXLDRAMEvent:
 #
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
@@ -133,9 +145,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-dram-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLDRAMEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
@@ -143,18 +155,21 @@
            }}
 
 ##
-# @cxl-inject-memory-module-event:
+# @cxl-inject-dram-event:
 #
-# Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
-# at the time of the event.
+# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# This event type is reported via one of the event logs
+# specified via the log parameter.
 #
-# @path: CXL type 3 device canonical QOM path
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-dram-event',
+  'data': 'CXLDRAMEvent' }
+
+##
+# @CXLMemModuleEvent:
 #
-# @log: Event Log to add the event to
-#
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
 #     Event Record for bit definitions for bit definiions.
@@ -185,9 +200,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-memory-module-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
-            'type': 'uint8', 'health-status': 'uint8',
+{ 'struct': 'CXLMemModuleEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'type': 'uint8', 'health-status': 'uint8',
             'media-status': 'uint8', 'additional-status': 'uint8',
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
@@ -195,6 +210,18 @@
             'corrected-persistent-error-count': 'uint32'
             }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.3)
+# This event type is reported via one of the event logs
+# specified via the log parameter.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': 'CXLMemModuleEvent' }
+
 ##
 # @cxl-inject-poison:
 #
-- 
2.48.1

