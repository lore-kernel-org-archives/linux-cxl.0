Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2E405C4B
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537614; cv=none; b=terRbsvkEpAs4etGCIuVyXKD23JPYLRAO78kOIxebcSK+rQh+ybm8nJ3g7O7gytlsqPPVEHTxVjecI8CMV5clVzerkEVwyt0Mdujx4UrizQKOW+AlAqWN12F5sZ4qXRlk1wEKAXffEBFI0uSrmuU6pPDyx+gcIcjp4uI24k1GCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537614; c=relaxed/simple;
	bh=zWCtVT1aFY3kt21xztgdp7lhnqr7XDTu2QVM8NdRqdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNo652kh4P8PUScLDtoXHK/q8c02a0JUlnqS8gucaThr2XWwYIgDU4Exd8N+R9hOYsWiyCFaRtoDiQWLcjB8kIbv6jhNntUO7JEh077fFQalli7LdH4auqfLY/Yz8fI5r0sNw/+qIdXhDn4ZkDwGjE7ciFSTPc74YEAJ2vzEKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pDajPlcQ; arc=none smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pDajPlcQ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2DD2494010B;
	Mon, 15 Jun 2026 14:55:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (100-96-8-48.trex-nlb.outbound.svc.cluster.local [100.96.8.48])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C2D1D941CF4;
	Mon, 15 Jun 2026 14:55:58 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Cooperative: 10c0921004bf34cb_1781535359104_2230568148
X-MC-Loop-Signature: 1781535359104:1887655733
X-MC-Ingress-Time: 1781535359104
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.8.48 (trex/7.1.5);
	Mon, 15 Jun 2026 14:55:59 +0000
Received: from offworld.lan (unknown [138.84.34.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4gfCqH367wz1NY;
	Mon, 15 Jun 2026 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781535358;
	bh=OhxO9FPQPpfaQewoF9XRwVD0B640IPWbiJlXt1q0aNA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pDajPlcQ7AyWJTL/MlUShuDzUm4AgfHcWWnRe7TNZDRbDh78DSDke/Dvtdt9FE4li
	 zm22SNqYU+ojYWcz4ozavdnVfHXOsnH8VkJ3atpggjMgmp1/Hr9Y+yaHOYt7N3W/M7
	 hIWFtUKo+XlLyMP97GuRc7atOrJ7HqSRpBJSYp+qlSiWAc0fBk+rVqz6CQijE1tzuo
	 K0QKsojGDMk91IkIhf+WmGbvO9pmbcNCYiaXu4DzaaoJG6ve5p1ySV4LJ4/PXDZ7Jq
	 tjuB2YV1i3e30Xb0kza8fGIwxlZ6XkI9HhG5x+P4NwdOFZbV/IuIjx51Hzv1QzctrB
	 DM+NstXqAbzgQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v5 1/5] cxl: Add BI register probing and port initialization
Date: Mon, 15 Jun 2026 07:55:25 -0700
Message-Id: <20260615145529.13848-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260615145529.13848-1-dave@stgolabs.net>
References: <20260615145529.13848-1-dave@stgolabs.net>
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
index ada51948d52f..ca8d8c14b787 100644
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
@@ -128,6 +184,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	cxl_port_map_bi(port);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -252,6 +310,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		 * on failure, or the device does not implement RAS registers.
 		 */
 		devm_cxl_port_ras_setup(port);
+
+		cxl_port_map_bi(port);
 	}
 
 	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
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

