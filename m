Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6317339705
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973416; cv=none; b=W6vap8WnRpiOWqcYVdwVLeXkbFoRD2bkXLSLWoSLp/2Sm2c7Arda5uP5/LWK7FEc+EjROsL03xmJY6lzutnWQGCy/jA5gHKmeW4M8YnwtFYYWT+VA4QF9MEFbmNT/CRu90GmzEdHRga9irx5vf1D41yoVtve0575njBIXvQ5nSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973416; c=relaxed/simple;
	bh=6SmUF9EMLyXUvbON0x/lNei/7y4pBUPCS5yf83sQp0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOMCyrot8rxzXnpoc/pfA3+mF3jos6ZZ8s+uligofIgpEW72n69vY9bkK1S5SSbcqCsDLi604pMUB+Ya9DC2v2FbLW2NhGkH3L0xwSigsZWBqwUkSPnDUkeJVlx3SjG6vEflqApvtKfNLSljH9dR35EraTvQVbr5D9c7Uw6mpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=aNzZyCYM; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="aNzZyCYM"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E5C03462316;
	Wed, 09 Sep 2026 17:03:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.96.169.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B6D3D462796;
	Wed, 09 Sep 2026 17:03:33 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Cold: 1f6196e43d0afea6_1788973413860_1590355590
X-MC-Loop-Signature: 1788973413860:1717634270
X-MC-Ingress-Time: 1788973413860
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
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zs0Nw4z1Z;
	Wed,  9 Sep 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973413;
	bh=5ZC4AuNV+t9dxln4Mzfktc7fTFls7qQ8TOnYxgqwuzk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=aNzZyCYMRRTzRRRm3fZ/JIGrNJa661yP5kzZUJelqx05eKX/m4aFw89kXFNHJ8GzC
	 MNu3UTboDKA5T+5y98awM0rL9yBGXak+ssvZA2ZwNHtTiWSeCt0HUG6vwQRx/8vYJ1
	 tFe2LAqhX/2OjPuEInvWFyUZuiS4Ow/NEM9hqa5nWGxbVwlkTsXVh+EQEO00J9J7O9
	 awY0w6R0NKYGwrJ68W/k33FdelxVI4shkfJcvUXGqvVJ9oxu7wcxFvn/f4EY8oBI2E
	 YxzcdqwuLa1HEYu0cyv0FZaqC/FFcMY2YYd61YyRysgkykiZZchfdhVSLPth9pIKBp
	 gqldBEk5lXA+w==
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
Subject: [PATCH v8 08/10] cxl: Allow auto-committed BI hdm decoders
Date: Wed,  9 Sep 2026 10:03:00 -0700
Message-Id: <20260909170302.1550680-9-dave@stgolabs.net>
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

Allow auto-committed BI hdm decoders on sane platforms, rejecting
only broken paths (ie: one that cannot route BISnp, or BI paired
with a host-only target range type).

The respective region creation is done like any other committed
decoder - with cxlds->bi set by the time an decoder attaches.

Skipping the commit does not weaken the rule stated in "cxl/pci: Add
BI topology enable/disable". Table 8-152 and Table 8-156 key it on a
new BI device being enabled anywhere below the port, and a level
firmware already brought up for this device is not seeing one.

Whether it did is a property of the path, not of the dport: a level's
committed state only proves firmware committed for some device below
it, which need not be this one. So adoption starts from the
endpoint's own BI Enable - only a device firmware itself enabled can
have had its BI-ID accounted for above - and a level is then taken
as found when nothing this driver routed sits below it, the control
value this driver would write is the one already there, the decoder
is committed, and the switch's route table - which carries a commit
of its own that firmware may not have performed - is committed too.
The first level that falls short ends it: from there up the driver
is enabling something new, and programs and commits as for any
other device.

A committed decoder is refused when the window's restrictions do not
permit its coherency model, on either axis: a BI decoder under a
window without the BI restriction, or a host-only or device-coherent
decoder under a window exposing only the other model (undefined
behavior per the CFMWS Window Restrictions). Assembly so far never
consulted the type bits, so a platform that sets them wrongly loses
auto-assembly of the affected decoders, with the refusal naming the
window.

A committed decoder cannot inherit a region's coherency model the way
a decoder this driver programs does, so the type-mismatch refusal
that "cxl: Add HDM-DB region creation" removed from
cxl_region_attach() in favor of inheritance returns there for
committed decoders, on both axes: the committed Target Range Type,
kept as the decoder's target_type since enumeration, must match the
region's, and the committed BI bit, read back from the decoder since
the driver keeps no copy of it, must match the root's. The refusal
names both models.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c    | 27 +++++++++-----
 drivers/cxl/core/pci.c    | 75 ++++++++++++++++++++++++++++++++-------
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 35bd308156af..595fe8c99821 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1049,13 +1049,23 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
-		/*
-		 * Autocommit BI-enabled decoders is not supported.
-		 * At this point cxlds->bi is not yet setup, so there
-		 * are no guarantees that the platform supports BI.
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
@@ -1302,7 +1312,8 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
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
index 95064be6faad..c5f3d9178513 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1085,6 +1085,29 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
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
@@ -1108,7 +1131,7 @@ static int cxl_bi_commit_dport(struct cxl_dport *dport)
  * below it.
  */
 static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
-			       bool direct)
+			       bool direct, bool *adopt)
 {
 	void __iomem *bi = dport->regs.bi_decoder;
 	struct cxl_port *port = dport->port;
@@ -1140,6 +1163,20 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
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
 
@@ -1153,19 +1190,21 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
 		}
 		return rc;
 	}
+done:
 	dport->nr_bi++;
 
 	return 0;
 }
 
-static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
+static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct,
+				    bool *adopt)
 {
-	return __cxl_bi_ctrl_dport(dport, true, direct);
+	return __cxl_bi_ctrl_dport(dport, true, direct, adopt);
 }
 
 static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
 {
-	return __cxl_bi_ctrl_dport(dport, false, false);
+	return __cxl_bi_ctrl_dport(dport, false, false, NULL);
 }
 
 static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
@@ -1181,11 +1220,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
 
 	if (enable) {
 		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
-			if (cxlds->bi)
-				return 0;
-			dev_err(cxlds->dev,
-				"BI already enabled in hardware\n");
-			return -EBUSY;
+			/* adopt firmware enabled */
+			if (!cxlds->bi)
+				dev_dbg(cxlds->dev,
+					"adopting firmware-enabled BI\n");
+			goto done;
 		}
 		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
 	} else {
@@ -1200,11 +1239,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
 	}
 
 	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
-	cxlds->bi = enable;
 
 	dev_dbg(cxlds->dev, "BI requests %s\n",
 		str_enabled_disabled(enable));
-
+done:
+	cxlds->bi = enable;
 	return 0;
 }
 
@@ -1262,14 +1301,26 @@ static void cxl_bi_dealloc(void *data)
 static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
 			      struct cxl_port *port, struct cxl_dport *dport)
 {
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
 	struct cxl_dport *dport_iter, *failed;
 	struct cxl_port *port_iter;
+	bool adopt;
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
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9874be7732d4..a9dcaff47a72 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1843,6 +1843,20 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
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
@@ -2153,6 +2167,24 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -3812,10 +3844,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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

