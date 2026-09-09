Received: from crab.ash.relay.mailchannels.net (crab.ash.relay.mailchannels.net [23.83.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF28330307
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973987; cv=none; b=Mx7muRO8t5uPpuP7MNIPBHc1S65VXa/VpdxirE2IogUMAk/rtXLbuvUZYZsKD5zyEb3CWcGL2lCye1yPeeK+cPzR/Ey+d+uCQBB8efda+EYMF0f/SAXJcnDr6q2yD0Vkyg4hDswu/lTXgclalGTxqiWxOfT+31/JMIiejb7KtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973987; c=relaxed/simple;
	bh=6075Clv4vM4hEGIxFwl7uN6D8YDvx+ZcY7oUGyqZzFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCY/cGDygJsw0k+D4vzKEvUxRxhthbnE3c9M04MUf3Ier4KVhpH8DQbWbckTOWvBhuUgqy0TMYeNQ6lsiaDkS/RnY+EPLvesd+Il67WL+KZldZk8XVKLNRIb8CfNi01QSkoZKOA2IJQ1+ixTJng1mSeU4JMgrM2wdCW4iOQKyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=CBOgiiQf; arc=none smtp.client-ip=23.83.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="CBOgiiQf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7CA99401EBF;
	Wed, 09 Sep 2026 17:03:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.96.117.16])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1AD664016F0;
	Wed, 09 Sep 2026 17:03:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Battle: 0d4811c4391d6065_1788973411410_4189441853
X-MC-Loop-Signature: 1788973411410:2221786286
X-MC-Ingress-Time: 1788973411410
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.117.16 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:31 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zp3Q0sz1Z;
	Wed,  9 Sep 2026 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973410;
	bh=sRGbOHb/VWXx06q/bgbhFIAgu6DjqZ7EaeeuNfpUADo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=CBOgiiQfVUA2m1DAfDe+n4Jp5aOVVwec1irEpwAwMJ8vxcDDsZJPjvWO+IFeOEEj1
	 16DNRPPKkuVbDShafmJlxgb5fiEkPsG+yyC/2fKyaA8+O7pndSFQovb7bZ8Nex4Wut
	 AE2xF2l9Bdf4Xb4diKNRdr7kZ8lRH4OF1BiDQDjQMbHEMAchMHW2VD5skBY5U0bekQ
	 WsYZVgDpueimRxv/19Ylkm3Xq3TIKxbHJcjmqxXziV2aphzU3eXNnTpNKMHq6ZtvcP
	 MKIx6ncWxAGShRSDL8wEjgM8h3xsrkJ6RmxlZxsDPKA3OBwB6bjkTmN7psMboJ4sCN
	 6Mj5SoJ5Y/8TQ==
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
Subject: [PATCH v8 04/10] cxl: Add HDM-DB region creation
Date: Wed,  9 Sep 2026 10:02:56 -0700
Message-Id: <20260909170302.1550680-5-dave@stgolabs.net>
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

A region inherits its coherency from the chosen root decoder: HDM-DB
if the root has CXL_DECODER_F_BI, otherwise HDM-H.

cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
model at all (neither Device Coherent nor Host-only Coherent), one that
sets BI together with Host-only Coherent, which the CFMWS definition
calls undefined behavior, and one that sets BI without Device Coherent,
since HDM-DB is defined only as bit[0] and bit[5] together. A BI Window
therefore always exposes device-coherent memory and nothing else.

Surface the topology through read-only sysfs:

  - decoderX.Y/cap_back_invalidate (root): CFMWS BI restriction.
  - decoderX.Y/back_invalidate (endpoint): '1' when configured for HDM-DB.

cxl_region_attach() rejects endpoints whose device or HDM cannot
serve the region's type; target_type is inherited from cxlr->type
in cxl_rr_assign_decoder(), restored to the endpoint default on
detach, and to whatever it was on a failed attach: a refusal may
come before any inheritance, for a decoder another region owns or
one firmware committed, and must not relabel it.

An HDM that reports Unknown coherency support is not rejected.
Supported Coherency Models is how a device declares whether Target
Range Type is writable - Host-only+Device Coherent means RW, a single
model means the bit may be hardwired to it, Unknown declares neither
- so refusing Unknown would also exclude devices that support both
models without saying so.

A Type 3 decoder defaults to host-only and inherits device-coherent
when it joins an HDM-DB region, which requires cxlds->bi. A Type 2
decoder defaults to device-coherent and keeps it: an HDM-D region is
only assembled from a committed decoder, taking that decoder's type,
so no inheritance is involved.

The HDM Decoder Control BI bit is set at commit time for a
device-coherent decoder in a region under a BI root, endpoint and
switch decoders alike. Whether the device has BI enabled (cxlds->bi)
is checked when an endpoint attaches and again for every target
before a commit programs anything, since a reset in between
invalidates it; the refusal is the same in both places.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 17 +++++-
 drivers/cxl/acpi.c                      | 27 +++++++++
 drivers/cxl/core/hdm.c                  | 11 ++++
 drivers/cxl/core/port.c                 | 39 +++++++++++--
 drivers/cxl/core/region.c               | 73 ++++++++++++++++++++-----
 drivers/cxl/cxl.h                       |  6 ++
 include/cxl/cxl.h                       |  3 +-
 7 files changed, 155 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..4707329dad4d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -303,6 +303,7 @@ What:		/sys/bus/cxl/devices/decoderX.Y/cap_pmem
 What:		/sys/bus/cxl/devices/decoderX.Y/cap_ram
 What:		/sys/bus/cxl/devices/decoderX.Y/cap_type2
 What:		/sys/bus/cxl/devices/decoderX.Y/cap_type3
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_back_invalidate
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
@@ -311,8 +312,9 @@ Description:
 		represents a fixed memory window identified by platform
 		firmware. A fixed window may only support a subset of memory
 		types. The 'cap_*' attributes indicate whether persistent
-		memory, volatile memory, accelerator memory, and / or expander
-		memory may be mapped behind this decoder's memory window.
+		memory, volatile memory, accelerator memory, expander memory,
+		and / or back-invalidate (HDM-DB) memory may be mapped behind
+		this decoder's memory window.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/target_type
@@ -432,6 +434,17 @@ Description:
 		current cached value.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/back_invalidate
+Date:		September, 2026
+KernelVersion:	v7.4
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
index 3b818adbd38b..2e8e31544a5f 100644
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
 
@@ -437,7 +457,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
+	/* host-only wins if firmware sets both coherency restrictions */
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	if (cxld->flags & CXL_DECODER_F_TYPE2) {
+		if (cxld->flags & CXL_DECODER_F_TYPE3)
+			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
+		else
+			cxld->target_type = CXL_DECODER_DEVMEM;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3ac16d3f873a..35bd308156af 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -705,9 +705,13 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
+	bool bi = cxld->target_type == CXL_DECODER_DEVMEM &&
+		  cxld->region && cxl_root_decoder_is_bi(cxld->region->cxlrd);
+
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -970,6 +974,13 @@ static int cxl_setup_hdm_decoder_from_dvsec(
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
index b81fd680d18a..1d26cd7c88a1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -132,6 +132,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+CXL_DECODER_FLAG_ATTR(cap_back_invalidate, CXL_DECODER_F_BI);
 
 static ssize_t target_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -234,6 +235,26 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
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
@@ -330,6 +351,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
+	&dev_attr_cap_back_invalidate.attr,
 	&dev_attr_target_list.attr,
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
@@ -340,16 +362,24 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 
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
@@ -403,6 +433,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_back_invalidate.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
 	SET_CXL_REGION_ATTR(region)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..6ccb3b387619 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -314,6 +314,20 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i, rc = 0;
 
+	/* a reset since attach may have invalidated cxlds->bi */
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (cxlr->type == CXL_DECODER_DEVMEM &&
+		    cxl_root_decoder_is_bi(cxlr->cxlrd) && !cxlmd->cxlds->bi) {
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
@@ -1131,16 +1145,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
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
@@ -1803,6 +1812,7 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	enum cxl_decoder_type type = cxled->cxld.target_type;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
@@ -1828,6 +1838,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
+	/* undo cxl_rr_assign_decoder() type inheritance */
+	cxled->cxld.target_type = type;
 	return rc;
 }
 
@@ -2056,6 +2068,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_port *ep_port, *root_port;
 	struct cxl_dport *dport;
+	struct cxl_hdm *cxlhdm;
 	int rc = -ENXIO;
 
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
@@ -2105,10 +2118,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxled->cxld.target_type != cxlr->type) {
-		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			cxled->cxld.target_type, cxlr->type);
+	/*
+	 * Verify the device and HDM are capable of the region's flavor before
+	 * proceeding. The endpoint decoder's target_type is then inherited
+	 * from cxlr->type later in cxl_rr_assign_decoder().
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM &&
+	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
+		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	cxlhdm = dev_get_drvdata(&ep_port->dev);
+	if (!cxlhdm)
+		return -ENXIO;
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
+		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
+			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+	if (cxlr->type == CXL_DECODER_DEVMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
+		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
+			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
 	}
 
@@ -2324,6 +2358,8 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		.start = 0,
 		.end = -1,
 	};
+	/* undo cxl_rr_assign_decoder() type inheritance */
+	cxled->cxld.target_type = cxled_default_type(cxled);
 
 	get_device(&cxlr->dev);
 	return cxlr;
@@ -2820,6 +2856,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 				   size_t len, enum cxl_partition_mode mode)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	enum cxl_decoder_type target_type;
 	struct cxl_region *cxlr;
 	int rc, id;
 
@@ -2831,7 +2868,15 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
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
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a990ed41edef..3a3fefaf5cfa 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -300,6 +300,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
+#define CXL_DECODER_F_BI    BIT(7)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
 enum cxl_decoder_type {
@@ -829,6 +830,11 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
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
index 718eb4353887..f9e9058a85da 100644
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

