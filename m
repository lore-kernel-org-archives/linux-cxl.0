Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDC61FFE
	for <linux-cxl@vger.kernel.org>; Mon, 16 Feb 2026 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771213094; cv=none; b=FaVf60LzguNgrqmpxm1XbdmMvfWpYrF3QRO1o8kwPJkT13olyKD4XEE/JpTWNgyrV5JnHapMS3tYhyvvYf35D//siDefr+rC8isQp8df9eu9MFfeSFNBbQwlqgli5cqsL+4vkKPZHwqKcFP6RzqoY16qRaFUx1VLUmgYTvc2xB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771213094; c=relaxed/simple;
	bh=DM4mPJnQDBG1TmpI2rXQzjILW1mgpAWC+ASAiJAbmlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=rsoB/QA5TAIgH1m1kYRbdRM9S7kDjUf9Q0eEaa8IaBHMofvCyaQvcnhXNgbBOhpng8O7fBqtqGi9RPbM2r6lHqT720SDiFJjX6qD7ZA85GK5xZwmieHXQtTz489AtIuwjl6XIUjaDs47XlX4yVAvv/Q7+TqG8o/a2LlQgfgf5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tKjfkkLO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tKjfkkLO"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260216033803epoutp0206b62ecbeb6b822cf35b0a3b8ac8a35d~UnOpXk7ac3051730517epoutp02R
	for <linux-cxl@vger.kernel.org>; Mon, 16 Feb 2026 03:38:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260216033803epoutp0206b62ecbeb6b822cf35b0a3b8ac8a35d~UnOpXk7ac3051730517epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771213083;
	bh=PDxxvZDuP39wgom3+gGouWxT+8ywLHbE/jx77H/e17E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKjfkkLOPfZA4q3z+aOVRuOEm+oQHYqvAXrSVMFk3GXW31/ZUUd6w0ednNqM2TLQ1
	 5evB0XSS7qAnaBHS2Nw8DSs8PWm2wck6ZuCieqJ0eLbaIp3g3IJk3nsJM7amjpsyBL
	 SlMUXI1C37b5gRPanVr+46fwMyMwdRmFumD5b6N4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260216033803epcas5p19d109e2f6b2b1e5d8c6157bbc8fd8483~UnOo9C9Qu2067920679epcas5p1N;
	Mon, 16 Feb 2026 03:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fDpQ324gmz6B9m5; Mon, 16 Feb
	2026 03:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260212152533epcas5p4d0066b16cafd8b16815608d571acb93b~TiTPA1k6s3246532465epcas5p47;
	Thu, 12 Feb 2026 15:25:33 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260212152532epsmtip1828d5d5cf285e011eb94e474d4bf8986~TiTNtMgCs1564315643epsmtip1C;
	Thu, 12 Feb 2026 15:25:32 +0000 (GMT)
Date: Thu, 12 Feb 2026 20:55:23 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>, Arpit Kumar <arpit.sysdev@gmail.com>,
	cpgs@samsung.com
Subject: Re: [PATCH qemu v5 3/3] hw/cxl: Add Physical Port Control FMAPI
 Command (Opcode 5102h)
Message-ID: <1931444790.41771213083290.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260204173223.44122-4-Jonathan.Cameron@huawei.com>
X-CMS-MailID: 20260212152533epcas5p4d0066b16cafd8b16815608d571acb93b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e0ac_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260212152533epcas5p4d0066b16cafd8b16815608d571acb93b
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
	<20260204173223.44122-4-Jonathan.Cameron@huawei.com>
	<CGME20260212152533epcas5p4d0066b16cafd8b16815608d571acb93b@epcas5p4.samsung.com>

------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e0ac_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/26 05:32PM, Jonathan Cameron wrote:
>From: Arpit Kumar <arpit1.kumar@samsung.com>
>
>Added assert-deassert PERST implementation for physical ports (both USP
>and DSP's).
>
>Assert PERST involves bg operation for holding 100ms.
>Reset PPB implementation for physical ports.
>
>Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>---
>Changes mostly due to dropping refactor that preceeded this in original
>series.

Looks good to me!
>---
> include/hw/cxl/cxl_port.h                   |  20 +++
> include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
> include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
> hw/cxl/cxl-mailbox-utils.c                  | 130 ++++++++++++++++++++
> hw/pci-bridge/cxl_downstream.c              |   9 ++
> hw/pci-bridge/cxl_upstream.c                |   1 +
> 6 files changed, 174 insertions(+)
>
>diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
>index 04db60f7bc23..fb2e22a9f2ae 100644
>--- a/include/hw/cxl/cxl_port.h
>+++ b/include/hw/cxl/cxl_port.h
>@@ -3,6 +3,8 @@
> #ifndef CXL_PORT_H
> #define CXL_PORT_H
>
>+#include "qemu/thread.h"
>+
> /* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
> #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
> #define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
>@@ -50,4 +52,22 @@
> #define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
> #define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
>
>+#define CXL_MAX_PHY_PORTS 256
>+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
>+
>+/* Assert - Deassert PERST */
>+typedef struct CXLPhyPortPerst {
>+    bool issued_assert_perst;
>+    QemuMutex lock; /* protecting assert-deassert reset request */
>+    uint64_t asrt_time;
>+    QemuThread asrt_thread; /* thread for 100ms delay */
>+} CXLPhyPortPerst;
>+
>+void cxl_init_physical_port_control(CXLPhyPortPerst *perst);
>+
>+static inline bool cxl_perst_asserted(CXLPhyPortPerst *perst)
>+{
>+    return perst->issued_assert_perst || perst->asrt_time < ASSERT_WAIT_TIME_MS;
>+}
>+
> #endif /* CXL_PORT_H */
>diff --git a/include/hw/pci-bridge/cxl_downstream_port.h b/include/hw/pci-bridge/cxl_downstream_port.h
>new file mode 100644
>index 000000000000..1611504c8764
>--- /dev/null
>+++ b/include/hw/pci-bridge/cxl_downstream_port.h
>@@ -0,0 +1,12 @@
>+/*
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#ifndef CXL_DOWNSTREAM_PORT_H
>+#define CXL_DOWNSTREAM_PORT_H
>+#include "include/hw/cxl/cxl_port.h"
>+
>+typedef struct CXLDownstreamPort CXLDownstreamPort;
>+CXLPhyPortPerst *cxl_dsp_get_perst(CXLDownstreamPort *dsp);
>+
>+#endif
>diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
>index e3d6a27acc86..dfe01771c7d7 100644
>--- a/include/hw/pci-bridge/cxl_upstream_port.h
>+++ b/include/hw/pci-bridge/cxl_upstream_port.h
>@@ -4,6 +4,7 @@
> #include "hw/pci/pcie.h"
> #include "hw/pci/pcie_port.h"
> #include "hw/cxl/cxl.h"
>+#include "hw/cxl/cxl_port.h"
>
> typedef struct CXLUpstreamPort {
>     /*< private >*/
>@@ -12,6 +13,7 @@ typedef struct CXLUpstreamPort {
>     /*< public >*/
>     CXLComponentState cxl_cstate;
>     CXLCCI swcci;
>+    CXLPhyPortPerst perst;
>
>     PCIExpLinkSpeed speed;
>     PCIExpLinkWidth width;
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index b6ac987ee021..c83b5f90d4d3 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -17,6 +17,7 @@
> #include "hw/cxl/cxl_mailbox.h"
> #include "hw/cxl/cxl_port.h"
> #include "hw/pci/pci.h"
>+#include "hw/pci-bridge/cxl_downstream_port.h"
> #include "hw/pci-bridge/cxl_upstream_port.h"
> #include "qemu/cutils.h"
> #include "qemu/host-utils.h"
>@@ -119,6 +120,7 @@ enum {
>     PHYSICAL_SWITCH = 0x51,
>         #define IDENTIFY_SWITCH_DEVICE      0x0
>         #define GET_PHYSICAL_PORT_STATE     0x1
>+        #define PHYSICAL_PORT_CONTROL       0x2
>     TUNNEL = 0x53,
>         #define MANAGEMENT_COMMAND     0x0
>     FMAPI_DCD_MGMT = 0x56,
>@@ -616,6 +618,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>         struct cxl_fmapi_port_state_info_block *port;
>         /* First try to match on downstream port */
>         PCIDevice *port_dev;
>+        CXLPhyPortPerst *perst;
>         uint16_t lnkcap, lnkcap2, lnksta;
>
>         port = &out->ports[i];
>@@ -663,6 +666,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>             port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
>                 CXL_PORT_SUPPORTS_256B;
>             port->supported_ld_count = 3;
>+            perst = cxl_dsp_get_perst(CXL_DSP(port_dev));
>         } else if (usp->port == in->ports[i]) { /* USP */
>             port_dev = PCI_DEVICE(usp);
>             port->config_state = CXL_PORT_CONFIG_STATE_USP;
>@@ -670,6 +674,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>             port->connected_device_mode = 0; /* Reserved for USP */
>             port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
>                 (CXL_USP(usp)->flitmode ? CXL_PORT_SUPPORTS_256B : 0);
>+            perst = &CXL_USP(usp)->perst;
>         } else {
>             return CXL_MBOX_INVALID_INPUT;
>         }
>@@ -698,6 +703,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>         /* TODO: Track down if we can get the rest of the info */
>         port->ltssm_state = 0x7;
>         port->first_lane_num = 0;
>+        port->link_state = perst ? CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED : 0;
>     }
>
>     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
>@@ -706,6 +712,115 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>     return CXL_MBOX_SUCCESS;
> }
>
>+static void *bg_assertcb(void *opaque)
>+{
>+    CXLPhyPortPerst *perst = opaque;
>+
>+    /* holding reset phase for 100ms */
>+    while (perst->asrt_time--) {
>+        usleep(1000);
>+    }
>+    perst->issued_assert_perst = true;
>+    return NULL;
>+}
>+
>+static CXLRetCode cxl_deassert_perst(Object *obj, CXLPhyPortPerst *perst)
>+{
>+    if (!perst->issued_assert_perst) {
>+        return CXL_MBOX_INTERNAL_ERROR;
>+    }
>+
>+    QEMU_LOCK_GUARD(&perst->lock);
>+    resettable_release_reset(obj, RESET_TYPE_COLD);
>+    perst->issued_assert_perst = false;
>+    perst->asrt_time = ASSERT_WAIT_TIME_MS;
>+
>+    return CXL_MBOX_SUCCESS;
>+}
>+
>+static CXLRetCode cxl_assert_perst(Object *obj, CXLPhyPortPerst *perst)
>+{
>+    if (cxl_perst_asserted(perst)) {
>+        return CXL_MBOX_INTERNAL_ERROR;
>+    }
>+
>+    QEMU_LOCK_GUARD(&perst->lock);
>+    resettable_assert_reset(obj, RESET_TYPE_COLD);
>+    qemu_thread_create(&perst->asrt_thread, "assert_thread", bg_assertcb,
>+                       perst, QEMU_THREAD_DETACHED);
>+
>+    return CXL_MBOX_SUCCESS;
>+}
>+
>+static CXLDownstreamPort *cxl_find_dsp_on_bus(PCIBus *bus, uint8_t pn)
>+{
>+
>+    PCIDevice *port_dev = pcie_find_port_by_pn(bus, pn);
>+
>+    if (object_dynamic_cast(OBJECT(port_dev), TYPE_CXL_DSP)) {
>+        return CXL_DSP(port_dev);
>+    }
>+
>+    return NULL;
>+}
>+
>+/* CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h) */
>+static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
>+                                            uint8_t *payload_in,
>+                                            size_t len_in,
>+                                            uint8_t *payload_out,
>+                                            size_t *len_out,
>+                                            CXLCCI *cci)
>+{
>+   CXLUpstreamPort *pp = CXL_USP(cci->d);
>+   CXLPhyPortPerst *perst;
>+   PCIDevice *dev;
>+
>+   struct cxl_fmapi_get_physical_port_control_req_pl {
>+        uint8_t ppb_id;
>+        uint8_t ports_op;
>+    } QEMU_PACKED *in = (void *)payload_in;
>+
>+    if (len_in < sizeof(*in)) {
>+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>+    }
>+
>+    if (PCIE_PORT(pp)->port == in->ppb_id) {
>+        dev = PCI_DEVICE(pp);
>+        perst = &pp->perst;
>+    } else {
>+        CXLDownstreamPort *dsp =
>+            cxl_find_dsp_on_bus(&PCI_BRIDGE(pp)->sec_bus, in->ppb_id);
>+
>+        if (!dsp) {
>+            return CXL_MBOX_INVALID_INPUT;
>+        }
>+        dev = PCI_DEVICE(dsp);
>+        perst = cxl_dsp_get_perst(dsp);
>+    }
>+
>+    switch (in->ports_op) {
>+    case 0:
>+        return cxl_assert_perst(OBJECT(&dev->qdev), perst);
>+    case 1:
>+        return cxl_deassert_perst(OBJECT(&dev->qdev), perst);
>+    case 2: {
>+        if (!perst) {
>+            return CXL_MBOX_INVALID_INPUT;
>+        }
>+
>+        if (perst->issued_assert_perst ||
>+            perst->asrt_time < ASSERT_WAIT_TIME_MS) {
>+            return CXL_MBOX_INTERNAL_ERROR;
>+        }
>+        device_cold_reset(&dev->qdev);
>+        return CXL_MBOX_SUCCESS;
>+    }
>+    default:
>+        return CXL_MBOX_INVALID_INPUT;
>+    }
>+}
>+
> /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
> static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>                                          uint8_t *payload_in,
>@@ -4412,6 +4527,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>         cmd_identify_switch_device, 0, 0 },
>     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
>         cmd_get_physical_port_state, ~0, 0 },
>+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
>+        cmd_physical_port_control, 2, 0 },
>     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
>                                      cmd_tunnel_management_cmd, ~0, 0 },
> };
>@@ -4618,6 +4735,19 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>     }
> }
>
>+void cxl_init_physical_port_control(CXLPhyPortPerst *perst)
>+{
>+    qemu_mutex_init(&perst->lock);
>+    perst->issued_assert_perst = false;
>+    /*
>+     * Assert PERST involves physical port to be in
>+     * hold reset phase for minimum 100ms. No other
>+     * physical port control requests are entertained
>+     * until Deassert PERST command.
>+     */
>+    perst->asrt_time = ASSERT_WAIT_TIME_MS;
>+}
>+
> void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> {
>     cci->payload_max = payload_max;
>diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
>index 320818a8f1ce..ec450d1aa09e 100644
>--- a/hw/pci-bridge/cxl_downstream.c
>+++ b/hw/pci-bridge/cxl_downstream.c
>@@ -13,9 +13,11 @@
> #include "hw/pci/msi.h"
> #include "hw/pci/pcie.h"
> #include "hw/pci/pcie_port.h"
>+#include "hw/pci-bridge/cxl_downstream_port.h"
> #include "hw/core/qdev-properties.h"
> #include "hw/core/qdev-properties-system.h"
> #include "hw/cxl/cxl.h"
>+#include "hw/cxl/cxl_port.h"
> #include "qapi/error.h"
>
> typedef struct CXLDownstreamPort {
>@@ -24,6 +26,7 @@ typedef struct CXLDownstreamPort {
>
>     /*< public >*/
>     CXLComponentState cxl_cstate;
>+    CXLPhyPortPerst perst;
> } CXLDownstreamPort;
>
> #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
>@@ -81,6 +84,11 @@ static void cxl_dsp_config_write(PCIDevice *d, uint32_t address,
>     cxl_dsp_dvsec_write_config(d, address, val, len);
> }
>
>+CXLPhyPortPerst *cxl_dsp_get_perst(CXLDownstreamPort *dsp)
>+{
>+    return &dsp->perst;
>+}
>+
> static void cxl_dsp_reset(DeviceState *qdev)
> {
>     PCIDevice *d = PCI_DEVICE(qdev);
>@@ -92,6 +100,7 @@ static void cxl_dsp_reset(DeviceState *qdev)
>     pci_bridge_reset(qdev);
>
>     latch_registers(dsp);
>+    cxl_init_physical_port_control(&dsp->perst);
> }
>
> static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
>diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
>index fb8d19539c9f..b6281cbd4cb0 100644
>--- a/hw/pci-bridge/cxl_upstream.c
>+++ b/hw/pci-bridge/cxl_upstream.c
>@@ -103,6 +103,7 @@ static void cxl_usp_reset(DeviceState *qdev)
>     pcie_cap_deverr_reset(d);
>     pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
>     latch_registers(usp);
>+    cxl_init_physical_port_control(&usp->perst);
> }
>
> static void build_dvsecs(CXLUpstreamPort *usp)
>-- 
>2.51.0
>

------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e0ac_
Content-Type: text/plain; charset="utf-8"


------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e0ac_--

