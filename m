Received: from black.aspen.relay.mailchannels.net (black.aspen.relay.mailchannels.net [23.83.221.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDB15C0
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737433540; cv=pass; b=VQvJYnDzilsu1Zr8Med/y5/OgPDWUiYhuYuadbyw1w1+GqbphXMf29FWJYHRk9JMHcnpLxg7O53QUjTLmvm+B/m/C72dlE3M9MrIRxQhCpYFg5Vq3VjfNG28XwuGhNqfq3uvSMegZntq18HyZAbuU6rhjaQSrIsldtuR60AsxQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737433540; c=relaxed/simple;
	bh=eAz9RkocehGQwri8yjRZnt6VbbxvDtbn8lYaA9dv8hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tj9rY6t/bkpVEwGGg5NeUYBF8GR1nOxLKQ8+J1fD3T25o7rPaQeRD2XWSzW0zHTjrCrVNyC9PGoPqca9+cmZlGNRHbAINSfIMNOzOeTjgZ2SGRysrS5Za7MkT5tfbNqLIlvDkzZIETdKOUewa0d6N66ArrWEc5Qb2twB3auJcYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=chm/uAzu; arc=pass smtp.client-ip=23.83.221.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="chm/uAzu"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 77AB31C28FF;
	Tue, 21 Jan 2025 04:25:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.117.137.138])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DCCDF1C2975;
	Tue, 21 Jan 2025 04:25:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1737433536; a=rsa-sha256;
	cv=none;
	b=ivu2NPtCTcRfryvEfWRIHhKyiMqkuGFEvdx2d06nG0t6vdUqLcrd5HDgsQBx2zZDCdqYJC
	IQOLmpAGW81pZMqe/+lk4PkjoGVyYSNHmgfg+YG8N1kDcp5oVtHrYIiieTVL0DVsWQ7Tip
	6LJxM/smAw52Fdqxqro6oelcL6G5EM6LuhatGDdquWUiMCDgNi42TiT0DHhcJldddo+hhV
	9w+4Z13Cr4bPLFgFuuo2tdIh3NqxIb7y/pp9EG481PFpQWQD6oBv4KpGAbd5qh8b6uHjFX
	9rMz4Z6GMj5zxo06ntKBuoJra1/Vof1bD/WkAMsCpbF9ejSyrexcKrvaARz8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1737433536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=XxhcPqUJD3zDNUfejEgdcJgiN7L32+eQ0b+Qv9DF+Bk=;
	b=QbHa4CUg3YnhY7FEHGwSImKao7oIm4JAUmrO8prpE6dBD9WyR2xp3b6+X+XR5iKOWflRFe
	IY796jVIMj1QUfqyP6Cz4OI1fTGqeOfd+0s0Xpt2OrRFFEQ+nY58W9Bvr2CkT+vMT8uxNi
	+ixvumO4s905zLMznK/Zjh86FQnx5V8MqzPPfINsZ2ID5BSdSfBO9FWBaqbbYN8qRbIJ2c
	LmDowJXHy3qr5k43YTFWWatyiitzIwFvx0xd2RaIn1LkKACksIDF/fj3Yeg42XZLu+ua1g
	VbOorvts/xDuXkfqRJxy6ZyxKl9hW7z3S/HYO8DjZyLk4mi6F3gLb6Bfh1MnBQ==
ARC-Authentication-Results: i=1;
	rspamd-7c8d66d945-7bdqg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Juvenile: 68f326b507fb8318_1737433536234_88258609
X-MC-Loop-Signature: 1737433536234:3567446871
X-MC-Ingress-Time: 1737433536234
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.137.138 (trex/7.0.2);
	Tue, 21 Jan 2025 04:25:36 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4YcYzL67cVz8w;
	Mon, 20 Jan 2025 20:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1737433535;
	bh=XxhcPqUJD3zDNUfejEgdcJgiN7L32+eQ0b+Qv9DF+Bk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=chm/uAzuYzJPeFvgBdMDsoUBh0y//LH8MmuTNwFSdPvb35dGtQXMa8L+ZNKcbts7V
	 /mrVJGcqhZVO1HRGb2Ii1FGTgrdoWIe655h8fTX7rTfiHT0dIfKzrWEuLM47k/GVYA
	 YTjG4NKL9TT2NNPDhLTawUAvqZvKDPmeiPPS74/fWiYOLJBRFjwp4t3/UMOJqzBfub
	 R4o5oZ4lOyNQ2k240gDmmyW8OK6w2LgfcCfBTC0A2klWvAy2rUOdWIYVQ8W6pci9bp
	 9assWCtz3F6u7KLx9SlvVfALruvYj7VvvDpIKoQoq5rTPIzTzlDpRrassEoH6MvBIi
	 3NsooHVmoQZVQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	hch@infradead.org,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3] cxl/pci: Support Global Persistent Flush (GPF)
Date: Mon, 20 Jan 2025 20:25:31 -0800
Message-Id: <20250121042531.776377-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for GPF flows. It is found that the CXL specification
around this to be a bit too involved from the driver side. And while
this should really all handled by the hardware, this patch takes
things with a grain of salt.

Upon respective port enumeration, both phase timeouts are set to
a max of 20 seconds, which is the NMI watchdog default for lockup
detection. The premise is that the kernel does not have enough
information to set anything better than a max across the board
and hope devices finish their GPF flows within the platform energy
budget.

Timeout detection is based on dirty Shutdown semantics. The driver
will mark it as dirty, expecting that the device clear it upon a
successful GPF event. The admin may consult the device Health and
check the dirty shutdown counter to see if there was a problem
with data integrity.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v2:
 - Remove RFC tag.
 - Setup T2MAX to 20 secs, just like T1 (Dan).
   This simplifies the patch significantly: 1) no longer need to 
   update upon hot-removal, 2) don't need the device max timeouts. 
 - Configure dvsec at port enumeration time, not pci_probe (Dan).
 - Skip RCH.
 - Cosmetic cleanups (Jonathan)

 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 18 ++++
 drivers/cxl/core/pci.c                        | 83 +++++++++++++++++++
 drivers/cxl/core/port.c                       |  2 +
 drivers/cxl/cxl.h                             |  2 +
 drivers/cxl/cxlmem.h                          |  5 ++
 drivers/cxl/cxlpci.h                          | 15 ++++
 drivers/cxl/pci.c                             | 21 +++--
 8 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index df8e2ac2a320..99dd2c841e69 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -130,7 +130,7 @@ Mailbox commands
 * [0] Switch CCI
 * [3] Timestamp
 * [1] PMEM labels
-* [0] PMEM GPF / Dirty Shutdown
+* [1] PMEM GPF / Dirty Shutdown
 * [0] Scan Media
 
 PMU
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..6b023e81832a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1308,6 +1308,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
 
+int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mbox_set_shutdown_state in = {
+		.state = 1
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
+		.size_in = sizeof(in),
+		.payload_in = &in,
+	};
+
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
+
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b3aac9964e0d..d2867ea18448 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1054,3 +1054,86 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+/*
+ * Set max timeout such that vendors will optimize GPF flow to avoid
+ * the implied worst-case scenario delays. On a sane platform, all
+ * devices should always complete GPF within the energy budget of
+ * the GPF flow. The kernel does not have enough information to pick
+ * anything better than "maximize timeouts and hope it works".
+ *
+ * A misbehaving device could block forward progress of GPF for all
+ * the other devices, exhausting the energy budget of the platform.
+ * However, the spec seems to assume that moving on from slow to respond
+ * devices is a virtue. It is not possible to know that, in actuality,
+ * the slow to respond device is *the* most critical device in the
+ * system to wait.
+ */
+#define GPF_TIMEOUT_BASE_MAX 2
+#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
+
+static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
+{
+	u16 ctrl;
+	int rc, offset, base, scale;
+
+	switch (phase) {
+	case 1:
+		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
+		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
+		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
+		break;
+	case 2:
+		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
+		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
+		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
+	if (rc)
+		return rc;
+
+	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
+	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
+		return rc;
+
+	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
+	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
+
+	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
+	if (!rc)
+		dev_dbg(&pdev->dev, "Port GPF phase %d timeout: %d0 secs\n",
+			phase, GPF_TIMEOUT_BASE_MAX);
+
+	return rc;
+}
+
+int cxl_setup_gpf_port(struct device *dport_dev)
+{
+	int dvsec;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dport_dev))
+		return 0;
+
+	pdev = to_pci_dev(dport_dev);
+
+	if (is_cxl_restricted(pdev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PORT_GPF);
+	if (!dvsec) {
+		dev_warn(&pdev->dev, "Port GPF DVSEC not present\n");
+		return -EINVAL;
+	}
+
+	update_gpf_port_dvsec(pdev, dvsec, 1);
+	update_gpf_port_dvsec(pdev, dvsec, 2);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_gpf_port, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..1ad6d2e05f09 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1653,6 +1653,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
+
+		cxl_setup_gpf_port(dport_dev);
 		struct cxl_port *port __free(put_cxl_port) =
 			find_cxl_port(dport_dev, &dport);
 		if (port) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fdac3ddb8635..c80c2300dee7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -912,6 +912,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_setup_gpf_port(struct device *dport_dev);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..a085374d52d3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -693,6 +693,10 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+struct cxl_mbox_set_shutdown_state {
+	u8 state;
+} __packed;
+
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
 	__le64 timestamp;
@@ -829,6 +833,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
+int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..9b229e3b9a9d 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -40,6 +40,12 @@
 
 /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
 #define CXL_DVSEC_PORT_GPF					4
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
 
 /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
 #define CXL_DVSEC_DEVICE_GPF					5
@@ -121,6 +127,15 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that any RCIEP that emits the CXL memory expander class code
+ * is an RCD
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..bad142095279 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -465,15 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
 static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 				  struct cxl_register_map *map,
 				  struct cxl_dport *dport)
@@ -1038,6 +1029,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (cxl_pci_ras_unmask(pdev))
 		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
 
+	/*
+	 * Set dirty shutdown now, with the expectation that the device
+	 * clear it upon a successful GPF flow. The exception to this
+	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
+	 */
+	if (resource_size(&cxlds->pmem_res)) {
+		rc = cxl_dirty_shutdown_state(mds);
+		if (rc)
+			dev_warn(&pdev->dev,
+				 "GPF: could not dirty shutdown state\n");
+	}
+
 	pci_save_state(pdev);
 
 	return rc;
-- 
2.39.5

