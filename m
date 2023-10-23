Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C21427E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3824CC
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 09:12:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg8y29cNz6JBBn;
	Tue, 24 Oct 2023 00:08:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:12:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
	<gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 08/17] hw/cxl/mbox: Add Physical Switch Identify command.
Date: Mon, 23 Oct 2023 17:07:57 +0100
Message-ID: <20231023160806.13206-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

Enable it for the switch CCI.

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
index 6741698ee7..6ada49d37c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -70,6 +70,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
 };
 
 
@@ -257,6 +259,67 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
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
@@ -816,6 +879,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0 },
 };
 
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
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

