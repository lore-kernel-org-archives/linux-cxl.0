Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175698;
	b=k+KFT0czmzu0f98Cgf1hUrwy3e7iMaFI/331asiaOpUkJsv7SLRNPdDgzPSaz6QM+7JD
	 cfkpauxj7BrLAMkzFkpFH+oCKdfWI5pmUbvdeuJqIBCbx9mDwPSwj6TcclSM0EkHrAzrq
	 +SZIkgyF4V3do9+wqlhaAmB9VUmLrntrgLmX3EMXUUmnwHOKxJrzd58NFkGKu4+UShKGj
	 niy/jjJgJ0vKzvzwVIjcmORtMOMKDlzmN4gudd+5tEOyc6qXKcAkfEuXDLf4DJZ/nEfIY
	 sbWLRMiWy8+YcSfVBjNIaIm//bREu0qVVNpWEtf7KPg4lGCgy5OH8TDLdoUcRcW8S9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175698;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Fumbling-Keen:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FeL8GAKdpXKTl55yDYesyoz+jtrKG5jPhueWYhcXdO8=;
	b=CDLlmjYGnUGDvAyTzl0jc4ZvTOe+i4RFqw6YAGZWUz37ofDtfYKkRnIAAR2nVyhLRNP7
	 vrWykdBN+aA9lAeSLDsPYGROORFUxT2J2C4Fj/XvhfPpZUWSTFhB/c/4dBVrWyDh6OwSX
	 ALQ+/34PWik5KggyFNO0Nn081Wj+HPAeVOpY0rz/vYlm55SMkAYxAftvNcOh0LJtjwa8c
	 HlVxJR6avplMQIV0rRUGsUbwert10iZESQrB9pliy7geV2s92sH0Zn+icxs9Lu6qvWIrZ
	 NUADR3JtExCe9FYmLMRyDOe6NWTP6KtuvUgUXDOUXKEtRONrt4/0SphoyZ1iObNjKyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=OqHW6NiZ;
	arc=none smtp.remote-ip=23.83.209.14
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445B606A334
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7445B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=OqHW6NiZ
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 01D028C2877;
	Sun, 08 Nov 2026 22:08:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.99.173.10])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CD4208C286D;
	Sun, 08 Nov 2026 22:08:11 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Keen: 52f352b234ef9796_1794175691928_3763654877
X-MC-Loop-Signature: 1794175691928:2065679528
X-MC-Ingress-Time: 1794175691928
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.173.10 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:11 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vg1RCmz1056;
	Sun,  8 Nov 2026 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175691;
	bh=FeL8GAKdpXKTl55yDYesyoz+jtrKG5jPhueWYhcXdO8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=OqHW6NiZTxKjRfq4IRHZ1Ba/yePKVA0Kf4SED1ehMdpG50ahtVWNAl6PSaBvPGcnz
	 KuPQQkqXBr9DvAEk8c1S9IBQeqkPyPyE4lRlZV74eh65CTB0Ggxr99pAUhc1YzF09w
	 Y37lMKRIZ42MMmadqs1cdIQ9OHCxinWjJXz+l9gu8oqiHEkwYeJPCfw548EZtmGWzv
	 gQgEnpi+7klfI596cWhmE7rK/OHoGvWnd4peEBJxJgigB7jgwTO/qthurh9khrqlsD
	 QIwTzR10Eaqz63wiULgIrSrFkKJMNI1VUZ6zPkcJ9dRUNT341eSsyClKOPvwryda0H
	 wImlcFLbkFEtg==
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
Subject: [PATCH v11 07/10] cxl/pci: Split BI capability probe from setup
Date: Sun,  8 Nov 2026 14:07:36 -0800
Message-Id: <79b13011027eab488311a2d2c879762b604e5e8f.1794172701.git.dave@stgolabs.net>
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

Decouple the topology read-only capability verification phase from
cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
cxlds->bi_capable.

This allows further dealing with auto-committed BI hdm decoders;
having such knowledge upon decoder enumeration time.

No functional change intended.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 40 +++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h      |  1 +
 drivers/cxl/port.c     |  1 +
 include/cxl/cxl.h      |  2 ++
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c443abb57c93..a618c382668f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1400,34 +1400,38 @@ void cxl_bi_reset_detected(struct cxl_port *endpoint)
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
@@ -1438,13 +1442,13 @@ int cxl_bi_setup(struct cxl_port *endpoint)
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
 
@@ -1452,6 +1456,20 @@ int cxl_bi_setup(struct cxl_port *endpoint)
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
index 7e2112d7ca96..90815daffe8e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -998,6 +998,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+void cxl_bi_probe_capable(struct cxl_port *endpoint);
 int cxl_bi_setup(struct cxl_port *endpoint);
 void cxl_bi_reset_detected(struct cxl_port *endpoint);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 1a69be0ec7c1..96fade029911 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -173,6 +173,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	cxl_endpoint_parse_cdat(port);
 
 	devm_cxl_port_bi_setup(port);
+	cxl_bi_probe_capable(port);
 
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c23f7d3a0fdc..6fa9d913ccdb 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -197,6 +197,7 @@ struct cxl_dpa_partition {
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @bi: device is BI (Back-Invalidate) enabled
+ * @bi_capable: device and topology path are BI capable
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -217,6 +218,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 	bool rcd;
 	bool bi;
+	bool bi_capable;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-- 
2.39.5

