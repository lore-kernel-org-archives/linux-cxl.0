Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C44CCE7A9D
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjIYQVO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjIYQVM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:21:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42010C
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:21:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSkw2fQKz6K9px;
        Tue, 26 Sep 2023 00:19:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:21:03 +0100
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
Subject: [PATCH 19/19] hw/cxl: Add tunneled command support to mailbox for switch cci/mctp.
Date:   Mon, 25 Sep 2023 17:11:24 +0100
Message-ID: <20230925161124.18940-20-Jonathan.Cameron@huawei.com>
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

The implementation of tunneling makes the choice that our Type 3 device is
a Logical Device (LD) of a Multi-Logical Device (MLD) that just happens to
only have one LD for now.

Tunneling is supported from a Switch Mailbox CCI or via MCTP over I2C
connected to the switch mctp CCI via an outer level to the FM owned LD in
the MLD Type 3 device. From there an inner tunnel may be used to access
particular LDs.

Protocol wise, the following is what happens in a real system but we
don't emulate the transports - just the destinations and the payloads.

( Host -> Switch Mailbox CCI - in band FM-API mailbox command
  or
  Host -> Switch MCTP CCI - MCTP over I2C using the CXL FM-API
  MCTP Binding.
)
then (if a tunnel command)
Switch -> Type 3 FM Owned LD - MCTP over PCI VDM using the
CXL FM-API binding (addressed by switch port)
then (if next command also a tunnel)
Type 3 FM Owned LD to LD0 via internal transport
(addressed by LD number)

or

Host to Type 3 FM Owned MCTP CCI - MCTP over I2C using the
CXL FM-API MCTP Binding.
thn (if next comamnd alstunnel)
Type 3 FM Owned LD to LD0 via internal transport.
(addressed by LD number)

It is worth noting that the tunneling commands over PCI VDM
presumably use the FM-API MCTP binding not the CXL Memory
Device Binding so it may not be possible to issue tunneled
commands to an SLD.  This and the near term usecase of
controlling DCD motivated the decision to emulate an MLD
from the start.

Additional commands will need to be added to make this
useful beyond testing the tunneling works.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  10 +++
 hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  11 +++
 3 files changed, 173 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index dfa25a0837..f9d921e8e4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -281,6 +281,13 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             bool *bg_started);
 void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                size_t payload_max);
+void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
+                                           DeviceState *intf,
+                                           size_t payload_max);
+
+void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
+                              DeviceState *intf, size_t payload_max);
+
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                 size_t payload_max);
 
@@ -402,6 +409,9 @@ struct CXLType3Dev {
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
     CXLCCI oob_mctp_cci; /* Initialized only if targetted */
+    /* Always intialized as no way to know if a VDM might show up */
+    CXLCCI vdm_fm_owned_ld_mctp_cci;
+    CXLCCI ld0_cci;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f40f12f0de..467735395d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -82,8 +82,125 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+    TUNNEL = 0x53,
+        #define MANAGEMENT_COMMAND     0x0
 };
 
+/* CCI Message Format CXL r3.0 Figure 7-19 */
+typedef struct CXLCCIMessage {
+    uint8_t category;
+#define CXL_CCI_CAT_REQ 0
+#define CXL_CCI_CAT_RSP 1
+    uint8_t tag;
+    uint8_t resv1;
+    uint8_t command;
+    uint8_t command_set;
+    uint8_t pl_length[3];
+    uint16_t rc;
+    uint16_t vendor_specific;
+    uint8_t payload[];
+} QEMU_PACKED CXLCCIMessage;
+
+/* This command is only defined to an MLD FM Owned LD or an MHD */
+static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    PCIDevice *tunnel_target;
+    CXLCCI *target_cci;
+    struct {
+        uint8_t port_or_ld_id;
+        uint8_t target_type;
+        uint16_t size;
+        CXLCCIMessage ccimessage;
+    } QEMU_PACKED *in;
+    struct {
+        uint16_t resp_len;
+        uint8_t resv[2];
+        CXLCCIMessage ccimessage;
+    } QEMU_PACKED *out;
+    size_t pl_length, length_out;
+    bool bg_started;
+    int rc;
+
+    if (cmd->in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    in = (void *)payload_in;
+    out = (void *)payload_out;
+
+    /* Enough room for minimum sized message - no payload */
+    if (in->size < sizeof(in->ccimessage)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+    if (in->ccimessage.category != CXL_CCI_CAT_REQ) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->target_type != 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "Tunneled Command sent to no existent FM-LD");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /*
+     * Target of a tunnel unfortunately depends on type of CCI readint
+     * the message.
+     * If in a switch, then it's the port number.
+     * If in an MLD it is the ld number.
+     * If in an MHD target type indicate where we are going.
+     */
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+        if (in->port_or_ld_id != 0) {
+            /* Only pretending to have one for now! */
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        target_cci = &ct3d->ld0_cci;
+    } else if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
+        CXLUpstreamPort *usp = CXL_USP(cci->d);
+
+        tunnel_target = pcie_find_port_by_pn(&PCI_BRIDGE(usp)->sec_bus,
+                                             in->port_or_ld_id);
+        if (!tunnel_target) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        tunnel_target =
+            pci_bridge_get_sec_bus(PCI_BRIDGE(tunnel_target))->devices[0];
+        if (!tunnel_target) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        if (object_dynamic_cast(OBJECT(tunnel_target), TYPE_CXL_TYPE3)) {
+            CXLType3Dev *ct3d = CXL_TYPE3(tunnel_target);
+            /* Tunneled VDMs always land on FM Owned LD */
+            target_cci = &ct3d->vdm_fm_owned_ld_mctp_cci;
+        } else {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    } else {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    pl_length = in->ccimessage.pl_length[2] << 16 |
+        in->ccimessage.pl_length[1] << 8 | in->ccimessage.pl_length[0];
+    rc = cxl_process_cci_message(target_cci,
+                                 in->ccimessage.command_set,
+                                 in->ccimessage.command,
+                                 pl_length, in->ccimessage.payload,
+                                 &length_out, out->ccimessage.payload,
+                                 &bg_started);
+    /* Payload should be in place. Rest of CCI header and needs filling */
+    out->resp_len = length_out + sizeof(CXLCCIMessage);
+    st24_le_p(out->ccimessage.pl_length, length_out);
+    out->ccimessage.rc = rc;
+    out->ccimessage.category = CXL_CCI_CAT_RSP;
+    *len_out = length_out + sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
 
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
@@ -1154,6 +1271,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0x49 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, ~0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, ~0 },
 };
 
 /*
@@ -1333,6 +1452,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 
 static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, ~0 },
 };
 
 void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
@@ -1344,12 +1465,43 @@ void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cxl_init_cci(cci, payload_max);
 }
 
+static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+};
+
+void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_t3_ld;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
+static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, ~0 },
+};
+
+void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
+                                           DeviceState *intf,
+                                           size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_t3_fm_owned_ld_mctp;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
 static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
     [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
         cmd_identify_switch_device, 0, 0x49 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, ~0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, ~0 },
 };
 
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a766c64575..52647b4ac7 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,6 +936,17 @@ static void ct3d_reset(DeviceState *dev)
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
+
+    /*
+     * Bring up an endpoint to target with MCTP over VDM.
+     * This device is emulating an MLD with single LD for now.
+     */
+    cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->vdm_fm_owned_ld_mctp_cci,
+                                          DEVICE(ct3d), DEVICE(ct3d),
+                                          512); /* Max payload made up */
+    cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
+                             512); /* Max payload made up */
+
 }
 
 static Property ct3_props[] = {
-- 
2.39.2

