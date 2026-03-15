Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C533B949
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607553; cv=pass; b=TukUvSn1s4rhuRk8pSZl4TSuIOBLa652e7vyu2nq3xQs613IzBansQ5DLhtcA49BpyqOQeQtYv1vh0ulqfFKYK2UwAuatYXS/RhbJxQsowQvVG3F0z0SGkNtUzka1z5kGT7w2weGMduqj08r/cL5G+Jry6aJYTR0Bmln9pG6uIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607553; c=relaxed/simple;
	bh=ZinOlMOR9iTSMYaq7Gz4cZQvOtvON52EpbH12TencKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecjW7VrtOJ7XWZcnuaYjfidJlgBuJ7DiLt6ElcdsodrvaFS76PetowaT71E/Q7vrdPa/5sgKKyxuhry2ylAWhUv8RQkudVPgtlygHUjIPNEVw1QNN1pSU4xnOIeJxFbtlujowJD6mkzwHIGoda1Qs9ikkYmPKWiKL0W8tZ5oOwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qW4ST+PB; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qW4ST+PB"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5336A821D72;
	Sun, 15 Mar 2026 20:27:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.115.143.64])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 539CE82206B;
	Sun, 15 Mar 2026 20:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606465;
	b=46QgMY8NJTfIWXEvoJRlt4JjWhylY/0PRG40WQ2jk/0GXYLTIC6eiIySUGRTozEz61v0WS
	joso/knmbitrcJrc6+vBELtnXQ18e/mH6a0vv8TRUr2RztSnnZVGoRcHK9K74O3Ge6Tqm8
	8lbkqPaZag6PIiNpjU84BZyL47iIx1y45CjZR5boSd8KQkZDvWsI1JbPC9B7puU3DCvd7b
	LD7WYDioyI+JPPhHDOtMrjcArgP/0pvhwaJzWVYeIn22RdA3VLNJXGzk+vqzoqeyCUH6kB
	efh4vtrUlnqN8aBL+XSfCLLeosJl/ylOARLShDhvLzbGEDj2mgpIlJ444vYJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lokCEJKxoaXX1dQThUmXv5pE2ZyIC1ZX5RQzOWGP9fo=;
	b=FIJxCbw58DUMdnjhHsFjGbc3YpfOgOPn2tbxDWXn9JeTQ4eUBP4olvZe2uNUTdQeiJILDy
	WAuVBFw1F8wL5M46jITasYzmo9gbFDsIU3us3ZN6MnWcYnVP6oIgFmiDusbxPbxux/YK8W
	sLzt+hy9W+o7CAwsrrrPlbATSaJHNd0b/ZiQrzp9lVVJ6LQni6geckZXkBow3GCUaVRscz
	ENupJzZQFDzQtau1KVENJ/rzQSXQGAiaWPhquA87jknUgbIWCFA80yBww1XTSXvEGw+9L9
	feZd6m+gD7Z3uVk23GLXSXuwB8rz7UMDf8lLAQyUzm5EXrwY2ISjV8ii+3vqWw==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-qm5f5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Relation: 2c1c75f34efc26a4_1773606465598_2092398195
X-MC-Loop-Signature: 1773606465598:4187486971
X-MC-Ingress-Time: 1773606465598
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.143.64 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:45 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXc4cmKz107M;
	Sun, 15 Mar 2026 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606465;
	bh=lokCEJKxoaXX1dQThUmXv5pE2ZyIC1ZX5RQzOWGP9fo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=qW4ST+PBUD6eZhJWsZwXIRcqPwUYQGz4YO2IntXfjoB01fzhIcpkSIHjqi+j8NCN7
	 zCgzb+sA9JtipCWRsDiBIZ7q1/KrESjbQBS5JYeNzoyDWa9aR+d2Czi/t7C4pgvh+o
	 vb2diE26oN5QKpW6MAq1JtMffyr+ynIrC+6OOPvJcpUEBBDrQkvfGV+69dMvq5Y30z
	 Mv+GZF+yQ1tWqIdNrEWIGYT1Z9htRkF3CGcAGxQQtWVMI8WS9PEcESeBIcfZIjf5pQ
	 y0ZKkxJSDNUHd87hBLo3w2rkDmXM4i0vNLRo8SalG/LpN77Fk1JjnoQ9AgHafepXzj
	 HEuyys8EsWYLQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/6] cxl: Add BI register probing and port initialization
Date: Sun, 15 Mar 2026 13:27:37 -0700
Message-Id: <20260315202741.3264295-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260315202741.3264295-1-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add register probing for BI Route Table and BI Decoder capability
structures in cxl_probe_component_regs(), and initialize BI registers
during port probe for both switch ports and endpoint ports.

For switch ports, map BI Decoder registers on downstream ports and
BI Route Table registers on upstream ports. For endpoint ports, map
the BI Decoder registers directly into the port's register block.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/regs.c | 13 ++++++
 drivers/cxl/port.c      | 88 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..82e6018fd4cf 100644
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
+			rmap = &map->bi;
+			break;
+		case CXL_CM_CAP_CAP_ID_BI_DECODER:
+			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
+				offset);
+			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
+			rmap = &map->bi;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -211,6 +223,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.bi, &regs->bi },
 	};
 	int i;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ada51948d52f..0540f0681ffb 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -58,6 +58,90 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+static int cxl_dport_init_bi(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (dport->regs.bi)
+		return 0;
+
+	if (!cxl_pci_flit_256(to_pci_dev(dev)))
+		return 0;
+
+	if (!map->component_map.bi.valid) {
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
+static void cxl_uport_init_bi(struct cxl_port *port, struct device *host)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	if (port->uport_regs.bi)
+		return;
+
+	if (!map->component_map.bi.valid) {
+		dev_dbg(host, "BI RT registers not found\n");
+		return;
+	}
+
+	map->host = host;
+	if (cxl_map_component_regs(map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_RT)))
+		dev_dbg(&port->dev, "Failed to map BI RT capability\n");
+}
+
+static void cxl_endpoint_init_bi(struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	cxl_dport_init_bi(port->parent_dport);
+
+	if (!map->component_map.bi.valid)
+		return;
+
+	if (cxl_map_component_regs(map, &port->regs,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
+		dev_dbg(&port->dev, "Failed to map BI decoder capability\n");
+}
+
+static void cxl_switch_port_init_bi(struct cxl_port *port)
+{
+	struct cxl_dport *parent_dport = port->parent_dport;
+
+	if (is_cxl_root(to_cxl_port(port->dev.parent)))
+		return;
+
+	if (dev_is_pci(port->uport_dev) &&
+	    !cxl_pci_flit_256(to_pci_dev(port->uport_dev)))
+		return;
+
+	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
+		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
+
+		switch (pci_pcie_type(pdev)) {
+		case PCI_EXP_TYPE_ROOT_PORT:
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			cxl_dport_init_bi(parent_dport);
+			break;
+		default:
+			break;
+		}
+	}
+
+	cxl_uport_init_bi(port, &port->dev);
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	/* Reset nr_dports for rebind of driver */
@@ -66,6 +150,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
+	cxl_switch_port_init_bi(port);
+
 	return 0;
 }
 
@@ -128,6 +214,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	cxl_endpoint_init_bi(port);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
-- 
2.39.5

