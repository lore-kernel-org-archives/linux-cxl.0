Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D582EEE75
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123737; cv=none; b=bU6JrT22UBxHP3H194YtnGR3/kUXKrBgV+mwO0nWRQBuxqnlRMsCun0yLOtM4uC21YDy0gltxmcMNH60kqtdrkgwDxqvC+bCzvw/hgpIoXPb+wmG0f7dPURv0XRa4Ejl5ilZpWsgVxKfSLTXuTvYGwjTIMU0FPoHjq/bjmeB4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123737; c=relaxed/simple;
	bh=xTW3FCK0CJpliQ9oWzaRz1kv0kLvRFt51qlmgfsiC2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tyZTqtv81r8nTaqH8G6UbgUjaKKnnMbojxLpCd9B5OSoClMG/nvAJ9js4kX/wVY7BkCAmuVhXRqUVcoODi2zC+DJbw496HFeiDiQ+My2BF1WBrDbhd1/k/KpWUcUtDS1V7MsDajc3TESlsky/1gto0+TBTK2gwhuZHgBQKLjbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BGTaEGuo; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BGTaEGuo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 340CC46252D;
	Tue, 22 Sep 2026 23:39:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-100-245-87.trex-nlb.outbound.svc.cluster.local [100.100.245.87])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 072D1462075;
	Tue, 22 Sep 2026 23:39:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Plucky: 2e284cc205cca6c7_1790120345125_1576028048
X-MC-Loop-Signature: 1790120345125:2661781955
X-MC-Ingress-Time: 1790120345125
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.245.87 (trex/8.0.2);
	Tue, 22 Sep 2026 23:39:05 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4hqGlD1zNlzND;
	Tue, 22 Sep 2026 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790120344;
	bh=SXL8eeZTj6qUB3KVAyQPThUjBn31It6t9zWDGXnfW/k=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=BGTaEGuokf2OX4DXIAKYWFZ1lIRj6P8vdM96MJXae+Bb/1P7eJBA0b0OQb5qKiZHj
	 c4k5FfWREjJcLD+zuKQ+Q2ydkSh7iqB1YePt1KKDASepIqQMWMehdqz/Ca6TCBZcQz
	 lHdq7uz0OvP7sZ9VjsiJUd8KK1ZMe4bWmBhrrwitFJ2QD5OTNXRntDRf3RiSPmnD1z
	 cbMkn/uQmrAH2COXPoDhquKaNyXYzNI53VgcMuHXqRLOXNXvNbCzVviFVI3jiDRSVy
	 /x5SVd2dRObVr8wh8o171EIFGMuow4Sp2gbDvLMOaKTTyHkq+pqtwmgXlU16HTd04Q
	 R8Iv7bjjuOPhg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 07/10] cxl/pci: Split BI capability probe from setup
Date: Tue, 22 Sep 2026 16:38:44 -0700
Message-Id: <c61a057a45837e29c53cc8cd4e15df8712439011.1790103847.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790103847.git.dave@stgolabs.net>
References: <cover.1790103847.git.dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decouple the topology read-only capability verification phase from
cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
cxlds->bi_capable.

This allows further dealing with auto-committed BI hdm decoders;
having such knowledge upon decoder enumeration time.

No functional change intended.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 40 +++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h      |  1 +
 drivers/cxl/port.c     |  1 +
 include/cxl/cxl.h      |  2 ++
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f3ca9861a7ba..9bf05820c142 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1332,34 +1332,38 @@ void cxl_bi_reset_detected(struct cxl_port *endpoint)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
 
-int cxl_bi_setup(struct cxl_port *endpoint)
+/*
+ * Verify the device and every component in the path up to the root
+ * are BI capable.
+ */
+void cxl_bi_probe_capable(struct cxl_port *endpoint)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_dport *dport = endpoint->parent_dport;
 	struct cxl_dport *dport_iter;
 	struct cxl_port *port_iter;
-	int rc;
+
+	cxlds->bi_capable = false;
 
 	if (!dev_is_pci(cxlds->dev))
-		return 0;
+		return;
 
 	/* BI is VH-only */
 	if (cxlds->rcd)
-		return 0;
+		return;
 
 	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
 			       endpoint->regs.bi_decoder))
-		return 0;
+		return;
 
-	port_iter = dport->port;
-	dport_iter = dport;
+	dport_iter = endpoint->parent_dport;
+	port_iter = dport_iter->port;
 	while (!is_cxl_root(port_iter)) {
 		/* check rp, dsp */
 		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
 				       dport_iter->regs.bi_decoder)) {
 			dev_dbg(cxlds->dev, "BI not supported by topology\n");
-			return 0;
+			return;
 		}
 
 		/* check usp */
@@ -1370,13 +1374,13 @@ int cxl_bi_setup(struct cxl_port *endpoint)
 					       NULL)) {
 				dev_dbg(cxlds->dev,
 					"BI not supported by USP\n");
-				return 0;
+				return;
 			}
 			if (port_iter->reg_map.component_map.bi_rt.valid &&
 			    !port_iter->regs.bi_rt) {
 				dev_dbg(cxlds->dev,
 					"BI RT advertised but unmapped\n");
-				return 0;
+				return;
 			}
 		}
 
@@ -1384,6 +1388,20 @@ int cxl_bi_setup(struct cxl_port *endpoint)
 		port_iter = dport_iter->port;
 	}
 
+	cxlds->bi_capable = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_probe_capable, "CXL");
+
+int cxl_bi_setup(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dport *dport = endpoint->parent_dport;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	int rc;
+
+	if (!cxlds->bi_capable)
+		return 0;
+
 	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3639cd2daf0c..5ab2f9c39f5c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -962,6 +962,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+void cxl_bi_probe_capable(struct cxl_port *endpoint);
 int cxl_bi_setup(struct cxl_port *endpoint);
 void cxl_bi_reset_detected(struct cxl_port *endpoint);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index eab935eca9b1..8e58adbc2e29 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -170,6 +170,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	cxl_endpoint_parse_cdat(port);
 
 	devm_cxl_port_bi_setup(port);
+	cxl_bi_probe_capable(port);
 
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f9e9058a85da..d0f03f305072 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -170,6 +170,7 @@ struct cxl_dpa_partition {
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @bi: device is BI (Back-Invalidate) enabled
+ * @bi_capable: device and topology path are BI capable
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -190,6 +191,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 	bool rcd;
 	bool bi;
+	bool bi_capable;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-- 
2.39.5

