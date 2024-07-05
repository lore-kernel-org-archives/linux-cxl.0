Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225B149C50
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181240; cv=none; b=JKu5HzcZtDlOYZXYAMX17ieJIRPdtd3idS4B3VGE7HPkrAuQwfpmctq9DDBiIizlZW2OZBghdgXa3nrOYeC71rPpavXGsaeO1oNfPD8rsKZs6ZsDYXN8hRVV+zJg30XJsDloOmxgYH/DgZhnniMDWC8MV5IV/gF4aR8ryf/OU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181240; c=relaxed/simple;
	bh=SyKowTkm1zhSqQr34qJA7wY3DsHu4BUpIXI+NtgOZQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWVfOkJ571n1OVeawrROQWYQJJC8+F/yBaOLkVvr7df8Dk/Qyu4zTgf4tfmTshFiShRTl2FCRXscP9IJ+Bzc/macnEPYMOUxRjI+snChofHB0nuOdtcfNFxoNYhaAvrQiwEJbkwoizI9fa6tI9Yf8JrHeBF4VLM8qMQiDi7rfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFsf70Gbhz6K9YG;
	Fri,  5 Jul 2024 20:05:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ABBB9140B18;
	Fri,  5 Jul 2024 20:07:14 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:07:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 1/4] hw/cxl: Add get scan media capabilities cmd support
Date: Fri, 5 Jul 2024 13:06:40 +0100
Message-ID: <20240705120643.959422-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
References: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Davidlohr Bueso <dave@stgolabs.net>

Use simple heuristics to determine the cost of scanning any given
chunk, assuming cost is equal across the whole device, without
differentiating between volatile or persistent partitions. This
is aligned to the fact that these constraints are not enforced
in respective poison query commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230908073152.4386-3-dave@stgolabs.net
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Tweaks: Update reference to 3.1 specification given 3.0 not easily
available any more.
---
 include/hw/cxl/cxl_device.h |   9 ++
 hw/cxl/cxl-mailbox-utils.c  | 211 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  22 ++--
 3 files changed, 233 insertions(+), 9 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0a4fcb2800..b5beb7f90e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -397,6 +397,11 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
+static inline bool scan_media_running(CXLCCI *cci)
+{
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+}
+
 static inline bool sanitize_running(CXLCCI *cci)
 {
     return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
@@ -491,6 +496,9 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+    /* Poison Injection - backup */
+    CXLPoisonList poison_list_bkp;
+    CXLPoisonList scan_media_results;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
@@ -558,6 +566,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
+void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d);
 
 CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 74eeb6fde7..6a60f81794 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
+        #define SCAN_MEDIA             0x4
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1117,6 +1119,10 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         out->flags = (1 << 1);
         stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
     }
+    if (scan_media_running(cci)) {
+        out->flags |= (1 << 2);
+    }
+
     stw_le_p(&out->count, record_count);
     *len_out = out_pl_len;
     return CXL_MBOX_SUCCESS;
@@ -1146,6 +1152,16 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
             return CXL_MBOX_SUCCESS;
         }
     }
+    /*
+     * Freeze the list if there is an on-going scan media operation.
+     */
+    if (scan_media_running(cci)) {
+        /*
+         * XXX: Spec is ambiguous - is this case considered
+         * a successful return despite not adding to the list?
+         */
+        goto success;
+    }
 
     if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
         return CXL_MBOX_INJECT_POISON_LIMIT;
@@ -1161,6 +1177,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
      */
     QLIST_INSERT_HEAD(poison_list, p, node);
     ct3d->poison_list_cnt++;
+success:
     *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
@@ -1200,6 +1217,17 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
         }
     }
 
+    /*
+     * Freeze the list if there is an on-going scan media operation.
+     */
+    if (scan_media_running(cci)) {
+        /*
+         * XXX: Spec is ambiguous - is this case considered
+         * a successful return despite not removing from the list?
+         */
+        goto success;
+    }
+
     QLIST_FOREACH(ent, poison_list, node) {
         /*
          * Test for contained in entry. Simpler than general case
@@ -1210,7 +1238,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
         }
     }
     if (!ent) {
-        return CXL_MBOX_SUCCESS;
+        goto success;
     }
 
     QLIST_REMOVE(ent, node);
@@ -1247,11 +1275,180 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     }
     /* Any fragments have been added, free original entry */
     g_free(ent);
+success:
     *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.4.4: Get Scan Media Capabilities
+ */
+static CXLRetCode
+cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct get_scan_media_capabilities_pl {
+        uint64_t pa;
+        uint64_t length;
+    } QEMU_PACKED;
+
+    struct get_scan_media_capabilities_out_pl {
+        uint32_t estimated_runtime_ms;
+    };
+
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    struct get_scan_media_capabilities_pl *in = (void *)payload_in;
+    struct get_scan_media_capabilities_out_pl *out = (void *)payload_out;
+    uint64_t query_start;
+    uint64_t query_length;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
+
+    if (query_start + query_length > cxl_dstate->static_mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /*
+     * Just use 400 nanosecond access/read latency + 100 ns for
+     * the cost of updating the poison list. For small enough
+     * chunks return at least 1 ms.
+     */
+    stl_le_p(&out->estimated_runtime_ms,
+             MAX(1, query_length * (0.0005L / 64)));
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
+static void __do_scan_media(CXLType3Dev *ct3d)
+{
+    CXLPoison *ent;
+    unsigned int results_cnt = 0;
+
+    QLIST_FOREACH(ent, &ct3d->scan_media_results, node) {
+        results_cnt++;
+    }
+
+    /* only scan media may clear the overflow */
+    if (ct3d->poison_list_overflowed &&
+        ct3d->poison_list_cnt == results_cnt) {
+        cxl_clear_poison_list_overflowed(ct3d);
+    }
+}
+
+/*
+ * CXL r3.1 section 8.2.9.9.4.5: Scan Media
+ */
+static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct scan_media_pl {
+        uint64_t pa;
+        uint64_t length;
+        uint8_t flags;
+    } QEMU_PACKED;
+
+    struct scan_media_pl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    uint64_t query_start;
+    uint64_t query_length;
+    CXLPoison *ent, *next;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
+
+    if (query_start + query_length > cxl_dstate->static_mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+    if (ct3d->dc.num_regions && query_start + query_length >=
+            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    if (in->flags == 0) { /* TODO */
+        qemu_log_mask(LOG_UNIMP,
+                      "Scan Media Event Log is unsupported\n");
+    }
+
+    /* any previous results are discarded upon a new Scan Media */
+    QLIST_FOREACH_SAFE(ent, &ct3d->scan_media_results, node, next) {
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    /* kill the poison list - it will be recreated */
+    if (ct3d->poison_list_overflowed) {
+        QLIST_FOREACH_SAFE(ent, &ct3d->poison_list, node, next) {
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
+            ct3d->poison_list_cnt--;
+        }
+    }
+
+    /*
+     * Scan the backup list and move corresponding entries
+     * into the results list, updating the poison list
+     * when possible.
+     */
+    QLIST_FOREACH_SAFE(ent, &ct3d->poison_list_bkp, node, next) {
+        CXLPoison *res;
+
+        if (ent->start >= query_start + query_length ||
+            ent->start + ent->length <= query_start) {
+            continue;
+        }
+
+        /*
+         * If a Get Poison List cmd comes in while this
+         * scan is being done, it will see the new complete
+         * list, while setting the respective flag.
+         */
+        if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
+            CXLPoison *p = g_new0(CXLPoison, 1);
+
+            p->start = ent->start;
+            p->length = ent->length;
+            p->type = ent->type;
+            QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+            ct3d->poison_list_cnt++;
+        }
+
+        res = g_new0(CXLPoison, 1);
+        res->start = ent->start;
+        res->length = ent->length;
+        res->type = ent->type;
+        QLIST_INSERT_HEAD(&ct3d->scan_media_results, res, node);
+
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    cci->bg.runtime = MAX(1, query_length * (0.0005L / 64));
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
 /*
  * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
  * (Opcode: 4800h)
@@ -1864,6 +2061,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = {
+        "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
+        cmd_media_get_scan_media_capabilities, 16, 0 },
+    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
+        cmd_media_scan_media, 17, BACKGROUND_OPERATION },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
@@ -1995,8 +2197,13 @@ static void bg_timercb(void *opaque)
             cxl_dev_enable_media(&ct3d->cxl_dstate);
         }
         break;
-        case 0x4304: /* TODO: scan media */
+        case 0x4304: /* scan media */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+            __do_scan_media(ct3d);
             break;
+        }
         default:
             __builtin_unreachable();
             break;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 35ac59883a..62956a0403 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1304,6 +1304,12 @@ void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
             cxl_device_get_timestamp(&ct3d->cxl_dstate);
 }
 
+void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d)
+{
+    ct3d->poison_list_overflowed = false;
+    ct3d->poison_list_overflow_ts = 0;
+}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
@@ -1340,19 +1346,21 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
         }
     }
 
-    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
-        cxl_set_poison_list_overflowed(ct3d);
-        return;
-    }
-
     p = g_new0(CXLPoison, 1);
     p->length = length;
     p->start = start;
     /* Different from injected via the mbox */
     p->type = CXL_POISON_TYPE_INTERNAL;
 
-    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
-    ct3d->poison_list_cnt++;
+    if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
+        QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+        ct3d->poison_list_cnt++;
+    } else {
+        if (!ct3d->poison_list_overflowed) {
+            cxl_set_poison_list_overflowed(ct3d);
+        }
+        QLIST_INSERT_HEAD(&ct3d->poison_list_bkp, p, node);
+    }
 }
 
 /* For uncorrectable errors include support for multiple header recording */
-- 
2.43.0

