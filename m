Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EE14F70
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB0710C
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 09:14:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgCv0ZjZz6JB8T;
	Tue, 24 Oct 2023 00:11:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:14:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
	<gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 13/17] hw/cxl: Add support for device sanitation
Date: Mon, 23 Oct 2023 17:08:02 +0100
Message-ID: <20231023160806.13206-14-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

From: Davidlohr Bueso <dave@stgolabs.net>

Make use of the background operations through the sanitize command, per CXL
3.0 specs. Traditionally run times can be rather long, depending on the
size of the media.

Estimate times based on:
	 https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  17 +++++
 hw/cxl/cxl-mailbox-utils.c  | 140 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  10 +++
 3 files changed, 167 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 2a813cdddd..70aca9024c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -343,6 +343,23 @@ REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
+{
+    uint64_t dev_status_reg;
+
+    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+}
+#define cxl_dev_disable_media(cxlds)                    \
+        do { __toggle_media((cxlds), 0x3); } while (0)
+#define cxl_dev_enable_media(cxlds)                     \
+        do { __toggle_media((cxlds), 0x1); } while (0)
+
+static inline bool sanitize_running(CXLCCI *cci)
+{
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
+}
+
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f3fd97deb5..2463f239af 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -18,6 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/uuid.h"
+#include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
@@ -68,6 +69,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    SANITIZE    = 0x44,
+        #define OVERWRITE     0x0
+        #define SECURE_ERASE  0x1
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -749,6 +753,108 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* Perform the actual device zeroing */
+static void __do_sanitization(CXLType3Dev *ct3d)
+{
+    MemoryRegion *mr;
+
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (mr) {
+            void *hostmem = memory_region_get_ram_ptr(mr);
+            memset(hostmem, 0, memory_region_size(mr));
+        }
+    }
+
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (mr) {
+            void *hostmem = memory_region_get_ram_ptr(mr);
+            memset(hostmem, 0, memory_region_size(mr));
+        }
+    }
+    if (ct3d->lsa) {
+        mr = host_memory_backend_get_memory(ct3d->lsa);
+        if (mr) {
+            void *lsa = memory_region_get_ram_ptr(mr);
+            memset(lsa, 0, memory_region_size(mr));
+        }
+    }
+}
+
+/*
+ * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    if (total_mem <= 512) {
+        secs = 4;
+    } else if (total_mem <= 1024) {
+        secs = 8;
+    } else if (total_mem <= 2 * 1024) {
+        secs = 15;
+    } else if (total_mem <= 4 * 1024) {
+        secs = 30;
+    } else if (total_mem <= 8 * 1024) {
+        secs = 60;
+    } else if (total_mem <= 16 * 1024) {
+        secs = 2 * 60;
+    } else if (total_mem <= 32 * 1024) {
+        secs = 4 * 60;
+    } else if (total_mem <= 64 * 1024) {
+        secs = 8 * 60;
+    } else if (total_mem <= 128 * 1024) {
+        secs = 15 * 60;
+    } else if (total_mem <= 256 * 1024) {
+        secs = 30 * 60;
+    } else if (total_mem <= 512 * 1024) {
+        secs = 60 * 60;
+    } else if (total_mem <= 1024 * 1024) {
+        secs = 120 * 60;
+    } else {
+        secs = 240 * 60; /* max 4 hrs */
+    }
+
+    /* EBUSY other bg cmds as of now */
+    cci->bg.runtime = secs * 1000UL;
+    *len_out = 0;
+
+    cxl_dev_disable_media(&ct3d->cxl_dstate);
+
+    if (secs > 2) {
+        /* sanitize when done */
+        return CXL_MBOX_BG_STARTED;
+    } else {
+        __do_sanitization(ct3d);
+        cxl_dev_enable_media(&ct3d->cxl_dstate);
+
+        return CXL_MBOX_SUCCESS;
+    }
+}
+
 /*
  * This is very inefficient, but good enough for now!
  * Also the payload will always fit, so no need to handle the MORE flag and
@@ -993,6 +1099,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
+        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
@@ -1050,6 +1158,21 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
+    /* forbid any selected commands while overwriting */
+    if (sanitize_running(cci)) {
+        if (h == cmd_events_get_records ||
+            h == cmd_ccls_get_partition_info ||
+            h == cmd_ccls_set_lsa ||
+            h == cmd_ccls_get_lsa ||
+            h == cmd_logs_get_log ||
+            h == cmd_media_get_poison_list ||
+            h == cmd_media_inject_poison ||
+            h == cmd_media_clear_poison ||
+            h == cmd_sanitize_overwrite) {
+            return CXL_MBOX_MEDIA_DISABLED;
+        }
+    }
+
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
     if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
@@ -1088,6 +1211,23 @@ static void bg_timercb(void *opaque)
 
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
+        if (ret == CXL_MBOX_SUCCESS) {
+            switch (cci->bg.opcode) {
+            case 0x4400: /* sanitize */
+            {
+                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+                __do_sanitization(ct3d);
+                cxl_dev_enable_media(&ct3d->cxl_dstate);
+            }
+            break;
+            case 0x4304: /* TODO: scan media */
+                break;
+            default:
+                __builtin_unreachable();
+                break;
+            }
+        }
 
         qemu_log("Background command %04xh finished: %s\n",
                  cci->bg.opcode,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0529745786..cc8220592f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -23,6 +23,7 @@
 #include "qemu/pmem.h"
 #include "qemu/range.h"
 #include "qemu/rcu.h"
+#include "qemu/guest-random.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "hw/cxl/cxl.h"
@@ -897,6 +898,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+        qemu_guest_getrandom_nofail(data, size);
+        return MEMTX_OK;
+    }
+
     return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
@@ -913,6 +919,10 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
+    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+        return MEMTX_OK;
+    }
+
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-- 
2.39.2

