Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7204DD3CD
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121265; cv=none; b=k63zOKxnIPmJYvvi0slQCN1T0vrbGvZO7gYehAdbpyOSTj9pX241vrz+SJunA61uEFOp0UTJ00jWbA7Ot+JJAXVtxCNtSwzK1TOuMvVjy0Dhv5M6HFGwHTa6B0cluKfGR3gWMpz69uu1gW2TSn2hxoLplb10E5s0yjS+FU2Lpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121265; c=relaxed/simple;
	bh=4+uEEztdGeIjDOBMF8/ENk6SF9JH1PAouVtIa8v8nU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muiaHm4T+4kLfNZjy3tprg9y7gw/o8vWwjwYm2zjh26frrkr7RzQqKR5POvvODKZPe3eBOPbSFqMi+z6p0Crru93OcTlzu/9Fq/lqag6t3GbJDRqjlsGgzdgtgBoozkOYU6ftx+fSgFjON8LzfCbTFjTbs/XBmj66m1mFq0tiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=PVTG/U3k; arc=none smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="PVTG/U3k"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 03E2F643692;
	Tue, 22 Sep 2026 23:39:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-99-163-208.trex-nlb.outbound.svc.cluster.local [100.99.163.208])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C51F3642973;
	Tue, 22 Sep 2026 23:39:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Eight: 1308697f6530846c_1790120345932_3345717781
X-MC-Loop-Signature: 1790120345932:1555817338
X-MC-Ingress-Time: 1790120345932
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.163.208 (trex/8.0.2);
	Tue, 22 Sep 2026 23:39:05 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4hqGlF0P43zPK;
	Tue, 22 Sep 2026 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790120345;
	bh=xgUnz6tvWyHWFsr9aAha5OScUA/TgcefeCdQ6SXVwTA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=PVTG/U3kmBdMJ77GuqdCdR0LTeN4I2SDKFCn1NeGz8O1padH46zCAyhtdR971amUg
	 iHtu4P9RzDQzY6P6z4uyLDzTKXqhCCzo209Pnhy8umPCWWqO9WUmwBJ8CA4RH6Nyjc
	 TYZG8rWPcY5FtBkxns2idZA/Qwvk/uyWQE1kbpEH4SfbveWbhDpS0L/uGkkHtG4+vF
	 KVk6MINZGASz51xBWgxgC6oHgPpwFjE4+xBxVl4IjPuRDI9B7QP8GOiEnBc8z76OMg
	 10Ip9vZziG8ejtwRPGr5jbkVOoAup/9n9AJMs9gnD+LsjKInrncEq2lRi08L5y7Tjr
	 IKwWkdyQeZfzQ==
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
Subject: [PATCH v9 08/10] cxl: Allow auto-committed BI hdm decoders
Date: Tue, 22 Sep 2026 16:38:45 -0700
Message-Id: <60fe8a8a0f66a9535905092e1dee604c1f7ae48c.1790103847.git.dave@stgolabs.net>
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

An HDM decoder that firmware committed with the BI bit set was
refused outright. Accept it, and refuse only what is broken - BI
paired with a host-only target range type, or for an endpoint
decoder BI on a path that cannot route BISnp.

Taking over such a path must not re-program what firmware already
did, and a dport's committed state does not say which device it was
committed for, only that firmware committed for something below it.
Two endpoints sharing a level show why that is not enough to go on.

                        RP      Forward set, but for mem0
                        |
                       USP
                       /  \
                   DSP0    DSP1
                     |       |
                  mem0      mem1
               BI Enable   BI Enable
                  set       clear

Adoption is therefore seeded from the endpoint's own BI Enable, since
only a device firmware itself enabled can have had its BI-ID
accounted for above, and carried up the walk. A level is taken as
found, with no register write and no commit, when nothing this driver
routed sits below it, the value this driver would write is already
there, and both the decoder and the switch's route table are
committed - the table carries a commit of its own that firmware may
not have performed. The first level to fall short ends adoption, and
from it up the driver programs and commits as for any other device.

                    RP    Forward, written but never committed
                    |
                  USP0    route table committed by the driver
                    |
                  DSP0    Forward, written and committed
                    |     ..... adoption ended here .....
                  USP1    route table already committed
                    |
                  DSP1    Enable, taken as found
                    |
                  mem0    BI Enable already set by firmware

An adopted level owes no commit either way. Table 8-152 and Table
8-156 owe one per new BI device enabled below the port, and an
adopted level is not seeing one.

The endpoint is adopted the same way. BI Enable already set was an
error before, since only this driver set it; it is now kept and
cxlds->bi taken up without a write.

On failure the walk unwinds only the levels it did not adopt. Since
adoption is a prefix, the unwind drops the refcount below the first
non-adopted level and leaves those registers alone. Teardown is
unchanged and still deallocates every level.

A committed decoder is refused when its coherency model does not fit
where it lands. The window must permit it, and unlike a decoder this
driver programs it cannot inherit a region's model, so its committed
Target Range Type and BI bit must already match. Assembly never
validated these bits, so setting them wrongly costs a platform the
auto-assembly of the affected decoders.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c    | 27 ++++++++----
 drivers/cxl/core/pci.c    | 90 +++++++++++++++++++++++++++++++++------
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++
 3 files changed, 143 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 44ff64b1a9df..0d9ef785e25f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1057,13 +1057,23 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
-		/*
-		 * Autocommit BI-enabled decoders is not supported. A path
-		 * firmware enabled is not taken over, so nothing verifies
-		 * it can route BISnp.
-		 */
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
-			return -ENXIO;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl)) {
+			struct cxl_dev_state *cxlds = cxled ?
+				cxled_to_memdev(cxled)->cxlds : NULL;
+
+			if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+				dev_warn(&port->dev,
+					 "decoder%d.%d: BI with host-only\n",
+					 port->id, cxld->id);
+				return -ENXIO;
+			}
+			if (cxlds && !cxlds->bi_capable) {
+				dev_warn(&port->dev,
+					 "decoder%d.%d: path not BI capable\n",
+					 port->id, cxld->id);
+				return -ENXIO;
+			}
+		}
 
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
@@ -1310,7 +1320,8 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
 	 * Between the port's HDM state and its decoders: devres,
 	 * unwinding in reverse, brings BI down only after the decoders
 	 * quiesce, while its slow walk still precedes the HDM state
-	 * free.
+	 * free. Must also precede region discovery, where HDM-DB
+	 * assembly requires cxlds->bi.
 	 */
 	rc = cxl_bi_setup(port);
 	if (rc)
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9bf05820c142..f83f5d1d8255 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1087,6 +1087,29 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
 				    scale, base);
 }
 
+/* Committed, or no explicit commit required */
+static bool cxl_bi_decoder_committed(void __iomem *bi)
+{
+	u32 caps = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
+	u32 sts = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
+
+	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, caps))
+		return true;
+
+	return FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMITTED, sts);
+}
+
+static bool cxl_bi_rt_committed(void __iomem *bi)
+{
+	u32 caps = readl(bi + CXL_BI_RT_CAPS_OFFSET);
+	u32 sts = readl(bi + CXL_BI_RT_STATUS_OFFSET);
+
+	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ, caps))
+		return true;
+
+	return FIELD_GET(CXL_BI_RT_STATUS_BI_COMMITTED, sts);
+}
+
 static int cxl_bi_commit_dport(struct cxl_dport *dport)
 {
 	struct cxl_port *port = dport->port;
@@ -1114,7 +1137,8 @@ static int cxl_bi_commit_dport(struct cxl_dport *dport)
  * @direct says the device is connected directly to this dport, which
  * takes BI Enable; every dport above it takes BI Forward.
  */
-static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
+static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct,
+				    bool *adopt)
 {
 	struct cxl_port *port = dport->port;
 	u32 ctrl, value, set, clr;
@@ -1135,6 +1159,20 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
 		       CXL_BI_DECODER_CTRL_BI_ENABLE;
 
 	value = (ctrl | set) & ~clr;
+
+	/*
+	 * Adopt this level as firmware left it: nothing below it that
+	 * firmware did not account for, nothing this driver has routed
+	 * through it, the value this walk would write already in place,
+	 * and the decoder (and route table) committed.
+	 */
+	if (*adopt && !dport->nr_bi && value == ctrl &&
+	    cxl_bi_decoder_committed(bi) &&
+	    (!port->regs.bi_rt || cxl_bi_rt_committed(port->regs.bi_rt)))
+		goto done;
+	/* firmware did not bring this level up, so nothing above may */
+	*adopt = false;
+
 	if (value != ctrl)
 		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
 
@@ -1148,6 +1186,7 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
 		}
 		return rc;
 	}
+done:
 	dport->nr_bi++;
 
 	return 0;
@@ -1156,9 +1195,11 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
 /*
  * Dealloc BI-ID changes in the given level of the topology. Called
  * once per endpoint that enabled this level: on teardown, or to
- * unwind a path that failed partway up.
+ * unwind a path that failed partway up. @clear false drops the
+ * reference without touching the register, for a level this driver
+ * adopted and therefore never wrote.
  */
-static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
+static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport, bool clear)
 {
 	struct cxl_port *port = dport->port;
 	void __iomem *bi;
@@ -1177,6 +1218,9 @@ static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
 	if (--dport->nr_bi > 0)
 		return 0;
 
+	if (!clear)
+		return 0;
+
 	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
 	writel(ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
 			CXL_BI_DECODER_CTRL_BI_ENABLE),
@@ -1198,11 +1242,10 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
 
 	if (enable) {
 		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
-			if (cxlds->bi)
-				return 0;
-			dev_err(cxlds->dev,
-				"BI already enabled in hardware\n");
-			return -EBUSY;
+			if (!cxlds->bi) /* adopt firmware enabled */
+				dev_dbg(cxlds->dev,
+					"adopting firmware-enabled BI\n");
+			goto done;
 		}
 	} else {
 		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
@@ -1216,10 +1259,10 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
 
 	FIELD_MODIFY(CXL_BI_DECODER_CTRL_BI_ENABLE, &ctrl, enable);
 	writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
-	cxlds->bi = enable;
 
 	dev_dbg(cxlds->dev, "BI requests %s\n", str_enabled_disabled(enable));
-
+done:
+	cxlds->bi = enable;
 	return 0;
 }
 
@@ -1257,7 +1300,7 @@ static void cxl_bi_dealloc(void *data)
 	dport_iter = endpoint->parent_dport;
 	port_iter = dport_iter->port;
 	while (!is_cxl_root(port_iter)) {
-		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
+		int rc = cxl_bi_ctrl_dport_disable(dport_iter, true);
 
 		/* best effort */
 		if (rc)
@@ -1276,17 +1319,33 @@ static void cxl_bi_dealloc(void *data)
 static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
 			      struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct cxl_dport *dport_iter, *failed;
+	struct cxl_dport *dport_iter, *failed, *programmed = NULL;
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
 	struct cxl_port *port_iter;
+	bool adopt, clear;
 	int rc;
 
+	/*
+	 * Adoption is a path property, not a per-dport one: only when
+	 * firmware enabled the device itself does a dport's committed
+	 * state cover this device's BI-ID.
+	 */
+	adopt = FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
+			  readl(endpoint->regs.bi_decoder +
+				CXL_BI_DECODER_CTRL_OFFSET));
+
 	port_iter = port;
 	dport_iter = dport;
 	while (!is_cxl_root(port_iter)) {
-		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
+		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport,
+					      &adopt);
 		if (rc)
 			goto err_rollback;
 
+		/* adoption is a prefix: this is the first level not adopted */
+		if (!adopt && !programmed)
+			programmed = dport_iter;
+
 		dport_iter = port_iter->parent_dport;
 		port_iter = dport_iter->port;
 	}
@@ -1301,8 +1360,11 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
 	failed = dport_iter;
 	dport_iter = dport;
 	port_iter = port;
+	clear = false;
 	while (!is_cxl_root(port_iter) && dport_iter != failed) {
-		cxl_bi_ctrl_dport_disable(dport_iter);
+		if (dport_iter == programmed)
+			clear = true;
+		cxl_bi_ctrl_dport_disable(dport_iter, clear);
 		dport_iter = port_iter->parent_dport;
 		port_iter = dport_iter->port;
 	}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f322a8a4a66d..0e3ba7c79a75 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1861,6 +1861,20 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	return rc;
 }
 
+static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	u32 ctrl;
+
+	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
+		return false;
+
+	ctrl = readl(cxlhdm->regs.hdm_decoder +
+		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));
+	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
+}
+
 static const char *cxl_coherency_name(enum cxl_decoder_type type, bool bi)
 {
 	if (type == CXL_DECODER_HOSTONLYMEM)
@@ -2179,6 +2193,24 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	/* a committed decoder cannot inherit the region's flavor */
+	if (cxled->state == CXL_DECODER_STATE_AUTO) {
+		bool bi = cxled_committed_bi(cxled);
+		const char *have, *want;
+
+		have = cxl_coherency_name(cxled->cxld.target_type, bi);
+		want = cxl_coherency_name(cxlr->type,
+					  cxl_root_decoder_is_bi(cxlrd));
+		if (cxled->cxld.target_type != cxlr->type ||
+		    bi != cxl_root_decoder_is_bi(cxlrd)) {
+			dev_err(&cxlr->dev,
+				"%s:%s coherency model mismatch: %s vs %s\n",
+				dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev), have, want);
+			return -ENXIO;
+		}
+	}
+
 	if (!cxled->dpa_res) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
@@ -3838,10 +3870,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
+	unsigned long need;
 
 	if (part < 0)
 		return ERR_PTR(-EBUSY);
 
+	/*
+	 * A committed decoder defines the region built from it, so no
+	 * attach check can find its coherency model wrong. Only the
+	 * window's restrictions can, on the BI and range type axes.
+	 */
+	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
+	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
+	if (cxled_committed_bi(cxled) != cxl_root_decoder_is_bi(cxlrd) ||
+	    !(cxlrd->cxlsd.cxld.flags & need)) {
+		dev_err(&cxlrd->cxlsd.cxld.dev,
+			"%s:%s coherency model not permitted by the window\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return ERR_PTR(-ENXIO);
+	}
+
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id),
-- 
2.39.5

