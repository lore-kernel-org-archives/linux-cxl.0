Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22ADC433FE
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Oct 2022 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJGPYC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJGPX7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Oct 2022 11:23:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138910B7AE
        for <linux-cxl@vger.kernel.org>; Fri,  7 Oct 2022 08:23:58 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MkXBj3vx4z67xX3;
        Fri,  7 Oct 2022 23:23:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 17:23:56 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 16:23:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>
CC:     <linuxarm@huawei.com>, <ira.weiny@intel.com>
Subject: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange
Date:   Fri, 7 Oct 2022 16:21:55 +0100
Message-ID: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>

The CDAT can be specified in two ways. One is to add ",cdat=<filename>"
in "-device cxl-type3"'s command option. The file is required to provide
the whole CDAT table in binary mode. The other is to use the default
that provides some 'reasonable' numbers based on type of memory and
size.

The DOE capability supporting CDAT is added to hw/mem/cxl_type3.c with
capability offset 0x190. The config read/write to this capability range
can be generated in the OS to request the CDAT data.

Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Signed-off-by: Chris Browy <cbrowy@avery-design.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
Changes since RFC:
- Break out type 3 user of library as separate patch.
- Change reported data for default to be based on the options provided
  for the type 3 device.
---
 hw/mem/cxl_type3.c | 227 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 568c9d62f5..3fa5d70662 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -12,9 +12,218 @@
 #include "qemu/range.h"
 #include "qemu/rcu.h"
 #include "sysemu/hostmem.h"
+#include "sysemu/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 
+#define DWORD_BYTE 4
+
+static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
+                                void *priv)
+{
+    g_autofree CDATDsmas *dsmas_nonvolatile = NULL;
+    g_autofree CDATDslbis *dslbis_nonvolatile = NULL;
+    g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
+    CXLType3Dev *ct3d = priv;
+    int len = 0;
+    int i = 0;
+    int next_dsmad_handle = 0;
+    int nonvolatile_dsmad = -1;
+    int dslbis_nonvolatile_num = 4;
+    MemoryRegion *mr;
+
+    /* Non volatile aspects */
+    if (ct3d->hostmem) {
+        dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
+        if (!dsmas_nonvolatile) {
+            return -ENOMEM;
+        }
+        nonvolatile_dsmad = next_dsmad_handle++;
+        mr = host_memory_backend_get_memory(ct3d->hostmem);
+        if (!mr) {
+            return -EINVAL;
+        }
+        *dsmas_nonvolatile = (CDATDsmas) {
+            .header = {
+                .type = CDAT_TYPE_DSMAS,
+                .length = sizeof(*dsmas_nonvolatile),
+            },
+            .DSMADhandle = nonvolatile_dsmad,
+            .flags = CDAT_DSMAS_FLAG_NV,
+            .DPA_base = 0,
+            .DPA_length = int128_get64(mr->size),
+        };
+        len++;
+
+        /* For now, no memory side cache, plausiblish numbers */
+        dslbis_nonvolatile = g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
+        if (!dslbis_nonvolatile)
+            return -ENOMEM;
+
+        dslbis_nonvolatile[0] = (CDATDslbis) {
+            .header = {
+                .type = CDAT_TYPE_DSLBIS,
+                .length = sizeof(*dslbis_nonvolatile),
+            },
+            .handle = nonvolatile_dsmad,
+            .flags = HMAT_LB_MEM_MEMORY,
+            .data_type = HMAT_LB_DATA_READ_LATENCY,
+            .entry_base_unit = 10000, /* 10ns base */
+            .entry[0] = 15, /* 150ns */
+        };
+        len++;
+
+        dslbis_nonvolatile[1] = (CDATDslbis) {
+            .header = {
+                .type = CDAT_TYPE_DSLBIS,
+                .length = sizeof(*dslbis_nonvolatile),
+            },
+            .handle = nonvolatile_dsmad,
+            .flags = HMAT_LB_MEM_MEMORY,
+            .data_type = HMAT_LB_DATA_WRITE_LATENCY,
+            .entry_base_unit = 10000,
+            .entry[0] = 25, /* 250ns */
+        };
+        len++;
+       
+        dslbis_nonvolatile[2] = (CDATDslbis) {
+            .header = {
+                .type = CDAT_TYPE_DSLBIS,
+                .length = sizeof(*dslbis_nonvolatile),
+            },
+            .handle = nonvolatile_dsmad,
+            .flags = HMAT_LB_MEM_MEMORY,
+            .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
+            .entry_base_unit = 1000, /* GB/s */
+            .entry[0] = 16,
+        };
+        len++;
+
+        dslbis_nonvolatile[3] = (CDATDslbis) {
+            .header = {
+                .type = CDAT_TYPE_DSLBIS,
+                .length = sizeof(*dslbis_nonvolatile),
+            },
+            .handle = nonvolatile_dsmad,
+            .flags = HMAT_LB_MEM_MEMORY,
+            .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
+            .entry_base_unit = 1000, /* GB/s */
+            .entry[0] = 16,
+        };
+        len++;
+
+        mr = host_memory_backend_get_memory(ct3d->hostmem);
+        if (!mr) {
+            return -EINVAL;
+        }
+        dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
+        *dsemts_nonvolatile = (CDATDsemts) {
+            .header = {
+                .type = CDAT_TYPE_DSEMTS,
+                .length = sizeof(*dsemts_nonvolatile),
+            },
+            .DSMAS_handle = nonvolatile_dsmad,
+            .EFI_memory_type_attr = 2, /* Reserved - the non volatile from DSMAS matters */
+            .DPA_offset = 0,
+            .DPA_length = int128_get64(mr->size),
+        };
+        len++;
+    }
+
+    *cdat_table = g_malloc0(len * sizeof(*cdat_table));
+    /* Header always at start of structure */
+    if (dsmas_nonvolatile) {
+        (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
+    }
+    if (dslbis_nonvolatile) {
+        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);        
+        int j;
+
+        for (j = 0; j < dslbis_nonvolatile_num; j++) {
+            (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
+        }
+    }
+    if (dsemts_nonvolatile) {
+        (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
+    }
+    
+    return len;
+}
+
+static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
+{
+    int i;
+
+    for (i = 0; i < num; i++) {
+        g_free(cdat_table[i]);
+    }
+    g_free(cdat_table);
+}
+
+static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
+{
+    CDATObject *cdat = &CXL_TYPE3(doe_cap->pdev)->cxl_cstate.cdat;
+    uint16_t ent;
+    void *base;
+    uint32_t len;
+    CDATReq *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    CDATRsp rsp;
+
+    assert(cdat->entry_len);
+
+    /* Discard if request length mismatched */
+    if (pcie_doe_get_obj_len(req) <
+        DIV_ROUND_UP(sizeof(CDATReq), DWORD_BYTE)) {
+        return false;
+    }
+
+    ent = req->entry_handle;
+    base = cdat->entry[ent].base;
+    len = cdat->entry[ent].length;
+
+    rsp = (CDATRsp) {
+        .header = {
+            .vendor_id = CXL_VENDOR_ID,
+            .data_obj_type = CXL_DOE_TABLE_ACCESS,
+            .reserved = 0x0,
+            .length = DIV_ROUND_UP((sizeof(rsp) + len), DWORD_BYTE),
+        },
+        .rsp_code = CXL_DOE_TAB_RSP,
+        .table_type = CXL_DOE_TAB_TYPE_CDAT,
+        .entry_handle = (ent < cdat->entry_len - 1) ?
+                        ent + 1 : CXL_DOE_TAB_ENT_MAX,
+    };
+
+    memcpy(doe_cap->read_mbox, &rsp, sizeof(rsp));
+    memcpy(doe_cap->read_mbox + DIV_ROUND_UP(sizeof(rsp), DWORD_BYTE),
+           base, len);
+
+    doe_cap->read_mbox_len += rsp.header.length;
+
+    return true;
+}
+
+static uint32_t ct3d_config_read(PCIDevice *pci_dev, uint32_t addr, int size)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
+    uint32_t val;
+
+    if (pcie_doe_read_config(&ct3d->doe_cdat, addr, size, &val)) {
+        return val;
+    }
+
+    return pci_default_read_config(pci_dev, addr, size);
+}
+
+static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
+                              int size)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
+
+    pcie_doe_write_config(&ct3d->doe_cdat, addr, val, size);
+    pci_default_write_config(pci_dev, addr, val, size);
+}
+
 /*
  * Null value of all Fs suggested by IEEE RA guidelines for use of
  * EU, OUI and CID
@@ -140,6 +349,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
     return true;
 }
 
+static DOEProtocol doe_cdat_prot[] = {
+    { CXL_VENDOR_ID, CXL_DOE_TABLE_ACCESS, cxl_doe_cdat_rsp },
+    { }
+};
+
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
@@ -189,6 +403,14 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     for (i = 0; i < msix_num; i++) {
         msix_vector_use(pci_dev, i);
     }
+
+    /* DOE Initailization */
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+
+    cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
+    cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
+    cxl_cstate->cdat.private = ct3d;
+    cxl_doe_cdat_init(cxl_cstate, errp);
 }
 
 static void ct3_exit(PCIDevice *pci_dev)
@@ -197,6 +419,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
     ComponentRegisters *regs = &cxl_cstate->crb;
 
+    cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
     address_space_destroy(&ct3d->hostmem_as);
 }
@@ -296,6 +519,7 @@ static Property ct3_props[] = {
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
+    DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -361,6 +585,9 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     pc->device_id = 0xd93; /* LVF for now */
     pc->revision = 1;
 
+    pc->config_write = ct3d_config_write;
+    pc->config_read = ct3d_config_read;
+
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "CXL PMEM Device (Type 3)";
     dc->reset = ct3d_reset;
-- 
2.37.2

