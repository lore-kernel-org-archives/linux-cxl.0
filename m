Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4231531DB;
	Tue,  7 Jan 2025 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222304; cv=pass; b=rwT4aCeMUasXnwS/kp9CrALS/kJKR8pfl28FdfaOovGm03K6yQbKI+0ix76isgl53JdMy7koTZz0u/yy5RPYk/ZGS5IuxNgrZ1ZYhtyBFrlk/ukLRegdavxRXFzwZNi5f7f13JTiNQ/creLk+MVlJkTb1TxCqHWd/LzE7qpQZh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222304; c=relaxed/simple;
	bh=7nFkkVqN7/D/o3xkRFgG0U8I1TMzENNOEsOlI33ucbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMCNclM7vN8TUzh24SC6ZO9X/NC/oMndzz3QhUosZ5p/2Fbe3XUyg1jj44il7VVQCpQUeF4y3L3qJu7qcfCkUUw9CkhFJvMSpwpsa1O+atWVT4/9Q2PD58sxdDtw8k5Q5YiLsVRKgOOLu6ruZb4npnq1lgCi1u85x/E0UcCVNC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=epH7HLy9; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="epH7HLy9"
ARC-Seal: i=1; a=rsa-sha256; t=1736222275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JnM2kxPJgo+cR61XE11ailDe3ukFGeFFXgyOKpviJAe38IXlvrS0bXRqTwgvGz87YKlfuED/g4OdmPZj97s1T4jd4Oz15zZuFuXl5wwcg+c8ZBMMGEAV6FWJMzWoZU3rX2NhE8AKaQVm6Dl9QMOG0rP+Pdq1BiyqLACrWDxfj2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222275; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rycCUr+DUm84Bi0eVFTDSNBuZn0sgVt0Mem0dR4C/+E=; 
	b=RjApRVAk9AHQCWQUzXnSrVq76xkryPQs+0V+3+TDLnMwrsaAEQEu8w10Z+v52S0t0+cLctaCLZChhEodmJngXnYPgUs16ILeGElpwE6290Tc6+CxvfMEzYZv2d+v2HBKlBrcISg81Z4xLrzQYfRymiaOSrpryflE+2jSw3BRu4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222275;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=rycCUr+DUm84Bi0eVFTDSNBuZn0sgVt0Mem0dR4C/+E=;
	b=epH7HLy9+liGyyXjdXx1cSsgQsimoagl9IYcLS9UEhEf7YqHZWy8db7qFI1w+GSU
	VfSV9BJEW5iwJ5pHjMk5CzaJacxO4zYLnM5CIzhsCSt0VaFvuCzygWT/rBuDVnqe6vw
	iT831Cbcec5wQ4jQWwhh+xahSLvPxcIbdJwCPxUE=
Received: by mx.zohomail.com with SMTPS id 1736222274358752.5936388453697;
	Mon, 6 Jan 2025 19:57:54 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [RFC PATCH 4/8] cxl/port: Remove port HDM during the last endpoint detaching
Date: Tue,  7 Jan 2025 11:57:04 +0800
Message-Id: <20250107035708.1134954-5-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107035708.1134954-1-ming.li@zohomail.com>
References: <20250107035708.1134954-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cb067eccf104b7fbeecfb58500007e962f4cf63ec338833a60be77648fcf007fc2cb62fb01d2d2:zu08011227eb3d0c92053a338e93b936d30000fb90b355ce885dec466a2a1b1e52786889740f6e2e8ce92ec4:rf0801122db7c2c356ce55061d7ce5b64400007cd11908feb53dbc9273b6d560028fab3e9c29ec039d67483b5209076e341f:ZohoMail
X-ZohoMailClient: External

HDM is set up on a CXL port when the first endpoint under the port
attaching. The HDM should be released when no endpoint is under the port
so that the first endpoint attaching can trigger HDM setup on the port
again next time. So remove HDM and decoders on a CXL port if no endpoint
is working under it.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 60 +++++++++++++++++++++++++++++++----------
 drivers/cxl/core/regs.c |  9 ++++++-
 2 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1022c0775daa..57ed152d96d7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1517,6 +1517,49 @@ static int port_has_memdev(struct device *dev, const void *data)
 	return !!cxl_ep_load(port, ctx->cxlmd);
 }
 
+static void cxld_unregister(void *dev)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	if (is_endpoint_decoder(dev)) {
+		cxled = to_cxl_endpoint_decoder(dev);
+		cxl_decoder_kill_region(cxled);
+	}
+
+	device_unregister(dev);
+}
+
+static int cxl_decoder_remove(struct device *dev, void *data)
+{
+	struct cxl_port *port = (struct cxl_port *)data;
+
+	if (!is_switch_decoder(dev) && !is_endpoint_decoder(dev))
+		return 0;
+
+	devm_release_action(&port->dev, cxld_unregister, dev);
+	return 0;
+}
+
+static void cxl_port_remove_hdm(struct cxl_port *port)
+{
+	const struct cxl_reg_map *rmap = &port->reg_map.component_map.hdm_decoder;
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	resource_size_t addr, length;
+
+	if (!cxlhdm)
+		return;
+
+	device_for_each_child(&port->dev, port, cxl_decoder_remove);
+	if (cxlhdm->regs.hdm_decoder) {
+		devm_iounmap(&port->dev, cxlhdm->regs.hdm_decoder);
+		addr = port->reg_map.resource + rmap->offset;
+		length = rmap->size;
+		devm_release_mem_region(&port->dev, addr, length);
+	}
+	devm_kfree(&port->dev, cxlhdm);
+	dev_set_drvdata(&port->dev, NULL);
+}
+
 static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -1545,11 +1588,12 @@ static void cxl_detach_ep(void *data)
 		cxl_ep_remove(port, ep);
 		if (ep && xa_empty(&port->endpoints)) {
 			/*
-			 * Reset component registers information on the port
+			 * Reset HDM and component registers information on the port
 			 * during the last ep detaching. So that the next ep
 			 * attaching can trigger component registers probing
-			 * again.
+			 * and HDM setup again.
 			 */
+			cxl_port_remove_hdm(port);
 			cxl_register_map_reset(&port->reg_map);
 
 			if (!port->dead && !is_cxl_root(parent_port) &&
@@ -2031,18 +2075,6 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
 
-static void cxld_unregister(void *dev)
-{
-	struct cxl_endpoint_decoder *cxled;
-
-	if (is_endpoint_decoder(dev)) {
-		cxled = to_cxl_endpoint_decoder(dev);
-		cxl_decoder_kill_region(cxled);
-	}
-
-	device_unregister(dev);
-}
-
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
 {
 	return devm_add_action_or_reset(host, cxld_unregister, &cxld->dev);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 59cb35b40c7e..7aba68785287 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -194,8 +194,15 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	}
 
 	ret_val = devm_ioremap(dev, addr, length);
-	if (!ret_val)
+	if (!ret_val) {
 		dev_err(dev, "Failed to map region %pr\n", res);
+		/*
+		 * Explicitly release mem region in failure case
+		 * so that no need to consider the case of devm_request_mem_region()
+		 * success but devm_ioremap() failure in cxl_port_remove_hdm().
+		 */
+		devm_release_mem_region(dev, addr, length);
+	}
 
 	return ret_val;
 }
-- 
2.34.1

