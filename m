Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20F145B0F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181272; cv=none; b=UiXI1A2IDfbXiJl0DkNSXUT3j0LmKGgbGJWj55uW+WRwKUJchtgmeuPb4CxeBW5ctrnYYrU+cYU88XmvxD+Lc9+hmwgXs6h3COkHKmDsXxPB+Fr6/MVfWEDXzCn0b9AiR0XI+3hiC9KQyosTPW56ze6FaEf0kw/p6Y2nbxqTqvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181272; c=relaxed/simple;
	bh=B5S/5PzAh6ipJodWeFLphqT28krDJUYgEO6AalTTHa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGMN6gRB1XYXX7gO+JNvaYU20Tm3bQma28FCHh5Cjz950vBBNUBvpxGfdFpFoClfommjSBqcA7RpXrv1Pmr1iylkEguF/aOXDAMls2SwBQQHWXHS+SyT/ToxJOIAyZjMQj0xbMrJjjbdJYJBn15+geKGid3qyAOaonSv2I5LU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFsh65v07z6HJcl;
	Fri,  5 Jul 2024 20:07:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CC9D140C98;
	Fri,  5 Jul 2024 20:07:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:07:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 2/4] hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
Date: Fri, 5 Jul 2024 13:06:41 +0100
Message-ID: <20240705120643.959422-3-Jonathan.Cameron@huawei.com>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

The spec states that reads/writes should have no effect and a part of
commands should be ignored when the media is disabled, not when the
sanitize command is running.

Introduce cxl_dev_media_disabled() to check if the media is disabled and
replace sanitize_running() with it.

Make sure that the media has been correctly disabled during sanitation
by adding an assert to __toggle_media(). Now, enabling when already
enabled or vice versa results in an assert() failure.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/r/20231222090051.3265307-4-42.hyeyoo@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Fix added to ensure the state sanity check only applies on type3 devices
---
 include/hw/cxl/cxl_device.h | 10 +++++-----
 hw/cxl/cxl-mailbox-utils.c  | 29 +++++++++++++++++------------
 hw/mem/cxl_type3.c          |  4 ++--
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b5beb7f90e..42a622197e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -397,14 +397,14 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
-static inline bool scan_media_running(CXLCCI *cci)
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+    uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
 }
-
-static inline bool sanitize_running(CXLCCI *cci)
+static inline bool scan_media_running(CXLCCI *cci)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
 }
 
 typedef struct CXLError {
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6a60f81794..adeb71071c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2115,6 +2115,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate;
 
     *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
@@ -2135,18 +2136,22 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
-    /* forbid any selected commands while overwriting */
-    if (sanitize_running(cci)) {
-        if (h == cmd_events_get_records ||
-            h == cmd_ccls_get_partition_info ||
-            h == cmd_ccls_set_lsa ||
-            h == cmd_ccls_get_lsa ||
-            h == cmd_logs_get_log ||
-            h == cmd_media_get_poison_list ||
-            h == cmd_media_inject_poison ||
-            h == cmd_media_clear_poison ||
-            h == cmd_sanitize_overwrite) {
-            return CXL_MBOX_MEDIA_DISABLED;
+    /* forbid any selected commands while the media is disabled */
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
+        if (cxl_dev_media_disabled(cxl_dstate)) {
+            if (h == cmd_events_get_records ||
+                h == cmd_ccls_get_partition_info ||
+                h == cmd_ccls_set_lsa ||
+                h == cmd_ccls_get_lsa ||
+                h == cmd_logs_get_log ||
+                h == cmd_media_get_poison_list ||
+                h == cmd_media_inject_poison ||
+                h == cmd_media_clear_poison ||
+                h == cmd_sanitize_overwrite) {
+                return CXL_MBOX_MEDIA_DISABLED;
+            }
         }
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 62956a0403..925c88ac5d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1127,7 +1127,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1149,7 +1149,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         return MEMTX_OK;
     }
 
-- 
2.43.0

