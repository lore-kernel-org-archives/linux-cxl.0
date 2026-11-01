Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569884;
	b=Vgzy77dC8uzuYzpQOE+gex+QI5m9T4eu1P7Fb2CB49LodKNp7EGvEkRTwETIlthjxpfd
	 ZpRd9ETjgyi8rOInrF4P2ASgXd/lv2hYYtHPeyU+1uHoZOR/NQ0NJwx1TflXwUk0mjrCh
	 UwTcoNeQCzuAUDNYcOaC7zshajZ0OJLroyHULa8f7QhTqrREV6IUTVT1ta8wLFe2pLGzL
	 XfQx6vuiToz3KyX4cO9CotykslgBfRfFl0I0i864X0TTqtpl0RCI2vfOSBJVbinsqnqA6
	 DhcXz9JxKflsBA7oQArKt9zR2yQQMS/Luc+mI0Sq2GVCA2UtOG8BTw4yT9ovZGmg6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569884;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Bottle-Chemical:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tZLiL00KWXTsxkVaK101/zZ8pthJaFlKqqvujMP5sLY=;
	b=IoRnV8JkNZ+u3/KCSs96a8DO9cOoJEqBXvfj73TZu49V6w60uvbdqaxFuqLTguvZDsoM
	 k7zYkYo0aH0l/x59TkM/j2OxsY9PBEwnQC89bo15/hPYkgrXecVyZ56VjXT8lUHdOXaSy
	 rpx8oeCOJuKZsJjS/r5/tX/6GBEoA/C40EEXo+xdKB7qYZ1YAjgb8s2WxFbeZi3dX7NNe
	 rfB6J6soIOCKY/eVNP9P3u6fbjzKER+ZvxOhizuvOfk39rBeP5QQ4F5BFeIaBSGoZt4e4
	 WdBV/kQalWJKpJxPU2XZInr0BQazm9+cDMLCIPiFe/CTLl/w92pGApwztwkNg/GAqFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=OHYMxbaP;
	arc=none smtp.remote-ip=23.83.218.253
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65761606A336
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 21:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65761606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=OHYMxbaP
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ECE054E25A3;
	Sun, 01 Nov 2026 21:51:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (100-99-180-32.trex-nlb.outbound.svc.cluster.local [100.99.180.32])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C5F614E2502;
	Sun, 01 Nov 2026 21:51:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Chemical: 5a49aef833f23db4_1793569876923_4127276031
X-MC-Loop-Signature: 1793569876923:1400733537
X-MC-Ingress-Time: 1793569876923
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.180.32 (trex/8.0.2);
	Sun, 01 Nov 2026 21:51:16 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4jHpSN0wv4z103v;
	Sun,  1 Nov 2026 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793569876;
	bh=tZLiL00KWXTsxkVaK101/zZ8pthJaFlKqqvujMP5sLY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=OHYMxbaPVLRRisptxJPiRN2KKO5GZD9HU4J+NEmtWxDrnbE9uv6au1W6ycflgJ2lC
	 9dLVHKUWqRPB77NgO6+hDinJlaMs9LYm5Umr5i2eCatRW/4J8ZgDy7XPLsLrF0/k4h
	 3f+XCSz4ZvFCYjUXJNbvzIDGaLlVLRt6CLTiD671nXPzn+xLp/hcVrK6qloJYm2gE6
	 Ytk3UbeJ5eG7qxazES/W9aNMLoHCW+27nHTPaJ2yyIAqNpbslhrEAZtnvR8PYAXY+D
	 MucVjEbaYi8Pg7UdsAZsFYYKJEpBaSqyGi6lM5KcQmWJH3aErUrxsTdD4LEL8OnsOj
	 Wk+AMdnFXQQxg==
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
Subject: [PATCH v10 04/10] cxl: Add HDM-DB region creation
Date: Sun,  1 Nov 2026 13:51:01 -0800
Message-Id: <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
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

A region created through sysfs inherits its coherency from the chosen
root decoder - HDM-DB if the root has CXL_DECODER_F_BI, otherwise
HDM-H. An auto-assembled region takes its type from the committed
decoder it is built from instead.

cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
model at all (neither Device Coherent nor Host-only Coherent), one that
sets BI together with Host-only Coherent, which the CFMWS definition
calls undefined behavior, and one that sets BI without Device Coherent,
since HDM-DB is defined only as bit[0] and bit[5] together. A BI Window
therefore always exposes device-coherent memory and nothing else.

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
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  22 ++++
 drivers/cxl/acpi.c                      |  20 ++++
 drivers/cxl/core/hdm.c                  |  24 ++++
 drivers/cxl/core/port.c                 |  39 ++++++-
 drivers/cxl/core/region.c               | 144 +++++++++++++++++++++---
 drivers/cxl/cxl.h                       |   7 ++
 include/cxl/cxl.h                       |   3 +-
 7 files changed, 238 insertions(+), 21 deletions(-)

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
index b7ce6b59c680..cc7c99d3066d 100644
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
@@ -198,6 +200,24 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
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
+	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
+	    !(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)) {
+		dev_err(dev, "CFMWS BI requires device-coherent\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0fe86a3e187c..c272fc6faf37 100644
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
@@ -1056,6 +1073,13 @@ static int cxl_setup_hdm_decoder_from_dvsec(
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
index 5c33fcb5240f..9d321f90c361 100644
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
+	return sysfs_emit(buf, "%d\n", cxlds->bi && cxlr &&
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
index a048bd5c06cb..28c61feef06d 100644
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
+		if (hdm_db && !cxlmd->cxlds->bi) {
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
@@ -346,6 +363,21 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
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
+			rc = -ENXIO;
+			i++; /* this target committed, so undo it too */
+			goto err;
+		}
 	}
 
 	return 0;
@@ -1132,16 +1164,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
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
@@ -1805,6 +1832,7 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	enum cxl_decoder_type type = cxled->cxld.target_type;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
@@ -1830,6 +1858,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
+	/* undo cxl_rr_assign_decoder() type inheritance */
+	cxled->cxld.target_type = type;
 	return rc;
 }
 
@@ -2049,6 +2079,61 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
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
+	if (cxlr->type == CXL_DECODER_DEVMEM && root_bi && !cxlds->bi) {
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
@@ -2107,12 +2192,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -2327,6 +2409,12 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
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
@@ -2835,6 +2923,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 				   size_t len, enum cxl_partition_mode mode)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	enum cxl_decoder_type target_type;
 	struct cxl_region *cxlr;
 	int rc, id;
 
@@ -2846,7 +2935,15 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
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
 
@@ -3794,10 +3891,25 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
index 176c359bd68c..88c38db26c51 100644
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
@@ -309,6 +310,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
+#define CXL_DECODER_F_BI    BIT(7)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
 enum cxl_decoder_type {
@@ -864,6 +866,11 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
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

