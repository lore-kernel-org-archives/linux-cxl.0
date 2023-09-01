Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D08CA0FE1
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 01:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348044AbjIAB3f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjIAB3e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Aug 2023 21:29:34 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E7E7A
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:29 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-58fc4eaa04fso16709767b3.0
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693531768; x=1694136568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK5oCagi08FeMUCQGqHJSgI0tQXilWJNHtFPW2LWiQk=;
        b=RuY3kxOWXQce6lGc5C06mxRkfn2/GVBFcN7TKaedb5+Z7h8OZhr+h/+Nj1KZcSd668
         yKeMcQLmghYghfyJdWhupYofUxjJXAjStkuFfPS3WU9q51iRZldiHCunst6PxXjDNDk6
         bxhP73SvGuym98wc5yZH1w3sJ66cri+xXt5rcA4yAGVJvm1lzpI5dvAFugI7USOD8dkJ
         xxLn1TBohQpf1YmK8ROqzsu0O6hNfAL+nQs/KjvBX3qEJEHWBFlwDbyo4XKprW/l1C02
         dClvAXOJ6+YOBwlZW7YFGBbgVINRwhO0MafsAZhLfuGioCt7B5mKOJ7RGzYQ5LYR2/jn
         pfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693531768; x=1694136568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK5oCagi08FeMUCQGqHJSgI0tQXilWJNHtFPW2LWiQk=;
        b=bu70ZXs5enNL4dDLlMosrBFd2NwXjJGNvaCHMU/g/H892cd/KH/tjBA7FAcgftzKyR
         9r9Qz17oUYQFES8JXJKXFcetFzJFeNbmoHu6P+cT3pVeOWqFjtLWGvOyNiSNLyvrouRX
         D2e2M4bjSQsEXpJ8QFc79/JP2gJAqpRHjMVdeyt8MK9upSwxfXKIf6VWKuczvjhKDXz4
         JmfQcHGssZzbQ3rC+uctAHPBYdk+fWj5nze+Fogp7wDZzKXILpkC+4v9ttB8nype3EHo
         QKNnsui5lS9TFqUGr9ZmDj4aY81wtO51K48v60DqrboNp09cHu6NSIM8kW5fXkL+3vr+
         nCXQ==
X-Gm-Message-State: AOJu0Yyr1/YW9Sf+L9oapCZYBvFx5eB1GY4aejZTNXS3fp9xWSnLM/HB
        LfylSqS9woMtgYu8keQX8w==
X-Google-Smtp-Source: AGHT+IFd14c2McmsazKq09dhOXm8Jz7l2aXJZNBHBtp257E18bLPdySiF2Ep/P0lolSJg1FbBCX1bg==
X-Received: by 2002:a0d:f342:0:b0:58c:4e9f:4ed4 with SMTP id c63-20020a0df342000000b0058c4e9f4ed4mr1086176ywf.42.1693531768598;
        Thu, 31 Aug 2023 18:29:28 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 18:29:28 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 5/5] cxl/vendor: SK hynix Niagara Multi-Headed SLD Device
Date:   Thu, 31 Aug 2023 21:29:14 -0400
Message-Id: <20230901012914.226527-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Create a new device to emulate the SK hynix Niagara MHSLD platform.

This device has custom CCI commands that allow for applying isolation
to each memory block between hosts. This enables an early form of
dynamic capacity, whereby the NUMA node maps the entire region, but
the host is responsible for asking the device which memory blocks
are allocated to it, and therefore may be onlined.

To instantiate:

-device cxl-skh-niagara,cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,sn=66666,mhd-head=0,mhd-shmid=0

The linux kernel will require raw CXL commands enabled to allow for
passing through of Niagara CXL commands via the CCI mailbox.

The Niagara MH-SLD has a shared memory region that must be initialized
using the 'init_niagara' tool located in the vendor subdirectory

usage: init_niagara <heads> <sections> <section_size> <shmid>
        heads         : number of heads on the device
        sections      : number of sections
        section_size  : size of a section in 128mb increments
        shmid         : shmid produced by ipcmk

Example:
$shmid1=ipcmk -M 131072
./init_niagara 4 32 1 $shmid1

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Junhee Ryu <junhee.ryu@sk.com>
Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
---
 hw/cxl/Kconfig                          |   4 +
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 516 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 169 ++++++++
 8 files changed, 793 insertions(+)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index c9b2e46bac..dd6c54b54d 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -2,5 +2,9 @@ config CXL
     bool
     default y if PCI_EXPRESS
 
+config CXL_VENDOR
+    bool
+    default y
+
 config I2C_MCTP_CXL
     bool
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 1393821fc4..e8c8c1355a 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -15,3 +15,5 @@ system_ss.add(when: 'CONFIG_CXL',
 system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
+
+subdir('vendor')
diff --git a/hw/cxl/vendor/meson.build b/hw/cxl/vendor/meson.build
new file mode 100644
index 0000000000..12db8991f1
--- /dev/null
+++ b/hw/cxl/vendor/meson.build
@@ -0,0 +1 @@
+subdir('skhynix')
diff --git a/hw/cxl/vendor/skhynix/.gitignore b/hw/cxl/vendor/skhynix/.gitignore
new file mode 100644
index 0000000000..6d96de38ea
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/.gitignore
@@ -0,0 +1 @@
+init_niagara
diff --git a/hw/cxl/vendor/skhynix/init_niagara.c b/hw/cxl/vendor/skhynix/init_niagara.c
new file mode 100644
index 0000000000..2c189dc33c
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/init_niagara.c
@@ -0,0 +1,99 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2023 MemVerge Inc.
+ * Copyright (c) 2023 SK hynix Inc.
+ *
+ */
+
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
+struct niagara_state {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[65536];
+    uint32_t total_sections;
+    uint32_t free_sections;
+    uint32_t section_size;
+    uint32_t sections[];
+};
+
+int main(int argc, char *argv[])
+{
+    int shmid = 0;
+    uint32_t sections = 0;
+    uint32_t section_size = 0;
+    uint32_t heads = 0;
+    struct niagara_state *niagara_state = NULL;
+    size_t state_size;
+    uint8_t i;
+
+    if (argc != 5) {
+        printf("usage: init_niagara <heads> <sections> <section_size> <shmid>\n"
+                "\theads         : number of heads on the device\n"
+                "\tsections      : number of sections\n"
+                "\tsection_size  : size of a section in 128mb increments\n"
+                "\tshmid         : /tmp/mytoken.tmp\n\n"
+                "It is recommended your shared memory region is at least 128kb\n");
+        return -1;
+    }
+
+    /* must have at least 1 head */
+    heads = (uint32_t)atoi(argv[1]);
+    if (heads == 0 || heads > 32) {
+        printf("bad heads argument (1-32)\n");
+        return -1;
+    }
+
+    /* Get number of sections */
+    sections = (uint32_t)atoi(argv[2]);
+    if (sections == 0) {
+        printf("bad sections argument\n");
+        return -1;
+    }
+
+    section_size = (uint32_t)atoi(argv[3]);
+    if (sections == 0) {
+        printf("bad section size argument\n");
+        return -1;
+    }
+
+    shmid = (uint32_t)atoi(argv[4]);
+    if (shmid == 0) {
+        printf("bad shmid argument\n");
+        return -1;
+    }
+
+    niagara_state = shmat(shmid, NULL, 0);
+    if (niagara_state == (void *)-1) {
+        printf("Unable to attach to shared memory\n");
+        return -1;
+    }
+
+    /* Initialize the niagara_state */
+    state_size = sizeof(struct niagara_state) + (sizeof(uint32_t) * sections);
+    memset(niagara_state, 0, state_size);
+    niagara_state->nr_heads = heads;
+    niagara_state->nr_lds = heads;
+    niagara_state->total_sections = sections;
+    niagara_state->free_sections = sections;
+    niagara_state->section_size = section_size;
+
+    memset(&niagara_state->ldmap, '\xff', sizeof(niagara_state->ldmap));
+    for (i = 0; i < heads; i++) {
+        niagara_state->ldmap[i] = i;
+    }
+
+    printf("niagara initialized\n");
+    shmdt(niagara_state);
+    return 0;
+}
diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
new file mode 100644
index 0000000000..4e57db65f1
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/meson.build
@@ -0,0 +1 @@
+system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
new file mode 100644
index 0000000000..88e53cc6cc
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c
@@ -0,0 +1,516 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2023 MemVerge Inc.
+ * Copyright (c) 2023 SK hynix Inc.
+ */
+
+#include <sys/shm.h>
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "skhynix_niagara.h"
+
+#define TYPE_CXL_NIAGARA "cxl-skh-niagara"
+OBJECT_DECLARE_TYPE(CXLNiagaraState, CXLNiagaraClass, CXL_NIAGARA)
+
+/*
+ * CXL r3.0 section 7.6.7.5.1 - Get Multi-Headed Info (Opcode 5500h)
+ *
+ * This command retrieves the number of heads, number of supported LDs,
+ * and Head-to-LD mapping of a Multi-Headed device.
+ */
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLCCI * cci)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
+    NiagaraMHDGetInfoInput *input = (void *)payload_in;
+    NiagaraMHDGetInfoOutput *output = (void *)payload_out;
+
+    uint8_t start_ld = input->start_ld;
+    uint8_t ldmap_len = input->ldmap_len;
+    uint8_t i;
+
+    if (start_ld >= s->mhd_state->nr_lds) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->nr_lds = s->mhd_state->nr_lds;
+    output->nr_heads = s->mhd_state->nr_heads;
+    output->resv1 = 0;
+    output->start_ld = start_ld;
+    output->resv2 = 0;
+
+    for (i = 0; i < ldmap_len && (start_ld + i) < output->nr_lds; i++) {
+        output->ldmap[i] = s->mhd_state->ldmap[start_ld + i];
+    }
+    output->ldmap_len = i;
+
+    *len_out = sizeof(*output) + output->ldmap_len;
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_niagara_get_section_status(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len_in,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
+    NiagaraSharedState *nss = (NiagaraSharedState *)s->mhd_state;
+    NiagaraGetSectionStatusOutput *output = (void *)payload_out;
+
+    output->total_section_count = nss->total_sections;
+    output->free_section_count = nss->free_sections;
+
+    *len_out = sizeof(*output);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static bool niagara_claim_section(CXLNiagaraState *s,
+                                  uint32_t *sections,
+                                  uint32_t section_idx)
+{
+    uint32_t *section = &sections[section_idx];
+    uint32_t old_value = __sync_fetch_and_or(section, (1 << s->mhd_head));
+
+    /* if we already owned the section, we haven't claimed it */
+    if (old_value & (1 << s->mhd_head)) {
+        return false;
+    }
+
+    /* if the old value wasn't 0, this section was already claimed */
+    if (old_value != 0) {
+        __sync_fetch_and_and(section, ~(1 << s->mhd_head));
+        return false;
+    }
+    return true;
+}
+
+static void niagara_release_sections(CXLNiagaraState *s,
+                                     uint32_t *section_ids,
+                                     uint32_t count)
+{
+    NiagaraSharedState *nss = s->mhd_state;
+    uint32_t *sections = &nss->sections[0];
+    uint32_t section;
+    uint32_t old_val;
+    uint32_t i;
+
+    /* free any successfully allocated sections */
+    for (i = 0; i < count; i++) {
+        section = section_ids[i];
+        old_val = __sync_fetch_and_and(&sections[section], ~(1 << s->mhd_head));
+
+        if (old_val & (1 << s->mhd_head)) {
+            __sync_fetch_and_add(&nss->free_sections, 1);
+        }
+    }
+}
+
+static void niagara_alloc_build_output(NiagaraAllocOutput *output,
+                                       size_t *len_out,
+                                       uint32_t *section_ids,
+                                       uint32_t section_count)
+{
+    uint32_t extents;
+    uint32_t previous;
+    uint32_t i;
+
+    /* Build the output */
+    output->section_count = section_count;
+    extents = 0;
+    previous = 0;
+    for (i = 0; i < section_count; i++) {
+        if (i == 0) {
+            /* start the first extent */
+            output->extents[extents].start_section_id = section_ids[i];
+            output->extents[extents].section_count = 1;
+            extents++;
+        } else if (section_ids[i] == (previous + 1)) {
+            /* increment the current extent */
+            output->extents[extents - 1].section_count++;
+        } else {
+            /* start a new extent */
+            output->extents[extents].start_section_id = section_ids[i];
+            output->extents[extents].section_count = 1;
+            extents++;
+        }
+        previous = section_ids[i];
+    }
+    output->extent_count = extents;
+    *len_out = (8 + (16 * extents));
+    return;
+}
+
+static CXLRetCode niagara_alloc_manual(CXLNiagaraState *s,
+                                       NiagaraAllocInput *input,
+                                       NiagaraAllocOutput *output,
+                                       size_t *len_out)
+{
+    NiagaraSharedState *nss = s->mhd_state;
+    uint32_t cur_extent = 0;
+    g_autofree uint32_t *section_ids = NULL;
+    uint32_t *sections;
+    uint32_t allocated;
+    uint32_t i = 0;
+    uint32_t ttl_sec = 0;
+
+    /* input validation: iterate extents, count total sectios */
+    for (i = 0; i < input->extent_count; i++) {
+        uint32_t start = input->extents[i].start_section_id;
+        uint32_t end = start + input->extents[i].section_count;
+
+        if ((start >= nss->total_sections) ||
+            (end > nss->total_sections)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        ttl_sec += input->extents[i].section_count;
+    }
+
+    if (ttl_sec != input->section_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    section_ids = malloc(input->section_count * sizeof(uint32_t));
+    sections = &nss->sections[0];
+    allocated = 0;
+
+    /* for each section requested in the input, try to allocate that section */
+    for (cur_extent = 0; cur_extent < input->extent_count; cur_extent++) {
+        uint32_t start_section = input->extents[cur_extent].start_section_id;
+        uint32_t section_count = input->extents[cur_extent].section_count;
+        uint32_t cur_section;
+
+        for (cur_section = input->extents[cur_extent].start_section_id;
+             cur_section < start_section + section_count;
+             cur_section++) {
+            if (niagara_claim_section(s, sections, cur_section)) {
+                __sync_fetch_and_sub(&nss->free_sections, 1);
+                section_ids[allocated++] = cur_section;
+            }
+        }
+    }
+
+    if ((input->policy & NIAGARA_SECTION_ALLOC_POLICY_ALL_OR_NOTHING) &&
+        (allocated != input->section_count)) {
+        niagara_release_sections(s, section_ids, allocated);
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    niagara_alloc_build_output(output, len_out, section_ids, allocated);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode niagara_alloc_auto(CXLNiagaraState *s,
+                                     NiagaraAllocInput *input,
+                                     NiagaraAllocOutput *output,
+                                     size_t *len_out)
+{
+    NiagaraSharedState *nss = s->mhd_state;
+    g_autofree uint32_t *section_ids = NULL;
+    uint32_t section_count = input->section_count;
+    uint32_t total_sections = nss->total_sections;
+    uint32_t *sections = &nss->sections[0];
+    uint32_t allocated = 0;
+    uint32_t cur_section;
+
+    section_ids = malloc(section_count * sizeof(uint32_t));
+
+    /* Iterate the the section list and allocate free sections */
+    for (cur_section = 0;
+         (cur_section < total_sections) && (allocated != section_count);
+         cur_section++) {
+        if (niagara_claim_section(s, sections, cur_section)) {
+            __sync_fetch_and_sub(&nss->free_sections, 1);
+            section_ids[allocated++] = cur_section;
+        }
+    }
+
+    if ((input->policy & NIAGARA_SECTION_ALLOC_POLICY_ALL_OR_NOTHING) &&
+        (allocated != input->section_count)) {
+        niagara_release_sections(s, section_ids, allocated);
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    niagara_alloc_build_output(output, len_out, section_ids, allocated);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_niagara_set_section_alloc(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
+    NiagaraAllocInput *input = (void *)payload_in;
+    NiagaraAllocOutput *output = (void *)payload_out;
+
+    if (input->section_count == 0 ||
+        input->section_count > s->mhd_state->total_sections) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (input->policy & NIAGARA_SECTION_ALLOC_POLICY_MANUAL) {
+        return niagara_alloc_manual(s, input, output, len_out);
+    }
+
+    return niagara_alloc_auto(s, input, output, len_out);
+}
+
+static CXLRetCode cmd_niagara_set_section_release(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
+    NiagaraSharedState *nss = s->mhd_state;
+    NiagaraReleaseInput *input = (void *)payload_in;
+    uint32_t i, j;
+    uint32_t *sections = &nss->sections[0];
+
+    for (i = 0; i < input->extent_count; i++) {
+        uint32_t start = input->extents[i].start_section_id;
+
+        for (j = 0; j < input->extents[i].section_count; j++) {
+            uint32_t *cur_section = &sections[start + j];
+            uint32_t hbit = 1 << s->mhd_head;
+            uint32_t old_val = __sync_fetch_and_and(cur_section, ~hbit);
+
+            if (old_val & hbit) {
+                __sync_fetch_and_add(&nss->free_sections, 1);
+            }
+        }
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_niagara_set_section_size(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
+    NiagaraSharedState *nss = s->mhd_state;
+    NiagaraSetSectionSizeInput *input = (void *)payload_in;
+    NiagaraSetSectionSizeOutput *output = (void *)payload_out;
+    uint32_t prev_size = nss->section_size;
+    uint32_t prev_ttl = nss->total_sections;
+
+    /* Only allow size change if all sections are free */
+    if (nss->free_sections != nss->total_sections) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    if (nss->section_size != (1 << (input->section_unit - 1))) {
+        nss->section_size = (1 << (input->section_unit - 1));
+        nss->total_sections = (prev_size * prev_ttl) / nss->section_size;
+        nss->free_sections = nss->total_sections;
+    }
+
+    output->section_unit = input->section_unit;
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_niagara_get_section_map(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
+    NiagaraSharedState *nss = s->mhd_state;
+    NiagaraGetSectionMapInput *input = (void *)payload_in;
+    NiagaraGetSectionMapOutput *output = (void *)payload_out;
+    uint32_t *sections = &nss->sections[0];
+    uint8_t query_type = input->query_type;
+    uint32_t i;
+    uint32_t bytes;
+
+    if ((query_type != NIAGARA_GSM_QUERY_FREE) &&
+        (query_type != NIAGARA_GSM_QUERY_ALLOCATED)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->ttl_section_count = nss->total_sections;
+    output->qry_section_count = 0;
+    bytes = (output->ttl_section_count / 8);
+    if (output->ttl_section_count % 8) {
+        bytes += 1;
+    }
+
+    for (i = 0; i < bytes; i++) {
+        output->bitset[i] = 0x0;
+    }
+
+    /* Iterate the the section list and check the bits */
+    for (i = 0; (i < nss->total_sections); i++) {
+        uint32_t section = sections[i];
+
+        if (((query_type == NIAGARA_GSM_QUERY_FREE) && (!section)) ||
+            ((query_type == NIAGARA_GSM_QUERY_ALLOCATED) &&
+             (section & (1 << s->mhd_head)))) {
+            uint32_t byte = i / 8;
+            uint8_t bit = (1 << (i % 8));
+
+            output->bitset[byte] |= bit;
+            output->qry_section_count++;
+        }
+    }
+
+    *len_out = (8 + bytes);
+    return CXL_MBOX_SUCCESS;
+}
+
+static bool mhdsld_access_valid(PCIDevice *d,
+                                uint64_t dpa_offset,
+                                unsigned int size)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(d);
+    NiagaraSharedState *nss = s->mhd_state;
+    uint32_t section = (dpa_offset / NIAGARA_MIN_MEMBLK);
+
+    if (!(nss->sections[section] & (1 << s->mhd_head))) {
+        return false;
+    }
+    return true;
+}
+
+static const struct cxl_cmd cxl_cmd_set_niagara[256][256] = {
+    [NIAGARA_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
+        cmd_mhd_get_info, 2, 0},
+    [NIAGARA_CMD][GET_SECTION_STATUS] = { "GET_SECTION_STATUS",
+        cmd_niagara_get_section_status, 0, 0 },
+    [NIAGARA_CMD][SET_SECTION_ALLOC] = { "SET_SECTION_ALLOC",
+        cmd_niagara_set_section_alloc, ~0,
+        (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_IMMEDIATE_POLICY_CHANGE | CXL_MBOX_IMMEDIATE_LOG_CHANGE)
+    },
+    [NIAGARA_CMD][SET_SECTION_RELEASE] = { "SET_SECTION_RELEASE",
+        cmd_niagara_set_section_release, ~0,
+        (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_IMMEDIATE_POLICY_CHANGE | CXL_MBOX_IMMEDIATE_LOG_CHANGE)
+    },
+    [NIAGARA_CMD][SET_SECTION_SIZE] = { "SET_SECTION_SIZE",
+        cmd_niagara_set_section_size, 8,
+        (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_IMMEDIATE_POLICY_CHANGE | CXL_MBOX_IMMEDIATE_LOG_CHANGE)
+    },
+    [NIAGARA_CMD][GET_SECTION_MAP] = { "GET_SECTION_MAP",
+        cmd_niagara_get_section_map, 8 , CXL_MBOX_IMMEDIATE_DATA_CHANGE },
+};
+
+static Property cxl_niagara_props[] = {
+    DEFINE_PROP_UINT32("mhd-head", CXLNiagaraState, mhd_head, ~(0)),
+    DEFINE_PROP_UINT32("mhd-shmid", CXLNiagaraState, mhd_shmid, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cxl_niagara_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(pci_dev);
+
+    ct3_realize(pci_dev, errp);
+
+    if (!s->mhd_shmid || s->mhd_head == ~(0)) {
+        error_setg(errp, "is_mhd requires mhd_shmid and mhd_head settings");
+        return;
+    }
+
+    if (s->mhd_head >= 32) {
+        error_setg(errp, "MHD Head ID must be between 0-31");
+        return;
+    }
+
+    s->mhd_state = shmat(s->mhd_shmid, NULL, 0);
+    if (s->mhd_state == (void *)-1) {
+        s->mhd_state = NULL;
+        error_setg(errp, "Unable to attach MHD State. Check ipcs is valid");
+        return;
+    }
+
+    /* For now, limit the number of LDs to the number of heads (SLD) */
+    if (s->mhd_head >= s->mhd_state->nr_heads) {
+        error_setg(errp, "Invalid head ID for multiheaded device.");
+        return;
+    }
+
+    if (s->mhd_state->nr_lds <= s->mhd_head) {
+        error_setg(errp, "MHD Shared state does not have sufficient lds.");
+        return;
+    }
+
+    s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
+    s->ct3d.mhd_access_valid = mhdsld_access_valid;
+    return;
+}
+
+static void cxl_niagara_exit(PCIDevice *pci_dev)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(pci_dev);
+
+    ct3_exit(pci_dev);
+
+    if (s->mhd_state) {
+        shmdt(s->mhd_state);
+    }
+}
+
+static void cxl_niagara_reset(DeviceState *d)
+{
+    CXLNiagaraState *s = CXL_NIAGARA(d);
+
+    ct3d_reset(d);
+    cxl_add_cci_commands(&s->ct3d.cci, cxl_cmd_set_niagara, 512);
+}
+
+static void cxl_niagara_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = cxl_niagara_realize;
+    pc->exit = cxl_niagara_exit;
+    dc->reset = cxl_niagara_reset;
+    device_class_set_props(dc, cxl_niagara_props);
+}
+
+static const TypeInfo cxl_niagara_info = {
+    .name = TYPE_CXL_NIAGARA,
+    .parent = TYPE_CXL_TYPE3,
+    .class_size = sizeof(struct CXLNiagaraClass),
+    .class_init = cxl_niagara_class_init,
+    .instance_size = sizeof(CXLNiagaraState),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void cxl_niagara_register_types(void)
+{
+    type_register_static(&cxl_niagara_info);
+}
+
+type_init(cxl_niagara_register_types)
diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.h b/hw/cxl/vendor/skhynix/skhynix_niagara.h
new file mode 100644
index 0000000000..0489102f38
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/skhynix_niagara.h
@@ -0,0 +1,169 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2023 MemVerge Inc.
+ * Copyright (c) 2023 SK hynix Inc.
+ */
+
+#ifndef CXL_SKH_NIAGARA_H
+#define CXL_SKH_NIAGARA_H
+#include <stdint.h>
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+
+#define NIAGARA_MIN_MEMBLK (1024 * 1024 * 128)
+
+/*
+ * The shared state cannot have 2 variable sized regions
+ * so we have to max out the ldmap.
+ */
+typedef struct NiagaraSharedState {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[65536];
+    uint32_t total_sections;
+    uint32_t free_sections;
+    uint32_t section_size;
+    uint32_t sections[];
+} NiagaraSharedState;
+
+struct CXLNiagaraState {
+    CXLType3Dev ct3d;
+    uint32_t mhd_head;
+    uint32_t mhd_shmid;
+    NiagaraSharedState *mhd_state;
+};
+
+struct CXLNiagaraClass {
+    CXLType3Class parent_class;
+};
+
+enum {
+    NIAGARA_MHD = 0x55,
+        #define GET_MHD_INFO 0x0
+    NIAGARA_CMD = 0xC0
+        #define GET_SECTION_STATUS 0x0
+        #define SET_SECTION_ALLOC 0x1
+        #define SET_SECTION_RELEASE 0x2
+        #define SET_SECTION_SIZE 0x3
+        /* Future: MOVE_DATA 0x4 */
+        #define GET_SECTION_MAP 0x5
+        /* Future: CLEAR_SECTION 0x99 */
+};
+
+typedef struct NiagaraExtent {
+    uint32_t start_section_id;
+    uint32_t section_count;
+    uint8_t reserved[8];
+} QEMU_PACKED NiagaraExtent;
+
+/*
+ * MHD Get Info Command
+ * Returns information the LD's associated with this head
+ */
+typedef struct NiagaraMHDGetInfoInput {
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+} QEMU_PACKED NiagaraMHDGetInfoInput;
+
+typedef struct NiagaraMHDGetInfoOutput {
+    uint8_t nr_lds;
+    uint8_t nr_heads;
+    uint16_t resv1;
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+    uint16_t resv2;
+    uint8_t ldmap[];
+} QEMU_PACKED NiagaraMHDGetInfoOutput;
+
+/*
+ * Niagara Section Status Command
+ *
+ * Returns the total sections and number of free sections
+ */
+typedef struct NiagaraGetSectionStatusOutput {
+    uint32_t total_section_count;
+    uint32_t free_section_count;
+} QEMU_PACKED NiagaraGetSectionStatusOutput;
+
+/*
+ * Niagara Set Section Alloc Command
+ *
+ * Policies:
+ *    All or nothing - if fail to allocate any section, nothing is allocated
+ *    Best effort - Allocate as many as possible
+ *    Manual - allocate the provided set of extents
+ *
+ * Policies can be combined.
+ *
+ * Returns: The allocated sections in extents
+ */
+#define NIAGARA_SECTION_ALLOC_POLICY_ALL_OR_NOTHING 0
+#define NIAGARA_SECTION_ALLOC_POLICY_BEST_EFFORT 1
+#define NIAGARA_SECTION_ALLOC_POLICY_MANUAL 2
+
+typedef struct NiagaraAllocInput {
+    uint8_t policy;
+    uint8_t reserved1[3];
+    uint32_t section_count;
+    uint8_t reserved2[4];
+    uint32_t extent_count;
+    NiagaraExtent extents[];
+} QEMU_PACKED NiagaraAllocInput;
+
+typedef struct NiagaraAllocOutput {
+    uint32_t section_count;
+    uint32_t extent_count;
+    NiagaraExtent extents[];
+} QEMU_PACKED NiagaraAllocOutput;
+
+/*
+ * Niagara Set Section Release Command
+ *
+ * Releases the provided extents
+ */
+typedef struct NiagaraReleaseInput {
+    uint32_t extent_count;
+    uint8_t policy;
+    uint8_t reserved[3];
+    NiagaraExtent extents[];
+} QEMU_PACKED NiagaraReleaseInput;
+
+/*
+ * Niagara Set Section Size
+ *
+ * Changes the section size to 128 * (1 << section_unit)
+ */
+typedef struct NiagaraSetSectionSizeInput {
+    uint8_t section_unit;
+    uint8_t reserved[7];
+} QEMU_PACKED NiagaraSetSectionSizeInput;
+
+typedef struct {
+    uint8_t section_unit;
+    uint8_t reserved[7];
+} QEMU_PACKED NiagaraSetSectionSizeOutput;
+
+/*
+ * Niagara Get Section Map Command
+ * query type:
+ *     Free - Map of free sections
+ *     Allocted - What sections are allocated for this head
+ * Returns a map of the requested type of sections
+ */
+#define NIAGARA_GSM_QUERY_FREE 0
+#define NIAGARA_GSM_QUERY_ALLOCATED 1
+
+typedef struct NiagaraGetSectionMapInput {
+    uint8_t query_type;
+    uint8_t reserved[7];
+} QEMU_PACKED NiagaraGetSectionMapInput;
+
+typedef struct NiagaraGetSectionMapOutput {
+    uint32_t ttl_section_count;
+    uint32_t qry_section_count;
+    uint8_t bitset[];
+} QEMU_PACKED NiagaraGetSectionMapOutput;
+
+#endif
-- 
2.39.1

