Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8713792B
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166924; cv=none; b=GEN+5XqjV5VzHXK6PFbznAo2uavtkJATRE7iIezDGTdVOcFBBCDAsBsnOTPjNzF4ei/Ir5k0TV7/0BoRrOYJrbIxbVdoxJNdYV53XzAb+d4j7M504KUPWvS9BZJHOGrHo5VlXLgJzlReH2e8NxlU6FvaYSvBiVTK1rA5Xyc7ubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166924; c=relaxed/simple;
	bh=EdXc3ZNr4W8xvkHQInB+Nt+XdpC2neCn3cdHc7oZxfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNGGcIgUBEmjyx4CAyEwOzi2Meg1mPNP61mTTE1Sq5/RrjoHjh5DmpiFaV6fFCVs2jinU67ycKwtSgIDOp34ixbvqZBXMHgMUIWvCtSrhy795MpELJVfZitnffvpxCbAe+QisDvMBq0rQHFJ+/nQ0CcjBXPZd+2ESnmZNqQJHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76cd0y8cz6K9Np;
	Wed,  5 Mar 2025 17:26:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 19E44140A70;
	Wed,  5 Mar 2025 17:28:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:28:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for Get Log Capabilities (Opcode 0402h)
Date: Wed, 5 Mar 2025 09:24:58 +0000
Message-ID: <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Arpit Kumar <arpit1.kumar@samsung.com>

CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
It provides log capabilities supported by specified log.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
 include/hw/cxl/cxl_mailbox.h |  5 ++++
 hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ed6cd50c67..87a376c982 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,18 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* types of logs */
+typedef enum {
+    CXL_LOG_COMMAND_EFFECT,
+    CXL_LOG_VENDOR_DEBUG,
+    CXL_LOG_COMPONENT_STATE_DUMP,
+    CXL_LOG_ERROR_CHECK_SCRUB,
+    CXL_LOG_MEDIA_TEST_CAPABILITY,
+    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
+    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
+    MAX_LOG_TYPE
+} CXLLogType;
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -163,6 +175,11 @@ typedef struct CXLEventLog {
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
 
+typedef struct CXLLogCapabilities {
+    uint32_t param_flags;
+    QemuUUID uuid;
+} CXLLogCapabilities;
+
 typedef struct CXLCCI {
     struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
@@ -171,6 +188,9 @@ typedef struct CXLCCI {
     } cel_log[1 << 16];
     size_t cel_size;
 
+    /* get log capabilities */
+    const CXLLogCapabilities *supported_log_cap;
+
     /* background command handling (times in ms) */
     struct {
         uint16_t opcode;
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..8e1c7c5f15 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -16,4 +16,9 @@
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
 
+#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
+#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
+#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
+#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
+
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 299f232f26..f35fc4f112 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -81,6 +81,7 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+        #define GET_LOG_CAPABILITIES   0x2
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
+{
+    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
+        if (qemu_uuid_is_equal(uuid,
+            &cci->supported_log_cap[i].uuid)) {
+                return &cci->supported_log_cap[i];
+        }
+    }
+    return NULL;
+}
+
+/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
+static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    const CXLLogCapabilities *cap;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in = (void *)payload_in;
+
+    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
+
+    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
+    if (!cap) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    memcpy(get_log_capabilities_out, &cap->param_flags,
+           sizeof(cap->param_flags));
+    *len_out = sizeof(*get_log_capabilities_out);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
+                                     cmd_logs_get_log_capabilities, 0x10, 0 },
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
@@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
     }
 }
 
+static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
+    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
+};
+
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
     cci->payload_max = payload_max;
     cxl_rebuild_cel(cci);
+    cci->supported_log_cap = cxl_get_log_cap;
 
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
-- 
2.43.0

