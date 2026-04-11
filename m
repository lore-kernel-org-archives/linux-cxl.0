Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C49275AEB
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871647; cv=none; b=SmaKEhqJkPqhFGqPL17Y5VpVz/2mZlAou030htUpNS5qgkhcAoLeTx8Cte/mgUZMUT/Ha5t2+OOZ58oF1R8kyEiVVJKjyK4cDG6cVtweV1Xyn4JHOCLwD0As0oYSrG9vqzFM00JqdqYZ1dPm5eIryJW8WyfEL1alcnbapTknHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871647; c=relaxed/simple;
	bh=CxMDC2QvU0ICW9jOYwSMTC8Gl/2gAdrmfTTrFw7QP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqoRqAtTljUcbWe1AyaSmgp4gPoo1MyCBLgUhy8xkpqHNw6KSwiI7QcAEew8qMI1yJmzdFXeT0IYiimnxKNQ2jGxWDrviJ09CeAr+OHVjC1KdmrYJAOkvzQZ49Kbtr3tzEiKWM25Vs6ZXIVOzzxX/exxFGLpjNbTKVEDhQroyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWev1QWE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWev1QWE"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-794719afcd4so28273787b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871643; x=1776476443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btME/s9Qalj9+othUJAapKB7VXopvnMCL6eq9ptjhTw=;
        b=RWev1QWEbx6dXxFfTT9tsjxd3Rhqy5/cZHja1A7fprIrpeDlcTXSvXh36/ZVFMnBqa
         d7Y1bvWW0+E7YR3dTWEOZ9UzxKqHEpYgmGm2Kc8+YB/AsGljQDSK3TmrVMGBGlTmZ/gO
         psGsIGCFCRgiOCT50C3H8t9VPXywpnr7sIk67xoco/xNeTQ8TwTC9Ud3juhaFAduswsU
         2qSx9grdC7H1PqReGEdLqG+x/ZhCPKcbM3+pBBRJhV73sg6om+9X71k3G6BaS6m6ILrs
         zaUrvWMYaDCcgJIk2d1ksRYV7utGpUqKP4UHnkF+QCb5dI3W+K9oycTzrcaGyv8NQjvR
         SxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871643; x=1776476443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=btME/s9Qalj9+othUJAapKB7VXopvnMCL6eq9ptjhTw=;
        b=GRj1OhE5tci6tgmdBnEotOwgnfVcVq2LDhqbRev7Td54ZzVzmKCgpvz93mn7btqJTl
         6zgBpy3rUszvU9kZF1ObzvpIijKIQLNk4EqVE38U0eKYkFP4JgEMpmlOIs0UoNXAAspP
         RgbEq984roksfrtg194Z/B7MFwz2e3Bo23cZpJ2JzD6dRvjqbRKqnu5+BMDa8rh8diwx
         TFW9DHwlACtBgGqi83tZAGfed0BeEouqv8OZrZRwQzuZrYuB5TF/keLvsyAd6GKRNwZO
         u87w4a1uvRTEp0mKBp/d7V4fKjuoq6MFvyXVkiFWePJr/K/jwQwV3ON4I4k55YhpmGYj
         rYIA==
X-Gm-Message-State: AOJu0YzAY+Ds2YNeJ6Vd/eqWtlw9ew9QGorsdv56qMojMs/J3jcF8jQF
	2btgG3j5+KahZf2ycud4GbL9sr3JsNK3GgMCyz398U5KFlx8axa3Zl5RjzUr+A==
X-Gm-Gg: AeBDieviedN62a9dxxTsDKSH1Ad4e7lPApqwvTvboJd5PE+twTRZwtTmsjMHVsYlUi9
	igyyfzQ39ih2WuMCbAj/lDf0+BYK7R+WV8qIAOSQmXWtEBCfoE9Rpffsw2wAnnB6EOMiOUf7kxj
	u3ZjN4Iif4MzZW3LBTipUkO/JAMAEIXcnlsCDbWZ/uchWyDCdFw8wum95YjM7JMuJdbYLbgAbLB
	dSEH74T6srXa8J8jvL2Lm962AGbX//Ue0sZTJnvorFpw/qZQyznz3JKWB2IpKBSghQrCCh9bz6I
	PSD62eX8n5BzcVoYDTIT9/ZRCB8Nf2MbAvmNHgtAe//IiNNj4J6Zco8PiF7Mo9K7bD9xx6d2qSN
	JAS5OIuMQvwozusdFVQJWydf2DhwDIplLsZsWc5m4P8NNKfNRpcV+3lDtaxdjqrjZeMKKTtij6V
	mAEGzVQfoCH1fkJ7LvijpZXgVECDQsmDuDak8uuljydg==
X-Received: by 2002:a05:690c:c513:b0:79f:1b26:cc17 with SMTP id 00721157ae682-7af6bd4956dmr65008997b3.0.1775871643309;
        Fri, 10 Apr 2026 18:40:43 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:43 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 12/20] cxl/extent: Process dynamic partition events and realize region extents
Date: Fri, 10 Apr 2026 18:23:07 -0700
Message-ID: <20260411013958.47422-13-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

A dynamic capacity device (DCD) sends events to signal the host for
changes in the availability of Dynamic Capacity (DC) memory.  These
events contain extents describing a DPA range and meta data for memory
to be added or removed.  Events may be sent from the device at any time.

Three types of events can be signaled, Add, Release, and Force Release.

On add, the host may accept or reject the memory being offered. If no
region exists or the extent DPA range is invalid, the extent is
rejected. Additionally, the implementation choice to reject extents
without a tag or form a non-contiguous range has been made (not stated
in the spec).

Add extent events may be grouped by a 'more' bit which indicates those extents
should be processed as a group. Use the first extent with a valid DPA
range, region, and non-null tag to check subsequent extents against for
contiguity and that it has the same tag.

On remove, the host can delay the response until the host is safely not
using the memory. If no region exists the release can be sent
immediately. The host may also release extents at any time. Thus the 'more' bit
grouping of release events is of less value and can be ignored in favor of
sending multiple release capacity responses for groups of release events. Upon
receiving a release event containing any extent falling under a region
with a tag matching the region's tag, release all extents under the
region.

Force removal is intended as a mechanism between the FM and the device
and intended only when the host is unresponsive, out of sync, or
otherwise broken.  Purposely ignore force removal events.

Regions are made up of one or more devices which may be surfacing memory
to the host. Once all devices in a region have surfaced an extent the
region can expose a corresponding extent for the user to consume.
A region extent is comprised of 1 or more contiguous device extents with
the same tag. It is surfaced after all extents from the DC event ar
 processed (events grouped together with the "More" flag).
Interleaving is unsupported.

Per the specification the device is allowed to offer or remove extents
at any time.  However, anticipated use cases can expect extents to be
offered, accepted, and removed in well defined chunks.

Simplify extent tracking with the following restrictions.

	1) Flag for removal any extent which overlaps a requested
	   release range.
	2) Refuse the offer of extents which overlap already accepted
	   memory ranges.
	3) Accept again a range which has already been accepted by the
	   host.  Eating duplicates serves three purposes.
	   3a) This simplifies the code if the device should get out of
	       sync with the host.  And it should be safe to acknowledge
	       the extent again.
	   3b) This simplifies the code to process existing extents if
	       the extent list should change while the extent list is
	       being read.
	   3c) Duplicates for a given partition which are seen during a
	       race between the hardware surfacing an extent and the cxl
	       dax driver scanning for existing extents will be ignored.

	   NOTE: Processing existing extents is done in a later patch.

Management of the region extent devices must be synchronized with
potential uses of the memory within the DAX layer.  Create region extent
devices as children of the cxl_dax_region device such that the DAX
region driver can co-drive them and synchronize with the DAX layer.
Synchronization and management is handled in a subsequent patch.

Process DCD events and create region devices.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
Changes:
[anisa] replace mds->pending_extents xarray with list

Spec requires the DC add response to send extents back in the same order
they were received in DC add event record. Extents are sorted by dpa
order to check for contiguity, then re-sorted by original index to send
DC rsp.

[anisa] replace cxl_dax_region->extent_ida with pointer to single region_extent

Each region is now associated with 1 tagged capacity. Make
cxl_dax_region:region_extent 1:1 instead of 1:many.

[anisa] enforce contiguous tagged add
Collect extents in pending_list and sort by dpa to enforce they are
contiguous. Drop non-contiguous extents.

Build 1 region_extent incrementally while iterating over
pending_extents. Uses the first valid extent (valid DPA, non-null tag, etc.)
to check all other extents against. Then all following extents must have the
same tag in order to be added to the region_extent.

"Commit" the region by onlining the region extent (sets
cxlr_dax->region_extent = region_ext). Once set, we disallow
adding additional extents to the region. It can only be added to after
being cleared with a release event, when we remove the entire tagged capacity
and set cxlr_dax->region_extent back to NULL.

[anisa] enforce tagged release

Upon receiving any DC release event, check that the extent is within the
bounds of a cxl_dax_region and its tag matches the region's tag.

Then release the entire capacity of the region by removing the
cxlr_dax->region_extent.

Deletes the functions allowing us to delete individual decoder_extents
and recalc the region_extent hpa range, as partial release is no longer
supported
---
 drivers/cxl/core/Makefile     |   2 +-
 drivers/cxl/core/core.h       |  18 +-
 drivers/cxl/core/extent.c     | 368 +++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c       | 401 +++++++++++++++++++++++++++++++++-
 drivers/cxl/core/region_dax.c |   6 +
 drivers/cxl/cxl.h             |  55 ++++-
 drivers/cxl/cxlmem.h          |  30 +++
 include/cxl/event.h           |  39 ++++
 tools/testing/cxl/Kbuild      |   5 +-
 9 files changed, 919 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cxl/core/extent.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..208917ad8aac 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,7 +15,7 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
-cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o
+cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o extent.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 14723cfd05f0..14d91dd52b02 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -64,13 +64,28 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
-
+int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
+int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
+int online_region_extent(struct region_extent *region_extent);
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
 {
 	return ULLONG_MAX;
 }
+static inline int cxl_add_extent(struct cxl_memdev_state *mds,
+				   struct cxl_extent *extent) {
+	return 0;
+}
+static inline int cxl_rm_extent(struct cxl_memdev_state *mds,
+				struct cxl_extent *extent)
+{
+	return 0;
+}
+static inline int online_region_extent(struct region_extent *region_extent)
+{
+	return 0;
+}
 static inline
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
 				     struct cxl_endpoint_decoder **cxled)
@@ -166,6 +181,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
new file mode 100644
index 000000000000..ecdd7717f7d7
--- /dev/null
+++ b/drivers/cxl/core/extent.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#include <linux/device.h>
+#include <cxl.h>
+
+#include "core.h"
+
+static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
+				 struct cxled_extent *ed_extent)
+{
+	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
+	struct device *dev = &cxled->cxld.dev;
+
+	dev_dbg(dev, "Remove extent %pra (%pU)\n",
+		&ed_extent->dpa_range, &ed_extent->uuid);
+	memdev_release_extent(mds, &ed_extent->dpa_range);
+	kfree(ed_extent);
+}
+
+static void free_region_extent(struct region_extent *region_extent)
+{
+	struct cxled_extent *ed_extent;
+	unsigned long index;
+
+	/*
+	 * Remove from each endpoint decoder the extent which backs this region
+	 * extent
+	 */
+	xa_for_each(&region_extent->decoder_extents, index, ed_extent)
+		cxled_release_extent(ed_extent->cxled, ed_extent);
+	xa_destroy(&region_extent->decoder_extents);
+	region_extent->cxlr_dax->region_extent = NULL;
+	kfree(region_extent);
+}
+
+static void region_extent_release(struct device *dev)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	free_region_extent(region_extent);
+}
+
+static const struct device_type region_extent_type = {
+	.name = "extent",
+	.release = region_extent_release,
+};
+
+bool is_region_extent(struct device *dev)
+{
+	return dev->type == &region_extent_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_region_extent, "CXL");
+
+static void region_extent_unregister(void *ext)
+{
+	struct region_extent *region_extent = ext;
+
+	dev_dbg(&region_extent->dev, "DAX region rm extent HPA %pra\n",
+		&region_extent->hpa_range);
+	device_unregister(&region_extent->dev);
+}
+
+static void region_rm_extent(struct region_extent *region_extent)
+{
+	struct device *region_dev = region_extent->dev.parent;
+
+	devm_release_action(region_dev, region_extent_unregister, region_extent);
+}
+
+static struct region_extent *
+alloc_region_extent(struct cxl_dax_region *cxlr_dax, struct range *hpa_range,
+		    uuid_t *uuid)
+{
+	struct region_extent *region_extent __free(kfree) =
+				kzalloc(sizeof(*region_extent), GFP_KERNEL);
+	if (!region_extent)
+		return ERR_PTR(-ENOMEM);
+
+	region_extent->hpa_range = *hpa_range;
+	region_extent->cxlr_dax = cxlr_dax;
+	uuid_copy(&region_extent->uuid, uuid);
+	region_extent->dev.id = 0;
+	xa_init(&region_extent->decoder_extents);
+	return no_free_ptr(region_extent);
+}
+
+int online_region_extent(struct region_extent *region_extent)
+{
+	struct cxl_dax_region *cxlr_dax = region_extent->cxlr_dax;
+	struct device *dev = &region_extent->dev;
+	int rc;
+
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr_dax->dev;
+	dev->type = &region_extent_type;
+	rc = dev_set_name(dev, "extent%d.%d", cxlr_dax->cxlr->id, dev->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	cxlr_dax->region_extent = region_extent;
+	dev_dbg(dev, "region extent HPA %pra\n", &region_extent->hpa_range);
+	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,
+					region_extent);
+
+err:
+	dev_err(&cxlr_dax->dev, "Failed to initialize region extent HPA %pra\n",
+		&region_extent->hpa_range);
+
+	put_device(dev);
+	return rc;
+}
+
+static bool extents_contain(struct cxl_dax_region *cxlr_dax,
+			    struct cxl_endpoint_decoder *cxled,
+			    struct range *new_range)
+{
+	struct region_extent *re = cxlr_dax->region_extent;
+	struct cxled_extent *entry;
+	unsigned long index;
+
+	if (!re)
+		return false;
+
+	xa_for_each(&re->decoder_extents, index, entry) {
+		if (cxled == entry->cxled &&
+		    range_contains(&entry->dpa_range, new_range))
+			return true;
+	}
+	return false;
+}
+
+static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
+			    struct cxl_endpoint_decoder *cxled,
+			    struct range *new_range)
+{
+	struct region_extent *re = cxlr_dax->region_extent;
+	struct cxled_extent *entry;
+	unsigned long index;
+
+	if (!re)
+		return false;
+
+	xa_for_each(&re->decoder_extents, index, entry) {
+		if (cxled == entry->cxled &&
+		    range_overlaps(&entry->dpa_range, new_range))
+			return true;
+	}
+	return false;
+}
+
+static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
+			   struct cxl_dax_region *cxlr_dax,
+			   struct range *dpa_range,
+			   struct range *hpa_range)
+{
+	resource_size_t dpa_offset, hpa;
+
+	dpa_offset = dpa_range->start - cxled->dpa_res->start;
+	hpa = cxled->cxld.hpa_range.start + dpa_offset;
+
+	hpa_range->start = hpa - cxlr_dax->hpa_range.start;
+	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
+}
+
+int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
+{
+	u64 start_dpa = le64_to_cpu(extent->start_dpa);
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_endpoint_decoder *cxled;
+	struct range dpa_range, hpa_range;
+	struct cxl_dax_region *cxlr_dax;
+	struct region_extent *reg_ext;
+	struct cxl_region *cxlr;
+	uuid_t tag;
+
+	dpa_range = (struct range) {
+		.start = start_dpa,
+		.end = start_dpa + le64_to_cpu(extent->length) - 1,
+	};
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
+	if (!cxlr) {
+		/*
+		 * No region can happen here for a few reasons:
+		 *
+		 * 1) Extents were accepted and the host crashed/rebooted
+		 *    leaving them in an accepted state.  On reboot the host
+		 *    has not yet created a region to own them.
+		 *
+		 * 2) Region destruction won the race with the device releasing
+		 *    all the extents.  Here the release will be a duplicate of
+		 *    the one sent via region destruction.
+		 *
+		 * 3) The device is confused and releasing extents for which no
+		 *    region ever existed.
+		 *
+		 * In all these cases make sure the device knows we are not
+		 * using this extent.
+		 */
+		memdev_release_extent(mds, &dpa_range);
+		return -ENXIO;
+	}
+
+	cxlr_dax = cxlr->cxlr_dax;
+	reg_ext = cxlr_dax->region_extent;
+	if (!reg_ext) {
+		dev_err(&cxlr->cxlr_dax->dev,
+			"no capacity has been added to the region\n");
+		return -ENXIO;
+	}
+
+	import_uuid(&tag, extent->uuid);
+	if (!uuid_equal(&tag, &reg_ext->uuid)) {
+		dev_err(&cxlr->cxlr_dax->dev,
+			"extent tag %pU doesn't match region tag %pU\n",
+			&tag, &reg_ext->uuid);
+		return -EINVAL;
+	}
+
+	calc_hpa_range(cxled, cxlr_dax, &dpa_range, &hpa_range);
+	if (!range_contains(&reg_ext->hpa_range, &hpa_range)) {
+		dev_err(&cxlr_dax->dev,
+			"extent HPA %pra exceeds region HPA %pra\n",
+			&hpa_range, &reg_ext->hpa_range);
+		return -EINVAL;
+	}
+
+	/* Release entire capacity of the region */
+	region_rm_extent(reg_ext);
+	return 0;
+}
+
+static int cxlr_add_extent(struct cxl_memdev_state *mds,
+			   struct cxl_dax_region *cxlr_dax,
+			   struct cxl_endpoint_decoder *cxled,
+			   struct cxled_extent *ed_extent)
+ {
+	struct region_extent **reg_ext;
+ 	struct range hpa_range;
+ 	int rc;
+
+ 	calc_hpa_range(cxled, cxlr_dax, &ed_extent->dpa_range, &hpa_range);
+
+	reg_ext = &mds->add_ctx.region_extent;
+	if (*reg_ext) {
+ 		/* Add decoder extent to existing region extent */
+		dev_dbg(&cxlr_dax->dev,
+			"Append decoder extent to region extent\n");
+		rc = xa_insert(&(*reg_ext)->decoder_extents,
+ 			       ed_extent->dpa_range.start, ed_extent,
+ 			       GFP_KERNEL);
+ 		if (rc) {
+ 			kfree(ed_extent);
+ 			return rc;
+ 		}
+		(*reg_ext)->hpa_range.start = min((*reg_ext)->hpa_range.start,
+ 						     hpa_range.start);
+		(*reg_ext)->hpa_range.end = max((*reg_ext)->hpa_range.end,
+ 						   hpa_range.end);
+ 		return 0;
+ 	}
+
+ 	/* First decoder extent - create new region extent */
+	dev_dbg(&cxlr_dax->dev, "Alloc new region_extent\n");
+	mds->add_ctx.region_extent = alloc_region_extent(cxlr_dax,
+							 &hpa_range,
+							 &ed_extent->uuid);
+	if (IS_ERR(*reg_ext)) {
+ 		kfree(ed_extent);
+		return PTR_ERR(*reg_ext);
+ 	}
+
+	rc = xa_insert(&(*reg_ext)->decoder_extents,
+ 		       ed_extent->dpa_range.start, ed_extent, GFP_KERNEL);
+ 	if (rc) {
+		free_region_extent(*reg_ext);
+ 		kfree(ed_extent);
+ 		return rc;
+ 	}
+
+ 	return 0;
+ }
+
+/* Callers are expected to ensure cxled has been attached to a region */
+int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
+{
+	u64 start_dpa = le64_to_cpu(extent->start_dpa);
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct region_extent *pending_region_ext = mds->add_ctx.region_extent;
+	struct cxl_endpoint_decoder *cxled;
+	struct range ed_range, ext_range;
+	struct cxl_dax_region *cxlr_dax;
+	struct cxled_extent *ed_extent;
+	struct cxl_region *cxlr;
+	struct device *dev;
+
+	ext_range = (struct range) {
+		.start = start_dpa,
+		.end = start_dpa + le64_to_cpu(extent->length) - 1,
+	};
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
+	if (!cxlr)
+		return -ENXIO;
+
+	cxlr_dax = cxlr->cxlr_dax;
+	/* Cannot add to a region_extent once it's been onlined */
+	if (cxlr_dax->region_extent) {
+		dev_err(&cxlr_dax->dev, "Can no longer add to region %d\n",
+			cxlr->id);
+		return -EINVAL;
+	}
+
+	if (pending_region_ext &&
+	    !uuid_equal((uuid_t *)extent->uuid, &pending_region_ext->uuid)) {
+		return -EINVAL;
+	}
+
+	dev = &cxled->cxld.dev;
+	ed_range = (struct range) {
+		.start = cxled->dpa_res->start,
+		.end = cxled->dpa_res->end,
+	};
+
+	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent %pra\n",
+		cxled->dpa_res, &ext_range);
+
+	if (!range_contains(&ed_range, &ext_range)) {
+		dev_err_ratelimited(dev,
+				    "DC extent DPA %pra (%pU) is not fully in ED %pra\n",
+				    &ext_range, extent->uuid, &ed_range);
+		return -ENXIO;
+	}
+
+	/*
+	 * Allowing duplicates or extents which are already in an accepted
+	 * range simplifies extent processing, especially when dealing with the
+	 * cxl dax driver scanning for existing extents.
+	 */
+	if (extents_contain(cxlr_dax, cxled, &ext_range)) {
+		dev_warn_ratelimited(dev, "Extent %pra exists; accept again\n",
+				     &ext_range);
+		return 0;
+	}
+
+	if (extents_overlap(cxlr_dax, cxled, &ext_range))
+		return -ENXIO;
+
+	ed_extent = kzalloc(sizeof(*ed_extent), GFP_KERNEL);
+	if (!ed_extent)
+		return -ENOMEM;
+
+	ed_extent->cxled = cxled;
+	ed_extent->dpa_range = ext_range;
+	import_uuid(&ed_extent->uuid, extent->uuid);
+
+	dev_dbg(dev, "Add extent %pra (%pU)\n", &ed_extent->dpa_range, &ed_extent->uuid);
+
+	return cxlr_add_extent(mds, cxlr_dax, cxled, ed_extent);
+}
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 01b1a318f34f..56d8b2a9974c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,8 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/unaligned.h>
+#include <linux/list.h>
+#include <linux/list_sort.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -936,6 +938,74 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 
+static int cxl_validate_extent_partition(struct cxl_memdev_state *mds,
+						struct cxl_extent *extent,
+						struct range *ext_range)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = mds->cxlds.dev;
+
+	/* Extents must be within the DC partition boundary */
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		struct cxl_dpa_partition *part = &cxlds->part[i];
+		struct range partition_range = {
+			.start = part->res.start,
+			.end = part->res.end,
+		};
+
+		if (part->mode != CXL_PARTMODE_DYNAMIC_RAM_A)
+			continue;
+
+		if (range_contains(&partition_range, ext_range)) {
+			dev_dbg(dev, "DC extent DPA %pra (DCR:%pra)(%pU)\n",
+				&ext_range, &partition_range, extent->uuid);
+			return 0;
+		}
+	}
+
+	dev_err_ratelimited(dev,
+			    "DC extent DPA %pra (%pU) is not in a valid DC partition\n",
+			    &ext_range, extent->uuid);
+	return -ENXIO;
+}
+
+/*
+ * Check extent tag is non-null, tag is not already in use, extent belongs to a
+ * region, and the extent is within the bounds of a DC partition.
+ * If extent is not first in the pending_list, check tag and region match the
+ * previous entry's.
+ *
+ */
+static int cxl_validate_extent(struct cxl_memdev_state *mds,
+			       struct cxl_extent_list_node *pos)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_extent *extent = pos->extent;
+	struct range ext_range = (struct range) {
+		.start = le64_to_cpu(extent->start_dpa),
+		.end = le64_to_cpu(extent->start_dpa) +
+			le64_to_cpu(extent->length) - 1,
+	};
+	uuid_t *uuid = (uuid_t *)extent->uuid;
+
+	if (uuid_is_null(uuid)) {
+		dev_dbg(dev, "no tag for extent: %pra\n", &ext_range);
+		return -EINVAL;
+	}
+
+	if (le16_to_cpu(extent->shared_extn_seq) != 0) {
+		dev_dbg(dev,
+			"DC extent DPA %pra (%pU) can not be shared\n",
+			&ext_range, uuid);
+		return -ENXIO;
+	}
+
+	if (cxl_validate_extent_partition(mds, extent, &ext_range))
+		return -ENXIO;
+
+	return 0;
+}
+
 void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
@@ -1102,6 +1172,324 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	return rc;
 }
 
+static int send_one_response(struct cxl_mailbox *cxl_mbox,
+			     struct cxl_mbox_dc_response *response,
+			     int opcode, u32 extent_list_size, u8 flags)
+{
+	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = opcode,
+		.size_in = struct_size(response, extent_list, extent_list_size),
+		.payload_in = response,
+	};
+
+	response->extent_list_size = cpu_to_le32(extent_list_size);
+	response->flags = flags;
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+}
+
+static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
+				struct list_head *extent_list, int cnt)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_dc_response *p;
+	struct cxl_extent_list_node *pos, *tmp;
+	struct cxl_extent *extent;
+	u32 pl_index;
+
+	size_t pl_size = struct_size(p, extent_list, cnt);
+	u32 max_extents = cnt;
+
+	/* May have to use more bit on response. */
+	if (pl_size > cxl_mbox->payload_size) {
+		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
+			      sizeof(struct updated_extent_list);
+		pl_size = struct_size(p, extent_list, max_extents);
+	}
+
+	struct cxl_mbox_dc_response *response __free(kfree) =
+						kzalloc(pl_size, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	if (cnt == 0)
+		return send_one_response(cxl_mbox, response, opcode, 0, 0);
+
+	pl_index = 0;
+	list_for_each_entry_safe(pos, tmp, extent_list, list) {
+		extent = pos->extent;
+		response->extent_list[pl_index].dpa_start = extent->start_dpa;
+		response->extent_list[pl_index].length = extent->length;
+		pl_index++;
+
+		if (pl_index == max_extents) {
+			u8 flags = 0;
+			int rc;
+
+			if (pl_index < cnt)
+				flags |= CXL_DCD_EVENT_MORE;
+			rc = send_one_response(cxl_mbox, response, opcode,
+					       pl_index, flags);
+			if (rc)
+				return rc;
+			cnt -= pl_index;
+			if (cnt < max_extents)
+				max_extents = cnt;
+			pl_index = 0;
+		}
+	}
+
+	if (!pl_index) /* nothing more to do */
+		return 0;
+	return send_one_response(cxl_mbox, response, opcode, pl_index, 0);
+}
+
+static void delete_extent_node(struct cxl_extent_list_node *node)
+{
+	list_del(&node->list);
+	kfree(node->extent);
+	kfree(node);
+}
+
+void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_extent_list_node *node;
+	LIST_HEAD(extent_list);
+
+	dev_dbg(dev, "Release response dpa %pra\n", range);
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return;
+
+	node->extent = kzalloc(sizeof(*node->extent), GFP_KERNEL);
+	if (!node->extent) {
+		kfree(node);
+		return;
+	}
+
+	node->extent->start_dpa = cpu_to_le64(range->start);
+	node->extent->length = cpu_to_le64(range_len(range));
+	list_add_tail(&node->list, &extent_list);
+
+	if (cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC, &extent_list, 1))
+		dev_dbg(dev, "Failed to release %pra\n", range);
+
+	delete_extent_node(node);
+}
+
+static void clear_pending_extents(void *_mds)
+{
+	struct cxl_memdev_state *mds = _mds;
+	struct cxl_extent_list_node *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &mds->add_ctx.pending_extents, list) {
+                delete_extent_node(pos);
+        }
+	mds->add_ctx.region_extent = NULL;
+}
+
+static int dpa_compare(void *priv,
+		       const struct list_head *a,
+		       const struct list_head *b)
+{
+	const struct cxl_extent_list_node *ea =
+		list_entry(a, struct cxl_extent_list_node, list);
+	const struct cxl_extent_list_node *eb =
+		list_entry(b, struct cxl_extent_list_node, list);
+
+	if (ea->extent->start_dpa < eb->extent->start_dpa)
+		return -1;
+	if (ea->extent->start_dpa > eb->extent->start_dpa)
+		return 1;
+
+	return 0;
+}
+
+static int idx_compare(void *priv,
+		       const struct list_head *a,
+		       const struct list_head *b)
+{
+	const struct cxl_extent_list_node *ea =
+		list_entry(a, struct cxl_extent_list_node, list);
+	const struct cxl_extent_list_node *eb =
+		list_entry(b, struct cxl_extent_list_node, list);
+
+	if (ea->idx < eb->idx)
+		return -1;
+	if (ea->idx > eb->idx)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Validate and add contiguous extents. Removes invalid, non-contiguous, or
+ * mismatched extents from pending_list. Sorts by DPA for processing, then
+ * restores original order for response.
+ */
+static int cxl_add_pending(struct cxl_memdev_state *mds)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_extent_list_node *pos, *tmp;
+	struct region_extent *pending_reg_ext;
+	struct cxl_extent *extent;
+	u64 prev_end, start, len;
+	int cnt = 0, rc;
+
+	list_sort(NULL, &mds->add_ctx.pending_extents, dpa_compare);
+	list_for_each_entry_safe(pos, tmp, &mds->add_ctx.pending_extents, list) {
+		extent = pos->extent;
+		start = le64_to_cpu(extent->start_dpa);
+		len = le64_to_cpu(extent->length);
+
+		/* Start enforcing contiguity after accepting first extent */
+		if (cnt && start != prev_end) {
+			dev_dbg(dev,
+				"Non-contiguous extent DPA:%#llx LEN:%#llx\n",
+				start, len);
+			delete_extent_node(pos);
+			continue;
+		}
+
+		if (cxl_validate_extent(mds, pos)) {
+			delete_extent_node(pos);
+			continue;
+		}
+
+		if (cxl_add_extent(mds, extent)) {
+			dev_dbg(dev,
+				"Failed to add extent DPA:%#llx LEN:%#llx\n",
+				start, len);
+			delete_extent_node(pos);
+			continue;
+		}
+
+		prev_end = start + len;
+		cnt++;
+	}
+
+	if (!mds->add_ctx.region_extent) {
+		dev_dbg(dev, "No valid extents in list; accept none\n");
+		return 0;
+	}
+
+	pending_reg_ext = mds->add_ctx.region_extent;
+
+	/* device model handles freeing region_extent */
+	rc = online_region_extent(mds->add_ctx.region_extent);
+	if (rc)
+		return rc;
+
+	/* Restore remaining extents to original order and send rsp */
+	list_sort(NULL, &mds->add_ctx.pending_extents, idx_compare);
+	return cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
+				    &mds->add_ctx.pending_extents, cnt);
+}
+
+static int add_to_pending_list(struct list_head *pending_list,
+			       struct cxl_extent *to_add)
+{
+	struct cxl_extent_list_node *node, *prev;
+	struct cxl_extent *extent;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+	extent = kmemdup(to_add, sizeof(*extent), GFP_KERNEL);
+	if (!extent)
+		return -ENOMEM;
+
+	node->extent = extent;
+	list_add_tail(&node->list, pending_list);
+
+	/*
+	 * List is sorted by DPA when adding. Save original index to restore
+	 * order when sending DC rsp, as required by the spec.
+	 */
+	if (list_is_first(&node->list, pending_list)) {
+		node->idx = 0;
+	} else {
+		prev = list_prev_entry(node, list);
+		node->idx = prev->idx + 1;
+	}
+
+	return 0;
+}
+
+static int handle_add_event(struct cxl_memdev_state *mds,
+			    struct cxl_event_dcd *event)
+{
+	struct device *dev = mds->cxlds.dev;
+	int rc;
+
+	rc = add_to_pending_list(&mds->add_ctx.pending_extents, &event->extent);
+	if (rc) {
+		return rc;
+	}
+
+	if (event->flags & CXL_DCD_EVENT_MORE) {
+		dev_dbg(dev, "more bit set; delay the surfacing of extent\n");
+		return 0;
+	}
+
+	rc = cxl_add_pending(mds);
+	clear_pending_extents(mds);
+	return rc;
+}
+
+static char *cxl_dcd_evt_type_str(u8 type)
+{
+	switch (type) {
+	case DCD_ADD_CAPACITY:
+		return "add";
+	case DCD_RELEASE_CAPACITY:
+		return "release";
+	case DCD_FORCED_CAPACITY_RELEASE:
+		return "force release";
+	default:
+		break;
+	}
+
+	return "<unknown>";
+}
+
+static void cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
+					struct cxl_event_record_raw *raw_rec)
+{
+	struct cxl_event_dcd *event = &raw_rec->event.dcd;
+	struct cxl_extent *extent = &event->extent;
+	struct device *dev = mds->cxlds.dev;
+	uuid_t *id = &raw_rec->id;
+	int rc;
+
+	if (!uuid_equal(id, &CXL_EVENT_DC_EVENT_UUID))
+		return;
+
+	dev_dbg(dev, "DCD event %s : DPA:%#llx LEN:%#llx\n",
+		cxl_dcd_evt_type_str(event->event_type),
+		le64_to_cpu(extent->start_dpa), le64_to_cpu(extent->length));
+
+	switch (event->event_type) {
+	case DCD_ADD_CAPACITY:
+		rc = handle_add_event(mds, event);
+		break;
+	case DCD_RELEASE_CAPACITY:
+		rc = cxl_rm_extent(mds, &event->extent);
+		break;
+	case DCD_FORCED_CAPACITY_RELEASE:
+		dev_err_ratelimited(dev, "Forced release event ignored.\n");
+		rc = 0;
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	if (rc)
+		dev_err_ratelimited(dev, "dcd event failed: %d\n", rc);
+}
+
 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				    enum cxl_event_log_type type)
 {
@@ -1138,9 +1526,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		if (!nr_rec)
 			break;
 
-		for (i = 0; i < nr_rec; i++)
+		for (i = 0; i < nr_rec; i++) {
 			__cxl_event_trace_record(cxlmd, type,
 						 &payload->records[i]);
+			if (type == CXL_EVENT_TYPE_DCD)
+				cxl_handle_dcd_event_records(mds,
+							&payload->records[i]);
+		}
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
@@ -1172,6 +1564,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
 {
 	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
 
+	if (cxl_dcd_supported(mds) && (status & CXLDEV_EVENT_STATUS_DCD))
+		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
 	if (status & CXLDEV_EVENT_STATUS_FATAL)
 		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
 	if (status & CXLDEV_EVENT_STATUS_FAIL)
@@ -1769,6 +2163,11 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 	}
 
 	mutex_init(&mds->event.log_lock);
+	INIT_LIST_HEAD(&mds->add_ctx.pending_extents);
+
+	rc = devm_add_action_or_reset(dev, clear_pending_extents, mds);
+	if (rc)
+		return ERR_PTR(rc);
 
 	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
 	if (rc == -EOPNOTSUPP)
diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
index 068690d02c8c..b2853494aee2 100644
--- a/drivers/cxl/core/region_dax.c
+++ b/drivers/cxl/core/region_dax.c
@@ -90,6 +90,12 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	if (IS_ERR(cxlr_dax))
 		return PTR_ERR(cxlr_dax);
 
+	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
+	    cxlr->params.interleave_ways != 1) {
+		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
+		return -EINVAL;
+	}
+
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..477e91bc2ab7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -13,6 +13,10 @@
 #include <linux/io.h>
 #include <linux/range.h>
 #include <cxl/cxl.h>
+#include <linux/xarray.h>
+
+/* FIXME needed? */
+#include <cxl/event.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -180,11 +184,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
+#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
 
 #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
 				 CXLDEV_EVENT_STATUS_WARN |	\
 				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+				 CXLDEV_EVENT_STATUS_FATAL |	\
+				 CXLDEV_EVENT_STATUS_DCD)
 
 /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
 #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
@@ -306,6 +312,18 @@ enum cxl_decoder_state {
 	CXL_DECODER_STATE_AUTO_STAGED,
 };
 
+/**
+ * struct cxled_extent - Extent within an endpoint decoder
+ * @cxled: Reference to the endpoint decoder
+ * @dpa_range: DPA range this extent covers within the decoder
+ * @uuid: uuid from device for this extent
+ */
+struct cxled_extent {
+	struct cxl_endpoint_decoder *cxled;
+	struct range dpa_range;
+	uuid_t uuid;
+};
+
 /**
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
@@ -457,6 +475,7 @@ struct cxl_region_params {
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
+ * @cxlr_dax: (for DC regions) cached copy of CXL DAX bridge
  * @flags: Region state flags
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
@@ -472,6 +491,7 @@ struct cxl_region {
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
+	struct cxl_dax_region *cxlr_dax;
 	unsigned long flags;
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
@@ -518,12 +538,45 @@ struct cxl_pmem_region {
 	struct cxl_pmem_region_mapping mapping[];
 };
 
+/* See CXL 3.1 8.2.9.2.1.6 */
+enum dc_event {
+	DCD_ADD_CAPACITY,
+	DCD_RELEASE_CAPACITY,
+	DCD_FORCED_CAPACITY_RELEASE,
+	DCD_REGION_CONFIGURATION_UPDATED,
+};
+
 struct cxl_dax_region {
 	struct device dev;
 	struct cxl_region *cxlr;
 	struct range hpa_range;
+	struct region_extent *region_extent;
+};
+
+/**
+ * struct region_extent - CXL DAX region extent
+ * @dev: device representing this extent
+ * @cxlr_dax: back reference to parent region device
+ * @hpa_range: HPA range of this extent
+ * @uuid: uuid of the extent
+ * @decoder_extents: Endpoint decoder extents which make up this region extent
+ */
+struct region_extent {
+	struct device dev;
+	struct cxl_dax_region *cxlr_dax;
+	struct range hpa_range;
+	uuid_t uuid;
+	struct xarray decoder_extents;
 };
 
+bool is_region_extent(struct device *dev);
+static inline struct region_extent *to_region_extent(struct device *dev)
+{
+	if (!is_region_extent(dev))
+		return NULL;
+	return container_of(dev, struct region_extent, dev);
+}
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88bcc69f22c2..6da958352afd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -7,6 +7,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/node.h>
+#include <linux/list.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
 #include "cxl.h"
@@ -415,6 +416,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @active_volatile_bytes: sum of hard + soft volatile
  * @active_persistent_bytes: sum of hard + soft persistent
  * @dcd_supported: all DCD commands are supported
+ * @pending_ctx: pending_add ctx
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -435,6 +437,10 @@ struct cxl_memdev_state {
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
 	bool dcd_supported;
+	struct pending_add_ctx {
+		struct list_head pending_extents;
+		struct region_extent *region_extent;
+	} add_ctx;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -511,6 +517,21 @@ enum cxl_opcode {
 	UUID_INIT(0x5e1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
 
+/*
+ * Add Dynamic Capacity Response
+ * CXL rev 3.1 section 8.2.9.9.9.3; Table 8-168 & Table 8-169
+ */
+struct cxl_mbox_dc_response {
+	__le32 extent_list_size;
+	u8 flags;
+	u8 reserved[3];
+	struct updated_extent_list {
+		__le64 dpa_start;
+		__le64 length;
+		u8 reserved[8];
+	} __packed extent_list[] __counted_by(extent_list_size);
+} __packed;
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];
@@ -581,6 +602,14 @@ struct cxl_mbox_identify {
 	UUID_INIT(0xe71f3a40, 0x2d29, 0x4092, 0x8a, 0x39, 0x4d, 0x1c, 0x96, \
 		  0x6c, 0x7c, 0x65)
 
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.1 section 8.2.9.2.1; Table 8-43
+ */
+#define CXL_EVENT_DC_EVENT_UUID                                             \
+	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f, 0x95, 0x26, 0x8e, \
+		  0x10, 0x1a, 0x2a)
+
 /*
  * Get Event Records output payload
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
@@ -606,6 +635,7 @@ enum cxl_event_log_type {
 	CXL_EVENT_TYPE_WARN,
 	CXL_EVENT_TYPE_FAIL,
 	CXL_EVENT_TYPE_FATAL,
+	CXL_EVENT_TYPE_DCD,
 	CXL_EVENT_TYPE_MAX
 };
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2..fbd95e381e41 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/workqueue_types.h>
+#include <linux/list.h>
 
 /*
  * Common Event Record Format
@@ -141,12 +142,50 @@ struct cxl_event_mem_sparing {
 	u8 reserved2[0x25];
 } __packed;
 
+/*
+ * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51
+ */
+struct cxl_extent {
+	__le64 start_dpa;
+	__le64 length;
+	u8 uuid[UUID_SIZE];
+	__le16 shared_extn_seq;
+	u8 reserved[0x6];
+} __packed;
+
+struct cxl_extent_list_node {
+	struct cxl_extent *extent;
+	struct list_head list;
+	int idx;
+	int rid;
+};
+
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-50
+ */
+#define CXL_DCD_EVENT_MORE			BIT(0)
+struct cxl_event_dcd {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	u8 validity_flags;
+	__le16 host_id;
+	u8 partition_index;
+	u8 flags;
+	u8 reserved1[0x2];
+	struct cxl_extent extent;
+	u8 reserved2[0x18];
+	__le32 num_avail_extents;
+	__le32 num_avail_tags;
+} __packed;
+
 union cxl_event {
 	struct cxl_event_generic generic;
 	struct cxl_event_gen_media gen_media;
 	struct cxl_event_dram dram;
 	struct cxl_event_mem_module mem_module;
 	struct cxl_event_mem_sparing mem_sparing;
+	struct cxl_event_dcd dcd;
 	/* dram & gen_media event header */
 	struct cxl_event_media_hdr media_hdr;
 } __packed;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..8941cf187462 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -63,7 +63,10 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o
+cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o \
+				 $(CXL_CORE_SRC)/region_pmem.o \
+				 $(CXL_CORE_SRC)/region_dax.o \
+				 $(CXL_CORE_SRC)/extent.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
-- 
2.43.0

