Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93538AC8C
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529456; cv=none; b=PbEBnRsx6EiXeAuFXJaDjiNAsg1aZtrV+g1ty85SfwLmqNvFSBn+BqaJ+xM1RIauUdRUD0Km2EUakS1gqMV/2h24OkmU5ucVKDcaqODE4w7vU79+5trwL54E7gSDvpUp4NX3MJNanu+SzRQg8DWa4mBiJwKK+tSA+bRwykSK9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529456; c=relaxed/simple;
	bh=GS+yMp5c/jTLNQ20LGU0OkNzkvMy6q0vA0h1FBrJHOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp8EUz2G4sKEPj+tz/ycSgiZt1Vx6AvgUoMX9ZUjwSuZbEirH0wljQovGLNlde0+7LfIAGo7nHf3RXq4JIrqbC1rwgmwDug4fAIOabAmPALO2hcZMoK4sxR9e2eSbolSIGCJUMe0yNhupy4rG5qJRnk9BoANxOyV8J7nOa6SZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tui+/81p; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tui+/81p"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-135e88b8e55so3425291c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529453; x=1780134253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiEYQbicDj1JkgORlqjRwmZPKqd/B9x9VxQhFj4OIII=;
        b=Tui+/81piEfbmyhvxR8//o2JxLDOiBevv5PlL3KIhLKRLBHGWjFcXYYuyiMMQ82mQI
         pQTR5DsunHgv5UrLuMPLTiVkrYGp0XAO7LcejlNA9az8KRcLDdCYbIikbFj3lx1HQeB/
         bZEKCusho87l8WYj3TVINiXsLLM40KM6sAyqGPrfwoOaQH5RGiG8qvbYWG8u0KwQKF6b
         kQnvmzbmR80Sx8MKqVmYSZ7lyPYAfdRIQEJb1esg41zJBuQVy11TIA2RJdxDYpDGtduC
         SeP6q2yKls4wP5cwJtJk2fKbZ5upeEGqwfaSpQuBjOM7UD2+63FgDawVEI7OuMaoGevH
         d87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529453; x=1780134253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiEYQbicDj1JkgORlqjRwmZPKqd/B9x9VxQhFj4OIII=;
        b=LtjyOqlytDM8IZMhbatTIk8JeepJY4/NF5dxyX87memkcpJX/zxORAf4TcVUAK0zYi
         4CE00/5dWsKRjDo3M+hXBC9TUbP07QA/XHsGx9HTqqVkpbRvTj+RUjYaKPL900pUnxRr
         jVUeQXj3zCvehAPBtpiaEZOZdHNErjuHS5NV+/uVtSYpMk+f6OIsCng+F2aCcdpm14Ub
         iAVTm2RlotHaT6uyUB1A6/vFUHuaZyLrVq5reMr3I9deARVEK98xal0HCB4KI073qfQV
         SOwwPXiDTeSqotN+Q4qH1icX38HAlakfA6cT7ZIWPjkTlC9XkQ4sp6yUz/C/qLJCE+0S
         7cTw==
X-Gm-Message-State: AOJu0YwYzBvliUWBIIWqtsbDPqChfUQYDxRB4QR2Nxq3lcwm/8e7uhRM
	OP/6ggjmWxHQYMXfpX5aYgtA4DUEoLKq4ptrx/eYQhPEUNvKN/MHsh+EAVa8AA==
X-Gm-Gg: Acq92OE0sy/FizIfgXMt2w22gZmCtwhfnusUW0PKIt/wDeVQefK37pyYCb0lWb3jWIn
	0wvVZzHTVfOpHHnq+tgvtauehy05xnODaWEd/6HYaokbrIwMavRBSx950+LVMlEH3Uv3SUa4tT9
	55DjrRvNk9bZmLO/Shm9tFjXm93VYWmU9PMmamMNDaR9oao93zMLXGb+HLQWfzXpd8HfhYLfzIJ
	SK7RrNbnlzQY0YzPv3zrC6qXbVqmvjzWQDYwXTEZD2aXAFjOHQcgqtrc3g15RyhtnPVH2AEApKX
	09yVgZUAeDJ2K3ZiiLpD5Axx/gxAlfaIHAdkC9bjPke3ewAUFOsud1CqpzOK49TstkugnYqM2BE
	lRk1Nc5svVU9h8WnFjQcdEc/MncQxs8jTDUXM7LEXjq4xpQvvrHm+jR7NuGQ0nvublUTs5KPuD/
	vLeidsfh4+r9wU1cmHNWyo5WE+cI13GDsJV/iboRXLi/hu7W+P2ldrWkWpgkWqfDCSwQmDsFNiB
	8d2VVWStMvvzCEUeA==
X-Received: by 2002:a05:7022:1605:b0:132:1e01:8737 with SMTP id a92af1059eb24-1365fb403b8mr2621962c88.26.1779529452731;
        Sat, 23 May 2026 02:44:12 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:12 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 18/31] cxl/extent: Handle DC Release Capacity events
Date: Sat, 23 May 2026 02:43:12 -0700
Message-ID: <b6069cc18b77f9eb7b2f1655721c8206fc447733.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the no-op ack stub for cxl_rm_extent() with the real teardown:
resolve the released DPA range to its region and endpoint decoder,
locate the matching dc_extent in cxlr_dax->dc_extents (filtering by
cxled, range containment, and tag), and tear down the entire containing
tag group atomically through rm_tag_group().  Partial release is not
supported.

rm_tag_group() invalidates caches once for the whole group (no mappings
exist at this point — partial release is not supported, so all members
are leaving together), then walks the group's dc_extents and releases
each via its devm action installed at online_tag_group() time.

cxl_region_invalidate_memregion() becomes non-static and is declared
in core.h so rm_tag_group() can flush caches before tearing the group down.

When the released range maps to no region (host crashed before
persisting acceptance, region destruction raced device release, or the
device is confused) the host has nothing to drop, so reply via
memdev_release_extent() to keep the device's view consistent.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[anisa: restructured from the original "Process dynamic partition
 events" monolith; this commit replaces the stubbed release with the
 real walk-and-tear-down of the matching tag group.]
---
 drivers/cxl/core/core.h   |   8 +++
 drivers/cxl/core/extent.c | 101 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c   |  19 -------
 drivers/cxl/core/region.c |   2 +-
 4 files changed, 110 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 30b6b05b155b..65daaaadf68e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -28,6 +28,8 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
+
 #ifdef CONFIG_CXL_REGION
 
 struct cxl_region_context {
@@ -67,6 +69,7 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
 		   u16 seq_num);
+int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
 int online_tag_group(struct cxl_dc_tag_group *group);
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
@@ -79,6 +82,11 @@ static inline int cxl_add_extent(struct cxl_memdev_state *mds,
 {
 	return 0;
 }
+static inline int cxl_rm_extent(struct cxl_memdev_state *mds,
+				struct cxl_extent *extent)
+{
+	return 0;
+}
 static inline int online_tag_group(struct cxl_dc_tag_group *group)
 {
 	return 0;
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index b01507022cff..51116c8139ed 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -344,6 +344,107 @@ static void dc_extent_unregister(void *ext)
 	device_unregister(&dc_extent->dev);
 }
 
+static void rm_tag_group(struct cxl_dc_tag_group *group)
+{
+	struct device *region_dev = &group->cxlr_dax->dev;
+	struct dc_extent *dc_extent;
+	unsigned long index;
+
+	/*
+	 * Tagged allocations release atomically.  Invalidate caches once
+	 * for the whole group (no mappings exist at this point — partial
+	 * release is not supported, so all members are leaving use
+	 * together) before tearing down each dc_extent device.
+	 *
+	 * Pin @group across the walk: each devm_release_action runs the
+	 * dc_extent_unregister action synchronously, which drops the last
+	 * reference on the dc_extent device and fires dc_extent_release.
+	 * The release decrements group->nr_extents and, on the final
+	 * decrement, frees @group.  Without the pin the next iteration's
+	 * xa_find_after() dereferences a freed xarray.
+	 */
+	cxl_region_invalidate_memregion(group->cxlr_dax->cxlr);
+
+	group->nr_extents++;
+	xa_for_each(&group->dc_extents, index, dc_extent)
+		devm_release_action(region_dev, dc_extent_unregister, dc_extent);
+	group->nr_extents--;
+	if (!group->nr_extents)
+		free_tag_group(group);
+}
+
+int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
+{
+	u64 start_dpa = le64_to_cpu(extent->start_dpa);
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dax_region *cxlr_dax;
+	struct cxl_dc_tag_group *group;
+	struct dc_extent *dc_extent;
+	struct cxl_region *cxlr;
+	struct range dpa_range;
+	unsigned long idx;
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
+	import_uuid(&tag, extent->uuid);
+
+	/*
+	 * Find the dc_extent whose DPA range covers the released range and
+	 * whose tag matches.  The release targets the entire containing
+	 * tag group atomically; partial release is not supported.
+	 */
+	group = NULL;
+	xa_for_each(&cxlr_dax->dc_extents, idx, dc_extent) {
+		if (dc_extent->cxled != cxled)
+			continue;
+		if (!range_contains(&dc_extent->dpa_range, &dpa_range))
+			continue;
+		if (!uuid_equal(&dc_extent->group->uuid, &tag))
+			continue;
+		group = dc_extent->group;
+		break;
+	}
+	if (!group) {
+		dev_err(&cxlr_dax->dev,
+			"release DPA %pra (%pU) matches no dc_extent\n",
+			&dpa_range, &tag);
+		return -EINVAL;
+	}
+
+	rm_tag_group(group);
+	return 0;
+}
+
 static void cleanup_pending_dc_extent(struct dc_extent *dc_extent)
 {
 	struct cxl_dc_tag_group *group = dc_extent->group;
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 545c48c9c373..70e6c4c9743c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1587,25 +1587,6 @@ static int handle_add_event(struct cxl_memdev_state *mds,
 	return rc;
 }
 
-/*
- * Stub: ack the release back to the device so it knows we are not
- * using the range.  A later commit replaces this with the real
- * teardown that walks the region's tag group and tears down the
- * member dc_extent devices.
- */
-static int cxl_rm_extent(struct cxl_memdev_state *mds,
-			 struct cxl_extent *extent)
-{
-	u64 start_dpa = le64_to_cpu(extent->start_dpa);
-	struct range dpa_range = {
-		.start = start_dpa,
-		.end = start_dpa + le64_to_cpu(extent->length) - 1,
-	};
-
-	memdev_release_extent(mds, &dpa_range);
-	return 0;
-}
-
 static char *cxl_dcd_evt_type_str(u8 type)
 {
 	switch (type) {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 733d77c07493..317630d8bf2e 100644
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
-- 
2.43.0

