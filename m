Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FA81E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182676; cv=none; b=of3WFPyLa+g3qqFcIwEagdPe7uciOljwHq6vNhVgfVF6UpuTBIWO7VwKlQt0+sOH8ZxSrYeERER11eB9Uyu3zRTK/MpLZntJp5IOKCrp0ey/DoKxaj1yTy33HhjlRkcFlPfnqIMN3DY1EzB0nybciNkriDPbuT5rVmqS7E72Grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182676; c=relaxed/simple;
	bh=tAGtVYcoa1hWe0vb7Mh4RznieGQMBRSg0jV/mHIZEG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C87gSmh7/YJcJs1c75pqr57QpQgbUNMoJGZSVJzoh+CfhC2Nst7T8/jkpurOuw6AYXiMXUtgtXzB67IaUVbSHkdWRJbpAayKNY6rNa96oYsFc2d7G6NC3Z3Ry46siDHEVyS0BmtHozgyaT/Wz//q1X1f5bIrpFeyqkbGjc9qdDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFt9l0HMrz6K96Z;
	Fri,  5 Jul 2024 20:29:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A04A3140B18;
	Fri,  5 Jul 2024 20:31:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:31:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>,
	<linuxarm@huawei.com>
Subject: [PATCH v6 1/4] cxl/mailbox: move mailbox effect definitions to a header
Date: Fri, 5 Jul 2024 13:30:35 +0100
Message-ID: <20240705123039.963781-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
References: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Gregory Price <gourry.memverge@gmail.com>

Preparation for allowing devices to define their own CCI commands

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Link: https://lore.kernel.org/r/20230906001517.324380-2-gregory.price@memverge.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c   | 34 +++++++++++++++-------------------
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
new file mode 100644
index 0000000000..beb048052e
--- /dev/null
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU CXL Mailbox
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_MAILBOX_H
+#define CXL_MAILBOX_H
+
+#define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
+#define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
+#define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
+#define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
+#define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+
+#endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e87089474a..2e72148118 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -12,6 +12,7 @@
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
+#include "hw/cxl/cxl_mailbox.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
@@ -2102,28 +2103,21 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
-#define IMMEDIATE_DATA_CHANGE (1 << 2)
-#define IMMEDIATE_POLICY_CHANGE (1 << 3)
-#define IMMEDIATE_LOG_CHANGE (1 << 4)
-#define SECURITY_STATE_CHANGE (1 << 5)
-#define BACKGROUND_OPERATION (1 << 6)
-
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
-        cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
+        cmd_events_clear_records, ~0, CXL_MBOX_IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
                                       cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
                                       cmd_events_set_interrupt_policy,
-                                      ~0, IMMEDIATE_CONFIG_CHANGE },
+                                      ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
-                         8, IMMEDIATE_POLICY_CHANGE },
+                         8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -2133,9 +2127,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_ccls_get_partition_info, 0, 0 },
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
-        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
-        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_SECURITY_STATE_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -2148,7 +2144,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
-        cmd_media_scan_media, 17, BACKGROUND_OPERATION },
+        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
@@ -2162,10 +2158,10 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
         8, 0 },
     [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
         "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [DCD_CONFIG][RELEASE_DYN_CAP] = {
         "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
@@ -2173,8 +2169,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
         cmd_infostat_bg_op_sts, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
-    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
-                         IMMEDIATE_POLICY_CHANGE },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -2217,7 +2213,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* Only one bg command at a time */
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         cci->bg.runtime > 0) {
         return CXL_MBOX_BUSY;
     }
@@ -2242,7 +2238,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
         *bg_started = true;
     } else {
-- 
2.43.0

