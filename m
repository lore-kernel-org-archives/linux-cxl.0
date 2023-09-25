Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D4ACE7A9A
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjIYQQH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjIYQQG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:16:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41992
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:15:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSXh4xZ6z6K9py;
        Tue, 26 Sep 2023 00:11:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:15:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 09/19] hw/cxl/mbox: Add Physical Switch Identify command.
Date:   Mon, 25 Sep 2023 17:11:14 +0100
Message-ID: <20230925161124.18940-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Enable it for MCTP CCI for the switch. Will shortly be enabled for switch
CCI as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h           |  6 ++++
 hw/cxl/cxl-mailbox-utils.c     | 65 ++++++++++++++++++++++++++++++++++
 hw/pci-bridge/cxl_downstream.c |  4 +--
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 4944725849..75e47b6864 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -61,4 +61,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 typedef struct CXLUpstreamPort CXLUpstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLUpstreamPort, CXL_USP, TYPE_CXL_USP)
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
+
+#define TYPE_CXL_DSP "cxl-downstream"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
+
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 84dc9d8963..e319cfccf7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -70,6 +70,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
 };
 
 
@@ -249,6 +251,67 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
+                                  void *private)
+{
+    uint8_t *bm = private;
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
+        uint8_t port = PCIE_PORT(d)->port;
+        bm[port / 8] |= 1 << (port % 8);
+    }
+}
+
+/* CXL r3 8.2.9.1.1 */
+static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    int num_phys_ports = pcie_count_ds_ports(bus);
+
+    struct cxl_fmapi_ident_switch_dev_resp_pl {
+        uint8_t ingress_port_id;
+        uint8_t rsvd;
+        uint8_t num_physical_ports;
+        uint8_t num_vcss;
+        uint8_t active_port_bitmask[0x20];
+        uint8_t active_vcs_bitmask[0x20];
+        uint16_t total_vppbs;
+        uint16_t bound_vppbs;
+        uint8_t num_hdm_decoders_per_usp;
+    } QEMU_PACKED *out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 0x49);
+
+    out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
+    *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
+        .num_physical_ports = num_phys_ports + 1, /* 1 USP */
+        .num_vcss = 1, /* Not yet support multiple VCS - potentialy tricky */
+        .active_vcs_bitmask[0] = 0x1,
+        .total_vppbs = num_phys_ports + 1,
+        .bound_vppbs = num_phys_ports + 1,
+        .num_hdm_decoders_per_usp = 4,
+    };
+
+    /* Depends on the CCI type */
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_PCIE_PORT)) {
+        out->ingress_port_id = PCIE_PORT(cci->intf)->port;
+    } else {
+        /* MCTP? */
+        out->ingress_port_id = 0;
+    }
+
+    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
+                                  out->active_port_bitmask);
+    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
+
+    *len_out = sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -866,6 +929,8 @@ void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 
 static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0x49 },
 };
 
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 8c0f759add..8d99e1e96d 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
 typedef struct CXLDownstreamPort {
@@ -23,9 +24,6 @@ typedef struct CXLDownstreamPort {
     CXLComponentState cxl_cstate;
 } CXLDownstreamPort;
 
-#define TYPE_CXL_DSP "cxl-downstream"
-DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
-
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR 1
 #define CXL_DOWNSTREAM_PORT_EXP_OFFSET 0x90
-- 
2.39.2

