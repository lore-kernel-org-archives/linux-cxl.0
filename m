Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175694;
	b=sXQeRlbMDcHgQ3yzTz+X6LVhe8RLsl9iCm1D/V45bSmFfWv68eWeYBLecHdN53w3WA58
	 JIkgsI+fE9SbnhGRJD48VQERECuWPJ4/cl6LerkbI6yQ+ouC6OYI2W6BjPVUUSulBbCIH
	 66aMTD6MPWmOfnhNgMgT+Qzf8hbOmjzW4xo8E51EAHhv39uFgMmJoJ4K1bv4OrCCTCgm1
	 R2dk4/PEhT11bLDsKVOvSbCmAAIZ0MCyUWIuMUvxypnCviVv/GhmlImF/pOEyuU+iYX7l
	 geIdLRjPNi9zwV/cxHfDYFLxUE4qALzGp6PYSB6q/4Dwq+ubNpqGNVy/Ma96yML+/pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175694;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Stop-Desert:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IRtDsgnQVYr2jJzxtlC76hQlfAyUdNohhdyDOr8pwPU=;
	b=JDvEc8EpOhoNBeFKegDMqEPIcb6UijHe9RMZVP+x1HrpOmAn0Gp4VkShYCDlrBORBoRf
	 y8x6o6IX7xbgI4/e6o8s4JzVbl9f0fSTLF1Saqhg/TEBsdtK8JFy7Cnx0TnzPT1MLOYvv
	 g8fYYwJ3TC4ZWHNp4D8kt0X3A5C8sYrAMOP+pLKCFB3/P6skrWQt7+aeMGqloAJTyjpwK
	 TtvlQ9o65Im4k3mgrpnH7pZqY8MWD6NFGE0WtVrAHIV5Xw4nuc0qpEwCJhRT0CcL9SegE
	 YOH4xLDgMaH6cT5+FiZbC30Bu8RViZM/k9Yre4FGvICSEs7hTu7LsQ+FWNIbLh+QcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="p/kJW76N";
	arc=none smtp.remote-ip=23.83.222.40
Received: from cornsilk.ash.relay.mailchannels.net (cornsilk.ash.relay.mailchannels.net [23.83.222.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DA606A320
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25DA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=p/kJW76N
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 22A764C21A2;
	Sun, 08 Nov 2026 22:08:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-101-214-1.trex-nlb.outbound.svc.cluster.local [100.101.214.1])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BEADE4C2237;
	Sun, 08 Nov 2026 22:08:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Desert: 2fcea86a45a15c49_1794175687011_635564582
X-MC-Loop-Signature: 1794175687011:796410004
X-MC-Ingress-Time: 1794175687011
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.214.1 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:07 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6VZ0hLQz1073;
	Sun,  8 Nov 2026 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175686;
	bh=IRtDsgnQVYr2jJzxtlC76hQlfAyUdNohhdyDOr8pwPU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=p/kJW76NDgEEUX8Ju/4LygXChGoOIDAAAdml9YpTm4BZCS81y8Xf1dj5E+bQVckib
	 h2HXb1IlAPdXv9kqIgV6zjq2sszLb4VsbKxbiL4sJ0vArqNFj5E/Zao6LrTTGzYNrg
	 kn/mOQ+mb+A+qkVwcMBR1Vusm6es/oiA5ixIef9hE3AXBaBv4FRMicYsGblfn+MnYr
	 NUanGbP4lsx8EhitH8EFKXTNGL0JFGUzBkNp9pq+N7aMj8YK2KQ7ottVBJRzt5cXWq
	 8aMFIprCqBpqJBo2FcsUIHfD/tDfQ/SnjavTQ6O4RLkVRdAUpcRbbRAucM4AvPmFRq
	 DtCEww/OmdN5g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v11 01/10] cxl: Add BI register probing and port initialization
Date: Sun,  8 Nov 2026 14:07:30 -0800
Message-Id: <823e11da0dbbd04a116ffecc2b31efb39a7b7a80.1794172701.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794172701.git.dave@stgolabs.net>
References: <cover.1794172701.git.dave@stgolabs.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add register probing for BI Route Table and BI Decoder capability
structures in cxl_probe_component_regs(), and helpers to map them.

cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
port or switch DSP) at dport-creation time via cxl_port_add_dport();
devm_cxl_port_bi_setup() maps a port's own BI capability when the
upstream link is in 256B Flit operation - the BI Decoder during
endpoint port probe, the BI RT of a switch USP on first-dport setup.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 38 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  4 +++-
 drivers/cxl/core/regs.c | 14 +++++++++++++
 drivers/cxl/cxl.h       | 10 +++++++++
 drivers/cxl/port.c      | 45 +++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h       |  6 ++++++
 7 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 79918fde1575..73478ebaf47e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -204,6 +204,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+void devm_cxl_dport_bi_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 125abb36df7f..80fda8acdf17 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -949,3 +949,41 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+
+static void cxl_dport_map_bi(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.bi_decoder.valid) {
+		dev_dbg(dev, "BI Decoder registers not found\n");
+		return;
+	}
+
+	if (cxl_map_component_regs(map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
+		dev_dbg(dev, "Failed to map BI Decoder capability\n");
+}
+
+/**
+ * devm_cxl_dport_bi_setup - Map BI Decoder registers on a CXL dport
+ * @dport: the cxl_dport that needs to be initialized
+ *
+ * Must be called while the dport's devres group is open so iomap
+ * allocations are released on dport removal.
+ */
+void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
+{
+	if (!dev_is_pci(dport->dport_dev))
+		return;
+
+	switch (pci_pcie_type(to_pci_dev(dport->dport_dev))) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		dport->reg_map.host = dport_to_host(dport);
+		cxl_dport_map_bi(dport);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f3705ea44db7..3371b2d9ba9a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1288,8 +1288,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
-	if (!dport->rch)
+	if (!dport->rch) {
 		devm_cxl_dport_ras_setup(dport);
+		devm_cxl_dport_bi_setup(dport);
+	}
 
 	/* keep the group, and mark the end of devm actions */
 	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 41416fa2ce4a..76bcc316a85c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -93,6 +93,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_BI_RT:
+			dev_dbg(dev, "found BI RT capability (0x%x)\n",
+				offset);
+			length = CXL_BI_RT_CAPABILITY_LENGTH;
+			rmap = &map->bi_rt;
+			break;
+		case CXL_CM_CAP_CAP_ID_BI_DECODER:
+			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
+				offset);
+			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
+			rmap = &map->bi_decoder;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -212,6 +224,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.bi_rt, &regs->bi_rt },
+		{ &map->component_map.bi_decoder, &regs->bi_decoder },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index baa6df2d362a..33fadf4dda52 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,9 +39,19 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
+/* CXL 4.0 8.2.4 Table 8-74 */
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
+#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
+#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
+
+/*
+ * CXL 4.0 8.2.4.26 / 8.2.4.27 BI Capability Structure lengths (Tables
+ * 8-151 and 8-155), unrelated to the capability IDs above.
+ */
+#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
+#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c12fd0b89883..1a69be0ec7c1 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -61,6 +61,47 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+static void devm_cxl_port_bi_setup(struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+	struct cxl_dport *parent_dport = port->parent_dport;
+	struct device *udev;
+	int cap_id;
+
+	/* no upstream BI registers above host bridges or the cxl_root */
+	if (!parent_dport || is_cxl_root(parent_dport->port))
+		return;
+
+	udev = is_cxl_endpoint(port) ?
+		port->uport_dev->parent : port->uport_dev;
+	if (!dev_is_pci(udev))
+		return;
+
+	/* BI requires 256B Flit on the upstream link */
+	if (!cxl_pci_flit_256(to_pci_dev(udev)))
+		return;
+
+	/* map this port's own BI capability */
+	if (is_cxl_endpoint(port)) {
+		if (!map->component_map.bi_decoder.valid) {
+			dev_dbg(&port->dev, "BI Decoder registers not found\n");
+			return;
+		}
+		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
+	} else {
+		if (!map->component_map.bi_rt.valid) {
+			dev_dbg(&port->dev, "BI RT registers not found\n");
+			return;
+		}
+		cap_id = CXL_CM_CAP_CAP_ID_BI_RT;
+	}
+
+	map->host = &port->dev;
+	if (cxl_map_component_regs(map, &port->regs, BIT(cap_id)))
+		dev_dbg(&port->dev, "Failed to map BI capability 0x%x\n",
+			cap_id);
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	/* Reset nr_dports for rebind of driver */
@@ -131,6 +172,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	devm_cxl_port_bi_setup(port);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -255,6 +298,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		 * on failure, or the device does not implement RAS registers.
 		 */
 		devm_cxl_port_ras_setup(port);
+
+		devm_cxl_port_bi_setup(port);
 	}
 
 	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1c04a7823f64..1df75fdefbfa 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -34,10 +34,14 @@ struct cxl_regs {
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
 	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 * @bi_rt: CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure
+	 * @bi_decoder: CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *bi_rt;
+		void __iomem *bi_decoder;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -80,6 +84,8 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map bi_rt;
+	struct cxl_reg_map bi_decoder;
 };
 
 struct cxl_device_reg_map {
-- 
2.39.5

