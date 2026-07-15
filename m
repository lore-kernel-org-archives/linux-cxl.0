Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA1442FD9
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142100; cv=none; b=czWYa8wMoj/v8buotWHTHQK5IL4J+DudEHMb7qXyBtwMYYTsOWLBYyoe6j8h0UmJFFapOS5SlQUU7rQmbcU8ha3QAgE6qt/fbpMAis7zYjCjeheMme+n52UQ4isLO89xOOHX2nXjhMqsORX3egpVFIf7DNMZyPQ2mekMFT4s43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142100; c=relaxed/simple;
	bh=uWyDmViRvJV2X0420aCttrgviOdcEiduNYitm5n8lsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PfjQ30sNTNuVc4AEP3pMF3bK9aUYUKC1MdhfrqbmjN5IxP3jTVw5FJK48OLsaMJ3lR3ry6mujXboCRsfFMq28sDf6T36k1T9d1dZPf90U0z/er1O0/tbifacBUy7CSkKVSSxcDg0bBwnOCgbsn7RcGemXFT6Rof2oSGZcBcO7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=eCDh+IN+; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="eCDh+IN+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 999B7722039;
	Wed, 15 Jul 2026 19:01:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.104.253.237])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4A5C57226C6;
	Wed, 15 Jul 2026 19:01:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Robust: 5e50854a37034e9f_1784142066534_2799884940
X-MC-Loop-Signature: 1784142066534:4183292506
X-MC-Ingress-Time: 1784142066534
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.253.237 (trex/8.0.2);
	Wed, 15 Jul 2026 19:01:06 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4h0lrK5cBFz105H;
	Wed, 15 Jul 2026 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784142066;
	bh=OI+6zijClSb0/F27JqulsMJoCpDvBXQSY9kpvQqGLwc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=eCDh+IN+/axdx+9wDkY8xHSLhYMk/htmilz9YwA6LefU4eWKmDJGbHfbz3SD3DkFQ
	 QgvXNOykfkQFWdmdSW6S9coRvVRypORDlEhls9pImiIdNaq1OlrXcfu2GWrTdZ49mu
	 vqQeSuncj9V+ERfB9Rp4Q+hTSfDj+QF2KsksCSdxxcsZ7cISQWOn4nCQhWEaZm5o5s
	 3JBv5rI2K6MaUdHbSFj9V8cxIMNS0FcmwEXcKIAi41o4nbE/X2wSpBfDeb194XEN0y
	 KegLhBZ4NyucsAx5eC6QBop559UUDoIbC6glJxIJudRh6HkTl6xaLu/+oY3MkRtQ04
	 QFI1i9X13b6Sg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -qemu-jic23] hw/cxl/cpmu: Add CXL 4.0 event groups and Channel/Rank/Bank filter
Date: Wed, 15 Jul 2026 12:00:50 -0700
Message-Id: <20260715190050.458288-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise FILTERS_SUP bit 1 and implement Filter ID 1 (CRB), widen the
per-counter filter values to the full 32-bit VALUE field (previously
stored as bool), and add the CXL r4.0 Table 13-5 DDR Interface,
Queue Occupancy, Queue Residency, Retry and Throttle event groups.

Introduce named constants for the event vendor IDs, group IDs, event
masks and filter IDs, replacing the raw hex values in cpmu_read().

Also fix the FILTER0_CNT2 write case, which was missing the value
store.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
This only applies to Jonathan's qemu tree (latest branch), but it would
be a good time to bring up if the cpmu support will ever be considered
for upstream qemu inclusion.

 hw/cxl/cxl-cpmu.c         | 117 ++++++++++++++++++++++++++++++++++----
 include/hw/cxl/cxl_cpmu.h |  20 +++++--
 2 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-cpmu.c b/hw/cxl/cxl-cpmu.c
index a25e6fa554f7..b0f5d1d28ed2 100644
--- a/hw/cxl/cxl-cpmu.c
+++ b/hw/cxl/cxl-cpmu.c
@@ -14,6 +14,36 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 
+/*
+ * Event Vendor IDs. The CXL-defined Event Groups (CXL r4.0 Table 13-5)
+ * are scoped by CXL_VENDOR_ID; any other Vendor ID is vendor specific.
+ */
+#define CPMU_VID_HUAWEI 0x19e5
+
+/* CXL r4.0 Table 13-5 Event Group IDs */
+#define CPMU_GID_BASE        0x0
+#define CPMU_GID_D2H_REQ     0x10
+#define CPMU_GID_H2D_REQ     0x12
+#define CPMU_GID_DDR         0x8000
+#define CPMU_GID_QUEUE_OCC   0x8001
+#define CPMU_GID_QUEUE_RESID 0x8002
+#define CPMU_GID_RETRY       0x8003
+#define CPMU_GID_THROTTLE    0x8004
+
+/* Supported Events bitmasks of the CXL r4.0 Table 13-5 Event IDs */
+#define CPMU_BASE_EVENTS        0x1    /* 00h: Clock Ticks */
+#define CPMU_D2H_REQ_EVENTS     0xFF   /* 00h-07h, arbitrary emulation subset */
+#define CPMU_H2D_REQ_EVENTS     0xFF   /* 00h-07h, arbitrary emulation subset */
+#define CPMU_DDR_EVENTS         0xFFFF /* 00h-0Fh */
+#define CPMU_QUEUE_OCC_EVENTS   0xF    /* 00h-03h */
+#define CPMU_QUEUE_RESID_EVENTS 0x3    /* 00h-01h */
+#define CPMU_RETRY_EVENTS       0xF    /* 00h-03h */
+#define CPMU_THROTTLE_EVENTS    0x3    /* 00h-01h */
+
+/* Supported Filter IDs, per CXL r4.0 Table 8-187 */
+#define CPMU_FILTER_ID_HDM BIT(0)
+#define CPMU_FILTER_ID_CRB BIT(1)
+
 static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
 {
     CPMUState *cpmu = opaque;
@@ -28,7 +58,8 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
         retval = FIELD_DP64(retval, CXL_CPMU_CAP, COUNTER_WIDTH, 48);
         retval = FIELD_DP64(retval, CXL_CPMU_CAP,
                             NUM_EVENT_GROUPS, CPMU_NUM_EVENT_GROUPS - 1);
-        retval = FIELD_DP64(retval, CXL_CPMU_CAP, FILTERS_SUP, 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, FILTERS_SUP,
+                            CPMU_FILTER_ID_HDM | CPMU_FILTER_ID_CRB);
         retval = FIELD_DP64(retval, CXL_CPMU_CAP, MSI_N, cpmu->msi_n);
         retval = FIELD_DP64(retval, CXL_CPMU_CAP, WRITEABLE_WHEN_EN, 1);
         retval = FIELD_DP64(retval, CXL_CPMU_CAP, FREEZE, 1);
@@ -42,26 +73,30 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
         break;
     case A_CXL_CPMU_EVENT_CAP0:
         /* Event group 0, clock ticks */
-        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, SUPPORTED_EVENTS, 1);
-        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, EVENT_GROUP_ID, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, SUPPORTED_EVENTS,
+                            CPMU_BASE_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, EVENT_GROUP_ID,
+                            CPMU_GID_BASE);
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0,
-                            EVENT_VENDOR_ID, 0x1e98);
+                            EVENT_VENDOR_ID, CXL_VENDOR_ID);
         break;
     case A_CXL_CPMU_EVENT_CAP1:
         /* Random mashup */
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, SUPPORTED_EVENTS,
-                            0xFF);
-        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_GROUP_ID, 0x10);
+                            CPMU_D2H_REQ_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_GROUP_ID,
+                            CPMU_GID_D2H_REQ);
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_VENDOR_ID,
-                            0x1e98);
+                            CXL_VENDOR_ID);
         break;
     case A_CXL_CPMU_EVENT_CAP2:
         /* Random mashup */
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, SUPPORTED_EVENTS,
-                            0xFF);
-        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, EVENT_GROUP_ID, 0x12);
+                            CPMU_H2D_REQ_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, EVENT_GROUP_ID,
+                            CPMU_GID_H2D_REQ);
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP2, EVENT_VENDOR_ID,
-                            0x1e98);
+                            CXL_VENDOR_ID);
         break;
     case A_CXL_CPMU_EVENT_CAP3:
         /* Random mashup - vendor specific */
@@ -69,7 +104,47 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
                             0xFF);
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP3, EVENT_GROUP_ID, 0);
         retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP3, EVENT_VENDOR_ID,
-                            0x19e5);
+                            CPMU_VID_HUAWEI);
+        break;
+    case A_CXL_CPMU_EVENT_CAP4:
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP4, SUPPORTED_EVENTS,
+                            CPMU_DDR_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP4, EVENT_GROUP_ID,
+                            CPMU_GID_DDR);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP4, EVENT_VENDOR_ID,
+                            CXL_VENDOR_ID);
+        break;
+    case A_CXL_CPMU_EVENT_CAP5:
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP5, SUPPORTED_EVENTS,
+                            CPMU_QUEUE_OCC_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP5, EVENT_GROUP_ID,
+                            CPMU_GID_QUEUE_OCC);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP5, EVENT_VENDOR_ID,
+                            CXL_VENDOR_ID);
+        break;
+    case A_CXL_CPMU_EVENT_CAP6:
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP6, SUPPORTED_EVENTS,
+                            CPMU_QUEUE_RESID_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP6, EVENT_GROUP_ID,
+                            CPMU_GID_QUEUE_RESID);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP6, EVENT_VENDOR_ID,
+                            CXL_VENDOR_ID);
+        break;
+    case A_CXL_CPMU_EVENT_CAP7:
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP7, SUPPORTED_EVENTS,
+                            CPMU_RETRY_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP7, EVENT_GROUP_ID,
+                            CPMU_GID_RETRY);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP7, EVENT_VENDOR_ID,
+                            CXL_VENDOR_ID);
+        break;
+    case A_CXL_CPMU_EVENT_CAP8:
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP8, SUPPORTED_EVENTS,
+                            CPMU_THROTTLE_EVENTS);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP8, EVENT_GROUP_ID,
+                            CPMU_GID_THROTTLE);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP8, EVENT_VENDOR_ID,
+                            CXL_VENDOR_ID);
         break;
 
     case A_CXL_CPMU_CNT0_CFG:
@@ -144,6 +219,15 @@ static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
         retval = FIELD_DP64(retval, CXL_CPMU_FILTER0_CNT3_CFG, VALUE,
                             cpmu->filter_value[0][index]);
         break;
+    case A_CXL_CPMU_FILTER1_CNT0_CFG:
+    case A_CXL_CPMU_FILTER1_CNT1_CFG:
+    case A_CXL_CPMU_FILTER1_CNT2_CFG:
+    case A_CXL_CPMU_FILTER1_CNT3_CFG:
+        /* Channel/Rank/Bank filter - consecutive counters are 32 bytes apart */
+        index = (offset - A_CXL_CPMU_FILTER1_CNT0_CFG) / 32;
+        retval = FIELD_DP64(retval, CXL_CPMU_FILTER1_CNT0_CFG, VALUE,
+                            cpmu->filter_value[1][index]);
+        break;
     case A_CXL_CPMU_CNT0:
     case A_CXL_CPMU_CNT1:
     case A_CXL_CPMU_CNT2:
@@ -196,12 +280,23 @@ static void cpmu_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case A_CXL_CPMU_FILTER0_CNT2_CFG:
         index = 2;
+        cpmu->filter_value[0][index] =
+            FIELD_EX32(value, CXL_CPMU_FILTER0_CNT1_CFG, VALUE);
         break;
     case A_CXL_CPMU_FILTER0_CNT3_CFG:
         index = 3;
         cpmu->filter_value[0][index] =
             FIELD_EX32(value, CXL_CPMU_FILTER0_CNT1_CFG, VALUE);
         break;
+    case A_CXL_CPMU_FILTER1_CNT0_CFG:
+    case A_CXL_CPMU_FILTER1_CNT1_CFG:
+    case A_CXL_CPMU_FILTER1_CNT2_CFG:
+    case A_CXL_CPMU_FILTER1_CNT3_CFG:
+        /* Channel/Rank/Bank filter - consecutive counters are 32 bytes apart */
+        index = (offset - A_CXL_CPMU_FILTER1_CNT0_CFG) / 32;
+        cpmu->filter_value[1][index] =
+            FIELD_EX32(value, CXL_CPMU_FILTER1_CNT0_CFG, VALUE);
+        break;
     case A_CXL_CPMU_CNT0:
     case A_CXL_CPMU_CNT1:
     case A_CXL_CPMU_CNT2:
diff --git a/include/hw/cxl/cxl_cpmu.h b/include/hw/cxl/cxl_cpmu.h
index 883212c439cd..d5c68edeaac7 100644
--- a/include/hw/cxl/cxl_cpmu.h
+++ b/include/hw/cxl/cxl_cpmu.h
@@ -36,6 +36,11 @@ CXL_CPMU_EVENT_CAP(0)
 CXL_CPMU_EVENT_CAP(1)
 CXL_CPMU_EVENT_CAP(2)
 CXL_CPMU_EVENT_CAP(3)
+CXL_CPMU_EVENT_CAP(4)
+CXL_CPMU_EVENT_CAP(5)
+CXL_CPMU_EVENT_CAP(6)
+CXL_CPMU_EVENT_CAP(7)
+CXL_CPMU_EVENT_CAP(8)
 
 #define CXL_CPMU_CNT_CFG(n) \
     REG64(CXL_CPMU_CNT##n##_CFG, 0x200 + 8 * (n))                     \
@@ -59,13 +64,18 @@ CXL_CPMU_CNT_CFG(3)
 
 #define CXL_CPMU_FILTER_CFG(n, f)                                       \
     REG64(CXL_CPMU_FILTER##f##_CNT##n##_CFG, 0x400 + 4 * ((f) + (n) * 8)) \
-        FIELD(CXL_CPMU_FILTER##f##_CNT##n##_CFG, VALUE, 0, 16)
+        FIELD(CXL_CPMU_FILTER##f##_CNT##n##_CFG, VALUE, 0, 32)
 
-/* Only HDM decoder filter suppored - no effect on first counter */
+/* Filter ID 0: HDM decoder filter - no effect on first counter */
 CXL_CPMU_FILTER_CFG(0, 0)
 CXL_CPMU_FILTER_CFG(1, 0)
 CXL_CPMU_FILTER_CFG(2, 0)
 CXL_CPMU_FILTER_CFG(3, 0)
+/* Filter ID 1: Channel/Rank/Bank (CRB) filter */
+CXL_CPMU_FILTER_CFG(0, 1)
+CXL_CPMU_FILTER_CFG(1, 1)
+CXL_CPMU_FILTER_CFG(2, 1)
+CXL_CPMU_FILTER_CFG(3, 1)
 
 #define CXL_CPMU_CNT(n)                     \
     REG64(CXL_CPMU_CNT##n, 0xc00 + 8 * (n))
@@ -77,12 +87,12 @@ CXL_CPMU_CNT(3)
 
 typedef struct CPMUState {
 #define CPMU_NUM_COUNTERS 4
-#define CPMU_NUM_EVENT_GROUPS 4
-#define CPMU_NUM_FILTERS 1
+#define CPMU_NUM_EVENT_GROUPS 9
+#define CPMU_NUM_FILTERS 2
     bool counter_enable[CPMU_NUM_COUNTERS];
     bool int_en[CPMU_NUM_COUNTERS];
     bool freeze_en[CPMU_NUM_COUNTERS];
-    bool filter_value[CPMU_NUM_FILTERS][CPMU_NUM_COUNTERS];
+    uint32_t filter_value[CPMU_NUM_FILTERS][CPMU_NUM_COUNTERS];
     uint64_t counter[CPMU_NUM_COUNTERS];
     uint64_t overflow_status_bm;
     uint64_t freeze_status_bm;
-- 
2.39.5

