Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B642EC083
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250170; cv=none; b=LwaBzVP+pfMchXmOs27HqF66S1Kqd0x2/m+09WQvA3fssHO9ChMOUtbnbzgCwjzW7Xf1LTm0hZEGt59B+Rn2NHYj3mEuiSBPUrIzNRBdas3uX9XDxqKdf6349IjscBZ5NQNhXS9CmESqOdCK0Vpfel6iU18uE4ruHkel7gCdel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250170; c=relaxed/simple;
	bh=AqIEMzpSby/YuG8mPfwypq70RYEYlBJ6VF/fVFHZtAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbhfALejY243i+m53PrqKHeE//HTwv5W0pMgZagmf2Z3PfVL6VYCzcr988HkxxUpgggAQnSy2SKrZt6lG4XKyK6SrWdhdpBVKq25FSOW1hx8nLt3vP6NtnkqgC+M6Uf3fjYHe7dMX1kzUPy1MrTP64pfJ0omsKiqDQQCtVtUC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=djMBxxLb; arc=none smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="djMBxxLb"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 75FD83E08D0;
	Tue, 28 Jul 2026 14:41:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.111.249.230])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1DC083E1807;
	Tue, 28 Jul 2026 14:41:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Share: 1c1081671b2c380d_1785249715375_2603803685
X-MC-Loop-Signature: 1785249715375:3538355929
X-MC-Ingress-Time: 1785249715375
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.249.230 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:55 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dTB3TFxz3K;
	Tue, 28 Jul 2026 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249710;
	bh=OdYCogi7ilmBQv7tG6DwbOUoCOGVpBBVzwuYITMiihY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=djMBxxLbnlVA75h5LlmNQY2W4KSQ+wXkM1/lGgp3VjOnagJzjQu8q0cqnJrZJJ40U
	 qCv/5ds7byUjy/IEGnDrryYqvRQ4TMe4A4WnO7ojwBCdtcsVNtGEl38ZzFqYU9kvvS
	 aVfgQNthoevFICWBP2AWSkNQB3d/OyfVK1bnQ5N6uiDVSsvVyqSLsI+3IRz6z/Jrts
	 RfCMFPDOq9rwYYmPhZpi/e/Vwg7rlDHQ20PahRZCnTynhuiHdVYj3WWEmXvL7ZiD63
	 asKmrmgSdhbbcZgk9lJnQjsJYR/jzGdaA2vAGuHPYa1ure+DdUAdttuQ+49R+A5hD0
	 snZ4RjLNVEfPQ==
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
Subject: [PATCH v7 7/8] cxl/pci: Split BI capability probe from setup
Date: Tue, 28 Jul 2026 07:41:35 -0700
Message-Id: <20260728144136.709882-8-dave@stgolabs.net>
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

Decouple the topology read-only capability verification phase from
cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
cxlds->bi_capable.

This allows further dealing with auto-committed BI hdm decoders;
having such knowledge upon decoder enumeration time.

No functional change intended.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 39 ++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h      |  1 +
 drivers/cxl/port.c     |  1 +
 include/cxl/cxl.h      |  2 ++
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a87c2ad9ac53..554058ccb1e9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1290,35 +1290,38 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
 	return rc;
 }
 
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
@@ -1328,13 +1331,27 @@ int cxl_bi_setup(struct cxl_port *endpoint)
 		    !cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
 				       port_iter->regs.bi_rt)) {
 			dev_dbg(cxlds->dev, "BI not supported by USP\n");
-			return 0;
+			return;
 		}
 
 		dport_iter = port_iter->parent_dport;
 		port_iter = dport_iter->port;
 	}
 
+	cxlds->bi_capable = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_probe_capable, "CXL");
+
+int cxl_bi_setup(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_dport *dport = endpoint->parent_dport;
+	int rc;
+
+	if (!cxlds->bi_capable)
+		return 0;
+
 	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ca7051641c47..e10d642684e1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -963,6 +963,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+void cxl_bi_probe_capable(struct cxl_port *endpoint);
 int cxl_bi_setup(struct cxl_port *endpoint);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 					    struct device *dport_dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 22bd4254ba8d..ab3317fc1388 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -170,6 +170,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	cxl_endpoint_parse_cdat(port);
 
 	cxl_port_map_bi(port);
+	cxl_bi_probe_capable(port);
 
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e507cb0f777f..80d942eb9456 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -169,6 +169,7 @@ struct cxl_dpa_partition {
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @bi: device is BI (Back-Invalidate) enabled
+ * @bi_capable: device and topology path are BI capable
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -189,6 +190,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 	bool rcd;
 	bool bi;
+	bool bi_capable;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-- 
2.39.5

