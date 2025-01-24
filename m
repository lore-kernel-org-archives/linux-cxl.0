Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1E1BD9E5
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739783; cv=none; b=hhCQq7hiznrDdJd02PwoduEJRXdkeVblyHk+aAGcFn/Mm6PUMe7z8JwUaEpKp/XEdY7A+oLOsGFobv2G4SELRatyKhqUOqZCX9DhX9kkdY0AVxpsUn7IJIxjupk2RNN+vNBZNIiZtDQsJ7YCDXYWI9cLB3YFScVzJoqYut1CeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739783; c=relaxed/simple;
	bh=yWKbe7OSPa44QwMaymiRJwSDpJUjHFKcyXlFDmR8VOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RS4dIltW7932EnMcl8CY1K0EiwKkUMKbWLguxYzUHiv+LTBTYtom1XNaBol+GRAX6NN0ctJ87spgJL5eOzko/qSUciuxkHk/Dod1vxsEMWongFUkVc5pGk9YlidSH6b+CzPLCV2TRz9o7jeMuXnRhZJgrIoMrLokOfxb9WHIhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YflBL2xWzz6L55j;
	Sat, 25 Jan 2025 01:27:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C36C140119;
	Sat, 25 Jan 2025 01:29:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 Jan 2025 18:29:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexandre Iooss
	<erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, <linuxarm@huawei.com>, Niyas Sait
	<niyas.sait@huawei.com>
Subject: [RFC PATCH QEMU 1/3] hw/cxl: Initial CXL Hotness Monitoring Unit Emulation
Date: Fri, 24 Jan 2025 17:29:03 +0000
Message-ID: <20250124172905.84099-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

Intended to support enabling in kernel. For now this is dumb and the data
made up.  That will change in the near future.

Instantiates 3 instances within one CHMU with separate
interrupts.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_chmu.h   | 154 ++++++++++++
 include/hw/cxl/cxl_device.h |  13 +-
 include/hw/cxl/cxl_pci.h    |   7 +-
 hw/cxl/cxl-chmu.c           | 459 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  25 +-
 hw/cxl/meson.build          |   1 +
 7 files changed, 655 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 857fa61898..bef856485f 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -16,6 +16,7 @@
 #include "hw/pci/pci_host.h"
 #include "cxl_pci.h"
 #include "cxl_component.h"
+#include "cxl_chmu.h"
 #include "cxl_cpmu.h"
 #include "cxl_device.h"
 
diff --git a/include/hw/cxl/cxl_chmu.h b/include/hw/cxl/cxl_chmu.h
new file mode 100644
index 0000000000..2de04ea605
--- /dev/null
+++ b/include/hw/cxl/cxl_chmu.h
@@ -0,0 +1,154 @@
+/*
+ * QEMU CXL Hotness Monitoring Unit
+ *
+ * Copyright (c) 2024 Huawei
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "hw/register.h"
+
+#ifndef _CXL_CHMU_H_
+#define _CXL_CHMU_H_
+
+/* Emulated parameters - arbitrary choices */
+#define CXL_CHMU_INSTANCES_PER_BLOCK 3
+#define CXL_HOTLIST_ENTRIES 1024
+ /* 1TB - should be enough for anyone, right? */
+#define CXL_MAX_DRAM_CAPACITY 0x10000000000UL
+
+/* In instance address space */
+#define CXL_CHMU_HL_START (0x70 + (CXL_MAX_DRAM_CAPACITY / (0x10000000UL * 8)))
+#define CXL_CHMU_INSTANCE_SIZE (CXL_CHMU_HL_START + CXL_HOTLIST_ENTRIES * 8)
+#define CXL_CHMU_SIZE \
+    (0x10 + CXL_CHMU_INSTANCE_SIZE * CXL_CHMU_INSTANCES_PER_BLOCK)
+
+/*
+ * Many of these registers are documented as being a multiple of 64 bits long.
+ * Reading then can only be done in 64 bit chunks though so specify them here
+ * as multiple registers.
+ */
+REG64(CXL_CHMU_COMMON_CAP0, 0x0)
+    FIELD(CXL_CHMU_COMMON_CAP0, VERSION, 0, 4)
+    FIELD(CXL_CHMU_COMMON_CAP0, NUM_INSTANCES, 8, 8)
+REG64(CXL_CHMU_COMMON_CAP1, 0x8)
+    FIELD(CXL_CHMU_COMMON_CAP1, INSTANCE_LENGTH, 0, 16)
+
+/* Per instance registers for instance 0 in CHMU main address space */
+REG64(CXL_CHMU0_CAP0, 0x10)
+    FIELD(CXL_CHMU0_CAP0, MSI_N, 0, 4)
+    FIELD(CXL_CHMU0_CAP0, OVERFLOW_INT, 4, 1)
+    FIELD(CXL_CHMU0_CAP0, LEVEL_INT, 5, 1)
+    FIELD(CXL_CHMU0_CAP0, EPOCH_TYPE, 6, 2)
+#define CXL_CHMU0_CAP0_EPOCH_TYPE_GLOBAL 0
+#define CXL_CHMU0_CAP0_EPOCH_TYPE_PERCNT 1
+    /* Break up the Tracked M2S Request field into flags */
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_R, 8, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_W, 9, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_RW, 10, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_ALL_R, 11, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_ALL_W, 12, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_ALL_RW, 13, 1)
+
+    FIELD(CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_SCALE, 16, 4)
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_100USEC 1
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_1MSEC 2
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_10MSEC 3
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_100MSEC 4
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_1SEC 5
+    FIELD(CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_VAL, 20, 12)
+    FIELD(CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_SCALE, 32, 4)
+    FIELD(CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_VAL, 36, 12)
+    FIELD(CXL_CHMU0_CAP0, HOTLIST_SIZE, 48, 16)
+REG64(CXL_CHMU0_CAP1, 0x18)
+    FIELD(CXL_CHMU0_CAP1, UNIT_SIZES, 0, 32)
+    FIELD(CXL_CHMU0_CAP1, DOWN_SAMPLING_FACTORS, 32, 16)
+    /* Split up Flags */
+    FIELD(CXL_CHMU0_CAP1, FLAGS_EPOCH_BASED, 48, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_ALWAYS_ON, 49, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_RANDOMIZED_DOWN_SAMPLING, 50, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_OVERLAPPING_ADDRESS_RANGES, 51, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_INSERT_AFTER_CLEAR, 52, 1)
+REG64(CXL_CHMU0_CAP2, 0x20)
+    FIELD(CXL_CHMU0_CAP2, BITMAP_REG_OFFSET, 0, 64)
+REG64(CXL_CHMU0_CAP3, 0x28)
+    FIELD(CXL_CHMU0_CAP3, HOTLIST_REG_OFFSET, 0, 64)
+
+REG64(CXL_CHMU0_CONF0, 0x50)
+    FIELD(CXL_CHMU0_CONF0, M2S_REQ_TO_TRACK, 0, 8)
+    FIELD(CXL_CHMU0_CONF0, FLAGS_RANDOMIZE_DOWNSAMPLING, 8, 1)
+    FIELD(CXL_CHMU0_CONF0, FLAGS_INT_ON_OVERFLOW, 9, 1)
+    FIELD(CXL_CHMU0_CONF0, FLAGS_INT_ON_FILL_THRESH, 10, 1)
+    FIELD(CXL_CHMU0_CONF0, CONTROL_ENABLE, 16, 1)
+    FIELD(CXL_CHMU0_CONF0, CONTROL_RESET, 17, 1)
+    FIELD(CXL_CHMU0_CONF0, HOTNESS_THRESHOLD, 32, 32)
+REG64(CXL_CHMU0_CONF1, 0x58)
+    FIELD(CXL_CHMU0_CONF1, UNIT_SIZE, 0, 32)
+    FIELD(CXL_CHMU0_CONF1, DOWN_SAMPLING_FACTOR, 32, 8)
+    FIELD(CXL_CHMU0_CONF1, REPORTING_MODE, 40, 8)
+    FIELD(CXL_CHMU0_CONF1, EPOCH_LENGTH_SCALE, 48, 4)
+    FIELD(CXL_CHMU0_CONF1, EPOCH_LENGTH_VAL, 52, 12)
+REG64(CXL_CHMU0_CONF2, 0x60)
+    FIELD(CXL_CHMU0_CONF2, NOTIFICATION_THRESHOLD, 0, 16)
+
+REG64(CXL_CHMU0_STATUS, 0x70)
+    /* Break up status field into separate flags */
+    FIELD(CXL_CHMU0_STATUS, STATUS_ENABLED, 0, 1)
+    FIELD(CXL_CHMU0_STATUS, OPERATION_IN_PROG, 16, 16)
+    FIELD(CXL_CHMU0_STATUS, COUNTER_WIDTH, 32, 8)
+    /* Break up oddly name overflow interrupt stats */
+    FIELD(CXL_CHMU0_STATUS, OVERFLOW_INT, 40, 1)
+    FIELD(CXL_CHMU0_STATUS, LEVEL_INT, 41, 1)
+
+REG16(CXL_CHMU0_HEAD, 0x78)
+REG16(CXL_CHMU0_TAIL, 0x7A)
+
+/* Provide first few of these so we can calculate the size */
+REG64(CXL_CHMU0_RANGE_CONFIG_BITMAP0, 0x80)
+REG64(CXL_CHMU0_RANGE_CONFIG_BITMAP1, 0x88)
+
+REG64(CXL_CHMU0_HOTLIST0, CXL_CHMU_HL_START + 0x10)
+REG64(CXL_CHMU0_HOTLIST1, CXL_CHMU_HL_START + 0x10)
+
+REG64(CXL_CHMU1_CAP0, 0x10 + CXL_CHMU_INSTANCE_SIZE)
+
+typedef struct CHMUState CHMUState;
+
+typedef struct CHMUInstance {
+    Object *private;
+    uint32_t hotness_thresh;
+    uint32_t unit_size;
+    uint8_t ds_factor;
+    uint16_t head, tail, fillthresh, op_in_prog;
+    uint8_t what;
+
+    bool int_on_overflow;
+    bool int_on_fill_thresh;
+    bool overflow_set;
+    bool fill_thresh_set;
+    uint8_t msi_n;
+
+    bool enabled;
+    uint64_t hotlist[CXL_HOTLIST_ENTRIES];
+    QEMUTimer *timer;
+    uint32_t epoch_ms;
+    /* Hack for now */
+    CHMUState *parent;
+} CHMUInstance;
+
+typedef struct CHMUState {
+    CHMUInstance inst[CXL_CHMU_INSTANCES_PER_BLOCK];
+    int socket;
+    /* Hack updated on first HDM decoder only */
+    uint64_t base;
+    uint64_t size;
+    uint16_t port;
+} CHMUState;
+typedef struct cxl_device_state CXLDeviceState;
+int cxl_chmu_register_block_init(Object *obj,
+                                 CXLDeviceState *cxl_dstte,
+                                 int id, uint8_t msi_n,
+                                 Error **errp);
+
+#endif /* _CXL_CHMU_H_ */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 04c93cd753..f855cd69d9 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -15,6 +15,7 @@
 #include "hw/register.h"
 #include "hw/cxl/cxl_events.h"
 
+#include "hw/cxl/cxl_chmu.h"
 #include "hw/cxl/cxl_cpmu.h"
 /*
  * The following is how a CXL device's Memory Device registers are laid out.
@@ -109,12 +110,20 @@
                   (x) * (1 << 16),                                      \
                   1 << 16)
 
+#define CXL_NUM_CHMU_INSTANCES 1
+#define CXL_CHMU_OFFSET(x)                                               \
+    QEMU_ALIGN_UP(CXL_MEMORY_DEVICE_REGISTERS_OFFSET +                  \
+                  CXL_MEMORY_DEVICE_REGISTERS_LENGTH +                  \
+                  (1 << 16) * CXL_NUM_CPMU_INSTANCES,                   \
+                  1 << 16)
+
 #define CXL_MMIO_SIZE                                                   \
     QEMU_ALIGN_UP(CXL_DEVICE_CAP_REG_SIZE +                             \
                   CXL_DEVICE_STATUS_REGISTERS_LENGTH +                  \
                   CXL_MAILBOX_REGISTERS_LENGTH +                        \
                   CXL_MEMORY_DEVICE_REGISTERS_LENGTH +                  \
-                  CXL_NUM_CPMU_INSTANCES * (1 << 16),                   \
+                  CXL_NUM_CPMU_INSTANCES * (1 << 16) +                  \
+                  CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
                   (1 << 16))
 
 /* CXL r3.1 Table 8-34: Command Return Codes */
@@ -231,6 +240,7 @@ typedef struct CXLCCI {
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
     MemoryRegion cpmu_registers[CXL_NUM_CPMU_INSTANCES];
+    MemoryRegion chmu_registers[1];
     /* CXL r3.1 Section 8.2.8.3: Device Status Registers */
     struct {
         MemoryRegion device;
@@ -280,6 +290,7 @@ typedef struct cxl_device_state {
 
     const struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
+    CHMUState chmu[1];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index c54ed54a25..88a5e3958e 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -32,7 +32,7 @@
 #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
 #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
 
-#define REG_LOC_DVSEC_LENGTH 0x2c
+#define REG_LOC_DVSEC_LENGTH 0x34
 #define REG_LOC_DVSEC_REVID  0
 
 enum {
@@ -172,9 +172,9 @@ typedef struct CXLDVSECRegisterLocator {
     struct {
             uint32_t lo;
             uint32_t hi;
-    } reg_base[4];
+    } reg_base[5];
 } QEMU_PACKED CXLDVSECRegisterLocator;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x2C);
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x34);
 
 /* BAR Equivalence Indicator */
 #define BEI_BAR_10H 0
@@ -190,5 +190,6 @@ QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x2C);
 #define RBI_BAR_VIRT_ACL   (2 << 8)
 #define RBI_CXL_DEVICE_REG (3 << 8)
 #define RBI_CXL_CPMU_REG   (4 << 8)
+#define RBI_CXL_CHMU_REG   (5 << 8)
 
 #endif
diff --git a/hw/cxl/cxl-chmu.c b/hw/cxl/cxl-chmu.c
new file mode 100644
index 0000000000..5922d78ffc
--- /dev/null
+++ b/hw/cxl/cxl-chmu.c
@@ -0,0 +1,459 @@
+/*
+ * CXL Hotness Monitoring Unit
+ *
+ * Copyright(C) 2024 Huawei
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/guest-random.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_chmu.h"
+
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+
+#define CHMU_HOTLIST_LENGTH 1024
+
+enum chmu_consumer_request {
+    QUERY_TAIL,
+    QUERY_HEAD,
+    SET_HEAD,
+    SET_HOTLIST_SIZE,
+    QUERY_HOTLIST_ENTRY,
+    SIGNAL_EPOCH_END,
+    SET_ENABLED,
+    SET_NUMBER_GRANUALS,
+    SET_HPA_BASE,
+    SET_HPA_SIZE,
+};
+
+static int chmu_send(CHMUState *chmu, uint64_t instance,
+                     enum chmu_consumer_request command,
+                     uint64_t param, uint64_t *response)
+{
+    uint64_t request[3] = { instance, command, param };
+    uint64_t temp;
+    uint64_t *reply = response ?: &temp;
+    int rc;
+
+    send(chmu->socket, request, sizeof(request), 0);
+    rc = recv(chmu->socket, reply, sizeof(*reply), 0);
+    if (rc < sizeof(reply)) {
+        return -1;
+    }
+    return 0;
+}
+
+static uint64_t chmu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CHMUState *chmu = opaque;
+    CHMUInstance *chmui;
+    uint64_t val = 0;
+    hwaddr chmu_stride = A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0;
+    int instance = 0;
+    int rc;
+
+    if (offset >= A_CXL_CHMU0_CAP0) {
+        instance = (offset - A_CXL_CHMU0_CAP0) / chmu_stride;
+        /*
+         * Offset allows register defs for CHMU instance 0 to be used
+         * for all instances. Includes common cap.
+         */
+        offset -= chmu_stride * instance;
+    }
+
+    if (instance >= CXL_CHMU_INSTANCES_PER_BLOCK) {
+        return 0;
+    }
+
+    chmui = &chmu->inst[instance];
+    switch (offset) {
+    case A_CXL_CHMU_COMMON_CAP0:
+        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP0, VERSION, 1);
+        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP0, NUM_INSTANCES,
+                         CXL_CHMU_INSTANCES_PER_BLOCK);
+        break;
+    case A_CXL_CHMU_COMMON_CAP1:
+        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP1, INSTANCE_LENGTH,
+                         A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0);
+        break;
+    case A_CXL_CHMU0_CAP0:
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MSI_N, chmui->msi_n);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, OVERFLOW_INT, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, LEVEL_INT, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, EPOCH_TYPE,
+                         CXL_CHMU0_CAP0_EPOCH_TYPE_GLOBAL);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_R, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_W, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_RW, 1);
+        /* No emulation of TEE modes yet so don't pretend to support them */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_SCALE,
+                         CXL_CHMU_EPOCH_LENGTH_SCALE_1SEC);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_VAL, 100);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_SCALE,
+                         CXL_CHMU_EPOCH_LENGTH_SCALE_100MSEC);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_VAL, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, HOTLIST_SIZE,
+                         CXL_HOTLIST_ENTRIES);
+        break;
+    case A_CXL_CHMU0_CAP1:
+        /* 4KiB and 8KiB only */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, UNIT_SIZES, BIT(4) | BIT(5));
+        /* Only support downsamp by 32 */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, DOWN_SAMPLING_FACTORS, BIT(5));
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_EPOCH_BASED, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_ALWAYS_ON, 0);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_RANDOMIZED_DOWN_SAMPLING,
+                         1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_OVERLAPPING_ADDRESS_RANGES,
+                         1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_INSERT_AFTER_CLEAR, 0);
+        break;
+    case A_CXL_CHMU0_CAP2:
+        val = FIELD_DP64(val, CXL_CHMU0_CAP2, BITMAP_REG_OFFSET,
+                         A_CXL_CHMU0_RANGE_CONFIG_BITMAP0 - A_CXL_CHMU0_CAP0);
+        break;
+    case A_CXL_CHMU0_CAP3:
+        val = FIELD_DP64(val, CXL_CHMU0_CAP3, HOTLIST_REG_OFFSET,
+                         A_CXL_CHMU0_HOTLIST0 - A_CXL_CHMU0_CAP0);
+        break;
+    case A_CXL_CHMU0_STATUS:
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, STATUS_ENABLED,
+                         chmui->enabled ? 1 : 0);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, OPERATION_IN_PROG,
+                         chmui->op_in_prog);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, COUNTER_WIDTH, 16);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, OVERFLOW_INT,
+                         chmui->overflow_set ? 1 : 0);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, LEVEL_INT,
+                         chmui->fill_thresh_set ? 1 : 0);
+        break;
+    case A_CXL_CHMU0_TAIL:
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, QUERY_TAIL, 0, &val);
+            if (rc < 0) {
+                printf("Failed to read tail\n");
+                return 0;
+            }
+        } else {
+            val = chmui->tail;
+        }
+        break;
+    case A_CXL_CHMU0_HEAD:
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, QUERY_HEAD, 0, &val);
+            if (rc < 0) {
+                printf("Failed to read head\n");
+                return 0;
+            }
+        } else {
+            val = chmui->head;
+        }
+        break;
+    case A_CXL_CHMU0_HOTLIST0...(8 * (A_CXL_CHMU0_HOTLIST0 +
+                                      CHMU_HOTLIST_LENGTH)):
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, QUERY_HOTLIST_ENTRY,
+                           (offset - A_CXL_CHMU0_HOTLIST0) / 8, &val);
+            if (rc < 0) {
+                printf("Failed to read a hotlist entry\n");
+                return 0;
+            }
+        } else {
+            val = chmui->hotlist[(offset - A_CXL_CHMU0_HOTLIST0) / 8];
+        }
+        break;
+    }
+    return val;
+}
+
+static void chmu_write(void *opaque, hwaddr offset, uint64_t value,
+                       unsigned size)
+{
+    CHMUState *chmu = opaque;
+    CHMUInstance *chmui;
+    hwaddr chmu_stride = A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0;
+    int instance = 0;
+    int i, rc;
+
+    if (offset >= A_CXL_CHMU0_CAP0) {
+        instance = (offset - A_CXL_CHMU0_CAP0) / chmu_stride;
+        /* offset as if in chmu0 so includes the common caps */
+        offset -= chmu_stride * instance;
+    }
+    if (instance >= CXL_CHMU_INSTANCES_PER_BLOCK) {
+        return;
+    }
+
+    chmui = &chmu->inst[instance];
+
+    switch (offset) {
+    case A_CXL_CHMU0_STATUS:
+        /* The interrupt fields are RW12C */
+        if (FIELD_EX64(value, CXL_CHMU0_STATUS, OVERFLOW_INT)) {
+            chmui->overflow_set = false;
+        }
+        if (FIELD_EX64(value, CXL_CHMU0_STATUS, LEVEL_INT)) {
+            chmui->fill_thresh_set = false;
+        }
+        break;
+    case A_CXL_CHMU0_RANGE_CONFIG_BITMAP0...(A_CXL_CHMU0_HOTLIST0 - 8):
+        /* TODO - wire this up */
+        printf("Bitmap write %lx %lx\n",
+               offset - A_CXL_CHMU0_RANGE_CONFIG_BITMAP0, value);
+        break;
+    case A_CXL_CHMU0_CONF0:
+        if (FIELD_EX64(value, CXL_CHMU0_CONF0, CONTROL_ENABLE)) {
+            chmui->enabled = true;
+            timer_mod(chmui->timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + chmui->epoch_ms);
+        } else {
+            timer_del(chmui->timer);
+            chmui->enabled = false;
+        }
+        if (chmu->socket) {
+            bool enabled = FIELD_EX64(value, CXL_CHMU0_CONF0, CONTROL_ENABLE);
+
+            if (enabled) {
+                rc = chmu_send(chmu, instance, SET_HPA_BASE, chmu->base, NULL);
+                if (rc < 0) {
+                    printf("Failed to set base\n");
+                }
+                rc = chmu_send(chmu, instance, SET_HPA_SIZE, chmu->size, NULL);
+                if (rc < 0) {
+                    printf("Failed to set size\n");
+                }
+            }
+            rc = chmu_send(chmu, instance, SET_ENABLED, enabled ? 1 : 0, NULL);
+            if (rc < 0) {
+                printf("Failed to set enabled\n");
+            }
+        }
+
+        if (FIELD_EX64(value, CXL_CHMU0_CONF0, CONTROL_RESET)) {
+            /* TODO reset counters once implemented */
+            chmui->head = 0;
+            chmui->tail = 0;
+            for (i = 0; i < CXL_HOTLIST_ENTRIES; i++) {
+                chmui->hotlist[i] = 0;
+            }
+        }
+        chmui->what =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, M2S_REQ_TO_TRACK);
+        chmui->int_on_overflow =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, FLAGS_INT_ON_OVERFLOW);
+        chmui->int_on_fill_thresh =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, FLAGS_INT_ON_FILL_THRESH);
+        chmui->hotness_thresh =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, HOTNESS_THRESHOLD);
+        break;
+    case A_CXL_CHMU0_CONF1: {
+        uint8_t scale;
+        uint32_t mult;
+
+        chmui->unit_size = FIELD_EX64(value, CXL_CHMU0_CONF1, UNIT_SIZE);
+        chmui->ds_factor =
+            FIELD_EX64(value, CXL_CHMU0_CONF1, DOWN_SAMPLING_FACTOR);
+
+        /* TODO: Sanity check value in supported range */
+        scale = FIELD_EX64(value, CXL_CHMU0_CONF1, EPOCH_LENGTH_SCALE);
+        mult = FIELD_EX64(value, CXL_CHMU0_CONF1, EPOCH_LENGTH_VAL);
+        switch (scale) {
+            /* TODO: Implement maths, not lookup */
+        case 1: /* 100usec */
+            chmui->epoch_ms = mult / 10;
+            break;
+        case 2:
+            chmui->epoch_ms = mult;
+            break;
+        case 3:
+            chmui->epoch_ms = mult * 10;
+            break;
+        case 4:
+            chmui->epoch_ms = mult * 100;
+            break;
+        case 5:
+            chmui->epoch_ms = mult * 1000;
+            break;
+        default:
+            /* Unknown value so ignore */
+            break;
+        }
+        break;
+    }
+    case A_CXL_CHMU0_CONF2:
+        chmui->fillthresh = FIELD_EX64(value, CXL_CHMU0_CONF2,
+                                      NOTIFICATION_THRESHOLD);
+        break;
+    case A_CXL_CHMU0_HEAD:
+        chmui->head = value;
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, SET_HEAD, value, NULL);
+            if (rc < 0) {
+                printf("Failed to set head\n");
+            }
+        }
+        break;
+    case A_CXL_CHMU0_TAIL: /* Not sure why this is writeable! */
+        chmui->tail = value;
+        break;
+    }
+}
+
+static const MemoryRegionOps chmu_ops = {
+    .read = chmu_read,
+    .write = chmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static void chmu_timer_update(void *opaque)
+{
+    CHMUInstance *chmui = opaque;
+    PCIDevice *pdev = PCI_DEVICE(chmui->private);
+    int i;
+#define entries_to_add  167
+    bool interrupt_needed = false;
+    bool remote = chmui->parent->socket;
+
+    timer_del(chmui->timer);
+
+    /* This tick is the epoch. How to handle? */
+    if (remote) {
+        int rc;
+        uint64_t reply;
+        /* hack instance always 0! */
+        rc = chmu_send(chmui->parent, 0, SIGNAL_EPOCH_END, 0, &reply);
+        if (rc < 0) {
+            printf("Epoch signalling failed\n");
+        }
+
+        rc = chmu_send(chmui->parent, 0, QUERY_TAIL, 0, &reply);
+        if (rc < 0) {
+            printf("failed to read the tail\n");
+        }
+        chmui->tail = reply;
+        printf("after epoch tail is %x\n", chmui->tail);
+    } else { /* Fake some data if we don't have a real source */
+        uint8_t rand[entries_to_add];
+
+        qemu_guest_getrandom_nofail(rand, sizeof(rand));
+        for (i = 0; i < entries_to_add; i++) {
+            if ((chmui->tail + 1) % CXL_HOTLIST_ENTRIES == chmui->head) {
+                /* Overflow occured, drop out */
+                break;
+            }
+            chmui->hotlist[chmui->tail % CXL_HOTLIST_ENTRIES] =
+                (chmui->tail << 16) | (chmui->hotness_thresh + rand[i]);
+            chmui->tail++;
+            chmui->tail %= CXL_HOTLIST_ENTRIES;
+        }
+    }
+
+    /* All interrupt code is kept in here whatever the data source */
+    if (chmui->int_on_fill_thresh && !chmui->fill_thresh_set) {
+        if (((chmui->tail > chmui->head) &&
+             (chmui->tail - chmui->head > chmui->fillthresh)) |
+            ((chmui->tail < chmui->head) &&
+             (CXL_HOTLIST_ENTRIES - chmui->head + chmui->tail >
+              chmui->fillthresh))) {
+            chmui->fill_thresh_set = true;
+            interrupt_needed = true;
+        }
+    }
+    if (chmui->int_on_overflow && !chmui->overflow_set) {
+        if ((chmui->tail + 1) % CXL_HOTLIST_ENTRIES == chmui->head) {
+            chmui->overflow_set = true;
+            interrupt_needed = true;
+        }
+    }
+
+    if (interrupt_needed) {
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, chmui->msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, chmui->msi_n);
+        }
+    }
+
+    timer_mod(chmui->timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + chmui->epoch_ms);
+}
+
+int cxl_chmu_register_block_init(Object *obj,
+                                 CXLDeviceState *cxl_dstate,
+                                 int id, uint8_t msi_n,
+                                 Error **errp)
+{
+    CHMUState *chmu = &cxl_dstate->chmu[id];
+    MemoryRegion *registers = &cxl_dstate->chmu_registers[id];
+    g_autofree gchar *name = g_strdup_printf("chmu%d-registers", id);
+    struct sockaddr_in server_addr;
+    int i;
+
+    memory_region_init_io(registers, obj, &chmu_ops, chmu, name,
+                          pow2ceil(CXL_CHMU_SIZE));
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_CHMU_OFFSET(id), registers);
+
+    for (i = 0; i < CXL_CHMU_INSTANCES_PER_BLOCK; i++) {
+        CHMUInstance *chmui = &chmu->inst[i];
+
+        chmui->parent = chmu;/* hack */
+        chmui->private = obj;
+        chmui->msi_n = msi_n + i;
+        chmui->timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, chmu_timer_update,
+                                    chmui);
+    }
+
+    if (chmu->port) {
+        uint64_t helloval = 41;
+        chmu->socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+        if (chmu->socket < 0) {
+            error_setg(errp, "Failed to create a socket");
+            return -1;
+        }
+
+        memset((char *)&server_addr, 0, sizeof(server_addr));
+        server_addr.sin_family = AF_INET;
+        server_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+        server_addr.sin_port = htons(chmu->port);
+        if (connect(chmu->socket, (struct sockaddr *)&server_addr,
+                    sizeof(server_addr)) < 0) {
+            close(chmu->socket);
+            error_setg(errp, "Socket connect failed");
+            return -1;
+        }
+
+        send(chmu->socket, &helloval, sizeof(helloval), 0);
+        for (i = 0; i < CXL_CHMU_INSTANCES_PER_BLOCK; i++) {
+            int rc;
+            rc = chmu_send(chmu, i, SET_HOTLIST_SIZE,
+                           CHMU_HOTLIST_LENGTH, NULL);
+            if (rc) {
+                error_setg(errp, "Failed to set hotlist size");
+                return rc;
+            }
+
+            rc = chmu_send(chmu, i, SET_NUMBER_GRANUALS,
+                           cxl_dstate->static_mem_size / 4096, NULL);
+            if (rc) {
+                error_setg(errp, "Failed to set number of granuals");
+                return rc;
+            }
+        }
+    }
+    return 0;
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c1004ddae8..78426758af 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -38,7 +38,10 @@ enum CXL_T3_MSIX_VECTOR {
     CXL_T3_MSIX_CPMU0,
     CXL_T3_MSIX_CPMU1,
     CXL_T3_MSIX_PCIE_DOE_COMPLIANCE,
-    CXL_T3_MSIX_VECTOR_NR
+    CXL_T3_MSIX_CHMU0_BASE,
+    /* One interrupt per CMUH instance in the block */
+    CXL_T3_MSIX_VECTOR_NR =
+        CXL_T3_MSIX_CHMU0_BASE + CXL_CHMU_INSTANCES_PER_BLOCK,
 };
 
 #define DWORD_BYTE 4
@@ -499,6 +502,8 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             RBI_CXL_CPMU_REG | CXL_DEVICE_REG_BAR_IDX;
         regloc_dvsec->reg_base[2 + i].hi = 0;
     }
+    regloc_dvsec->reg_base[4].lo = CXL_CHMU_OFFSET(0) | RBI_CXL_CHMU_REG |
+        CXL_DEVICE_REG_BAR_IDX;
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
@@ -535,6 +540,17 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    if (which == 0) {
+        uint32_t low, high;
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI);
+        ct3d->cxl_dstate.chmu[0].base = ((uint64_t)high << 32) | (low & 0xf0000000);
+        
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI);
+        ct3d->cxl_dstate.chmu[0].size = ((uint64_t)high << 32) | (low & 0xf0000000);
+    }
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -1008,6 +1024,12 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                                  CXL_T3_MSIX_CPMU0);
     cxl_cpmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate, 1,
                                  CXL_T3_MSIX_CPMU1);
+    rc = cxl_chmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate,
+                                      0, CXL_T3_MSIX_CHMU0_BASE, errp);
+    if (rc) {
+        goto err_free_special_ops;
+    }
+
     pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
@@ -1317,6 +1339,7 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0), 
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 4db7cad267..c97e64b586 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-host.c',
                    'cxl-cdat.c',
                    'cxl-events.c',
+                   'cxl-chmu.c',
                    'cxl-cpmu.c',
                    'switch-mailbox-cci.c',
                ),
-- 
2.43.0

