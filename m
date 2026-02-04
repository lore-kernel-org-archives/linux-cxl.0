Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E2125D0
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226379; cv=none; b=XHL6qzXzsZthApDehO8+QhjE/GFQrSueb8Kvz6Py4UcjylLAzbHwCJmM8g3Vo36TkQhd45Xe5B1eoCyfdk3qiPm47hgJX7QE9HkUbQOulKAgKkSr4lt+A/asbnNYwx0M1+p7SaXt4JEZa73VN97f6k06Deudm4k9HZGyIRYVYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226379; c=relaxed/simple;
	bh=g5Ux+EYQNbpOHbGf4MHrmUT8TYcq8+WQL5tITuuOFqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS+txvX/rht5a27peB/JhdNXID9gjo2cCC8Ryajm1N4BgPUG37mp1kOkIhVBtBoJ3tRwl0D93LovDLt8NiYuwJA7xaFx2Q0iHGty9/K6+H6CaDccsJTfYrxcVZdPPM5P5Bqw65+oUOvhqdTHGBMpqMydWnYYpbTT7ebv5RGE1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5nTy6KBXzJ46FB;
	Thu,  5 Feb 2026 01:32:06 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CE0D40569;
	Thu,  5 Feb 2026 01:32:56 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:32:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Arpit Kumar
	<arpit1.kumar@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 1/3] hw/cxl: Physical Port Info FMAPI - update to current spec and add defines.
Date: Wed, 4 Feb 2026 17:32:21 +0000
Message-ID: <20260204173223.44122-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Arpit Kumar <arpit1.kumar@samsung.com>

Add a new cxl/cxl_ports.h header for field definitions related only to port
commands. Bring field naming up to date with spec as 'version' bitmasks
have been replaced with bitmasks of the specific features.

Fix a small issue where a reserved value for USP was set to 2 rather
than 0.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---
This is effectively lifted out of Arpit's orginal rework.
Arpit please confirm you are fine with keeping authorship on this one.
---
 include/hw/cxl/cxl_port.h  | 53 ++++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c | 31 ++++++++++++++--------
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
new file mode 100644
index 000000000000..04db60f7bc23
--- /dev/null
+++ b/include/hw/cxl/cxl_port.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef CXL_PORT_H
+#define CXL_PORT_H
+
+/* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
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
+#endif /* CXL_PORT_H */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2f449980cdc0..1c8cbe0f682d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -15,6 +15,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_port.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
@@ -565,16 +566,16 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     } QEMU_PACKED *in;
 
     /*
-     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
+     * CXL r3.2 Table 7-19: Get Physical Port State Port Information Block
      * Format
      */
     struct cxl_fmapi_port_state_info_block {
         uint8_t port_id;
         uint8_t config_state;
-        uint8_t connected_device_cxl_version;
+        uint8_t connected_device_mode;
         uint8_t rsv1;
         uint8_t connected_device_type;
-        uint8_t port_cxl_version_bitmask;
+        uint8_t supported_cxl_mode_bitmask;
         uint8_t max_link_width;
         uint8_t negotiated_link_width;
         uint8_t supported_link_speeds_vector;
@@ -623,21 +624,30 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         if (port_dev) { /* DSP */
             PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
                 ->devices[0];
-            port->config_state = 3;
+            port->config_state = CXL_PORT_CONFIG_STATE_DSP;
             if (ds_dev) {
                 if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
-                    port->connected_device_type = 5; /* Assume MLD for now */
+                    /* Assume MLD for now */
+                    port->connected_device_type =
+                        CXL_PORT_CONNECTED_DEV_TYPE_3_MLD;
                 } else {
-                    port->connected_device_type = 1;
+                    port->connected_device_type =
+                        CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
+                    port->connected_device_mode =
+                        CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
+
                 }
             } else {
-                port->connected_device_type = 0;
+                port->connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
+                port->connected_device_mode =
+                    CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
             }
             port->supported_ld_count = 3;
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
-            port->config_state = 4;
-            port->connected_device_type = 0;
+            port->config_state = CXL_PORT_CONFIG_STATE_USP;
+            port->connected_device_type = 0; /* Reserved for USP */
+            port->connected_device_mode = 0; /* Reserved for USP */
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -667,8 +677,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
         port->link_state = 0;
-        port->port_cxl_version_bitmask = 0x2;
-        port->connected_device_cxl_version = 0x2;
+        port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
-- 
2.51.0

