Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6FB67E
	for <linux-cxl@vger.kernel.org>; Sat, 16 May 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898566; cv=pass; b=A8cnEs6fMNzQpZG+xLfk44zuPQjOy0SoN8hw4Z83do1ecELO39oz0VCO304anz7FtK9tyzSC8lvbW/uhK6mBF/eCqc4oXdy/Z0tA3MxoMrGn3BFdKGsOr3SIlKfrj1a00954T1faCvD8ZTMlS43aBuEifK6s3QblhaMnQkYD3J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898566; c=relaxed/simple;
	bh=4o3o05VJeQ44Z4Cu3uzz3+HM6y0ATB2nUsrfJw0UmVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmUP6zpVJUs0jDzs/yxVS4emaP7+Ar1plWma1Tz233XorASFKhGIbwAedykOziy/P1YJWk8iROF8bykdgN2jqQ7nKcGZFNxaU8cqTbq/bn6gYBk5c9ccGZmv1d/LrKUJAPlIXQZOMw1lV8v3XAftrLNu2qaN6nRW3gfLjmzLeH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=oX/4Znq2; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="oX/4Znq2"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 816927A127C;
	Sat, 16 May 2026 02:21:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.106.191.157])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 23D727A1258;
	Sat, 16 May 2026 02:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778898068;
	b=v7iIscThfM4FnJTunG/M5LzR1+OFDC+bmpdbyRgMOelwvVqzsvsNNsWecxpZztW1WdVW4T
	HLn89vLvwKpTNBjWVzVJS0cafu5z3ReGqg137DzTMaKnZpbLj2nTB4OEP/4jxZQLCtAQjU
	rBxySvw3kc2p+EqAzD/WMu24Q3wSpm5eAlik6kjGInQg51ReH3l0RQMUnG6Wb7LQn63NM6
	+Ekk6jHClh62mnOcrR6CGeml51oN9Ar91IwsV07ySg9lUqzjm82yZS3U75+j+EUly/Eunb
	H++b4g70EdZurye3kaDtzuFD6U8kW94cCcBRoyrYQjCMFTT197LSv+Ho8MlPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778898068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=v22o1NHKkpQzKHlbczbZ+WSCNwxQB+2iv9jla4G6s58=;
	b=qMuvXv7ogOYHK/G1R6+srCb50WO2DxJS7WSr7pTrIbbIqgUQxpsL4/rPXoEsv8XbIUhaji
	lQwNl9ch0JYp2ukKbhNvp4Z7CeJHPp/2f4k5xnLISoaEEJUMG/46kXhUELaZSoXcPuuLFJ
	ME9ZPhSLssHo8Md/Xy14l1JhOBSBGHkdyXfEpgG23R3NGeqLsSAyghF1lMaEHRaZpLh8/H
	cBBfeCBLNJPxfFhmpbgLj7QsCc1KqwxUEEGQXaRXe2ArpaZ8IWdntE5oIHvcC1q7feF3PH
	EU6N54/6WUcjOMa9ihz09IYFQ5L8s9SbYU+17GYSARku459cOnV2x13TXZNMCQ==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-dmtq6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Macabre: 3a5de2bb4dafa11f_1778898068410_3168027317
X-MC-Loop-Signature: 1778898068410:751262939
X-MC-Ingress-Time: 1778898068410
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.191.157 (trex/7.1.5);
	Sat, 16 May 2026 02:21:08 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gHSVC2lMGz102b;
	Fri, 15 May 2026 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778898068;
	bh=v22o1NHKkpQzKHlbczbZ+WSCNwxQB+2iv9jla4G6s58=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=oX/4Znq2TnUO3yKkePO2MeTpW+YkkxWIAdkTl5M29zh1eYugalx0qmRH2XaQcLzBF
	 fJ4v4yqB+scaZK9iLN03WUt9065Sumtctd6RU7yLzAN5Rautk6m7Mb/xGJqeiwb0Ho
	 rgiaCuhK6iXjufONfuZgCjNzZWRIaXaXWj/ZgsdXveEJVTBrRlceL/UxyHQ+M/LOfB
	 moTClA4Fo01MNb/zJlTAIGUOGjS5qV/gNUyZRwtdlKfxHyzg6dTGMSjTrePWaTqoEm
	 A1kkNpDCZOfd7+cipRA+aUQZ4ZgqeuzfuzvnMQCQbhmlMz+U/TFjlMZMlCj2LwyUMV
	 t1p0eT48Rbz3Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/5] cxl: Add BI register probing and port initialization
Date: Fri, 15 May 2026 19:20:32 -0700
Message-Id: <20260516022037.1761453-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260516022037.1761453-1-dave@stgolabs.net>
References: <20260516022037.1761453-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add register probing for BI Route Table and BI Decoder capability
structures in cxl_probe_component_regs(), and initialize BI registers
during port probe for switch ports and endpoint ports.

Each port's probe initializes its own BI cap and the parent dport's
BI Decoder. Switch DSPs are therefore mapped by the children below
them (endpoint or sub-switch USP), and a root port is mapped by
whichever cxl_port sits directly below it -- a switch USP, or a
direct attached endpoint.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/regs.c | 14 +++++++
 drivers/cxl/cxl.h       |  6 +++
 drivers/cxl/port.c      | 89 +++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h       |  6 +++
 4 files changed, 115 insertions(+)

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
index ada51948d52f..e0ac9432848a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -58,6 +58,91 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+static int cxl_dport_init_bi(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	/*
+	 * Already mapped. The BI Decoder iomap persists for the dport's
+	 * lifetime via the parent cxl_port's devm context.
+	 */
+	if (dport->regs.bi_decoder)
+		return 0;
+
+	if (!map->component_map.bi_decoder.valid) {
+		dev_dbg(dev, "BI decoder registers not found\n");
+		return 0;
+	}
+
+	if (cxl_map_component_regs(map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER))) {
+		dev_dbg(dev, "Failed to map BI decoder capability.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Initialize Back-Invalidate registers for @port: map the BI Decoder on
+ * the upstream parent dport (root port or switch DSP), and map this
+ * port's own BI capability -- BI RT for a switch USP, BI Decoder for
+ * an endpoint.
+ */
+static void cxl_port_init_bi(struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+	struct cxl_dport *parent_dport = port->parent_dport;
+	struct device *dport_dev, *udev;
+	int cap_id;
+
+	/* no upstream BI registers above host bridges or the cxl_root */
+	if (!parent_dport || is_cxl_root(parent_dport->port))
+		return;
+
+	/* BI requires 256B Flit on the upstream link */
+	udev = is_cxl_endpoint(port) ?
+		port->uport_dev->parent : port->uport_dev;
+	if (dev_is_pci(udev) && !cxl_pci_flit_256(to_pci_dev(udev)))
+		return;
+
+	dport_dev = parent_dport->dport_dev;
+	if (dev_is_pci(dport_dev)) {
+		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
+		case PCI_EXP_TYPE_ROOT_PORT:
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			cxl_dport_init_bi(parent_dport);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (is_cxl_endpoint(port)) {
+		if (port->regs.bi_decoder)
+			return;
+		if (!map->component_map.bi_decoder.valid) {
+			dev_dbg(&port->dev, "BI Decoder registers not found\n");
+			return;
+		}
+		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
+	} else {
+		if (port->regs.bi_rt)
+			return;
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
@@ -66,6 +151,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
+	cxl_port_init_bi(port);
+
 	return 0;
 }
 
@@ -128,6 +215,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	cxl_port_init_bi(port);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
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

