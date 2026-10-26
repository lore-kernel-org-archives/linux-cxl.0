Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.37.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008456;
	b=Jm86JhUi8rS3virbsySuG4R9OPdvBBiqPeuVoA8a2h31ihsVMP+MSg1R7mhhNOLcP570
	 muNg4BDt9Ui1nSIsr5GfABxhoknpebCPXmUE19x12e3sKpXX6a/5cDzoT2ND5aN6yRBIQ
	 1oSz4dEh9t+e09QEzHV5N1kCpSfK335Lne0Yvl+XBf6qzorVl61F7XXgYG/KeCcZQK22n
	 ZXjkjjc+AHps2hs174HD2nmaVB2AztXexCI3AavVUmoMOjYOB7sI7h7BFkICe2Fu8ql42
	 ozZu6X5gtXnolJ+SMeq3LvrzuG7DX9UbBCV11S93OlIK+OPEHnWJZSeGed3z3iBHExQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008456;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oIV57EJWTOMtrl0TA07o16PQYh/OKipP1ACFbkkxDuk=;
	b=Z3ZpK9M0f6QvGS2lkSiqrn0mFT8IkGyXjTuXPaLkAizt8S/k3HP5j/N8py556x8SR4yg
	 wHh+nBbK4FGjAti0z1cGI+5ShlGjUSH9xgz37k/Am4H3CYuzI2uQCZIpzgN9reZRCmCp0
	 7VBgvjLaXOVCyRWFQpRzw/JiNkJ7orhHfdXH4cSZkp0ZjrgKX2l5cdOCGY55aT94tr2hz
	 Yc+yx/FYfjdJr1bkffdpYNCzU/i8Nr7t4+ZCzGusOL4s0W4gcvGXRohCGB0EuWwTDq2cD
	 wPABI5+2UoXPVFVU92XXiCo7g7w2pUFhGFcLTBJlpj4mXxGm/FNQndwVW0uhT9Yyz8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=O13mroCb;
	arc=none smtp.remote-ip=139.138.37.100
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7198606A31B
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7198606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=O13mroCb
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008455; x=1824544455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYV8jtdiDIttht3TRaM0y5nY4jvIepG6G6eTEjUpCEU=;
  b=O13mroCb2bN3qHprTmvJdK8JMjNtKuXnDjB5UHwXDjxnCaiH7qTMNJEI
   nhURbfn2RqpVmFWTX4kvJvUo9TyQk4ChoKDlbNaPPTrr0E/8XjrVH/90p
   UUAO19MO3bnKz9NJyPgSlDgIU58IyGH2EYfn4AKooOHZVnFK+zKdlcj0f
   pDPlsYpZHIhfUGBL/4LDGQOOLGDJHblon8tWeOKzvbj4rQUqYYucvuTHx
   dlSZeXlCSYwvtnvo76bOCzceUsMLJIyIneeFW1mAfRkZRVvA6ulHr91/4
   m/s822CtjvREMCu6Hwzyqh+3f+toID3d+L9H10Z8zN55UejcL+DSdQeOF
   Q==;
X-CSE-ConnectionGUID: oyN+F7MsRh+hQiMscbU8/A==
X-CSE-MsgGUID: O/TZP3k2RxO+FbABGmcuLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="237204748"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="237204748"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:14 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 3036A1000373
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:14 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTP id 9A48D100087E
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:13 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 63690202EBDE;
	Mon, 26 Oct 2026 18:54:12 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	linux-cxl@vger.kernel.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 4/7] =?UTF-8?q?QEMU/hw/cxl:=20auto=E2=80=91program=20H?= =?UTF-8?q?DM=20decoders=20for=20CXL=20Type=203?=
Date: Mon, 26 Oct 2026 19:03:25 +0900
Message-ID: <a8e078e52c09acc0be7874b7c8dd244546127547.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some real systems, firmware programs the HDM decoders on both the
endpoint and the CXL host bridge so that the OS can discover CXL memory
ranges at boot and the CXL driver can automatically create regions.

This patch adds helpers to program the HDM decoders in QEMU using the
per‑device HPA range from `ct3_type3_get_hpm_range()`, and wires them
into the CXL Type 3 reset path. When `program_hdm_decoder` is enabled,
both the endpoint and host‑bridge HDM decoders are configured so that
the guest sees the same kind of automatically assigned CXL regions as
on real hardware.

The reset hold phase processes child devices before their parents.
Consequently, the Type 3 reset handler programs the host bridge decoder
before the pxb-cxl reset handler runs. Calling
cxl_component_register_init_common() from the pxb-cxl reset handler
would then clear the component register block and erase the decoder
configuration that was just programmed.

When the affected HPA ranges are advertised through E820 and SRAT,
which will be added in the following patches, Linux attempts to use them
as system memory. Without a valid host bridge decoder, accesses to
these ranges cannot be routed to the Type 3 devices. This corrupts
kernel memory-management data and eventually causes a kernel panic.

Initialize the common host bridge component registers when the PXB is
realized instead. Keep the reset handler limited to the
topology-dependent HDM capability setup so that the automatically
programmed decoder settings are not overwritten.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c                  | 98 +++++++++++++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge.c | 13 +++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 811f8e247d..60e4c0e20f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -19,6 +19,9 @@
 #include "hw/pci/pci.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl_host.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -1358,6 +1361,59 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static void __update_hdm_decoder_n(uint32_t *cache_mem, int which,
+                                   uint32_t ctrl, uint64_t base,
+                                   uint64_t size)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc,
+             base & 0xffffffff);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc,
+             base >> 32);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc,
+             size & 0xffffffff);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc,
+             size >> 32);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+}
+
+static void update_hdm_decoder_endpoint(uint32_t *cache_mem, int which,
+                                        uint32_t ctrl, uint64_t base,
+                                        uint64_t size)
+{
+    return __update_hdm_decoder_n(cache_mem, which, ctrl, base, size);
+}
+
+static void update_hdm_decoder_pxb(uint32_t *cache_mem, int which,
+                                   uint64_t tl, uint32_t ctrl,
+                                   uint64_t base, uint64_t size)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+
+    stl_le_p(cache_mem +
+             R_CXL_HDM_DECODER0_TARGET_LIST_LO + which * hdm_inc,
+             tl & 0xffffffff);
+    stl_le_p(cache_mem +
+             R_CXL_HDM_DECODER0_TARGET_LIST_HI + which * hdm_inc,
+             tl >> 32);
+
+    __update_hdm_decoder_n(cache_mem, which, ctrl, base, size);
+}
+
+static uint8_t ct3d_root_port_number(DeviceState *dev)
+{
+    BusState *bus = dev->parent_bus;
+    DeviceState *rp_dev;
+
+    assert(bus);
+    rp_dev = bus->parent;
+    assert(rp_dev);
+    assert(object_dynamic_cast(OBJECT(rp_dev), TYPE_PCIE_ROOT_PORT));
+
+    return PCIE_PORT(rp_dev)->port;
+}
+
 static uint64_t c3t_addr_size(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
@@ -1398,6 +1454,42 @@ void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size)
     *size = c3t_addr_size(DEVICE(dev));
 }
 
+static void program_pxb_hdm_decoder(DeviceState *dev)
+{
+    CXLHost *cxl = ct3d_to_cxl_pxb(dev);
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    int hdm_num = ct3d->idx;
+    int order = ct3d_root_port_number(dev);
+    assert(cxl);
+    uint64_t base, size;
+    ct3_type3_get_hpm_range(ct3d, &base, &size);
+
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    uint32_t *cache_mem = cxl_cstate->crb.cache_mem_registers;
+
+    uint32_t ctrl = R_CXL_HDM_DECODER0_CTRL_COMMIT_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_COMMITTED_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_TYPE_MASK;
+
+    update_hdm_decoder_pxb(cache_mem, hdm_num, order, ctrl, base, size);
+}
+
+static void program_hdm_decoder(DeviceState *dev)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    uint64_t base, size;
+    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+
+    ct3_type3_get_hpm_range(ct3d, &base, &size);
+
+    uint32_t ctrl = R_CXL_HDM_DECODER0_CTRL_COMMIT_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_COMMITTED_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_TYPE_MASK;
+
+    update_hdm_decoder_endpoint(cache_mem, 0, ctrl, base, size);
+}
+
 static void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
@@ -1408,6 +1500,12 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+
+    if (ct3d->program_hdm_decoder) {
+        program_hdm_decoder(dev);
+        program_pxb_hdm_decoder(dev);
+    }
+
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e08..e8fd7343d1 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -297,16 +297,24 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
+static void pxb_cxl_dev_init(DeviceState *dev)
+{
+    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+}
+
 static void pxb_cxl_dev_reset(DeviceState *dev)
 {
     CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
     CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
     PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
     uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
-    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
@@ -507,6 +515,7 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
     if (!pxb_dev_realize_common(dev, CXL, errp)) {
         return;
     }
+    pxb_cxl_dev_init(DEVICE(dev));
     pxb_cxl_dev_reset(DEVICE(dev));
 }
 
-- 
2.52.0

