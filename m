Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175699;
	b=z7hedNR4Dqe/w3eFwzUogusHzu6/8CxDeqTow7hzQ0KOKxRgVFKa/2ay/jkAKtcLnwBX
	 8Nk++WqF+Y5RHqPGq7nDCQg2tFyI/hWvUYVOVRG01dOpKWGqn1YtVp/haFpBHdn5PNluN
	 1ga2CxFb5zSD3IstNkxck0gjNHwa9Rmp88QArPNvgdCZWyMtHa5TJEAu43mwzr8nXzJ8D
	 cyL395uqXts4B2dpnaUyhuK5XHdIGWG6XGSDP5ChGyCl2iIggPpHqz8fl3J1dQG4K98gp
	 8cKgB8bXbpw1Po1SLGldgAcLN8X0Ce5ejqsvt1SWBTFKzxnwZV2x1MGEiQWS36QjFhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175699;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Juvenile-Abortive:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PwSzHMjXPNPEsog/T1I7lwJhsIGfiC+/dgm/jHQ/nB4=;
	b=htUL/JQv1z1uw6bwbhcQsH0Sel1ydw1okLsZyVZO4ocRqw43pCVZUWN3Ll1ZHiZ8FYyF
	 EYp3bLE/dRAF+dXZNCB/WuMKw+Z7wkrgaIi/Yq29UWMsvkHC572F8trTu3FToerO/KCdQ
	 2fNUKbdBNMQ/k2qJKe17D8TwFRS1D/mhE/j/Bp05cl1kGXktNknu6MAYQYVdqnbe9lYMk
	 LOgYYgIzfz05VgvxM/flOrZJ/6DZIckDqkyvH601sl5Vo2oIK5I1JPPfrvWbOWFx5HpyN
	 6QQa1Ft+AS+Y4V0nGmXzNQUNSXx8llFg73c8IKH0SVWN3BiBHpWrGngIPIWbFrR4Qow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=NdjulwzE;
	arc=none smtp.remote-ip=23.83.209.93
Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409F606A330
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7409F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=NdjulwzE
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AA9A64C2461;
	Sun, 08 Nov 2026 22:08:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.99.170.189])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 894924C244D;
	Sun, 08 Nov 2026 22:08:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Abortive: 17dd46f85a9eae49_1794175692663_996188231
X-MC-Loop-Signature: 1794175692663:3192465150
X-MC-Ingress-Time: 1794175692663
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.170.189 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:12 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vg67qgz1073;
	Sun,  8 Nov 2026 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175692;
	bh=PwSzHMjXPNPEsog/T1I7lwJhsIGfiC+/dgm/jHQ/nB4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=NdjulwzEW0Ui758mBljemTFGFLPpn8Ob5txTJsJLsaQ5FsSJqZ9kt50frNNZqdbhS
	 9tPT0RKYsb0KfJ86GP1KV145lN1r2osIGjunTDmdAT8AQRK8pKfZVCAiuTQ2iLTfOO
	 HNRjrKNEP2cR/s0IgLCcFtKa5kZ4cAB/UjfHi40l0ESjKCfu+GzjOrCqdXt15J+eHh
	 wEY3mtA7wmxSQYprPDL7fTwGfrIE9Ij+WaNB1lqvo8+swPhHJ7LTbU21fv3z3UL+Xt
	 TaB8z+Hwd6LU0JNHs1l5sXbu1+dro5FU/zpz69K/82y3C7DP8qSZj4ATKz4D+KtMDN
	 +46coFDPVNcxg==
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
Subject: [PATCH v11 08/10] cxl: Handle auto-committed BI hdm decoders
Date: Sun,  8 Nov 2026 14:07:37 -0800
Message-Id: <0570b67e078439a64c513d62faca1abd7ed70e6c.1794172701.git.dave@stgolabs.net>
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

An HDM decoder that firmware committed with the BI bit set was
assembled without the bit ever being looked at. Record it, and
refuse what is broken - BI paired with a host-only target range type,
or for an endpoint decoder BI on a path that cannot route BISnp.

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

On failure the walk unwinds through the same release as teardown. An
adopted level was found up and is held, so the unwind drops its
reference and leaves its register alone; a level this walk brought up
is cleared. Teardown works the same way: every level this driver
brought up is deallocated, unless a decoder below still decodes with
BI and holds it.

A committed decoder is refused when its coherency model does not fit
where it lands: unlike a decoder this driver programs it cannot
inherit a region's model, so its committed BI bit must match the
window's, checked before the region is built and again at attach,
where a second decoder joining the region arrives.

A firmware-committed decoder's BI bit is recorded as CXL_DECODER_F_BI
at enumeration, as it already is for a decoder this driver commits.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c    | 24 +++++++++++++++-
 drivers/cxl/core/pci.c    | 60 +++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/region.c | 33 +++++++++++++--------
 3 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 31fbfae372e5..1136f7d1bd5b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1145,11 +1145,32 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_BI)
+			cxld->flags |= CXL_DECODER_F_BI;
+
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
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
+
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1428,7 +1449,8 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
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
index a618c382668f..3c37584a661e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1109,6 +1109,32 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
 				    scale, base);
 }
 
+/* Committed, or no explicit commit required */
+static bool __cxl_bi_committed(void __iomem *caps_reg, void __iomem *status_reg,
+			       u32 req_bit, u32 committed_bit)
+{
+	if (!(readl(caps_reg) & req_bit))
+		return true;
+
+	return readl(status_reg) & committed_bit;
+}
+
+static bool cxl_bi_rt_committed(void __iomem *bi)
+{
+	return __cxl_bi_committed(bi + CXL_BI_RT_CAPS_OFFSET,
+				  bi + CXL_BI_RT_STATUS_OFFSET,
+				  CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
+				  CXL_BI_RT_STATUS_BI_COMMITTED);
+}
+
+static bool cxl_bi_decoder_committed(void __iomem *bi)
+{
+	return __cxl_bi_committed(bi + CXL_BI_DECODER_CAPS_OFFSET,
+				  bi + CXL_BI_DECODER_STATUS_OFFSET,
+				  CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
+				  CXL_BI_DECODER_STATUS_BI_COMMITTED);
+}
+
 static int cxl_bi_commit_dport(struct cxl_dport *dport)
 {
 	struct cxl_port *port = dport->port;
@@ -1136,7 +1162,8 @@ static int cxl_bi_commit_dport(struct cxl_dport *dport)
  * @direct says the device is connected directly to this dport, which
  * takes BI Enable; every dport above it takes BI Forward.
  */
-static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
+static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct,
+				    bool *adopt)
 {
 	struct cxl_port *port = dport->port;
 	u32 ctrl, value, set, clr;
@@ -1168,6 +1195,20 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
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
 
@@ -1181,6 +1222,7 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
 		}
 		return rc;
 	}
+done:
 	dport->nr_bi++;
 
 	return 0;
@@ -1277,7 +1319,9 @@ static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
 /*
  * Release the device's BI, then each dport up the path short of @stop,
  * following the deallocate sequence in the implementation notes of
- * CXL 4.0 9.14.2. Setup's unwind and teardown alike.
+ * CXL 4.0 9.14.2. Setup's unwind and teardown alike: a level the
+ * walk adopted was found up and is held, so the unwind leaves its
+ * register as it found it.
  *
  * A decoder that still decodes with its BI bit set needs BI Enable,
  * the device-wide permission behind it, so the device keeps it. The
@@ -1341,14 +1385,24 @@ static void cxl_bi_dealloc(void *data)
 static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
 			      struct cxl_port *port, struct cxl_dport *dport)
 {
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
 	struct cxl_dport *dport_iter;
 	struct cxl_port *port_iter;
+	bool adopt;
 	int rc;
 
+	/*
+	 * Adoption is a path property, not a per-dport one: only when
+	 * firmware enabled the device itself does a dport's committed
+	 * state cover this device's BI-ID.
+	 */
+	adopt = cxl_bi_decoder_enabled(endpoint);
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
index 545e0e3331d0..935417257568 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2131,13 +2131,19 @@ static int cxl_region_check_coherency(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	/* a committed decoder cannot inherit the region's type */
-	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) &&
-	    cxled->cxld.target_type != cxlr->type) {
-		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			cxled->cxld.target_type, cxlr->type);
-		return -ENXIO;
+	/* a committed decoder cannot inherit the region's flavor */
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		bool bi = cxled->cxld.flags & CXL_DECODER_F_BI;
+
+		if (cxled->cxld.target_type != cxlr->type || bi != root_bi) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s coherency model mismatch: %s vs %s\n",
+				dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev),
+				cxl_coherency_name(cxled->cxld.target_type, bi),
+				cxl_coherency_name(cxlr->type, root_bi));
+			return -ENXIO;
+		}
 	}
 
 	return 0;
@@ -3900,6 +3906,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	bool bi = cxled->cxld.flags & CXL_DECODER_F_BI;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 	unsigned long need;
@@ -3909,14 +3916,16 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/*
 	 * A committed decoder defines the region built from it, so no
-	 * attach check can find its range type wrong. Only the window's
-	 * restrictions can.
+	 * attach check can find its coherency model wrong. Only the
+	 * window's restrictions can, if they do not permit its BI bit or
+	 * range type.
 	 */
 	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
 	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
-	if (!(cxlrd->cxlsd.cxld.flags & need)) {
-		dev_dbg(&cxlrd->cxlsd.cxld.dev,
-			"%s:%s range type not permitted by the window\n",
+	if (bi != cxl_root_decoder_is_bi(cxlrd) ||
+	    !(cxlrd->cxlsd.cxld.flags & need)) {
+		dev_err(&cxlrd->cxlsd.cxld.dev,
+			"%s:%s coherency model not permitted by the window\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return ERR_PTR(-ENXIO);
 	}
-- 
2.39.5

