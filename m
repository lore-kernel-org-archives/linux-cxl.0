Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A221F5EA
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118474; cv=none; b=ALVfpneyDawvdhuQAk5AdxZKOZRodcHYW5ckJO3kOePgxqtj/Md0fWZoVHtNR7xR6wflPQ+u5VnIVR1JW8AXK6m7y5RLeFI/9OcoOm0scEh7Q9LcekiH3pdVURz9/UT8RMLZoc5LPumq8xnmZoV/ANtuvj6gsHZ10xxCgKaNkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118474; c=relaxed/simple;
	bh=nh6nuzv339hl/Ha1T64et2yTL63+jteGyXLGXsuKws0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX3dfwswa7vKBHbnkJ+paOqCQgWWalV2s8Q2I03735txKf/kMpdM1unXaCgsXl/LpOEwx0Dax6faDZ/Ps24okh6+UpjBkWnSaw7SvnLlgt/M1qTHGLbuF1Mx+kkeWhkqHCRS9wKLa6TVnUljmxzbEqq2/2A/A0NWQ61x0f2JZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRgdH6R3Dz6L5Jd;
	Wed, 17 Sep 2025 22:09:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DC881402EC;
	Wed, 17 Sep 2025 22:14:28 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Sep 2025 16:14:27 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>
CC: <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu for 10.2 1/5] qapi: cxl: Refactor CXL event injection for common commands arguments
Date: Wed, 17 Sep 2025 15:13:51 +0100
Message-ID: <20250917141355.293217-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917141355.293217-1-Jonathan.Cameron@huawei.com>
References: <20250917141355.293217-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

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
index 52cc5d4f33..e8c5387cfd 100644
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

