Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F42EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGQRZO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGQRZN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:25:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB6171E
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:24:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TRQ5NZqz6J6Bx;
        Tue, 18 Jul 2023 01:22:26 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:24:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 16/17] hw/cxl: Implement Physical Ports status retrieval
Date:   Mon, 17 Jul 2023 18:16:45 +0100
Message-ID: <20230717171646.8972-17-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-of-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 87 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c1020d9ab..4cddd6eae1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -73,6 +73,7 @@ enum {
         #define CLEAR_POISON           0x2
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
+        #define GET_PHYSICAL_PORT_STATE     0x1
 };
 
 
@@ -318,6 +319,88 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    /*
+     * CXL r3.0 7.6.7.1.2 Get Physical Port State (Opcode 5101h)
+     */
+    /* CXL r3.0 Table 7-18 Get Physical Port State Request Payload */
+    struct cxl_fmapi_get_phys_port_state_req_pl {
+        uint8_t num_ports; /* CHECK. may get too large for MCTP message size */
+        uint8_t ports[];
+    } QEMU_PACKED *in;
+
+    /* CXL r3.0 Table 7-20 Get Physical Port State Port Information Block Format */
+    struct cxl_fmapi_port_state_info_block {
+        uint8_t port_id;
+        uint8_t config_state;
+        uint8_t connected_device_cxl_version;
+        uint8_t rsv1;
+        uint8_t connected_device_type;
+        uint8_t port_cxl_version_bitmask;
+        uint8_t max_link_width;
+        uint8_t negotiated_link_width;
+        uint8_t supported_link_speeds_vector;
+        uint8_t max_link_speed;
+        uint8_t current_link_speed;
+        uint8_t ltssm_state;
+        uint8_t first_lane_num;
+        uint16_t link_state;
+        uint8_t supported_ld_count;
+    } QEMU_PACKED;
+
+    /* CXL r3.0 Table 7-19 Get Physical Port State Response Payload */
+    struct cxl_fmapi_get_phys_port_state_resp_pl {
+        uint8_t num_ports;
+        uint8_t rsv1[3];
+        struct cxl_fmapi_port_state_info_block ports[];
+    } QEMU_PACKED *out;
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    int num_phys_ports = pcie_count_ds_ports(bus);
+    int i;
+    size_t pl_size;
+ 
+    in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
+    out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
+    /* Not currently matching against requested  */
+    out->num_ports = num_phys_ports;
+
+    for (i = 0; i < out->num_ports; i++) {
+        struct cxl_fmapi_port_state_info_block *port;
+        port = &out->ports[i];
+        port->port_id = i; /* TODO: Right port number */
+        if (port->port_id < 1) { /* 1 upstream ports */
+            port->config_state = 4;
+            port->connected_device_type = 0;
+        } else { /* remainder downstream ports */
+            port->config_state = 3;
+            port->connected_device_type = 4; /* TODO: Check. CXL type 3 */
+            port->supported_ld_count = 3;
+        }
+        port->connected_device_cxl_version = 2;
+        port->port_cxl_version_bitmask = 0x2;
+        port->max_link_width = 0x10; /* x16 */
+        port->negotiated_link_width = 0x10;
+        port->supported_link_speeds_vector = 0x1c; /* 8, 16, 32 GT/s */
+        port->max_link_speed = 5;
+        port->current_link_speed = 5; /* 32 */
+        port->ltssm_state = 0x7; /* L2 */
+        port->first_lane_num = 0;
+        port->link_state = 0;
+    }
+
+    pl_size = sizeof(out) + sizeof(*out->ports) * in->num_ports;
+
+    *len_out = pl_size;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.0 8.2.9.1.2 */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -905,6 +988,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
         cmd_identify_switch_device, 0, 0x49 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, ~0 },
 };
 
 /*
@@ -990,6 +1075,8 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
     [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
         cmd_identify_switch_device, 0, 0x49 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, ~0 },
 };
 
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf, size_t payload_max)
-- 
2.39.2

