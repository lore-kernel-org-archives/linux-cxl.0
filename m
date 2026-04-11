Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808D255F52
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871650; cv=none; b=EBaTt4y8u5ysv4r+ws/eLq/MldNoHo7hoJ6P/YP90s7NkUllebk/ZLshY1nqD9PL89YWqZpKrhRkhBNOgfd2r1Rz/DL8R2zZL9cfmsTdyByWFKZV0CboiRgVWOcJoxKO42sxNm9TabNeyjESZlycphgZfjp3DJdoCHMpy6OgnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871650; c=relaxed/simple;
	bh=1vOKJ+BhGk3YGwGvviZ+6kCxyRQ3JIz79ptDnCh97Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZFGh8hSJOsarbJtAhjLaZWp96KfDPOBMxvJ7U8QMuWjIvJA8+yqjI2NxNinxCsCt1AXPd/87/fkzJ66aQSnpslGJKQrNGL1XM7NWCxVWOfw7OBnnTGUUJKENouOvsPkP3eOenuI+hw71XXSU/mDGjel3On4h2VF9eMaiO0yVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2ttmK3+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2ttmK3+"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso22696257b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871647; x=1776476447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4OAf7OfYzU+TWqMGowLwDvrMO8Ikrg5wyaOBbL6ZHs=;
        b=p2ttmK3+ZBz7iiKn47Pr/PLshNbxOZKPBhrUjRmKz79Y+1PzjoScr4+V54t2ZoUdfU
         mV4bzk3eyJzJ64YV3sLEzxYbJQErGp28u1labCsvbAml1MlHXiVqAtXt0GaETCaQMNjW
         UBXuBvEU4PDI1qDSfNtXXgeEop/XERUPp0FwAtL+prTR6UZWp38AymtTWozG0vNr4gmv
         nw7D1j7QFUttOPW3aHVOF/qoNxcvCa0KbQ40OEX0pG7GzVQ9MjBvZQnmvL+UEvLWUgGY
         +5aSwmapIVYZBFTQKJiBUqwQnIKhpHwm7JaK3bYpv1Q7b1slF0SN01b7FxA/0uBA0xOo
         L1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871647; x=1776476447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4OAf7OfYzU+TWqMGowLwDvrMO8Ikrg5wyaOBbL6ZHs=;
        b=ciUZe4EQbOxeSxjpHiM1Uv3cS49x8jFcpEoZUQZdQ/x8JeXV76CSA2p1kedwLt8KoG
         E29YU6ZLtynI3OJhAyUcGBkIpfKWdYAKGcijwVeEoyldv4lyXinAq7YDWKCbLGWNSlaM
         q53MZ72mzmiGkkdRqc8THDmkXa2HkAxzJYsly6PmEvV6DKKMeCacx8ETmBfCnAXESVwC
         5+ZERhRCd0ntRa6KokkRhpo095ACh37JNRtQqiUHuGP4YmN5L15O4ZgHFsb6GUgpleH8
         w6ilOMwB4BJJrGAodjbFcwY59iaS32EiLiDtrrL7ETJMVZUtZ2GaNOB9uKOzKWgipjPX
         Z+7Q==
X-Gm-Message-State: AOJu0YyrcRzH7/3idqtEuDva5dm4U5g4rkvcSs5uuz20BWYVRLeKAgza
	jigslPTvQN9gTko0g7zL43Bq+l8Qz5J/yNFJRMixHFmr8/fZwnrBFs1GmVT/rQ==
X-Gm-Gg: AeBDiesZSBkHgPDeaID8CIr9RPmAG5ff7MkIA38h4r3ggk2WlI70/Kp5i64HSL9RkcH
	LU4Eo3lCjbzP9jvjUJ08RSHvn09GPsHFqwW/0+4J1X6gbEQ5bFEeIgX+kStXarQTzy26WM/KKmr
	Uo1ac2lqfKTkZKlQwkWWKCZyjciapT7g4vSAvr1MhaDuG581ziqjtitGnKgIf0kjLNeki8kib+3
	NqudKBQ9AWuzGoItvYM7ytiDqdtVsGQLmwe3+MI31DK0V4ix1NzvR4wOOnvyYcuOjD7Lppickf7
	Paa64FQnQ+pzq/+06bO17Zgw037EEPVL7LW3w7AU98HVmgkt49ZG2mLQOUzGrKyJYtpgNS5awG3
	qMmuHZkdEfPSIJqsa1usqmtUp2MbIumDelhQ/P4+SlihoDoNzAz28t2O+eU8sG21NuZZGGn8Rcz
	VWcjOq+pc4aLM/IL1S8aZCqbUlqmtH5807noclkcNO5A==
X-Received: by 2002:a05:690c:f04:b0:79d:bb7:54da with SMTP id 00721157ae682-7af71a57a72mr62962177b3.41.1775871647153;
        Fri, 10 Apr 2026 18:40:47 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:46 -0700 (PDT)
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/20] dax/region: Create resources on DAX regions
Date: Fri, 10 Apr 2026 18:23:10 -0700
Message-ID: <20260411013958.47422-16-anisa.su@samsung.com>
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

DAX regions which map dynamic capacity partitions require that memory be
allowed to come and go.  Recall struct dax_resource was created for this
purpose.  Now that extents can be realized within DAX regions the DAX
region driver can start tracking sub-resource information.

The tight relationship between DAX region operations and extent
operations require memory changes to be controlled synchronously with
the user of the region.  Synchronize through the dax_region_rwsem and by
having the region driver drive both the region device as well as the
extent sub-devices.

Recall requests to remove extents can happen at any time and that a host
is not obligated to release the memory until it is not being used.  If
an extent is not used allow a release response.

When extents are eligible for release.  No mappings exist but data may
reside in caches not yet written to the device.  Call
cxl_region_invalidate_memregion() to write back data to the device prior
to signaling the release complete.

Speculative writes after a release may dirty the cache such that a read
from a newly surfaced extent may not come from the device.  Call
cxl_region_invalidate_memregion() prior to bringing a new extent online
to ensure the cache is marked invalid.

While these invalidate calls are inefficient they are the best we can do
to ensure cache consistency without back invalidate.  Furthermore this
should occur infrequently with sufficiently large extents that real work
loads should not be impacted much.

The DAX layer has no need for the details of the CXL memory extent
devices.  Expose extents to the DAX layer as device children of the DAX
region device.  A single callback from the driver aids the DAX layer to
determine if the child device is an extent.  The DAX layer also
registers a devres function to automatically clean up when the device is
removed from the region.

There is a race between extents being surfaced and the dax_cxl driver
being loaded.  Synchronizes the driver during probe by scanning for
existing extents while under the device lock.

Respond to extent notifications.  Manage the DAX region resource tree
based on the extents lifetime.  Return the status of remove
notifications to lower layers such that it can manage the hardware
appropriately.

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: notify once for region_extent_online and region_rm_extent]

Instead of notifying the DAX layer for each device extent, notify only
once after processing the entire pending list. This ensures the tagged
capacity is added/removed all at once.
---
 drivers/cxl/core/core.h   |  11 ++
 drivers/cxl/core/extent.c |  47 +++++++-
 drivers/cxl/core/mbox.c   |  16 ++-
 drivers/cxl/core/region.c |   2 +-
 drivers/cxl/cxl.h         |   5 +
 drivers/dax/bus.c         | 247 ++++++++++++++++++++++++++++++++++----
 drivers/dax/bus.h         |   3 +-
 drivers/dax/cxl.c         |  61 +++++++++-
 drivers/dax/dax-private.h |  40 ++++++
 drivers/dax/hmem/hmem.c   |   2 +-
 drivers/dax/pmem.c        |   2 +-
 include/linux/ioport.h    |   3 +
 12 files changed, 404 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 14d91dd52b02..cb3f46a1152a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -28,6 +28,8 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
+
 #ifdef CONFIG_CXL_REGION
 
 struct cxl_region_context {
@@ -67,6 +69,9 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
 int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
 int online_region_extent(struct region_extent *region_extent);
+void region_rm_extent(struct region_extent *region_extent);
+int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+		       struct region_extent *region_extent);
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
@@ -86,6 +91,12 @@ static inline int online_region_extent(struct region_extent *region_extent)
 {
 	return 0;
 }
+static inline void region_rm_extent(struct region_extent *region_extent) { }
+static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			      struct region_extent *region_extent)
+{
+	return 0;
+}
 static inline
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
 				     struct cxl_endpoint_decoder **cxled)
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 17fad51f084d..c4ad81814fb4 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -116,10 +116,16 @@ static void region_extent_unregister(void *ext)
 
 	dev_dbg(&region_extent->dev, "DAX region rm extent HPA %pra\n",
 		&region_extent->hpa_range);
+	/*
+	 * Extent is not in use or an error has occur.  No mappings
+	 * exist at this point.  Write and invalidate caches to ensure
+	 * the device has all data prior to final release.
+	 */
+	cxl_region_invalidate_memregion(region_extent->cxlr_dax->cxlr);
 	device_unregister(&region_extent->dev);
 }
 
-static void region_rm_extent(struct region_extent *region_extent)
+void region_rm_extent(struct region_extent *region_extent)
 {
 	struct device *region_dev = region_extent->dev.parent;
 
@@ -226,6 +232,38 @@ static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
 	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
 }
 
+int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			      struct region_extent *region_extent)
+{
+	struct device *dev = &cxlr->cxlr_dax->dev;
+	struct cxl_notify_data notify_data;
+	struct cxl_driver *driver;
+
+	dev_dbg(dev, "Trying notify: type %d HPA %pra\n", event,
+		&region_extent->hpa_range);
+
+	guard(device)(dev);
+
+	/*
+	 * The lack of a driver indicates a notification has failed.  No user
+	 * space coordination was possible.
+	 */
+	if (!dev->driver)
+		return 0;
+	driver = to_cxl_drv(dev->driver);
+	if (!driver->notify)
+		return 0;
+
+	notify_data = (struct cxl_notify_data) {
+		.event = event,
+		.region_extent = region_extent,
+	};
+
+	dev_dbg(dev, "Notify: type %d HPA %pra\n", event,
+		&region_extent->hpa_range);
+	return driver->notify(dev, &notify_data);
+}
+
 int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
 {
 	u64 start_dpa = le64_to_cpu(extent->start_dpa);
@@ -236,6 +274,7 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
 	struct region_extent *reg_ext;
 	struct cxl_region *cxlr;
 	uuid_t tag;
+	int rc;
 
 	dpa_range = (struct range) {
 		.start = start_dpa,
@@ -290,6 +329,12 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
 		return -EINVAL;
 	}
 
+	rc = cxlr_notify_extent(cxlr,
+				DCD_RELEASE_CAPACITY,
+				cxlr_dax->region_extent);
+	if (rc == -EBUSY)
+		return 0;
+
 	/* Release entire capacity of the region */
 	region_rm_extent(reg_ext);
 	return 0;
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 56d8b2a9974c..c256081d2c65 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1375,12 +1375,26 @@ static int cxl_add_pending(struct cxl_memdev_state *mds)
 	}
 
 	pending_reg_ext = mds->add_ctx.region_extent;
+	/* Ensure caches are clean prior onlining */
+	rc = cxl_region_invalidate_memregion(pending_reg_ext->cxlr_dax->cxlr);
+	if (rc)
+		return rc;
 
 	/* device model handles freeing region_extent */
-	rc = online_region_extent(mds->add_ctx.region_extent);
+	rc = online_region_extent(pending_reg_ext);
 	if (rc)
 		return rc;
 
+	rc = cxlr_notify_extent(pending_reg_ext->cxlr_dax->cxlr,
+				DCD_ADD_CAPACITY,
+				pending_reg_ext);
+	/*
+	 * The region device was briefly live but DAX layer ensures it was not
+	 * used
+	 */
+	if (rc)
+		region_rm_extent(pending_reg_ext);
+
 	/* Restore remaining extents to original order and send rsp */
 	list_sort(NULL, &mds->add_ctx.pending_extents, idx_compare);
 	return cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e00fdb74589c..7b869c8ada22 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -222,7 +222,7 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
-static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!cpu_cache_has_invalidate_memregion()) {
 		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 477e91bc2ab7..6fda10e25043 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -858,12 +858,17 @@ extern const struct bus_type cxl_bus_type;
  * by @id and the add_dport() op only defined for the CXL_DEVICE_PORT driver
  * template.
  */
+struct cxl_notify_data {
+	enum dc_event event;
+	struct region_extent *region_extent;
+};
 struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
 	struct cxl_dport *(*add_dport)(struct cxl_port *port,
 				       struct device *dport_dev);
+	int (*notify)(struct device *dev, struct cxl_notify_data *notify_data);
 	struct device_driver drv;
 	int id;
 };
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 40f11fda66b5..2ada38fa7dca 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -184,6 +184,93 @@ static bool is_sparse(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
 }
 
+static void __dax_release_resource(struct dax_resource *dax_resource)
+{
+	struct dax_region *dax_region = dax_resource->region;
+
+	lockdep_assert_held_write(&dax_region_rwsem);
+	dev_dbg(dax_region->dev, "Extent release resource %pr\n",
+		dax_resource->res);
+	if (dax_resource->res)
+		__release_region(&dax_region->res, dax_resource->res->start,
+				 resource_size(dax_resource->res));
+	dax_resource->res = NULL;
+}
+
+static void dax_release_resource(void *res)
+{
+	struct dax_resource *dax_resource = res;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+	__dax_release_resource(dax_resource);
+	kfree(dax_resource);
+}
+
+int dax_region_add_resource(struct dax_region *dax_region,
+			    struct device *device,
+			    resource_size_t start, resource_size_t length)
+{
+	struct resource *new_resource;
+	int rc;
+
+	struct dax_resource *dax_resource __free(kfree) =
+				kzalloc(sizeof(*dax_resource), GFP_KERNEL);
+	if (!dax_resource)
+		return -ENOMEM;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+
+	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
+	new_resource = __request_region(&dax_region->res, start, length, "extent", 0);
+	if (!new_resource) {
+		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
+			&start, &length);
+		return -ENOSPC;
+	}
+
+	dev_dbg(dax_region->dev, "add resource %pr\n", new_resource);
+	dax_resource->region = dax_region;
+	dax_resource->res = new_resource;
+
+	/*
+	 * open code devm_add_action_or_reset() to avoid recursive write lock
+	 * of dax_region_rwsem in the error case.
+	 */
+	rc = devm_add_action(device, dax_release_resource, dax_resource);
+	if (rc) {
+		__dax_release_resource(dax_resource);
+		return rc;
+	}
+
+	dev_set_drvdata(device, no_free_ptr(dax_resource));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_region_add_resource);
+
+int dax_region_rm_resource(struct dax_region *dax_region,
+			   struct device *dev)
+{
+	struct dax_resource *dax_resource;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource)
+		return 0;
+
+	if (dax_resource->use_cnt)
+		return -EBUSY;
+
+	/*
+	 * release the resource under dax_region_rwsem to avoid races with
+	 * users trying to use the extent
+	 */
+	__dax_release_resource(dax_resource);
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_region_rm_resource);
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
@@ -297,19 +384,41 @@ static ssize_t region_align_show(struct device *dev,
 static struct device_attribute dev_attr_region_align =
 		__ATTR(align, 0400, region_align_show, NULL);
 
+resource_size_t
+dax_avail_size(struct resource *dax_resource)
+{
+	resource_size_t rc;
+	struct resource *used_res;
+
+	rc = resource_size(dax_resource);
+	for_each_child_resource(dax_resource, used_res)
+		rc -= resource_size(used_res);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_avail_size);
+
 #define for_each_dax_region_resource(dax_region, res) \
 	for (res = (dax_region)->res.child; res; res = res->sibling)
 
 static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 {
-	resource_size_t size = resource_size(&dax_region->res);
+	resource_size_t size;
 	struct resource *res;
 
 	lockdep_assert_held(&dax_region_rwsem);
 
-	if (is_sparse(dax_region))
-		return 0;
+	if (is_sparse(dax_region)) {
+		/*
+		 * Children of a sparse region represent available space not
+		 * used space.
+		 */
+		size = 0;
+		for_each_dax_region_resource(dax_region, res)
+			size += dax_avail_size(res);
+		return size;
+	}
 
+	size = resource_size(&dax_region->res);
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
 	return size;
@@ -450,15 +559,26 @@ EXPORT_SYMBOL_GPL(kill_dev_dax);
 static void trim_dev_dax_range(struct dev_dax *dev_dax)
 {
 	int i = dev_dax->nr_range - 1;
-	struct range *range = &dev_dax->ranges[i].range;
+	struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+	struct range *range = &dev_range->range;
 	struct dax_region *dax_region = dev_dax->region;
+	struct resource *res = &dax_region->res;
 
 	lockdep_assert_held_write(&dax_region_rwsem);
 	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
 		(unsigned long long)range->start,
 		(unsigned long long)range->end);
 
-	__release_region(&dax_region->res, range->start, range_len(range));
+	if (dev_range->dax_resource) {
+		res = dev_range->dax_resource->res;
+		dev_dbg(&dev_dax->dev, "Trim sparse extent %pr\n", res);
+	}
+
+	__release_region(res, range->start, range_len(range));
+
+	if (dev_range->dax_resource)
+		dev_range->dax_resource->use_cnt--;
+
 	if (--dev_dax->nr_range == 0) {
 		kfree(dev_dax->ranges);
 		dev_dax->ranges = NULL;
@@ -642,7 +762,7 @@ static void dax_region_unregister(void *region)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
-		unsigned long flags)
+		unsigned long flags, struct dax_sparse_ops *sparse_ops)
 {
 	struct dax_region *dax_region;
 	int rc;
@@ -661,12 +781,16 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 			|| !IS_ALIGNED(range_len(range), align))
 		return NULL;
 
+	if (!sparse_ops && (flags & IORESOURCE_DAX_SPARSE_CAP))
+		return NULL;
+
 	dax_region = kzalloc_obj(*dax_region);
 	if (!dax_region)
 		return NULL;
 
 	dev_set_drvdata(parent, dax_region);
 	kref_init(&dax_region->kref);
+	dax_region->sparse_ops = sparse_ops;
 	dax_region->id = region_id;
 	dax_region->align = align;
 	dax_region->dev = parent;
@@ -859,7 +983,8 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 }
 
 static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
-			       u64 start, resource_size_t size)
+			       u64 start, resource_size_t size,
+			       struct dax_resource *dax_resource)
 {
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
@@ -898,6 +1023,7 @@ static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
 			.start = alloc->start,
 			.end = alloc->end,
 		},
+		.dax_resource = dax_resource,
 	};
 
 	dev_dbg(dev, "alloc range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
@@ -980,7 +1106,8 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 	int i;
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
-		struct range *range = &dev_dax->ranges[i].range;
+		struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+		struct range *range = &dev_range->range;
 		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
@@ -996,12 +1123,21 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 			continue;
 		}
 
-		for_each_dax_region_resource(dax_region, res)
-			if (strcmp(res->name, dev_name(dev)) == 0
-					&& res->start == range->start) {
-				adjust = res;
-				break;
-			}
+		if (dev_range->dax_resource) {
+			for_each_child_resource(dev_range->dax_resource->res, res)
+				if (strcmp(res->name, dev_name(dev)) == 0
+						&& res->start == range->start) {
+					adjust = res;
+					break;
+				}
+		} else {
+			for_each_dax_region_resource(dax_region, res)
+				if (strcmp(res->name, dev_name(dev)) == 0
+						&& res->start == range->start) {
+					adjust = res;
+					break;
+				}
+		}
 
 		if (dev_WARN_ONCE(dev, !adjust || i != dev_dax->nr_range - 1,
 					"failed to find matching resource\n"))
@@ -1039,19 +1175,21 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 }
 
 /**
- * dev_dax_resize_static - Expand the device into the unused portion of the
- * region. This may involve adjusting the end of an existing resource, or
- * allocating a new resource.
+ * __dev_dax_resize - Expand the device into the unused portion of the region.
+ * This may involve adjusting the end of an existing resource, or allocating a
+ * new resource.
  *
  * @parent: parent resource to allocate this range in
  * @dev_dax: DAX device to be expanded
  * @to_alloc: amount of space to alloc; must be <= space available in @parent
+ * @dax_resource: if sparse; the parent resource
  *
  * Return the amount of space allocated or -ERRNO on failure
  */
-static ssize_t dev_dax_resize_static(struct resource *parent,
-				     struct dev_dax *dev_dax,
-				     resource_size_t to_alloc)
+static ssize_t __dev_dax_resize(struct resource *parent,
+				struct dev_dax *dev_dax,
+				resource_size_t to_alloc,
+				struct dax_resource *dax_resource)
 {
 	struct resource *res, *first;
 	int rc;
@@ -1059,7 +1197,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	first = parent->child;
 	if (!first) {
 		rc = alloc_dev_dax_range(parent, dev_dax,
-					   parent->start, to_alloc);
+					   parent->start, to_alloc,
+					   dax_resource);
 		if (rc)
 			return rc;
 		return to_alloc;
@@ -1073,7 +1212,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 		if (res == first && res->start > parent->start) {
 			alloc = min(res->start - parent->start, to_alloc);
 			rc = alloc_dev_dax_range(parent, dev_dax,
-						 parent->start, alloc);
+						 parent->start, alloc,
+						 dax_resource);
 			if (rc)
 				return rc;
 			return alloc;
@@ -1097,7 +1237,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 				return rc;
 			return alloc;
 		}
-		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc,
+					 dax_resource);
 		if (rc)
 			return rc;
 		return alloc;
@@ -1108,6 +1249,51 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	return 0;
 }
 
+static ssize_t dev_dax_resize_static(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	return __dev_dax_resize(&dax_region->res, dev_dax, to_alloc, NULL);
+}
+
+static int find_free_extent(struct device *dev, const void *data)
+{
+	const struct dax_region *dax_region = data;
+	struct dax_resource *dax_resource;
+
+	if (!dax_region->sparse_ops->is_extent(dev))
+		return 0;
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource || !dax_avail_size(dax_resource->res))
+		return 0;
+	return 1;
+}
+
+static ssize_t dev_dax_resize_sparse(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	struct dax_resource *dax_resource;
+	ssize_t alloc;
+
+	struct device *extent_dev __free(put_device) =
+			device_find_child(dax_region->dev, dax_region,
+					  find_free_extent);
+	if (!extent_dev)
+		return 0;
+
+	dax_resource = dev_get_drvdata(extent_dev);
+	if (!dax_resource)
+		return 0;
+
+	to_alloc = min(dax_avail_size(dax_resource->res), to_alloc);
+	alloc = __dev_dax_resize(dax_resource->res, dev_dax, to_alloc, dax_resource);
+	if (alloc > 0)
+		dax_resource->use_cnt++;
+	return alloc;
+}
+
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
@@ -1132,7 +1318,10 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		return -ENXIO;
 
 retry:
-	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
+	if (is_sparse(dax_region))
+		alloc = dev_dax_resize_sparse(dax_region, dev_dax, to_alloc);
+	else
+		alloc = dev_dax_resize_static(dax_region, dev_dax, to_alloc);
 	if (alloc <= 0)
 		return alloc;
 	to_alloc -= alloc;
@@ -1241,7 +1430,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
 		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
-					 to_alloc);
+					 to_alloc, NULL);
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
@@ -1480,6 +1669,12 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	struct device *dev;
 	int rc;
 
+	dev_dax = kzalloc_obj(*dev_dax);
+	if (is_sparse(dax_region) && data->size) {
+		dev_err(parent, "Sparse DAX region devices must be created initially with 0 size");
+		return ERR_PTR(-EINVAL);
+	}
+
 	dev_dax = kzalloc_obj(*dev_dax);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
@@ -1510,7 +1705,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
 	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
-				 data->size);
+				 data->size, NULL);
 	if (rc)
 		goto err_range;
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 7abdd5a403dc..d41cb36e8868 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -11,6 +11,7 @@ struct dev_dax;
 struct resource;
 struct dax_device;
 struct dax_region;
+struct dax_sparse_ops;
 
 /* dax bus specific ioresource flags */
 #define IORESOURCE_DAX_STATIC BIT(0)
@@ -19,7 +20,7 @@ struct dax_region;
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
-		unsigned long flags);
+		unsigned long flags, struct dax_sparse_ops *sparse_ops);
 
 struct dev_dax_data {
 	struct dax_region *dax_region;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 9ebe974d25c3..159fb4e82529 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -5,6 +5,57 @@
 
 #include "../cxl/cxl.h"
 #include "bus.h"
+#include "dax-private.h"
+
+static int __cxl_dax_add_resource(struct dax_region *dax_region,
+				  struct region_extent *region_extent)
+{
+	struct device *dev = &region_extent->dev;
+	resource_size_t start, length;
+
+	start = dax_region->res.start + region_extent->hpa_range.start;
+	length = range_len(&region_extent->hpa_range);
+	return dax_region_add_resource(dax_region, dev, start, length);
+}
+
+static int cxl_dax_add_resource(struct device *dev, void *data)
+{
+	struct dax_region *dax_region = data;
+	struct region_extent *region_extent;
+
+	region_extent = to_region_extent(dev);
+	if (!region_extent)
+		return 0;
+
+	dev_dbg(dax_region->dev, "Adding resource HPA %pra\n",
+		&region_extent->hpa_range);
+
+	return __cxl_dax_add_resource(dax_region, region_extent);
+}
+
+static int cxl_dax_region_notify(struct device *dev,
+				 struct cxl_notify_data *notify_data)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	struct region_extent *region_extent = notify_data->region_extent;
+
+	switch (notify_data->event) {
+	case DCD_ADD_CAPACITY:
+		return __cxl_dax_add_resource(dax_region, region_extent);
+	case DCD_RELEASE_CAPACITY:
+		return dax_region_rm_resource(dax_region, &region_extent->dev);
+	case DCD_FORCED_CAPACITY_RELEASE:
+	default:
+		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n",
+			notify_data->event);
+		return -ENXIO;
+	}
+}
+
+struct dax_sparse_ops sparse_ops = {
+	.is_extent = is_region_extent,
+};
 
 static int cxl_dax_region_probe(struct device *dev)
 {
@@ -24,15 +75,18 @@ static int cxl_dax_region_probe(struct device *dev)
 		flags |= IORESOURCE_DAX_SPARSE_CAP;
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, flags);
+				      PMD_SIZE, flags, &sparse_ops);
 	if (!dax_region)
 		return -ENOMEM;
 
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
+	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A) {
+		device_for_each_child(&cxlr_dax->dev, dax_region,
+				      cxl_dax_add_resource);
 		/* Add empty seed dax device */
 		dev_size = 0;
-	else
+	} else {
 		dev_size = range_len(&cxlr_dax->hpa_range);
+	}
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
@@ -47,6 +101,7 @@ static int cxl_dax_region_probe(struct device *dev)
 static struct cxl_driver cxl_dax_region_driver = {
 	.name = "cxl_dax_region",
 	.probe = cxl_dax_region_probe,
+	.notify = cxl_dax_region_notify,
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index c6ae27c982f4..83b198068597 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -16,6 +16,14 @@ struct inode *dax_inode(struct dax_device *dax_dev);
 int dax_bus_init(void);
 void dax_bus_exit(void);
 
+/**
+ * struct dax_sparse_ops - Operations for sparse regions
+ * @is_extent: return if the device is an extent
+ */
+struct dax_sparse_ops {
+	bool (*is_extent)(struct device *dev);
+};
+
 /**
  * struct dax_region - mapping infrastructure for dax devices
  * @id: kernel-wide unique region for a memory range
@@ -27,6 +35,7 @@ void dax_bus_exit(void);
  * @res: resource tree to track instance allocations
  * @seed: allow userspace to find the first unbound seed device
  * @youngest: allow userspace to find the most recently created device
+ * @sparse_ops: operations required for sparse regions
  */
 struct dax_region {
 	int id;
@@ -38,6 +47,7 @@ struct dax_region {
 	struct resource res;
 	struct device *seed;
 	struct device *youngest;
+	struct dax_sparse_ops *sparse_ops;
 };
 
 /**
@@ -57,11 +67,13 @@ struct dax_mapping {
  * @pgoff: page offset
  * @range: resource-span
  * @mapping: reference to the dax_mapping for this range
+ * @dax_resource: if not NULL; dax sparse resource containing this range
  */
 struct dev_dax_range {
 	unsigned long pgoff;
 	struct range range;
 	struct dax_mapping *mapping;
+	struct dax_resource *dax_resource;
 };
 
 /**
@@ -102,6 +114,34 @@ struct dev_dax {
  */
 void run_dax(struct dax_device *dax_dev);
 
+/**
+ * struct dax_resource - For sparse regions; an active resource
+ * @region: dax_region this resources is in
+ * @res: resource
+ * @use_cnt: count the number of uses of this resource
+ *
+ * Changes to the dax_region and the dax_resources within it are protected by
+ * dax_region_rwsem
+ *
+ * dax_resource's are not intended to be used outside the dax layer.
+ */
+struct dax_resource {
+	struct dax_region *region;
+	struct resource *res;
+	unsigned int use_cnt;
+};
+
+/*
+ * Similar to run_dax() dax_region_{add,rm}_resource() and dax_avail_size() are
+ * exported but are not intended to be generic operations outside the dax
+ * subsystem.  They are only generic between the dax layer and the dax drivers.
+ */
+int dax_region_add_resource(struct dax_region *dax_region, struct device *dev,
+			    resource_size_t start, resource_size_t length);
+int dax_region_rm_resource(struct dax_region *dax_region,
+			   struct device *dev);
+resource_size_t dax_avail_size(struct resource *dax_resource);
+
 static inline struct dev_dax *to_dev_dax(struct device *dev)
 {
 	return container_of(dev, struct dev_dax, dev);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index af21f66bf872..be938c2a73f8 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -28,7 +28,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 
 	mri = dev->platform_data;
 	dax_region = alloc_dax_region(dev, pdev->id, &mri->range,
-				      mri->target_node, PMD_SIZE, flags);
+				      mri->target_node, PMD_SIZE, flags, NULL);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..5b5be86768f3 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -53,7 +53,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	range.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
-			IORESOURCE_DAX_STATIC);
+			IORESOURCE_DAX_STATIC, NULL);
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5533a5debf3f..ab364e25f479 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -28,6 +28,9 @@ struct resource {
 	struct resource *parent, *sibling, *child;
 };
 
+#define for_each_child_resource(parent, res) \
+	for (res = (parent)->child; res; res = res->sibling)
+
 /*
  * IO resources have these defined flags.
  *
-- 
2.43.0

