Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CD18E36
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414FE10A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 09:16:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgHL0vrLz6K6Rw;
	Tue, 24 Oct 2023 00:14:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:16:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
	<gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 17/17] hw/cxl: Add tunneled command support to mailbox for switch cci.
Date: Mon, 23 Oct 2023 17:08:06 +0100
Message-ID: <20231023160806.13206-18-Jonathan.Cameron@huawei.com>
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

This implementation of tunneling makes the choice that our Type 3 device is
a Logical Device (LD) of a Multi-Logical Device (MLD) that just happens to
only have one LD for now.

Tunneling is supported from a Switch Mailbox CCI (and shortly via MCTP over
I2C connected to the switch MCTP CCI) via an outer level to the FM owned LD
in the MLD Type 3 device. From there an inner tunnel may be used to access
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
then (if unwrapped command also a tunnel command)
Type 3 FM Owned LD to LD0 via internal transport
(addressed by LD number)

or (added shortly)

Host to Type 3 FM Owned MCTP CCI - MCTP over I2C using the
CXL FM-API MCTP Binding.
then (if unwrapped comand is a tunnel comamnd)
Type 3 FM Owned LD to LD0 via internal transport.
(addressed by LD number)

It is worth noting that the tunneling commands over PCI VDM
presumably use the appropriate MCTP binding depending on opcode.
This may be the CXL FMAPI binding or the CXL Memory Device Binding.

Additional commands will need to be added to make this
useful beyond testing the tunneling works.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
- Fix some missing element in tunneled responses (tag, cmd, cmd_set)
  Picked up by adding a more exhaustive test case.
- Reordering to move the MCTP over i2c support to after this resulted
  in various changes.
---
 include/hw/cxl/cxl_device.h |   9 ++
 hw/cxl/cxl-mailbox-utils.c  | 162 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  11 +++
 3 files changed, 182 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 70aca9024c..61b7f897f7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -279,6 +279,12 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
                             bool *bg_started);
+void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
+                                           DeviceState *intf,
+                                           size_t payload_max);
+
+void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
+                              DeviceState *intf, size_t payload_max);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
@@ -397,6 +403,9 @@ struct CXLType3Dev {
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
+    /* Always intialized as no way to know if a VDM might show up */
+    CXLCCI vdm_fm_owned_ld_mctp_cci;
+    CXLCCI ld0_cci;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 693c2cbdcd..b365575097 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -82,8 +82,132 @@ enum {
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
+    /* Length of input payload should be in->size + a wrapping tunnel header */
+    if (in->size != len_in - offsetof(typeof(*out), ccimessage)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+    if (in->ccimessage.category != CXL_CCI_CAT_REQ) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->target_type != 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "Tunneled Command sent to non existent FM-LD");
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
+    out->ccimessage.command = in->ccimessage.command;
+    out->ccimessage.command_set = in->ccimessage.command_set;
+    out->ccimessage.tag = in->ccimessage.tag;
+    *len_out = length_out + sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
 
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
@@ -1171,6 +1295,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
 };
 
 /*
@@ -1347,3 +1473,39 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cci->intf = d;
     cxl_init_cci(cci, payload_max);
 }
+
+static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
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
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
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

