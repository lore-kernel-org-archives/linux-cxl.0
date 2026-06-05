Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908A64A8C
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620024; cv=none; b=rije5GDrfA++SPnd+EbxgbDD3aRPmPY9zUnSUX4J4B6rWfK+yUjB9N0CwY9SkRy20MeCLuq1IffZO6cyWfmSptib+IQBIUwAHn3Q71Qx8TlclP9YucNG1GfgLDLLslDw4sM5RfQlnJ4dW0KOogNBrqa0uWTefFXEwOtx/2AoZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620024; c=relaxed/simple;
	bh=pDDZz3S2Wkh845Ki6rUOvIOV3oqRSci/ywoSiaoyku4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+1/DIGjLeMR+tYOolyPDWWkl0j2Xu7epGzVzQ7zXJ1MXMvforCsTuLWAfRrPF7CnIb1Nc9xXpDFOLBKhFU6T+ItGLb4pRsKhgCzuTZaLTGofK3ybVTV7xWx3kTZBleeuUAxnJdJQ45iF+TfvMXobwfbWDCFWjr95UqIbNLT0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gYmQssQq; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gYmQssQq"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6D3E461BC4;
	Fri, 05 Jun 2026 00:34:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.105.228.210])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DBA7A61C70;
	Fri, 05 Jun 2026 00:34:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Zesty: 22af064e49df7a31_1780619642363_2254224821
X-MC-Loop-Signature: 1780619642363:184235675
X-MC-Ingress-Time: 1780619642363
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.228.210 (trex/7.1.5);
	Fri, 05 Jun 2026 00:34:02 +0000
Received: from localhost.localdomain (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWj9L255kz1066;
	Thu,  4 Jun 2026 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780619641;
	bh=55ALJj1HcO/rG6mwum95wltRyfbyZ5Oa0iMUW0qS9+I=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gYmQssQqmjtJF74xboBwMCuIhENJ662OFkjEZPoGCWL5709dwFZ4PnEenvJatccsO
	 lyunimvN02p6kl4efG/X5fAfFGlS3ugZhphiaeDxPIS+54ym8kCWEST2mw1xHaQOep
	 Z7kRvd/2BnqV4o843YmEJSbU4oD/ImPYBw+2qKAFcBkjqR/oWR667bWXvmUvVTbeoK
	 IMj7ASq0l+Qt/tBWd0IHrhvkWeOVX5I1aBemdJoJ71z/1y8EEUc3q281AvJCi7R/Tn
	 riRbyTbGnaj+WROiKWH7VkBux03IKB4g0xrqpD16KOqkBvh0hhQC7jDHQsXuujTKMK
	 j3heVULJo8K6A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/5] cxl: Add BI register probing and port initialization
Date: Thu,  4 Jun 2026 17:33:25 -0700
Message-Id: <20260605003329.2584012-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260605003329.2584012-1-dave@stgolabs.net>
References: <20260605003329.2584012-1-dave@stgolabs.net>
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
 drivers/cxl/core/regs.c | 14 ++++++++
 drivers/cxl/cxl.h       |  6 ++++
 drivers/cxl/port.c      | 71 +++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h       |  6 ++++
 4 files changed, 97 insertions(+)

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
index 1297594beaec..760f51b43891 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -42,6 +42,12 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
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
index ada51948d52f..2dd712c5d312 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -58,6 +58,62 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
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
@@ -66,6 +122,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
+	cxl_port_map_bi(port);
+
 	return 0;
 }
 
@@ -128,6 +186,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	cxl_port_map_bi(port);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -261,6 +321,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 	/* This group was only needed for early exit above */
 	devres_remove_group(&port->dev, no_free_ptr(port_dr_group));
 
+	if (dev_is_pci(dport_dev)) {
+		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
+		case PCI_EXP_TYPE_ROOT_PORT:
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			cxl_dport_map_bi(dport);
+			break;
+		default:
+			break;
+		}
+	}
+
 	cxl_switch_parse_cdat(dport);
 
 	/* New dport added, update the decoder targets */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..8ce9b4e9ca73 100644
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

