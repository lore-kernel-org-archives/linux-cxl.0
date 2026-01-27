Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1B3112C9
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527439; cv=none; b=YTtcAAIHzRCVEVpDRu0/myJjsNCxI3AeSQ/d7GulUEbul8mA/r9G98xtLm+GbirUbYzNw+vuV1yQHF7GBbpn+13BZAG3NXT44vXH9dnF6CiRA3wUXysih7PQDUx/O6Z84ViVn7YG9mBFyp85Voe3yKWYrytZncrdE/NnaDDMZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527439; c=relaxed/simple;
	bh=AqQBWZPnA+P1UFvuFoZ4PGO6PL4fpAmQrUpoLe8P/S0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwCVQjd7jglpSiC6qbJqSC53LkbHEcnDYSVlYRCSbNiKa6YoDvqsHiD3cfGg+93hi8lxYDHTB+7DQci8znDytjWeOqDYXWVvk9u2zdyE5jzR4KPnQIAeO1jjxeaZ6pZVX05gGe8uDPMDvoSmEXhHwlvcvADU1iTikki9kwygzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0q0p6qFyzHnGjf;
	Tue, 27 Jan 2026 23:23:06 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id AD0154056A;
	Tue, 27 Jan 2026 23:23:52 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 15:23:52 +0000
Date: Tue, 27 Jan 2026 15:23:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20260127152350.00006447@huawei.com>
In-Reply-To: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
References: <CGME20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4@epcas5p2.samsung.com>
 <20250916080736.1266083-1-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 16 Sep 2025 13:37:34 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> This patch series refactor existing support for Identify Switch Device
> and Get Physical Port State by utilizing physical ports (USP & DSP)
> information stored during enumeration.

Hi Arpit.

So I came back to this series to try and tweak it into being in a state
for upstreaming.  I made some fairly heavy changes (to push the
data down to the individual ports where to me it more logically sits)
but it became apparent to me during this that there is a fundamental
problem.  This stuff isn't static because it needs to reflect port
retraining and hotplug events etc.  If we want to store cached
data we are going to have to deal with updating it from a significant
number of different places. The perst one you have covered in patch 2
is an example but there are others.

Now we definitely can do the generation in a neater way, but I've
come to the conclusion that caching it really doesn't make sense.

Maybe we can do that for the USP, but definitely not DSPs.

Given I did a bunch of refactoring I might as well share it even though
I'm currently thinking it might not be worth doing:

=46rom 40a8a36f22a6eb053c965231a698c8054d417049 Mon Sep 17 00:00:00 2001
From: Arpit Kumar <arpit1.kumar@samsung.com>
Date: Tue, 16 Sep 2025 13:37:35 +0530
Subject: [PATCH] hw/cxl: Refactored Identify Switch Device & Get Physical P=
ort
 State

Store the physical port info for the USP on reset but refresh
it on demand for the DSPs as they are hotplug capable.

Enables common data to be used for both of:
* Identify Switch Device (Opcode 5100h)
* Get Physical Port State (Opcode 5101h) physical switch FM-API command set.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Co-developed: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Added a Co-dev as I have modified this a lot from Arpit's v4.
v5:
- Create a new header to avoid importing all of cxl_device.h into
the upstream port emulation.
- Move the call that caches state to the cxl_upstream_port reset
  to ensure downstream ports are in place before it is called.
  Also will make it available from whatever CCI.  If we ever support
  multiple VCS switches this will need to move an appropriate structure
  representing whole switch information. With only one USP that is
  a reasonable place to put full switch info.
- Downstream ports have more dynamic state (as devices can be
  hotplugged below them).  As such, only fill in the data at time
  of request.
---
 include/hw/cxl/cxl_port.h                   |  87 ++++++++
 include/hw/pci-bridge/cxl_downstream_port.h |  11 +
 include/hw/pci-bridge/cxl_upstream_port.h   |   5 +
 hw/cxl/cxl-mailbox-utils.c                  | 210 ++++++++++----------
 hw/pci-bridge/cxl_downstream.c              |  27 +++
 hw/pci-bridge/cxl_upstream.c                |   5 +
 6 files changed, 245 insertions(+), 100 deletions(-)
 create mode 100644 include/hw/cxl/cxl_port.h
 create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h

diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
new file mode 100644
index 000000000000..15960f8b5778
--- /dev/null
+++ b/include/hw/cxl/cxl_port.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef CXL_PORT_H
+#define CXL_PORT_H
+
+#include "hw/pci/pci.h"
+
+/* Port related commands */
+#define CXL_MAX_PHY_PORTS 256
+
+/* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block For=
mat */
+#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
+#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
+#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
+#define CXL_PORT_CONFIG_STATE_DSP                0x3
+#define CXL_PORT_CONFIG_STATE_USP                0x4
+#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
+#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
+
+#define CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN 0x00
+#define CXL_PORT_CONNECTED_DEV_MODE_RCD                0x01
+#define CXL_PORT_CONNECTED_DEV_MODE_68B_VH             0x02
+#define CXL_PORT_CONNECTED_DEV_MODE_256B               0x03
+#define CXL_PORT_CONNECTED_DEV_MODE_LO_256B            0x04
+#define CXL_PORT_CONNECTED_DEV_MODE_PBR                0x05
+
+#define CXL_PORT_CONNECTED_DEV_TYPE_NONE            0x00
+#define CXL_PORT_CONNECTED_DEV_TYPE_PCIE            0x01
+#define CXL_PORT_CONNECTED_DEV_TYPE_1               0x02
+#define CXL_PORT_CONNECTED_DEV_TYPE_2_OR_HBR_SWITCH 0x03
+#define CXL_PORT_CONNECTED_DEV_TYPE_3_SLD           0x04
+#define CXL_PORT_CONNECTED_DEV_TYPE_3_MLD           0x05
+#define CXL_PORT_CONNECTED_DEV_PBR_COMPONENT        0x06
+
+#define CXL_PORT_SUPPORTS_RCD        BIT(0)
+#define CXL_PORT_SUPPORTS_68B_VH     BIT(1)
+#define CXL_PORT_SUPPORTS_256B       BIT(2)
+#define CXL_PORT_SUPPORTS_LO_256B    BIT(3)
+#define CXL_PORT_SUPPORTS_PBR        BIT(4)
+
+#define CXL_PORT_LTSSM_DETECT        0x00
+#define CXL_PORT_LTSSM_POLLING       0x01
+#define CXL_PORT_LTSSM_CONFIGURATION 0x02
+#define CXL_PORT_LTSSM_RECOVERY      0x03
+#define CXL_PORT_LTSSM_L0            0x04
+#define CXL_PORT_LTSSM_L0S           0x05
+#define CXL_PORT_LTSSM_L1            0x06
+#define CXL_PORT_LTSSM_L2            0x07
+#define CXL_PORT_LTSSM_DISABLED      0x08
+#define CXL_PORT_LTSSM_LOOPBACK      0x09
+#define CXL_PORT_LTSSM_HOT_RESET     0x0A
+
+#define CXL_PORT_LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
+#define CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
+#define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
+#define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
+
+typedef struct CXLPhyPortInfo {
+    uint8_t port_id;
+    uint8_t current_port_config_state;
+    uint8_t connected_device_mode;
+    uint8_t rsv1;
+    uint8_t connected_device_type;
+    uint8_t supported_cxl_modes;
+    uint8_t max_link_width;
+    uint8_t negotiated_link_width;
+    uint8_t supported_link_speeds_vector;
+    uint8_t max_link_speed;
+    uint8_t current_link_speed;
+    uint8_t ltssm_state;
+    uint8_t first_negotiated_lane_num;
+    uint16_t link_state_flags;
+    uint8_t supported_ld_count;
+} QEMU_PACKED CXLPhyPortInfo;
+
+void cxl_init_physical_port_info(PCIDevice *port_dev, CXLPhyPortInfo *info,
+                                 uint8_t pn,
+                                 uint8_t current_port_config_state,
+                                 uint8_t connected_device_type,
+                                 uint8_t supported_ld_count);
+
+/* Common data for CXL USP and DSP */
+typedef struct CXLSwitchPortData {
+    CXLPhyPortInfo info;
+} CXLSwitchPortData;
+
+#endif /* CXL_PORT_H */
diff --git a/include/hw/pci-bridge/cxl_downstream_port.h b/include/hw/pci-b=
ridge/cxl_downstream_port.h
new file mode 100644
index 000000000000..c3f058365283
--- /dev/null
+++ b/include/hw/pci-bridge/cxl_downstream_port.h
@@ -0,0 +1,11 @@
+#ifndef CXL_DOWNSTREAM_PORT_H
+#define CXL_DOWNSTREAM_PORT_H
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
+#include "include/hw/cxl/cxl_port.h"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+CXLPhyPortInfo *cxl_dsp_get_physical_port_info(CXLDownstreamPort *dsp);
+
+#endif
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bri=
dge/cxl_upstream_port.h
index e3d6a27acc86..fe367fb66f0c 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "include/hw/cxl/cxl_port.h"
=20
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -19,6 +20,10 @@ typedef struct CXLUpstreamPort {
=20
     DOECap doe_cdat;
     uint64_t sn;
+
+    CXLSwitchPortData swport_data;
 } CXLUpstreamPort;
=20
+void cxl_set_physical_port_info(CXLUpstreamPort *cxl_usp);
+
 #endif /* CXL_SUP_H */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2f449980cdc0..f7aa56b0d385 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -13,9 +13,11 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_port.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/cxl/cxl_mailbox.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
@@ -488,13 +490,21 @@ static CXLRetCode cmd_set_response_msg_limit(const st=
ruct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
=20
-static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
-                                  void *private)
+static uint8_t cxl_num_switch_ports(CXLUpstreamPort *usp)
 {
-    uint8_t *bm =3D private;
-    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
-        uint8_t port =3D PCIE_PORT(d)->port;
-        bm[port / 8] |=3D 1 << (port % 8);
+    PCIBus *bus =3D &PCI_BRIDGE(usp)->sec_bus;
+
+    return pcie_count_ds_ports(bus) + 1;
+}
+
+static void cxl_mark_dsp_active(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    uint8_t *bitmask =3D opaque;
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
+        uint8_t pn =3D PCIE_PORT(dev)->port;
+
+        bitmask[pn / 8] |=3D (1 << (pn % 8));
     }
 }
=20
@@ -506,9 +516,9 @@ static CXLRetCode cmd_identify_switch_device(const stru=
ct cxl_cmd *cmd,
                                              size_t *len_out,
                                              CXLCCI *cci)
 {
-    PCIEPort *usp =3D PCIE_PORT(cci->d);
-    PCIBus *bus =3D &PCI_BRIDGE(cci->d)->sec_bus;
-    int num_phys_ports =3D pcie_count_ds_ports(bus);
+    CXLUpstreamPort *pp =3D CXL_USP(cci->d);
+    uint8_t num_phys_ports =3D cxl_num_switch_ports(pp);
+    uint8_t pn;
=20
     struct cxl_fmapi_ident_switch_dev_resp_pl {
         uint8_t ingress_port_id;
@@ -525,11 +535,11 @@ static CXLRetCode cmd_identify_switch_device(const st=
ruct cxl_cmd *cmd,
=20
     out =3D (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
     *out =3D (struct cxl_fmapi_ident_switch_dev_resp_pl) {
-        .num_physical_ports =3D num_phys_ports + 1, /* 1 USP */
+        .num_physical_ports =3D num_phys_ports,
         .num_vcss =3D 1, /* Not yet support multiple VCS - potentially tri=
cky */
         .active_vcs_bitmask[0] =3D 0x1,
-        .total_vppbs =3D num_phys_ports + 1,
-        .bound_vppbs =3D num_phys_ports + 1,
+        .total_vppbs =3D num_phys_ports,
+        .bound_vppbs =3D num_phys_ports,
         .num_hdm_decoders_per_usp =3D 4,
     };
=20
@@ -541,16 +551,46 @@ static CXLRetCode cmd_identify_switch_device(const st=
ruct cxl_cmd *cmd,
         out->ingress_port_id =3D 0;
     }
=20
-    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
+    pn =3D PCIE_PORT(pp)->port;
+    out->active_port_bitmask[pn / 8] |=3D (1 << pn % 8);
+    pci_for_each_device_under_bus(&PCI_BRIDGE(pp)->sec_bus,
+                                  cxl_mark_dsp_active,
                                   out->active_port_bitmask);
-    out->active_port_bitmask[usp->port / 8] |=3D (1 << usp->port % 8);
=20
     *len_out =3D sizeof(*out);
=20
     return CXL_MBOX_SUCCESS;
 }
=20
-/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
+static CXLDownstreamPort *cxl_find_dsp_on_bus(PCIBus *bus, uint8_t pn)
+{
+
+    PCIDevice *port_dev =3D pcie_find_port_by_pn(bus, pn);
+
+    if (object_dynamic_cast(OBJECT(port_dev), TYPE_CXL_DSP)) {
+        return CXL_DSP(port_dev);
+    }
+
+    return NULL;
+}
+
+static CXLPhyPortInfo *cxl_get_phyport_info(CXLUpstreamPort *usp, uint8_t =
pn)
+{
+    CXLDownstreamPort *dsp;
+
+    if (usp->swport_data.info.port_id =3D=3D pn) {
+        return &usp->swport_data.info;
+    }
+
+    dsp =3D cxl_find_dsp_on_bus(&PCI_BRIDGE(usp)->sec_bus, pn);
+    if (dsp) {
+        return cxl_dsp_get_physical_port_info(dsp);
+    }
+
+    return NULL;
+}
+
+/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
 static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               uint8_t *payload_in,
                                               size_t len_in,
@@ -558,44 +598,22 @@ static CXLRetCode cmd_get_physical_port_state(const s=
truct cxl_cmd *cmd,
                                               size_t *len_out,
                                               CXLCCI *cci)
 {
-    /* CXL r3.1 Table 7-17: Get Physical Port State Request Payload */
+    CXLUpstreamPort *pp =3D CXL_USP(cci->d);
+    size_t pl_size;
+    int i;
+
+    /* CXL r3.2 Table 7-17: Get Physical Port State Request Payload */
     struct cxl_fmapi_get_phys_port_state_req_pl {
         uint8_t num_ports;
         uint8_t ports[];
     } QEMU_PACKED *in;
=20
-    /*
-     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
-     * Format
-     */
-    struct cxl_fmapi_port_state_info_block {
-        uint8_t port_id;
-        uint8_t config_state;
-        uint8_t connected_device_cxl_version;
-        uint8_t rsv1;
-        uint8_t connected_device_type;
-        uint8_t port_cxl_version_bitmask;
-        uint8_t max_link_width;
-        uint8_t negotiated_link_width;
-        uint8_t supported_link_speeds_vector;
-        uint8_t max_link_speed;
-        uint8_t current_link_speed;
-        uint8_t ltssm_state;
-        uint8_t first_lane_num;
-        uint16_t link_state;
-        uint8_t supported_ld_count;
-    } QEMU_PACKED;
-
-    /* CXL r3.1 Table 7-18: Get Physical Port State Response Payload */
+    /* CXL r3.2 Table 7-18: Get Physical Port State Response Payload */
     struct cxl_fmapi_get_phys_port_state_resp_pl {
         uint8_t num_ports;
         uint8_t rsv1[3];
-        struct cxl_fmapi_port_state_info_block ports[];
+        CXLPhyPortInfo ports[];
     } QEMU_PACKED *out;
-    PCIBus *bus =3D &PCI_BRIDGE(cci->d)->sec_bus;
-    PCIEPort *usp =3D PCIE_PORT(cci->d);
-    size_t pl_size;
-    int i;
=20
     in =3D (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
     out =3D (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
@@ -608,69 +626,22 @@ static CXLRetCode cmd_get_physical_port_state(const s=
truct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
=20
-    /* For success there should be a match for each requested */
-    out->num_ports =3D in->num_ports;
+    if (in->num_ports > cxl_num_switch_ports(pp)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
=20
     for (i =3D 0; i < in->num_ports; i++) {
-        struct cxl_fmapi_port_state_info_block *port;
-        /* First try to match on downstream port */
-        PCIDevice *port_dev;
-        uint16_t lnkcap, lnkcap2, lnksta;
-
-        port =3D &out->ports[i];
-
-        port_dev =3D pcie_find_port_by_pn(bus, in->ports[i]);
-        if (port_dev) { /* DSP */
-            PCIDevice *ds_dev =3D pci_bridge_get_sec_bus(PCI_BRIDGE(port_d=
ev))
-                ->devices[0];
-            port->config_state =3D 3;
-            if (ds_dev) {
-                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
-                    port->connected_device_type =3D 5; /* Assume MLD for n=
ow */
-                } else {
-                    port->connected_device_type =3D 1;
-                }
-            } else {
-                port->connected_device_type =3D 0;
-            }
-            port->supported_ld_count =3D 3;
-        } else if (usp->port =3D=3D in->ports[i]) { /* USP */
-            port_dev =3D PCI_DEVICE(usp);
-            port->config_state =3D 4;
-            port->connected_device_type =3D 0;
-        } else {
+        int pn =3D in->ports[i];
+        CXLPhyPortInfo *info =3D cxl_get_phyport_info(pp, pn);
+
+        if (!info) {
             return CXL_MBOX_INVALID_INPUT;
         }
=20
-        port->port_id =3D in->ports[i];
-        /* Information on status of this port in lnksta, lnkcap */
-        if (!port_dev->exp.exp_cap) {
-            return CXL_MBOX_INTERNAL_ERROR;
-        }
-        lnksta =3D port_dev->config_read(port_dev,
-                                       port_dev->exp.exp_cap + PCI_EXP_LNK=
STA,
-                                       sizeof(lnksta));
-        lnkcap =3D port_dev->config_read(port_dev,
-                                       port_dev->exp.exp_cap + PCI_EXP_LNK=
CAP,
-                                       sizeof(lnkcap));
-        lnkcap2 =3D port_dev->config_read(port_dev,
-                                        port_dev->exp.exp_cap + PCI_EXP_LN=
KCAP2,
-                                        sizeof(lnkcap2));
-
-        port->max_link_width =3D (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
-        port->negotiated_link_width =3D (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
-        /* No definition for SLS field in linux/pci_regs.h */
-        port->supported_link_speeds_vector =3D (lnkcap2 & 0xFE) >> 1;
-        port->max_link_speed =3D lnkcap & PCI_EXP_LNKCAP_SLS;
-        port->current_link_speed =3D lnksta & PCI_EXP_LNKSTA_CLS;
-        /* TODO: Track down if we can get the rest of the info */
-        port->ltssm_state =3D 0x7;
-        port->first_lane_num =3D 0;
-        port->link_state =3D 0;
-        port->port_cxl_version_bitmask =3D 0x2;
-        port->connected_device_cxl_version =3D 0x2;
+        memcpy(&out->ports[i], info, sizeof(*info));
     }
=20
+    out->num_ports =3D in->num_ports;
     pl_size =3D sizeof(*out) + sizeof(*out->ports) * in->num_ports;
     *len_out =3D pl_size;
=20
@@ -4633,6 +4604,45 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct =
cxl_cmd (*cxl_cmd_set)[256],
     cxl_rebuild_cel(cci);
 }
=20
+void cxl_init_physical_port_info(PCIDevice *port_dev, CXLPhyPortInfo *info,
+                                 uint8_t pn,
+                                 uint8_t current_port_config_state,
+                                 uint8_t connected_device_type,
+                                 uint8_t supported_ld_count)
+{
+    uint16_t lnkcap, lnkcap2, lnksta;
+
+    if (!port_dev->exp.exp_cap) {
+        return;
+    }
+    lnksta =3D port_dev->config_read(port_dev,
+                                   port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
+                                   sizeof(lnksta));
+    lnkcap =3D port_dev->config_read(port_dev,
+                                   port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
+                                   sizeof(lnkcap));
+    lnkcap2 =3D port_dev->config_read(port_dev,
+                                    port_dev->exp.exp_cap + PCI_EXP_LNKCAP=
2,
+                                    sizeof(lnkcap2));
+
+    *info =3D (CXLPhyPortInfo) {
+        .port_id =3D pn,
+        .current_port_config_state =3D current_port_config_state,
+        .connected_device_mode =3D CXL_PORT_CONNECTED_DEV_MODE_256B,
+        .connected_device_type =3D connected_device_type,
+        .supported_cxl_modes =3D CXL_PORT_SUPPORTS_256B,
+        .max_link_width =3D (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4,
+        .negotiated_link_width =3D (lnksta & PCI_EXP_LNKSTA_NLW) >> 4,
+        .supported_link_speeds_vector =3D (lnkcap2 & 0xFE) >> 1,
+        .max_link_speed =3D lnkcap & PCI_EXP_LNKCAP_SLS,
+        .current_link_speed =3D lnksta & PCI_EXP_LNKSTA_CLS,
+        .ltssm_state =3D CXL_PORT_LTSSM_L2,
+        .first_negotiated_lane_num =3D 0,
+        .link_state_flags =3D 0,
+        .supported_ld_count =3D supported_ld_count,
+    };
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 320818a8f1ce..8611f54ebd0c 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
@@ -24,6 +25,7 @@ typedef struct CXLDownstreamPort {
=20
     /*< public >*/
     CXLComponentState cxl_cstate;
+    CXLSwitchPortData swport_data;
 } CXLDownstreamPort;
=20
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
@@ -81,6 +83,31 @@ static void cxl_dsp_config_write(PCIDevice *d, uint32_t =
address,
     cxl_dsp_dvsec_write_config(d, address, val, len);
 }
=20
+CXLPhyPortInfo *cxl_dsp_get_physical_port_info(CXLDownstreamPort *dsp)
+{
+    CXLPhyPortInfo *info =3D &dsp->swport_data.info;
+    uint8_t connected_device_type;
+    PCIDevice *port_dev =3D PCI_DEVICE(dsp);
+    PCIDevice *ds_dev =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dsp))
+        ->devices[0];
+
+    if (ds_dev) {
+        if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+            connected_device_type =3D CXL_PORT_CONNECTED_DEV_TYPE_3_SLD;
+        } else {
+            connected_device_type =3D CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
+        }
+    } else {
+        connected_device_type =3D CXL_PORT_CONNECTED_DEV_TYPE_NONE;
+    }
+
+    cxl_init_physical_port_info(port_dev, info, PCIE_PORT(dsp)->port,
+                                CXL_PORT_CONFIG_STATE_DSP,
+                                connected_device_type, 3);
+
+    return info;
+}
+
 static void cxl_dsp_reset(DeviceState *qdev)
 {
     PCIDevice *d =3D PCI_DEVICE(qdev);
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index fb8d19539c9f..64f31110ff2c 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -103,6 +103,11 @@ static void cxl_usp_reset(DeviceState *qdev)
     pcie_cap_deverr_reset(d);
     pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
     latch_registers(usp);
+
+    /* Assume that the info about the upstream link only changes on reset.=
 */
+    cxl_init_physical_port_info(PCI_DEVICE(usp), &usp->swport_data.info,
+                                PCIE_PORT(usp)->port, CXL_PORT_CONFIG_STAT=
E_USP,
+                                CXL_PORT_CONNECTED_DEV_TYPE_NONE, 0);
 }
=20
 static void build_dvsecs(CXLUpstreamPort *usp)
--=20
2.48.1



>=20
> Additionally, it introduces new support for Physical Port Control
> of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
> It primarily constitutes two logic:
>     -Assert-Deassert PERST: Assert PERST involves physical port to be in
>      hold reset phase for minimum 100ms. No other physical port control
>      request are entertained until Deassert PERST command for the given
>      port is issued.
>     -Reset PPB: cold reset of physical port (completing enter->hold->exit
>      phases).
>=20
> Tested using libcxl-mi interface[1]:
> All active ports and all opcodes per active port is tested. Also, tested
> against possible edge cases manually since the interface currently dosen't
> support run time input.
>=20
> Typical Qemu topology
> (1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 D=
SP's):
> FM=3D"-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D$TMP_DIR/t3_cx=
l1.raw,size=3D256M \
>     -object memory-backend-file,id=3Dcxl-lsa1,mem-path=3D$TMP_DIR/t3_lsa1=
.raw,size=3D1M \
>     -object memory-backend-file,id=3Dcxl-mem2,mem-path=3D$TMP_DIR/t3_cxl2=
.raw,size=3D512M \
>     -object memory-backend-file,id=3Dcxl-lsa2,mem-path=3D$TMP_DIR/t3_lsa2=
.raw,size=3D512M \
>     -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1,hdm_for_passthrou=
gh=3Dtrue \
>     -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,slo=
t=3D2 \
>     -device cxl-upstream,port=3D2,sn=3D1234,bus=3Dcxl_rp_port0,id=3Dus0,a=
ddr=3D0.0,multifunction=3Don, \
>     -device cxl-switch-mailbox-cci,bus=3Dcxl_rp_port0,addr=3D0.1,target=
=3Dus0 \
>     -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,sl=
ot=3D4 \
>     -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,sl=
ot=3D5 \
>     -device cxl-downstream,port=3D3,bus=3Dus0,id=3Dswport2,chassis=3D0,sl=
ot=3D6 \
>     -device cxl-type3,bus=3Dswport0,memdev=3Dcxl-mem1,id=3Dcxl-pmem1,lsa=
=3Dcxl-lsa1,sn=3D3 \
>     -device cxl-type3,bus=3Dswport2,memdev=3Dcxl-mem2,id=3Dcxl-pmem2,lsa=
=3Dcxl-lsa2,sn=3D4 \
>     -machine cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.in=
terleave-granularity=3D1k \
>     -device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D4,target=3Dus0 \
>     -device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D5,target=3Dcxl-=
pmem1 \
>     -device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D6,target=3Dcxl-=
pmem2 \
>     -device virtio-rng-pci,bus=3Dswport1"
>=20
> Tested multiple Qemu topologies:
>         -without any devices connected to downstream ports.
>         -with virtio-rng-pci devices connected to downstream ports.
>         -with CXLType3 devices connected to downstream ports.
>         -with different unique values of ports (both upstream and downstr=
eam).
>=20
> Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.000001=
90@huawei.com/T/):
>         -Namespaced the defines with cleaner prefix for Get Physical Port=
 State=20
>          Port Information Block members.
>         -switch CCI implementation instead of switch FM interface as per
>          Jonathan's review comments, hence moved perst members initializa=
tions
>          from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swc=
ci().
>=20
> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f=
832a87694d7b18d2d50be5b8
>=20
> The patches are generated against the Johnathan's tree
> https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.
>=20
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>=20
> Arpit Kumar (2):
>   hw/cxl: Refactored Identify Switch Device & Get Physical Port State
>   hw/cxl: Add Physical Port Control (Opcode 5102h)
>=20
>  hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
>  include/hw/cxl/cxl_device.h               |  76 +++++
>  include/hw/cxl/cxl_mailbox.h              |   1 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   9 +
>  4 files changed, 348 insertions(+), 106 deletions(-)
>=20

