Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3BC0015E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Jul 2023 16:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGUQjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjGUQjP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Jul 2023 12:39:15 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751249F6
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:37:36 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so2012534276.2
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689957452; x=1690562252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEhi5WEhD5/cGTeWcmoP4kJuwJqV6DWzWOMgRGMsmJ0=;
        b=OD0ZQxXeFs23cQ12bk3fVD5EJ7umB1jG5jnr2zV5lGIYTOpa8WHLl0XhspEY7+krrZ
         a2zWcyQZcaoG1I2GqJsmDjTxCVZ5Cdv7tcSCEDWw427YDy51gm71jdB6YUAkiT6p3AEY
         XaPx/9itwE/Mat9vyn3WbZBS+KvI0DGynWxQXTISM0K242+LOtIrzfVQ2Xpk8qlOyKcw
         86NzOpRfRFI1rJVqH5aY6QNCMC1XbqCHf/r+FGtTOAv+C3CUJZzQVoVosFVtwvz6MIhA
         GPbNEX+NeSwdADqr+jcQur2u9bkl04UbKsYwgX7UkDIJeFgPV99MCgG1hYKuaKRFqAGb
         oafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957452; x=1690562252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEhi5WEhD5/cGTeWcmoP4kJuwJqV6DWzWOMgRGMsmJ0=;
        b=ATPGb84ksX2gVrYs3JmBG9NIF/qgmXRj1Yl2MklhwAgVzUM7ZWNZLqjWvxlNgZrCLi
         hBb1Iwx81npIUaPUY2bFFEN1PhS321ChLZ49RN26/xWuyNt9b/6diitltDr4bHNnLg4i
         L+rZjGNe5sS1XrR9f63gB+xQU9SyF3WAwEZq1NoTcRV6awgwaXv1b6UgdL8IeJKl0vXI
         ELxv1U8/2ot3BQXT3OgUJ6mop7RNgIuPHm2iEV+VDIkqxsUcXF78EBpoGHO8CmuELyMq
         7AiA8FbAWSSwQo+nJd9/a8CZbWBtAn2hUzlJ6B+H2THWLl2GYpr5lV5rziCXkrzCb75F
         jwqQ==
X-Gm-Message-State: ABy/qLakqB8kpbqsLmldXLWR4HbcQzMs4b4E3pTg6nzAXMqgDluTV9Lu
        EEsgI5EL+AJV8clb+LT/Ew==
X-Google-Smtp-Source: APBJJlG1pBAOWr7nmiIumumAEa6emm/+LI1IjY01KIViMH13UYM4m9IofTnVUKq8l3MXA8hU43znlQ==
X-Received: by 2002:a5b:70f:0:b0:c7c:8095:a38e with SMTP id g15-20020a5b070f000000b00c7c8095a38emr2020803ybq.65.1689957451810;
        Fri, 21 Jul 2023 09:37:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:37:31 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 3/4] cxl/type3: minimum MHD cci support
Date:   Fri, 21 Jul 2023 12:35:08 -0400
Message-Id: <20230721163505.1910-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230721163505.1910-1-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement the MHD GET_INFO cci command and add a shared memory
region to the type3 device to host the information.

Add a helper program to initialize this shared memory region.

Add a function pointer to type3 devices for future work that
will allow an mhd device to provide a hook to validate whether
a memory access is valid or not.

For now, limit the number of LD's to the number of heads. Later,
this limitation will need to be lifted for MH-MLDs.

Intended use case:

1. Create the shared memory region
2. Format the shared memory region
3. Launch QEMU with `is_mhd=true,mhd_head=N,mhd_shmid=$shmid`

shmid=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
cxl_mhd_init 4 $shmid
qemu-system-x86_64 \
  -nographic \
  -accel kvm \
  -drive file=./mhd.qcow2,format=qcow2,index=0,media=disk,id=hd \
  -m 4G,slots=4,maxmem=8G \
  -smp 4 \
  -machine type=q35,cxl=on,hmat=on \
  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
  -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
  -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=4G,share=true \
  -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,sn=66666,is_mhd=true,mhd_head=0,mhd_shmid=$shmid \
  -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 53 +++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 67 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 14 ++++++++
 tools/cxl/cxl_mhd_init.c    | 63 ++++++++++++++++++++++++++++++++++
 tools/cxl/meson.build       |  3 ++
 tools/meson.build           |  1 +
 6 files changed, 201 insertions(+)
 create mode 100644 tools/cxl/cxl_mhd_init.c
 create mode 100644 tools/cxl/meson.build

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cad0cd0adb..57b8da4376 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,8 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
+    MHD = 0x55,
+        #define GET_MHD_INFO     0x0
 };
 
 /* CCI Message Format CXL r3.0 Figure 7-19 */
@@ -1155,6 +1157,56 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint8_t start_ld;
+        uint8_t ldmap_len;
+    } QEMU_PACKED *input = (void *)payload_in;
+
+    struct {
+        uint8_t nr_lds;
+        uint8_t nr_heads;
+        uint16_t resv1;
+        uint8_t start_ld;
+        uint8_t ldmap_len;
+        uint16_t resv2;
+        uint8_t ldmap[];
+    } QEMU_PACKED *output = (void *)payload_out;
+
+    uint8_t start_ld = input->start_ld;
+    uint8_t ldmap_len = input->ldmap_len;
+    uint8_t i;
+
+    if (!ct3d->is_mhd) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (start_ld >= ct3d->mhd_state->nr_lds) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->nr_lds = ct3d->mhd_state->nr_lds;
+    output->nr_heads = ct3d->mhd_state->nr_heads;
+    output->resv1 = 0;
+    output->start_ld = start_ld;
+    output->resv2 = 0;
+
+    for (i = 0; i < ldmap_len && (start_ld + i) < output->nr_lds; i++) {
+        output->ldmap[i] = ct3d->mhd_state->ldmap[start_ld + i];
+    }
+    output->ldmap_len = i;
+
+    *len_out = sizeof(*output) + output->ldmap_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1195,6 +1247,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index efb7dece80..c8eb3aa67d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -18,6 +18,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/spdm.h"
+#include <sys/shm.h>
 
 #define DWORD_BYTE 4
 
@@ -794,6 +795,48 @@ static DOEProtocol doe_spdm_prot[] = {
     { }
 };
 
+static bool cxl_setup_mhd(CXLType3Dev *ct3d, Error **errp)
+{
+    if (!ct3d->is_mhd) {
+        ct3d->mhd_access_valid = NULL;
+        return true;
+    } else if (ct3d->is_mhd &&
+               (!ct3d->mhd_shmid || (ct3d->mhd_head == ~(0)))) {
+        error_setg(errp, "is_mhd requires mhd_shmid and mhd_head settings");
+        return false;
+    } else if (!ct3d->is_mhd &&
+               (ct3d->mhd_shmid || (ct3d->mhd_head == ~(0)))) {
+        error_setg(errp, "(is_mhd,mhd_head,mhd_shmid) invalid");
+        return false;
+    }
+
+    if (ct3d->mhd_head >= 32) {
+        error_setg(errp, "MHD Head ID must be between 0-31");
+        return false;
+    }
+
+    ct3d->mhd_state = shmat(ct3d->mhd_shmid, NULL, 0);
+    if (ct3d->mhd_state == (void*)-1) {
+        ct3d->mhd_state = NULL;
+        error_setg(errp, "Unable to attach MHD State. Check ipcs is valid");
+        return false;
+    }
+
+    /* For now, limit the number of heads to the number of LD's (SLD) */
+    if (ct3d->mhd_state->nr_heads <= ct3d->mhd_head) {
+        error_setg(errp, "Invalid head ID for multiheaded device.");
+        return false;
+    }
+
+    if (ct3d->mhd_state->nr_lds <= ct3d->mhd_head) {
+        error_setg(errp, "MHD Shared state does not have sufficient lds.");
+        return false;
+    }
+
+    ct3d->mhd_state->ldmap[ct3d->mhd_head] = ct3d->mhd_head;
+    return true;
+}
+
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
@@ -806,6 +849,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     QTAILQ_INIT(&ct3d->error_list);
 
+    if (!cxl_setup_mhd(ct3d, errp)) {
+        return;
+    }
+
     if (!cxl_setup_memory(ct3d, errp)) {
         return;
     }
@@ -910,6 +957,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     if (ct3d->hostvmem) {
         address_space_destroy(&ct3d->hostvmem_as);
     }
+    if (ct3d->mhd_state) {
+        shmdt(ct3d->mhd_state);
+    }
 }
 
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
@@ -1006,6 +1056,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
@@ -1016,16 +1067,23 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (ct3d->is_mhd && ct3d->mhd_access_valid) {
+        if (!ct3d->mhd_access_valid(ct3d, dpa_offset, size))
+            return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&CXL_TYPE3(d)->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
+
     return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
@@ -1035,6 +1093,12 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
+
+    if (ct3d->is_mhd && ct3d->mhd_access_valid) {
+        if (!ct3d->mhd_access_valid(ct3d, dpa_offset, size))
+            return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&CXL_TYPE3(d)->cci)) {
         return MEMTX_OK;
     }
@@ -1067,6 +1131,9 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_BOOL("is_mhd", CXLType3Dev, is_mhd, false),
+    DEFINE_PROP_UINT32("mhd_head", CXLType3Dev, mhd_head, 0),
+    DEFINE_PROP_UINT32("mhd_shmid", CXLType3Dev, mhd_shmid, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index abc8405cc5..b545c5b6f3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -408,6 +408,12 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+struct CXLMHD_SharedState {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[];
+};
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -442,6 +448,14 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    /* Multi-headed Device */
+    bool is_mhd;
+    uint32_t mhd_head;
+    uint32_t mhd_shmid;
+    struct CXLMHD_SharedState *mhd_state;
+    bool (*mhd_access_valid)(CXLType3Dev* ct3d, uint64_t addr,
+                             unsigned int size);
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
diff --git a/tools/cxl/cxl_mhd_init.c b/tools/cxl/cxl_mhd_init.c
new file mode 100644
index 0000000000..1303aa9494
--- /dev/null
+++ b/tools/cxl/cxl_mhd_init.c
@@ -0,0 +1,63 @@
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+struct mhd_state {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[];
+};
+
+int main(int argc, char *argv[]) {
+    int shmid = 0;
+    uint32_t heads = 0;
+    struct mhd_state* mhd_state = 0;
+    uint8_t i;
+
+    if (argc != 3) {
+        printf("usage: cxl_mhd_init <heads> <shmid>\n"
+                "\theads         : number of heads on the device\n"
+                "\tshmid         : /tmp/mytoken.tmp\n");
+        return -1;
+    }
+
+    // must have at least 1 head
+    heads = (uint32_t)atoi(argv[1]);
+    if (heads == 0 || heads > 32) {
+        printf("bad heads argument (1-32)\n");
+        return -1;
+    }
+
+    shmid = (uint32_t)atoi(argv[2]);
+    if (shmid== 0) {
+        printf("bad shmid argument\n");
+        return -1;
+    }
+
+    mhd_state = shmat(shmid, NULL, 0);
+    if (mhd_state == (void*)-1) {
+        printf("Unable to attach to shared memory\n");
+        return -1;
+    }
+
+    // Initialize the mhd_state
+    size_t mhd_state_size = sizeof(struct mhd_state) + (sizeof(uint8_t) * heads);
+    memset(mhd_state, 0, mhd_state_size);
+    mhd_state->nr_heads = heads;
+    mhd_state->nr_lds = heads;
+
+    // Head ID == LD ID for now
+    for (i = 0; i < heads; i++)
+        mhd_state->ldmap[i] = i;
+
+    printf("mhd initialized\n");
+    shmdt(mhd_state);
+    return 0;
+}
diff --git a/tools/cxl/meson.build b/tools/cxl/meson.build
new file mode 100644
index 0000000000..218658fe69
--- /dev/null
+++ b/tools/cxl/meson.build
@@ -0,0 +1,3 @@
+executable('cxl_mhd_init', files('cxl_mhd_init.c'),
+  install: true,
+  install_dir: get_option('libexecdir'))
diff --git a/tools/meson.build b/tools/meson.build
index e69de29bb2..91a1d788cb 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -0,0 +1 @@
+subdir('cxl')
-- 
2.39.1

