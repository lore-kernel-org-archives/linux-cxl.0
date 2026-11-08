Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175698;
	b=DS+Gi3LasTOufY5UNxWD4sFpt5i342leSx5f1T6YYtA+djldIZUtmh0iVuRV9o3JMYib
	 ubbvi4hCSJxE3tbpORwaVPCLA/NwumaIry3DjEql1GbW2NrCQORRaSU7ZWFKrkAioYYKX
	 ulLIpEXO566ef2cVPyL3aWnhgQKe/XDpZDly9aFZTd5A2P/yAp/mIBiT5VY5VY/C6953U
	 fdO59iATSqLHucMKVZqyFgQ7vwNdUbhxGM5sR1Mu4OtnbJssaDjIA84kAEIHFgb8RKQHT
	 f+r0FDsf13ghST1dDhoOezkl4Wt/fO0dmPvGGqybwIvsv1wrDFHi1CyncZ0YwHlRjxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175698;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Whistle-Bored:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vD3hVWqYPR78vxCfonf8V5Q7Hbj25ZcKqaNRi6ExXqQ=;
	b=GFvm9xYK9USlPyzIkPFc+UdSkehlkG7Fxv3IPgOQeQ1w/Yo3xxyAgTY43vxwSG7N0SvF
	 vfPXHH0V1C9Y+XS1G1q3AmYV4itLohRAPIpp3jvjhW5aik9UgA14/57e7bpz+0o3KDNuP
	 G05drWDGbJYr9W+y9KDfc18JOKRWAYArwkURyqCvFMYfq9HhqqVca94K6Gitd3fjE3ZGO
	 tXEgjeTxGgRnCo652cs6EOE5/7JJyUqb7DufXSB8ztRS4GOzgxLx4iHPqTK4pYyfdXrml
	 8m9I2lcIo+nnt01Q2KtJQwYewx6t88iIWlsudWtgl6PWFZBmsDptVnTJbG6fLpexZxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=JWrY+yPo;
	arc=none smtp.remote-ip=23.83.222.24
Received: from buffalo.ash.relay.mailchannels.net (buffalo.ash.relay.mailchannels.net [23.83.222.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742B606A330
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0742B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=JWrY+yPo
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E17364E1701;
	Sun, 08 Nov 2026 22:08:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-99-170-189.trex-nlb.outbound.svc.cluster.local [100.99.170.189])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B70D84E14B3;
	Sun, 08 Nov 2026 22:08:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Bored: 41d3cdea56918cf7_1794175689857_1711801855
X-MC-Loop-Signature: 1794175689857:74631555
X-MC-Ingress-Time: 1794175689857
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.170.189 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:09 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vd0XJDzyr8;
	Sun,  8 Nov 2026 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175689;
	bh=vD3hVWqYPR78vxCfonf8V5Q7Hbj25ZcKqaNRi6ExXqQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=JWrY+yPo6gXRjnTNYwFj+cBN3TRKnljkzFzs1wLvBqZ7aunkzlHwtxdA3pqchVuLD
	 wi8iN+9qCV79lX5hGIdlCXwXWogUBhHfDf97Um82cUd6WDOEpFutw1mOWcnUut9EjU
	 HOgKeFfOyPDXeV5sKwf8FpjVab9nMRQ/2QNR+yt5fS0Fj+8v6nePdo+F1XZS5seC54
	 yRjAh+5M3ssVLAINoXqUWGOxEq+OouLet7mqA4MLWRqUShLV7zJHH3di/1JS93gegj
	 HTy9e6DLuV8rtld0/buRGeFuHKGmMtrFunN7TmqPziSF7AMts/DVpcmUXj6hUkWKCV
	 7rrws8BSoT8qw==
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
Subject: [PATCH v11 04/10] cxl: Add HDM-DB region creation
Date: Sun,  8 Nov 2026 14:07:33 -0800
Message-Id: <5d3ac10113c01cb52f12184b06eb6a1dcbb2516d.1794172701.git.dave@stgolabs.net>
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

A region created through sysfs inherits its coherency from the chosen
root decoder - HDM-DB if the root has CXL_DECODER_F_BI, otherwise
HDM-H. An auto-assembled region takes its type from the committed
decoder it is built from instead.

cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
model at all (neither Device Coherent nor Host-only Coherent), and one
that sets BI together with Host-only Coherent, which the CFMWS
definition calls undefined behavior. A BI Window therefore always
exposes device-coherent memory and nothing else, HDM-DB being defined
only as bit[0] and bit[5] together.

Introduce the following read-only sysfs ABI.

  - decoderX.Y/cap_back_invalidate (root) reports the CFMWS BI
    restriction.
  - decoderX.Y/back_invalidate (endpoint) reads '1' when configured
    for HDM-DB.

cxl_region_attach() rejects endpoints whose device or HDM cannot
serve the region's type; target_type is inherited from cxlr->type
in cxl_rr_assign_decoder(), restored to the endpoint default on
detach unless the decoder is still committed, and to whatever it was
on a failed attach - a refusal may come before any inheritance, for a
decoder another region owns or one firmware committed, and must not
relabel it.

An HDM that reports Unknown coherency support is not rejected.
Supported Coherency Models is how a device declares whether Target
Range Type is writable - Host-only+Device Coherent means RW, a single
model means the bit may be hardwired to it, Unknown declares neither
- so refusing Unknown would also exclude devices that support both
models without saying so.

A Type 3 decoder defaults to host-only, unless its HDM supports only
device-coherent, and inherits device-coherent when it joins an HDM-DB
region, which requires cxlds->bi. A Type 2 decoder defaults to
device-coherent and an HDM-H region refuses it outright, since the
spec reserves HDM-H for Type 3 devices. An HDM-D region is only
assembled from a committed decoder, taking that decoder's type, so no
inheritance is involved.

The HDM Decoder Control BI bit is set at commit time for a
device-coherent decoder in a region under a BI root, endpoint and
switch decoders alike. Whether the device has BI enabled (cxlds->bi)
is checked when an endpoint attaches and again for every target
before a commit programs anything, since a reset in between
invalidates it; the refusal is the same in both places.

The BI bit a decoder was committed with is read back and recorded as
CXL_DECODER_F_BI, and cleared with CXL_DECODER_F_ENABLE on reset. On
a root decoder the same flag is the window's BI restriction, as
F_LOCK already means a fixed window there and Lock On Commit below.

A committed decoder cannot inherit a region's type, so its range type
is checked instead: against the window before the region is built,
as the manual path already does through can_create_ram(), and
against the region at attach, where upstream's type mismatch refusal
stays for committed decoders. Committed means CXL_DECODER_F_ENABLE,
not an auto-assembly state: a decoder left committed by a region that
never assembled, or by a locked one, is as committed as one in an
assembled region.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  22 ++++
 drivers/cxl/acpi.c                      |  14 +++
 drivers/cxl/core/hdm.c                  |  31 ++++-
 drivers/cxl/core/port.c                 |  39 ++++++-
 drivers/cxl/core/region.c               | 146 +++++++++++++++++++++---
 drivers/cxl/cxl.h                       |  10 +-
 include/cxl/cxl.h                       |   3 +-
 7 files changed, 242 insertions(+), 23 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..d5b775bcb9bd 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -432,6 +432,28 @@ Description:
 		current cached value.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_back_invalidate
+Date:		October, 2026
+KernelVersion:	v7.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) When a CXL decoder is of devtype "cxl_decoder_root", '1'
+		indicates the fixed memory window carries the CFMWS
+		Back-Invalidate restriction, so HDM-DB memory may be mapped
+		behind it.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/back_invalidate
+Date:		October, 2026
+KernelVersion:	v7.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Shows '1' if this endpoint decoder is currently configured
+		for HDM-DB (device-managed coherency with back-invalidate).
+		The HDM-DB state is inherited from the region the decoder is
+		attached to, which is in turn set from the chosen root
+		decoder's CFMWS BI restriction (see cap_back_invalidate).
+
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
 Date:		May, 2022
 KernelVersion:	v6.0
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b7ce6b59c680..3f43c957ea58 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 		flags |= CXL_DECODER_F_PMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
 		flags |= CXL_DECODER_F_LOCK;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
+		flags |= CXL_DECODER_F_BI;
 
 	return flags;
 }
@@ -198,6 +200,18 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
 			cfmws->header.length, expected_len);
 
+	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
+	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
+		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
+		return -EINVAL;
+	}
+
+	if (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
+				     ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) {
+		dev_err(dev, "CFMWS has no coherency model\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0fe86a3e187c..31fbfae372e5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -790,9 +790,26 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
+	bool bi = cxld->target_type == CXL_DECODER_DEVMEM &&
+		  cxld->region && cxl_root_decoder_is_bi(cxld->region->cxlrd);
+
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
+
+	/*
+	 * Interleave Set Position: the endpoint's position in the
+	 * interleave set, RWL for a BI-capable device and reserved
+	 * otherwise (CXL 4.0 Table 8-123).
+	 */
+	if (bi && is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		u32p_replace_bits(ctrl, cxled->pos,
+				  CXL_HDM_DECODER0_CTRL_ISP_MASK);
+	}
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -890,6 +907,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	int id = cxld->id, rc;
+	u32 ctrl;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -933,6 +951,10 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
 
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_BI)
+		cxld->flags |= CXL_DECODER_F_BI;
+
 	return 0;
 }
 
@@ -1003,7 +1025,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
-	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxld->flags &= ~(CXL_DECODER_F_ENABLE | CXL_DECODER_F_BI);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1056,6 +1078,13 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	return 0;
 }
 
+/*
+ * HDMs that advertise support for both coherency modes
+ * (CXL_HDM_DECODER_COHERENCY_BOTH) default to host-only; the region
+ * attach path switches target_type to device-coherent if the region's
+ * root decoder has the CFMWS BI bit set. Only HDMs that strictly
+ * support device-coherent mode default to HDM-DB.
+ */
 enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5c33fcb5240f..6f12c1d21c92 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -132,6 +132,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+CXL_DECODER_FLAG_ATTR(cap_back_invalidate, CXL_DECODER_F_BI);
 
 static ssize_t target_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -243,6 +244,26 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(mode);
 
+static ssize_t back_invalidate_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
+	struct cxl_region *cxlr;
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	/*
+	 * An endpoint decoder is HDM-DB when the device has BI enabled
+	 * (cxlds->bi) and it is attached to a device-coherent (DEVMEM)
+	 * region whose root decoder advertises the CFMWS BI restriction.
+	 */
+	cxlr = cxled->cxld.region;
+	return sysfs_emit(buf, "%d\n", READ_ONCE(cxlds->bi) && cxlr &&
+			  cxled->cxld.target_type == CXL_DECODER_DEVMEM &&
+			  cxl_root_decoder_is_bi(cxlr->cxlrd));
+}
+static DEVICE_ATTR_RO(back_invalidate);
+
 static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -339,6 +360,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
+	&dev_attr_cap_back_invalidate.attr,
 	&dev_attr_target_list.attr,
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
@@ -349,16 +371,24 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 
 static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+	unsigned long flags = cxlrd->cxlsd.cxld.flags;
+	unsigned long hdm_h, hdm_db;
 
-	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
+
+	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
 
 static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+	unsigned long flags = cxlrd->cxlsd.cxld.flags;
+	unsigned long hdm_h, hdm_db;
+
+	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
 
-	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
 
 static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
@@ -412,6 +442,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_back_invalidate.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
 	SET_CXL_REGION_ATTR(region)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..9a3d36a6dd09 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -313,8 +313,25 @@ static int commit_decoder(struct cxl_decoder *cxld)
 static int cxl_region_decode_commit(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
+	bool hdm_db;
 	int i, rc = 0;
 
+	hdm_db = cxlr->type == CXL_DECODER_DEVMEM &&
+		 cxl_root_decoder_is_bi(cxlr->cxlrd);
+
+	/* a reset since attach may have invalidated cxlds->bi */
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (hdm_db && !READ_ONCE(cxlmd->cxlds->bi)) {
+			dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
+				dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev));
+			return -ENXIO;
+		}
+	}
+
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -346,6 +363,22 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 			cxled->cxld.reset(&cxled->cxld);
 			goto err;
 		}
+
+		/*
+		 * A reset after the check above wipes BI Enable, but
+		 * cxlds->bi is only refreshed from .reset_done, which may
+		 * not have run. Ask the hardware.
+		 */
+		if (hdm_db && !cxl_bi_decoder_enabled(cxled_to_port(cxled))) {
+			dev_err(&cxlr->dev,
+				"%s:%s BI disabled by reset during commit\n",
+				dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev));
+			WRITE_ONCE(cxlmd->cxlds->bi, false);
+			rc = -ENXIO;
+			i++; /* this target committed, so undo it too */
+			goto err;
+		}
 	}
 
 	return 0;
@@ -1132,16 +1165,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	}
 
 	/*
-	 * Endpoints should already match the region type, but backstop that
-	 * assumption with an assertion. Switch-decoders change mapping-type
-	 * based on what is mapped when they are assigned to a region.
+	 * Endpoint decoders inherit their type from cxlr->type; broken
+	 * pairings were already rejected by the coherency checks in
+	 * cxl_region_attach(). Switch-decoders change mapping-type based
+	 * on what is mapped when they are assigned to a region.
 	 */
-	dev_WARN_ONCE(&cxlr->dev,
-		      port == cxled_to_port(cxled) &&
-			      cxld->target_type != cxlr->type,
-		      "%s:%s mismatch decoder type %d -> %d\n",
-		      dev_name(&cxled_to_memdev(cxled)->dev),
-		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
 	cxld->target_type = cxlr->type;
 	cxl_rr->decoder = cxld;
 	return 0;
@@ -1805,6 +1833,7 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	enum cxl_decoder_type type = cxled->cxld.target_type;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
@@ -1830,6 +1859,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
+	/* undo cxl_rr_assign_decoder() type inheritance */
+	cxled->cxld.target_type = type;
 	return rc;
 }
 
@@ -2049,6 +2080,62 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+/*
+ * Verify the device and HDM are capable of the region's flavor. The
+ * endpoint decoder's target_type is then inherited from cxlr->type
+ * later in cxl_rr_assign_decoder().
+ */
+static int cxl_region_check_coherency(struct cxl_region *cxlr,
+				      struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	bool root_bi = cxl_root_decoder_is_bi(cxlr->cxlrd);
+	struct cxl_hdm *cxlhdm;
+
+	if (cxlr->type == CXL_DECODER_DEVMEM && root_bi &&
+	    !READ_ONCE(cxlds->bi)) {
+		dev_dbg(&cxlr->dev, "%s:%s BI not enabled on device\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	if (cxled->state != CXL_DECODER_STATE_AUTO &&
+	    cxlr->type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlds->type == CXL_DEVTYPE_DEVMEM) {
+		dev_dbg(&cxlr->dev, "%s:%s HDM-H requires a Type 3 device\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	cxlhdm = dev_get_drvdata(&cxled_to_port(cxled)->dev);
+	if (!cxlhdm)
+		return -ENXIO;
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
+		dev_dbg(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+	if (cxlr->type == CXL_DECODER_DEVMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
+		dev_dbg(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	/* a committed decoder cannot inherit the region's type */
+	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) &&
+	    cxled->cxld.target_type != cxlr->type) {
+		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			cxled->cxld.target_type, cxlr->type);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -2107,12 +2194,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxled->cxld.target_type != cxlr->type) {
-		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			cxled->cxld.target_type, cxlr->type);
-		return -ENXIO;
-	}
+	rc = cxl_region_check_coherency(cxlr, cxled);
+	if (rc)
+		return rc;
 
 	if (cxled_empty(cxled)) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
@@ -2327,6 +2411,12 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		.start = 0,
 		.end = -1,
 	};
+	/*
+	 * Undo cxl_rr_assign_decoder() type inheritance, unless the
+	 * decoder is still committed and its type is what it decodes.
+	 */
+	if (!(cxled->cxld.flags & CXL_DECODER_F_ENABLE))
+		cxled->cxld.target_type = cxled_default_type(cxled);
 
 	get_device(&cxlr->dev);
 	return cxlr;
@@ -2835,6 +2925,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 				   size_t len, enum cxl_partition_mode mode)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	enum cxl_decoder_type target_type;
 	struct cxl_region *cxlr;
 	int rc, id;
 
@@ -2846,7 +2937,15 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
 		return rc;
 
-	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
+	/*
+	 * The CFMWS dictates endpoint coherency: a BI-restricted Window
+	 * produces an HDM-DB region; otherwise HDM-H. HDM-D is not an
+	 * option here, type2 regions are created by their driver.
+	 */
+	target_type = cxl_root_decoder_is_bi(cxlrd) ?
+		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
+
+	cxlr = __create_region(cxlrd, mode, id, target_type);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3794,10 +3893,25 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
+	unsigned long need;
 
 	if (part < 0)
 		return ERR_PTR(-EBUSY);
 
+	/*
+	 * A committed decoder defines the region built from it, so no
+	 * attach check can find its range type wrong. Only the window's
+	 * restrictions can.
+	 */
+	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
+	       CXL_DECODER_F_TYPE2 : CXL_DECODER_F_TYPE3;
+	if (!(cxlrd->cxlsd.cxld.flags & need)) {
+		dev_dbg(&cxlrd->cxlsd.cxld.dev,
+			"%s:%s range type not permitted by the window\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return ERR_PTR(-ENXIO);
+	}
+
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id),
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 176c359bd68c..b34f25dee019 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -81,6 +81,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
 #define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
+#define   CXL_HDM_DECODER0_CTRL_ISP_MASK GENMASK(27, 24)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 /* Target list capacity, i.e. max interleave ways for a non-endpoint decoder */
@@ -309,7 +310,9 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
-#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
+#define CXL_DECODER_F_BI    BIT(7)
+#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK | \
+				  CXL_DECODER_F_BI)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -864,6 +867,11 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 {
 	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
 }
+
+static inline bool cxl_root_decoder_is_bi(struct cxl_root_decoder *cxlrd)
+{
+	return cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI;
+}
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
 /**
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 37a373eeb283..c23f7d3a0fdc 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -16,7 +16,8 @@
  *			 mailbox, or other memory-device-standard manageability
  *			 flows.
  * @CXL_DEVTYPE_CLASSMEM: Common class definition of a CXL Type-3 device with
- *			   HDM-H and class-mandatory memory device registers
+ *			   HDM-H or HDM-DB, and class-mandatory memory device
+ *			   registers
  */
 enum cxl_devtype {
 	CXL_DEVTYPE_DEVMEM,
-- 
2.39.5

