Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FBAC433EF
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiCFSAs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 13:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCFSAs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 13:00:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE33EF37
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 09:59:54 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTpx5VH4z67QKJ;
        Mon,  7 Mar 2022 01:58:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:59:52 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 17:59:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 36/46] i386/pc: Enable CXL fixed memory windows
Date:   Sun, 6 Mar 2022 17:41:27 +0000
Message-ID: <20220306174137.5707-37-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

Add the CFMWs memory regions to the memorymap and adjust the
PCI window to avoid hitting the same memory.

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/i386/pc.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7a18dce529..5ece806d2b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -816,7 +816,7 @@ void pc_memory_init(PCMachineState *pcms,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
-    hwaddr cxl_base;
+    hwaddr cxl_base, cxl_resv_end = 0;
 
     assert(machine->ram_size == x86ms->below_4g_mem_size +
                                 x86ms->above_4g_mem_size);
@@ -924,6 +924,24 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
+        cxl_resv_end = cxl_base + cxl_size;
+        if (machine->cxl_devices_state->fixed_windows) {
+            hwaddr cxl_fmw_base;
+            GList *it;
+
+            cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
+            for (it = machine->cxl_devices_state->fixed_windows; it; it = it->next) {
+                CXLFixedWindow *fw = it->data;
+
+                fw->base = cxl_fmw_base;
+                memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
+                                      "cxl-fixed-memory-region", fw->size);
+                memory_region_add_subregion(system_memory, fw->base, &fw->mr);
+                e820_add_entry(fw->base, fw->size, E820_RESERVED);
+                cxl_fmw_base += fw->size;
+                cxl_resv_end = cxl_fmw_base;
+            }
+        }
     }
 
     /* Initialize PC system firmware */
@@ -953,6 +971,10 @@ void pc_memory_init(PCMachineState *pcms,
         if (!pcmc->broken_reserved_end) {
             res_mem_end += memory_region_size(&machine->device_memory->mr);
         }
+
+        if (machine->cxl_devices_state->is_enabled) {
+            res_mem_end = cxl_resv_end;
+        }
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
     }
@@ -989,6 +1011,13 @@ uint64_t pc_pci_hole64_start(void)
     if (ms->cxl_devices_state->host_mr.addr) {
         hole64_start = ms->cxl_devices_state->host_mr.addr +
             memory_region_size(&ms->cxl_devices_state->host_mr);
+        if (ms->cxl_devices_state->fixed_windows) {
+            GList *it;
+            for (it = ms->cxl_devices_state->fixed_windows; it; it = it->next) {
+                CXLFixedWindow *fw = it->data;
+                hole64_start = fw->mr.addr + memory_region_size(&fw->mr);
+            }
+        }
     } else if (pcmc->has_reserved_memory && ms->device_memory->base) {
         hole64_start = ms->device_memory->base;
         if (!pcmc->broken_reserved_end) {
-- 
2.32.0

