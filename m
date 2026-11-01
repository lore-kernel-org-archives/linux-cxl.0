Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.212.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569886;
	b=VvM8P/8OUKCLIIcQ6l/VPJ4gbINpFmKQEL11iZaNHDZvHaftQN/YcwbfBM9T+kq8A82i
	 WtvpksyiNt7P/fNH3rIrwkhWp0VEo8cT3Cb1/71S65N0mazkYiSv8ZfYOdObl+gEzVqB2
	 188OjgAIFDL2nVoPgRJ9t67L1nz1nXdm3+d9FRd2XahCNlnIbwdQBg+o2/GShWlDs7G90
	 fx+t1iKGKmFvA9Xt5qkGlTN/8jB1po6E6dm1yBcqpTTnIKACd9hUnwsBFJA+P6QPL6wU6
	 5Ly7xCJE7RQqQCxgQkwJFpqPdtBaKUQqRF8blDj7FLWfj/VoHlvvTeKBR+dtKZ1b9bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569886;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Plucky-Quick:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EqV1PvgWEktX+fqEWC8lKgagSEOgUBlsqQO0eRZwwY4=;
	b=4gcvLohIrPiwe0VJkw484/VqjZpG548DFS/z1/l07X8AvRIKoBYlbQPl3bqNRVG2Ffuf
	 CP4BF1lKUp5MNkfjUs01rdlVlvIrVbA511NTfZ0x0ctXWKyd3970ORpUhmvXaBjS3YdAC
	 JgOzweZflisvtC1GZaWt9ULt2JkMML+sEQ1Q2Zk0hPxA81GLrtvw04kao4lpnowRkBJQo
	 jNk4ClUv2aeNRqBdgQyZbY+WzKM19ocCeB91dYDnpMlDrL10DhSkAMjN/nWIhWi5zxgbQ
	 x8yxCgO4mbElOQhvmBkqLh/4JbSToNIFd1CehTs1FEkD1fvQNVuRsMUBMZmeSkJsyKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Vo+sScF8;
	arc=none smtp.remote-ip=23.83.212.19
Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C503606A327
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 21:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C503606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Vo+sScF8
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A3022605A6;
	Sun, 01 Nov 2026 21:51:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.99.172.205])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7CA4060531;
	Sun, 01 Nov 2026 21:51:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Quick: 707e6f104b288f99_1793569879620_2007999333
X-MC-Loop-Signature: 1793569879620:87211477
X-MC-Ingress-Time: 1793569879619
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.172.205 (trex/8.0.2);
	Sun, 01 Nov 2026 21:51:19 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4jHpSQ60gzz1041;
	Sun,  1 Nov 2026 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793569879;
	bh=EqV1PvgWEktX+fqEWC8lKgagSEOgUBlsqQO0eRZwwY4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Vo+sScF8SF1wNVk381wYzB10SSXOU4wrO4Wxx/FHwotY/tLxzRYTzTsUbZSiFeU6j
	 pGU6797UNFpQrxiMKJ+Yz5g3Ksx7wAvLfCXBoMjLw2dzSUA987B5gVwrT0jslxrCkS
	 WeTrGIvaRRVhULoJ5EGljXJ2uAIhwtHEYUDPBB5jB8bconrsVqEmWJwJcFcIdb3jSW
	 9IOwXMEN1lTeo93ytFgDeuermiviHdXyotXe6u4cHawKgMuXZUGYLDqVA7BO/V1BvK
	 zRpDW1cu/i6zCVy69RAeNnhTqe4Yzh4LGFhPIK3k73LOIHQwccVQwG65ja9WblTmA+
	 YhFksFwCJdggg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v10 08/10] cxl: Handle auto-committed BI hdm decoders
Date: Sun,  1 Nov 2026 13:51:05 -0800
Message-Id: <db0f7cc38da1300596a7b8653bd2fba010e20e52.1793567979.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793567979.git.dave@stgolabs.net>
References: <cover.1793567979.git.dave@stgolabs.net>
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

A committed decoder's BI bit is recorded as CXL_DECODER_F_BI. On a
root decoder the same flag is the window's BI restriction, as F_LOCK
already means a fixed window there and Lock On Commit below.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c    | 31 ++++++++++++++++++--
 drivers/cxl/core/pci.c    | 60 +++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/region.c | 32 +++++++++++++--------
 drivers/cxl/cxl.h         |  3 +-
 4 files changed, 108 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c272fc6faf37..1136f7d1bd5b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -907,6 +907,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	int id = cxld->id, rc;
+	u32 ctrl;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -950,6 +951,10 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
 
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_BI)
+		cxld->flags |= CXL_DECODER_F_BI;
+
 	return 0;
 }
 
@@ -1020,7 +1025,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
-	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxld->flags &= ~(CXL_DECODER_F_ENABLE | CXL_DECODER_F_BI);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1140,11 +1145,32 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
@@ -1423,7 +1449,8 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
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
index aec1edf648bd..11e2a97f6567 100644
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
index 06a0e9bb892f..4c92aed1a744 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2129,13 +2129,19 @@ static int cxl_region_check_coherency(struct cxl_region *cxlr,
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
@@ -3898,6 +3904,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	bool bi = cxled->cxld.flags & CXL_DECODER_F_BI;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 	unsigned long need;
@@ -3907,14 +3914,15 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/*
 	 * A committed decoder defines the region built from it, so no
-	 * attach check can find its range type wrong. Only the window's
-	 * restrictions can.
+	 * attach check can find its coherency model wrong. Only the
+	 * window's restrictions can, on the BI and range type axes.
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a95045b05601..90815daffe8e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -311,7 +311,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_BI    BIT(7)
-#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
+#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK | \
+				  CXL_DECODER_F_BI)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
-- 
2.39.5

