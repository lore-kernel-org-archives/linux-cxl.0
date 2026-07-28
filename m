Received: from dog.ash.relay.mailchannels.net (dog.ash.relay.mailchannels.net [23.83.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF634570F7
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250219; cv=none; b=HhvsBziid3+kdGchg+riNW8uElgm2s70xZMbWo7fB/t5w1xaKRFHFd2UvCDGdixbZO//uFk24q96RUpwrCWXB4Ey0iF25NCEARte6J7ic1xWjkNC89u/SJMB5oAR/UWT8hSyZYmBT6fA+wtFkDaOWWjB+cdFaA6r2Q+jZs5DSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250219; c=relaxed/simple;
	bh=b+QRNzTTpuN50afrbD/vr38kyLMPzGoqk5wdr+Bu/4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlb0LagxX4aLmKdnukNahCrIRSq/weG3To6nqQn71Tmb9qOSxDp0Qu4K7JjRNQynEkQHZBIv7PSvT2e+V6s7Xf+jm78JNA8LqYmxRDJb4Z/yS0YMCzq1tN+81bhlDOvj6OvmMjX2rI3XkgJTXRl6hE23RvXacg5A4e8i2fT/eqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pbxkSTw5; arc=none smtp.client-ip=23.83.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pbxkSTw5"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 996EF4221E;
	Tue, 28 Jul 2026 14:41:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-111-252-5.trex-nlb.outbound.svc.cluster.local [100.111.252.5])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 27E92421A9;
	Tue, 28 Jul 2026 14:41:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Trade: 44c7d6656b1afcef_1785249707425_427973147
X-MC-Loop-Signature: 1785249707425:1206023528
X-MC-Ingress-Time: 1785249707425
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.252.5 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:47 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dT63Ldcz3K;
	Tue, 28 Jul 2026 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249707;
	bh=pUGALzoq+kDkejwAoM19VH1HCULtsnak4lrR98Q9b9g=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pbxkSTw5fCRCB8tMefYeNQVEy71DIWD10fGYyBy5s03THFrVY2+8tGPRhOJNxDRLl
	 Zc6ykzZiIlqB0eNkTpa0GwQNSCq2rrWMsG08XrEBQ95NJPlSGEbQylLMr9lO/212Uc
	 e5Z3WhMYq5ummGwBcV+uP0ijCZJbZgPBXn6e2hT/sS2crO6Q8hnyQedaM1DtitSBtg
	 DotEiWExX6Nz539bb+QUXL1NWlEGroti3ZpvMeiuUmqTM44VeZnemhFFOaan5lEvHh
	 wB3wsbxLNIRuK5xKtGb1uSG4BhH4Ooo4HYhL0eC/uGoJ0TRVUXAj5yxoiWJOX8az63
	 HHkuKM/EEf+TQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v7 1/8] cxl: Add BI register probing and port initialization
Date: Tue, 28 Jul 2026 07:41:29 -0700
Message-Id: <20260728144136.709882-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260728144136.709882-1-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add register probing for BI Route Table and BI Decoder capability
structures in cxl_probe_component_regs(), and helpers to map them.

cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
port or switch DSP) at dport-creation time via cxl_port_add_dport();
cxl_port_map_bi() maps a port's own BI capability during port probe
when the upstream link is in 256B Flit operation -- BI Decoder for
an endpoint, BI RT for a switch USP.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 38 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  4 +++-
 drivers/cxl/core/regs.c | 14 +++++++++++++
 drivers/cxl/cxl.h       |  7 +++++++
 drivers/cxl/port.c      | 45 +++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h       |  6 ++++++
 7 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..e36b55fd63bd 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -209,6 +209,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+void devm_cxl_dport_bi_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..f82559d8a8c5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -926,3 +926,41 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
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
index 1215ee4f4035..b2f8fb9547d3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1242,8 +1242,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
-	if (!dport->rch)
+	if (!dport->rch) {
 		devm_cxl_dport_ras_setup(dport);
+		devm_cxl_dport_bi_setup(dport);
+	}
 
 	/* keep the group, and mark the end of devm actions */
 	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..a6caa793e7a4 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
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
@@ -211,6 +223,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.bi_rt, &regs->bi_rt },
+		{ &map->component_map.bi_decoder, &regs->bi_decoder },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..f9fcb6387fc8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,9 +39,16 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
+/* CXL 4.0 8.2.4 Table 8-74 */
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
+#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
+#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
+
+/* CXL 4.0 8.2.4.26 / 8.2.4.27 BI Capability Structures */
+#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
+#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99cf77b6b699..a527dd13fb68 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -58,6 +58,47 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+static void cxl_port_map_bi(struct cxl_port *port)
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
@@ -128,6 +169,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	cxl_port_map_bi(port);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -252,6 +295,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		 * on failure, or the device does not implement RAS registers.
 		 */
 		devm_cxl_port_ras_setup(port);
+
+		cxl_port_map_bi(port);
 	}
 
 	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 016c74fb747c..2816954680b3 100644
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

