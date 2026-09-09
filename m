Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1334252D
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973422; cv=none; b=p5slF3dU6BLYPNH+j4mcnNuhkB5igveLZErn9YImj1HrgoDV4uEjt7fjX6hanMEuK+rTLRZsYW8gLQwy4/dMC9imSHznoidWmsO99dcBMVvi/ULooThy2zdp2BLU+Xi9q2K1Ho+M9ywBxT9+FYH7cRuj69c93q9F6JurtCJkqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973422; c=relaxed/simple;
	bh=PR8/RGKuAr8btKceGO61pGqoQyW775p8YmwCuQ7QhYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJMUDxZcLE+gNB60v89CxAoTjEixnkFM2EfYJtmuqQJxCizRbHsfw7GXnPV95AJWMgKZibhrbHOmBqS1VtNHxTlcJ/3S22c0u8J08vR2HA6m+NEu34W4e41GdqUBQ8RZfEJM04kEptW21yxWYMImlDgi1KX7af0IQ2gGV08Qef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KVv/OcfC; arc=none smtp.client-ip=23.83.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KVv/OcfC"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 49C084624D4;
	Wed, 09 Sep 2026 17:03:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (100-96-169-19.trex-nlb.outbound.svc.cluster.local [100.96.169.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 099024624DB;
	Wed, 09 Sep 2026 17:03:33 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Bored: 63eb150d34a1646a_1788973413174_3202328544
X-MC-Loop-Signature: 1788973413174:1708893529
X-MC-Ingress-Time: 1788973413174
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.169.19 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:33 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zr2rwlz1dF;
	Wed,  9 Sep 2026 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973412;
	bh=dIzPSvOVYTjlJEBxbLTR9Z4WkLztfiTDMqmsaKq5MW8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=KVv/OcfCldmUQyM6jzlkTJbTtFOBJltmc/FLjRPl/o904485x6t+YHVnDDkjqzemJ
	 sALCLbEKZMQA2Gc5Tj4gJsHxSzOUlNAnvwl4eo6sPGN7wWaPvlJA18dVJCvQNzydLT
	 SXvR8vF7VHGK4YBdwcXyZHkQfjdT4wUozG1B4/qm0EN/xEGztYZ9RskwBBfPLnCdkz
	 TqLLJ8pH2YUSXjU4zAE5H2hRCJg0a6iFWdV4zXhaw4rgWhRK5vfXwzrIDAlE5v+sqn
	 NrIqS0bFL539OtqBvNf+EoF04hL6IiTeTcJOR70rsSoLtpAjGhDrSEzyEwcCSO9R/O
	 CCOPTESTVo1Wg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v8 07/10] cxl/pci: Split BI capability probe from setup
Date: Wed,  9 Sep 2026 10:02:59 -0700
Message-Id: <20260909170302.1550680-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909170302.1550680-1-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
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
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 87 +++++++++++++++++++++++++-----------------
 drivers/cxl/cxl.h      |  1 +
 drivers/cxl/port.c     |  1 +
 include/cxl/cxl.h      |  2 +
 4 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8c3c00137849..95064be6faad 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1297,59 +1297,37 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
 }
 
 /*
- * An SBR wipes the device's BI Enable; an FLR leaves it alone.
- * The check is against the hardware, not decoder state: BI is
- * enabled at probe, so it can be wiped with no decoder ever
- * committed. A wipe invalidates the software state; BI is never
- * re-enabled here.
+ * Verify the device and every component in the path up to the root
+ * are BI capable.
  */
-void cxl_bi_reset_detected(struct cxl_port *endpoint)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	void __iomem *bi = endpoint->regs.bi_decoder;
-
-	if (!cxlds->bi)
-		return;
-
-	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
-		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
-		return;
-
-	dev_dbg(cxlds->dev, "BI disabled by reset\n");
-	cxlds->bi = false;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
-
-int cxl_bi_setup(struct cxl_port *endpoint)
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
 
-	/* walkup the topology twice, first to check, then to enable */
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
@@ -1360,13 +1338,13 @@ int cxl_bi_setup(struct cxl_port *endpoint)
 					       port_iter->regs.bi_rt)) {
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
 
@@ -1374,6 +1352,45 @@ int cxl_bi_setup(struct cxl_port *endpoint)
 		port_iter = dport_iter->port;
 	}
 
+	cxlds->bi_capable = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_probe_capable, "CXL");
+
+/*
+ * An SBR wipes the device's BI Enable; an FLR leaves it alone.
+ * The check is against the hardware, not decoder state: BI is
+ * enabled at probe, so it can be wiped with no decoder ever
+ * committed. A wipe invalidates the software state; BI is never
+ * re-enabled here.
+ */
+void cxl_bi_reset_detected(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	void __iomem *bi = endpoint->regs.bi_decoder;
+
+	if (!cxlds->bi)
+		return;
+
+	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
+		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
+		return;
+
+	dev_dbg(cxlds->dev, "BI disabled by reset\n");
+	cxlds->bi = false;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
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
index c12009674445..5ce7bfe9daf4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -961,6 +961,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
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

