Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9637C001B0
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Jul 2023 18:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGSScq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGSScm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Jul 2023 14:32:42 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C78B6
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 11:32:38 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so53613276.0
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791557; x=1690396357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZNO0lAS38XkkxRCJG38vZhvleKkSXD1W1EGlNTFzi0=;
        b=FwyxyfwUr5gOA738WI6fOV/88x+fPhoGOBrTexUy9nm/zDNuYc1d86UfARRShePJoI
         kDQWpM44BNxm+NyIQd7O6x1b9lFQW19b+nlubzJVuj3lAC83o+5k0YjjTxZPk0dhZdnK
         y7ithA3VVqGp92AYBemfDrBqfni8YG27PLNDZYVnFgOGdIhnVxdbizNLOfPo7SNHKkKW
         3Tjd3yiGIhbA5IjDBcnWpjqZWREMAMVkafoLHLB2f1buEsTHdzFYemrQUvDB9AV4g4I7
         dT9TBqdj/35Tn1YLT+P8tq4C4CA+EDK9cmhXBAPwmSwRnHe/AtwMhdqfy4FUPEcsMSwh
         JntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791557; x=1690396357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZNO0lAS38XkkxRCJG38vZhvleKkSXD1W1EGlNTFzi0=;
        b=hSZq/5+Q0eF+9di5imEnN+Y24U4WTCeFsMapt8SuMtiJktjEMl48opM8WRx8jQ9GJU
         SQYpHxT6GZhpR4uxqzJQ8bXHaPKvLPom4SCzZiI15tXngQwG9X4GOX8ZhLestPe0s4iT
         8EgtPv2rPk4/qnIMZos35zbVL3eJfo/RqhUyL1I1SJbo19y7lj+A47h+Aj8QfhrhvY7X
         YaMqWliUT/socD71Sif3+rkEnUfheSmiV9tQkVzfyVMmXPLxgYtHl5EsKf17SaqqtUYu
         L0F2rVKuST1Xx96u8hK0dGvb4tT0CG4dJF+33U1e7LtE9a4+tA4qb8xBbTEgNdf7z+vG
         bWBw==
X-Gm-Message-State: ABy/qLYw9EijIPfez4Ce4qjrkeBraErrFJbg/D7FB0XCIRkLw2c1SwPW
        nIY0VovGSaGJKkg4Ca6sX/x3WOo46ex3
X-Google-Smtp-Source: APBJJlEi7akNhCM3CYRV5xw0Zp3j+/QfKtdWXhZWOIxpeR376H/0vtRvBRppO6iC0Jl/tHxUM/Pi+Q==
X-Received: by 2002:a25:abec:0:b0:c75:593f:d4ab with SMTP id v99-20020a25abec000000b00c75593fd4abmr3309559ybi.22.1689791557375;
        Wed, 19 Jul 2023 11:32:37 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y80-20020a253253000000b00c4e1589475esm1005053yby.27.2023.07.19.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:32:36 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC] cxl/type3: minimum MHD cci support
Date:   Wed, 19 Jul 2023 14:32:19 -0400
Message-Id: <20230719183219.8093-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement the MHD GET_INFO cci command and add a shared memory
region to the type3 device to host the information.

Add a helper program to initialize this shared memory region.

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




Comments:

base repo: https://gitlab.com/jic23/qemu
base branch: cxl-2023-07-17

Originally I wanted to add this as a separate CCI, but I realized this
wouldn't work as intended because that would require a separate pci/cxl
device in /dev/ to tunnel messages though.  This is not how this will
present on real devices, so I went away from that.

Next I wanted to simply *dynamically* add the command to the existing
CCI in the type3 device, but these are statically defined in
cxl-mailbox.

I settled for simply adding the cci command to the type 3 device by
default, and checking for whether `is_mhd` is set in the command.

Ultimately, for MHD, they are likely to have a bunch of vendor specific
commands associated with them *and* a bunch of vendor specific state. It
would be nice to able to have something like "cci_add_command_set()" to
the cci-mailbox, and an interface to override certain type3 functions
such as read/write (but this is an exercise for a later patch set).

---
 hw/cxl/cxl-mailbox-utils.c  | 53 +++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 50 +++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 12 +++++++
 tools/cxl/cxl_mhd_init.c    | 63 +++++++++++++++++++++++++++++++++++++
 tools/cxl/meson.build       |  3 ++
 tools/meson.build           |  1 +
 6 files changed, 182 insertions(+)
 create mode 100644 tools/cxl/cxl_mhd_init.c
 create mode 100644 tools/cxl/meson.build

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2819914e8d..9ef4d7f5e0 100644
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
index efb7dece80..98282aabab 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -18,6 +18,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/spdm.h"
+#include <sys/shm.h>
 
 #define DWORD_BYTE 4
 
@@ -794,6 +795,45 @@ static DOEProtocol doe_spdm_prot[] = {
     { }
 };
 
+static bool cxl_setup_mhd(CXLType3Dev *ct3d, Error **errp)
+{
+    if (ct3d->is_mhd && (!ct3d->mhd_shmid || (ct3d->mhd_head == ~(0)))) {
+        error_setg(errp, "is_mhd requires a shared memory region (mhd_shmid) and mhd_head < 32");
+        return false;
+    } else if (!ct3d->is_mhd && (ct3d->mhd_shmid || (ct3d->mhd_head == ~(0)))) {
+        error_setg(errp, "(is_mhd,mhd_head,mhd_shmid) fields must be used together");
+        return false;
+    } else if (!ct3d->is_mhd) {
+        return true;
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
@@ -806,6 +846,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     QTAILQ_INIT(&ct3d->error_list);
 
+    if (!cxl_setup_mhd(ct3d, errp)) {
+        return;
+    }
+
     if (!cxl_setup_memory(ct3d, errp)) {
         return;
     }
@@ -910,6 +954,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     if (ct3d->hostvmem) {
         address_space_destroy(&ct3d->hostvmem_as);
     }
+    if (ct3d->mhd_state) {
+        shmdt(ct3d->mhd_state);
+    }
 }
 
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
@@ -1067,6 +1114,9 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_BOOL("is_mhd", CXLType3Dev, is_mhd, false),
+    DEFINE_PROP_UINT32("mhd_head", CXLType3Dev, mhd_head, 0),
+    DEFINE_PROP_UINT32("mhd_shmid", CXLType3Dev, mhd_shmid, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c68981b618..ebaa613c7b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -406,6 +406,12 @@ typedef struct CXLPoison {
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
@@ -440,6 +446,12 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    /* Multi-headed Device */
+    bool is_mhd;
+    uint32_t mhd_head;
+    uint32_t mhd_shmid;
+    struct CXLMHD_SharedState *mhd_state;
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

