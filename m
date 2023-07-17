Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62613C0015E
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGQRZt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQRZs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:25:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF2B5
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:25:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TQK2z2cz682sK;
        Tue, 18 Jul 2023 01:21:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:25:25 +0100
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
Subject: [RFC PATCH 17/17] hw/cxl: Add tunneled command support to mailbox for switch cci.
Date:   Mon, 17 Jul 2023 18:16:46 +0100
Message-ID: <20230717171646.8972-18-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
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

Allow a switch CCI to perform basic tunneling (which is transported
in real hardware via PCIe VDM) to downstream devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 92 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  4 ++
 3 files changed, 97 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 215383ba37..4f8095847e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -407,6 +407,7 @@ struct CXLType3Dev {
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
     CXLCCI oob_mctp_cci; /* Initialized only if targetted */
+    CXLCCI vdm_mctp_cci; /* Always intialized as no way to know if a VDM might show up */
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4cddd6eae1..33f7b9a9a5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -74,8 +74,98 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+    TUNNEL = 0x53,
+        #define MANAGEMENT_COMMAND     0x0
 };
 
+/* CCI Message Format CXL r3.0 Figure 7-19 */
+typedef struct CXLCCIMessage {
+    uint8_t category;
+    uint8_t tag;
+    uint8_t resv1;
+    uint8_t command;
+    uint8_t command_set;
+    uint8_t pl_length[3];
+    uint16_t vendor_specific;
+    uint16_t rc;
+    uint8_t payload[];
+} QEMU_PACKED CXLCCIMessage;
+    
+static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    CXLUpstreamPort *usp = CXL_USP(cci->d);
+    PCIDevice *tunnel_target;
+    struct {
+        uint8_t port_or_ld_id;
+        uint8_t target_type;
+        uint16_t size;
+        CXLCCIMessage ccimessage;
+    } *in;
+    struct {
+        uint16_t resp_len;
+        uint8_t resv[2];
+        CXLCCIMessage ccimessage;
+    } *out;
+
+    if (cmd->in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    in = (void *)payload_in;
+    out = (void*)payload_out;
+    
+    if (cmd->in < sizeof(*in) + in->size) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    if (in->size < 3 * sizeof(uint32_t)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    /* Need to find target CCI */
+    //Lets assume simple tunnel to port - find that device.
+    if (in->target_type != 0) {
+        printf("QEMU: sent to FM-LD which makes no sense yet\n");
+    }
+
+    tunnel_target = pcie_find_port_by_pn(&PCI_BRIDGE(usp)->sec_bus, in->port_or_ld_id);
+    if (!tunnel_target) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    tunnel_target = pci_bridge_get_sec_bus(PCI_BRIDGE(tunnel_target))->devices[0];
+    if (!tunnel_target) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (object_dynamic_cast(OBJECT(tunnel_target), TYPE_CXL_TYPE3)) {
+        CXLType3Dev *ct3d = CXL_TYPE3(tunnel_target);
+        size_t pl_length = in->ccimessage.pl_length[2] << 16 |
+            in->ccimessage.pl_length[1] << 8 | in->ccimessage.pl_length[0];
+        size_t length_out;
+        bool bg_started;
+        int rc;
+
+        rc = cxl_process_cci_message(&ct3d->vdm_mctp_cci,
+                                     in->ccimessage.command_set,
+                                     in->ccimessage.command,
+                                     pl_length, in->ccimessage.payload,
+                                     &length_out, out->ccimessage.payload,
+                                     &bg_started);
+        /* Payload should be in place.. But rest of CCI header and needs filling */
+        out->resp_len = length_out + sizeof(CXLCCIMessage); /* CHECK */
+        st24_le_p(out->ccimessage.pl_length, length_out);
+        out->ccimessage.rc = rc;
+        printf("len_out is %lu\n", length_out);
+        *len_out = length_out + sizeof(*out);
+
+        return CXL_MBOX_SUCCESS;
+    }
+
+    return CXL_MBOX_INVALID_INPUT;
+}
 
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
@@ -990,6 +1080,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0x49 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, ~0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, ~0 }, 
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f479dc67e8..5714ea0c77 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1042,6 +1042,10 @@ static void ct3d_reset(DeviceState *dev)
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
+
+    /* Bring up an endpoint to target with MCTP over VDM */
+    cxl_initialize_usp_mctpcci(&ct3d->vdm_mctp_cci, DEVICE(ct3d), DEVICE(ct3d),
+                               512); /* Max payload made up */
 }
 
 static Property ct3_props[] = {
-- 
2.39.2

