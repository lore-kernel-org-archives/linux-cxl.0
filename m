Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3933DB31F
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386952; cv=none; b=IM8NY8tJIpKp3rPYIWIfU6GeqxAn8iphJgjI0Znh3DdgupJdcGMuWaK/iyx5ZFUFjm/mz1rRWQT1FeZ764BmULx1NRBLBpkfi34c9VEfPMaUjuaMY6QTUmykfPM0lRhxWHbP2P53OYfi9cMJTfo3OvvBCGX649NdhHZ5jYNejoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386952; c=relaxed/simple;
	bh=6qKcxsI+Hcn66mb0Blp0i4V/Mi07BPWAM4cnaO63B6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia+Txq6LgtmZS0AKes6EMQiXFc5RA65vq/EfzDLRWvOEaTKfoEUwL0MEOAZxO3wI265886/RXGiHajevGjfu6YWAWdFxdGDKYZ5cloDzVsYSGGJA/xmE4Lsjy8cuB0kXwo8bVXYmNKNDZktjXSJH9H9GVuYSTIAlXjiBGI+vTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKaVq1Kt; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKaVq1Kt"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c23abc62eso2419661eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386949; x=1782991749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prXgzviaQ5XF3+xTkjMwztccSHvafbmS9irNhDm7cbQ=;
        b=XKaVq1Kt5HZX1U6lYWHovMNOi01JQMVXWMkojn/3LziNJ95CtS6uvbPcuCM3U3OOOJ
         /ixPtZUtB+1FjH07X9qwZeXLvw+dxFzB81TbZo+QeDRX/PO/6jYkC0dQN82s3Tv7NE+f
         R5R2HkPQVcGN4Wu3jJdN93UU2DeMqFdWWI/qh5OFL40+iduFz55tS+sqY/0Lyfc6/8p0
         1RsZCmVZuFc9m4uxHPVGH2lozoyz8DMw1vrwVvgLtCU4ny+olk4+ikxV4Yyj9ls8R6mz
         GHnN72CqphjpstbV7Ooj5zJFbI+YHDGFS8fRlN5XVq/yTbVx4yitmKejs9rvJNHZQoTh
         AcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386949; x=1782991749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prXgzviaQ5XF3+xTkjMwztccSHvafbmS9irNhDm7cbQ=;
        b=HUFkFGcByD47MtXdK7OwCbIsEQKUbFHLkcl2mpv+GRWNbehUoldvnmXJ9bgmUn/KlM
         FjPD1luoKXnrpvUynqkzqjTip4V0+gf7eSiXSZUBhleUSFo++1+HwRHqTEniyDQqDP+q
         HQnTsjIDmk5GNTF7K08CfSo0Zz5zOKRqS3hSyvcNUE+j63LOjd4KXVUrzawJF5P6iZ6p
         EbBSVwfxwNZFhYBuvkxfsQlSY6z9pLF5lfmqbOxPlRJ6qd4rX/f7K6Q0KLEBD+AHaY1E
         hEp6VbnOqcRof6BGVEJP/YPLbwYCu2RIngcf5K3TyqFh4XjrB38M/o52Evq46WxaPjn+
         0LBw==
X-Gm-Message-State: AOJu0YxDL7HERkwdlY00P2LOXCVZE2lu/qtnjXximp3Zg1NYWbDotfvi
	8DuTGAQVow+kjaQUs4cu94RKGD/k3IHIrkJYua08yiLzEHUP2IkcmuglkIPYaA==
X-Gm-Gg: AfdE7cm/Nx705bIC/8z5S5CWW4I8nzV7sjflKigSvm37louPeiO8JaqWCUwZI7nrRZc
	HoXp+KLWbDrom0QDZQLeZNyaJ9Z8K28Klk2oM8bo0nwYGAT0yZ/1sby7i9Gg+aec8jNgocUa6DO
	PtzpKKMQu/LRcyT2w0rT9a2m9ou3Y7zETs+EFTsH6ZUQtYwqdeyJnSbXZyASRF43kxTKOW3m0ev
	o2fab4XMFkuDGdhdYs+ZHNaOB9nGvB6UBIMdAb1avorSYR0V/Or+mzhFQ/BSIz5C+zmJI0YdWSA
	VZveDY3GghzHIXmW4kXyKxZ0JzpLG1sxevSrfP80uMot7vvHoox6CkYdf8lYk/1//l5NmRBnI/r
	ePBry54a8YgMyOC9SqwIhGovTuNxU7TDHqmt0ynWrWqpiAJvcoQQqUxrfHhh/1uHMASqC0j3/ik
	lzshCLT0bAjzBenpu7DMoc2rFPaBK7kAFuDqWUCpW/zRtnjOtschEPxtsdcndY5PNsVF39
X-Received: by 2002:a05:7300:372b:b0:30c:5fe:7f2e with SMTP id 5a478bee46e88-30c84d435demr2325369eec.19.1782386948373;
        Thu, 25 Jun 2026 04:29:08 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:29:08 -0700 (PDT)
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
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 27/31] cxl/region: Read existing extents on region creation
Date: Thu, 25 Jun 2026 04:05:04 -0700
Message-ID: <20260625112638.550691-28-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Dynamic capacity device extents may be left in an accepted state on a
device due to an unexpected host crash.  In this case it is expected
that the creation of a new region on top of a DC partition can read
those extents and surface them for continued use.

Once all endpoint decoders are part of a region and the region is being
realized, a read of the 'devices extent list' can reveal these
previously accepted extents.

CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
this purpose.  The call returns all the extents for all dynamic capacity
partitions.  If the fabric manager is adding extents to any DCD
partition, the extent list for the recovered region may change; the
generation number changing between queries is detected and the read is
retried.

Process the existing extents inside the asynchronous cxl_dax_region
probe rather than at region-creation time.  Reading them at creation
races the probe.

New add events for a region are deferred until that region's pre-existing
extents have been read so a tag already in use is never registered twice.
Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
1. request a full buffer (max_extent_count) per Get DC Extent List
   call rather than max(buffer, remaining).
2. latch the first per-extent error rather than the last.
3. cap the -EAGAIN retry at CXL_READ_EXTENT_LIST_RETRY (10) total
   attempts (was off by one, 11).
4. register cxlr_dax_unregister before processing existing extents
   so a failure there fails region creation cleanly.
5. recovered extents are processed with existing=true so they are
   not re-acknowledged via Add-DC-Response (the device rejects a DPA
   already added by a prior response, CXL r4.0 8.2.10.9.9.3); a failed
   online still releases them.
6. hold add_ctx.lock while consuming pending_extents in
   __cxl_process_extent_list(), the same lock handle_add_event() holds.
7. process existing extents inside the dax_region probe (with the
   __cxlr_notify_extent() lock-held core) instead of at region
   creation to avoid racing with probe
---
 drivers/cxl/core/core.h       |  15 +++-
 drivers/cxl/core/extent.c     |  35 ++++++--
 drivers/cxl/core/mbox.c       | 155 +++++++++++++++++++++++++++++++++-
 drivers/cxl/core/region_dax.c |  40 ++++++++-
 drivers/cxl/cxl.h             |   7 ++
 drivers/cxl/cxlmem.h          |  21 +++++
 drivers/dax/cxl.c             |  16 +++-
 7 files changed, 273 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1a2bc22ad3cc..29c92e45972c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -26,6 +26,8 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
 	return to_cxl_memdev_state(cxlmd->cxlds);
 }
 
+int cxl_process_extent_list(struct cxl_endpoint_decoder *cxled);
+
 #ifdef CONFIG_CXL_REGION
 
 int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
@@ -66,13 +68,15 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
-		   u16 seq_num);
+		   u16 seq_num, bool existing);
 bool cxl_tag_already_committed(const uuid_t *tag);
 int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
 int online_tag_group(struct cxl_dc_tag_group *group, bool skip_release);
 void rm_tag_group(struct cxl_dc_tag_group *group);
 int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
 		       struct cxl_dc_tag_group *group);
+int __cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			 struct cxl_dc_tag_group *group);
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
@@ -80,7 +84,8 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 	return ULLONG_MAX;
 }
 static inline int cxl_add_extent(struct cxl_memdev_state *mds,
-				 struct cxl_extent *extent, u16 seq_num)
+				 struct cxl_extent *extent, u16 seq_num,
+				 bool existing)
 {
 	return 0;
 }
@@ -105,6 +110,12 @@ static inline int cxlr_notify_extent(struct cxl_region *cxlr,
 {
 	return 0;
 }
+static inline int __cxlr_notify_extent(struct cxl_region *cxlr,
+				       enum dc_event event,
+				       struct cxl_dc_tag_group *group)
+{
+	return 0;
+}
 static inline
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
 				     struct cxl_endpoint_decoder **cxled)
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 7009ac6a51b4..03ae9473b461 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -261,7 +261,7 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
 			       struct cxl_extent *extent,
 			       struct cxl_endpoint_decoder **out_cxled,
 			       struct cxl_dax_region **out_cxlr_dax,
-			       struct range *out_ext_range)
+			       struct range *out_ext_range, bool existing)
 {
 	u64 start_dpa = le64_to_cpu(extent->start_dpa);
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
@@ -300,6 +300,13 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
 	if (!cxlr || !cxlr->cxlr_dax)
 		return -ENXIO;
 
+	/*
+	 * Pre-existing extents must be read before any new extent is added so a
+	 * tag already in use is never added twice; defer new adds until then.
+	 */
+	if (!existing && !smp_load_acquire(&cxlr->cxlr_dax->extents_scanned))
+		return -EBUSY;
+
 	ed_range = (struct range) {
 		.start = cxled->dpa_res->start,
 		.end = cxled->dpa_res->end,
@@ -376,16 +383,22 @@ dc_extent_build(struct cxl_endpoint_decoder *cxled,
 	return dc_extent;
 }
 
-int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
-		       struct cxl_dc_tag_group *group)
+/*
+ * Core notify: the caller must hold device_lock(&cxlr->cxlr_dax->dev).  Used by
+ * the existing-extent path that runs inside cxl_dax_region_probe(), where the
+ * async device-attach already holds the dax_region's device_lock — taking it
+ * again (as cxlr_notify_extent() does) would deadlock the probe against itself.
+ */
+int __cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			 struct cxl_dc_tag_group *group)
 {
 	struct device *dev = &cxlr->cxlr_dax->dev;
 	struct cxl_notify_data notify_data;
 	struct cxl_driver *driver;
 
-	dev_dbg(dev, "Trying notify: type %d tag %pUb\n", event, &group->uuid);
+	device_lock_assert(dev);
 
-	guard(device)(dev);
+	dev_dbg(dev, "Trying notify: type %d tag %pUb\n", event, &group->uuid);
 
 	/*
 	 * The lack of a driver indicates a notification has failed.  No user
@@ -406,6 +419,13 @@ int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
 	return driver->notify(dev, &notify_data);
 }
 
+int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+		       struct cxl_dc_tag_group *group)
+{
+	guard(device)(&cxlr->cxlr_dax->dev);
+	return __cxlr_notify_extent(cxlr, event, group);
+}
+
 /*
  * Stage 4: insert @dc_extent into the pending tag group.  All extents in
  * one More-chain group share a UUID — enforced here as the group is
@@ -465,7 +485,7 @@ static int cxlr_add_extent(struct cxl_memdev_state *mds,
  * and <0 on error
  */
 int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
-		   u16 seq_num)
+		   u16 seq_num, bool existing)
 {
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_dax_region *cxlr_dax;
@@ -475,7 +495,8 @@ int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
 
 	guard(rwsem_read)(&cxl_rwsem.region);
 
-	rc = cxl_validate_extent(mds, extent, &cxled, &cxlr_dax, &ext_range);
+	rc = cxl_validate_extent(mds, extent, &cxled, &cxlr_dax, &ext_range,
+				 existing);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 79258681d428..6f0d776e7e78 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1503,7 +1503,7 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 		else
 			seq_num++;
 
-		if (cxl_add_extent(mds, pos->extent, seq_num) < 0) {
+		if (cxl_add_extent(mds, pos->extent, seq_num, existing) < 0) {
 			dev_dbg(dev,
 				"Tag %pUb: failed to add extent DPA:%#llx LEN:%#llx\n",
 				tag,
@@ -1527,8 +1527,18 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 		return rc;
 	}
 
-	rc = cxlr_notify_extent(tag_group->cxlr_dax->cxlr, DCD_ADD_CAPACITY,
-				tag_group);
+	/*
+	 * The @existing path runs inside cxl_dax_region_probe() with the
+	 * dax_region's device_lock already held, so use the lock-held notify
+	 * variant to avoid re-acquiring it (which would deadlock the async
+	 * probe against itself).  The runtime add-event path holds no such lock.
+	 */
+	if (existing)
+		rc = __cxlr_notify_extent(tag_group->cxlr_dax->cxlr,
+					  DCD_ADD_CAPACITY, tag_group);
+	else
+		rc = cxlr_notify_extent(tag_group->cxlr_dax->cxlr,
+					DCD_ADD_CAPACITY, tag_group);
 	if (rc) {
 		/*
 		 * The dax-side notification failed; tear down the tag group.
@@ -2199,6 +2209,145 @@ int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
 
+/* Return -EAGAIN if the extent list changes while reading */
+static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
+{
+	u32 current_index, total_read, total_expected, initial_gen_num;
+	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_cmd mbox_cmd;
+	u32 max_extent_count;
+	int rc = 0;
+	bool first = true;
+
+	struct cxl_mbox_get_extent_out *extents __free(kvfree) =
+				kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!extents)
+		return -ENOMEM;
+
+	/*
+	 * Build and consume add_ctx.pending_extents under add_ctx.lock, the
+	 * same lock the DC event path (handle_add_event()) holds, so the two
+	 * cannot corrupt the shared pending list.
+	 */
+	guard(mutex)(&mds->add_ctx.lock);
+
+	total_read = 0;
+	current_index = 0;
+	total_expected = 0;
+	max_extent_count = (cxl_mbox->payload_size - sizeof(*extents)) /
+			    sizeof(struct cxl_extent);
+	do {
+		u32 nr_returned, current_total, current_gen_num;
+		struct cxl_mbox_get_extent_in get_extent;
+
+		get_extent = (struct cxl_mbox_get_extent_in) {
+			.extent_cnt = cpu_to_le32(max_extent_count),
+			.start_extent_index = cpu_to_le32(current_index),
+		};
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+			.payload_in = &get_extent,
+			.size_in = sizeof(get_extent),
+			.size_out = cxl_mbox->payload_size,
+			.payload_out = extents,
+			.min_out = 1,
+		};
+
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			goto out;
+
+		/* Save initial data */
+		if (first) {
+			total_expected = le32_to_cpu(extents->total_extent_count);
+			initial_gen_num = le32_to_cpu(extents->generation_num);
+			first = false;
+		}
+
+		nr_returned = le32_to_cpu(extents->returned_extent_count);
+		total_read += nr_returned;
+		current_total = le32_to_cpu(extents->total_extent_count);
+		current_gen_num = le32_to_cpu(extents->generation_num);
+
+		dev_dbg(dev, "Got extent list %d-%d of %d generation Num:%d\n",
+			current_index, total_read - 1, current_total, current_gen_num);
+
+		if (current_gen_num != initial_gen_num || total_expected != current_total) {
+			dev_warn(dev, "Extent list change detected; gen %u != %u : cnt %u != %u\n",
+				 current_gen_num, initial_gen_num,
+				 total_expected, current_total);
+			rc = -EAGAIN;
+			goto out;
+		}
+
+		/* No progress with more expected: a buggy device would loop forever. */
+		if (!nr_returned && total_expected > total_read) {
+			dev_warn(dev, "Device returned 0 of %u remaining extents\n",
+				 total_expected - total_read);
+			rc = -EIO;
+			goto out;
+		}
+
+		for (int i = 0; i < nr_returned ; i++) {
+			struct cxl_extent *extent = &extents->extent[i];
+
+			dev_dbg(dev, "Processing extent %d/%d\n",
+				current_index + i, total_expected);
+
+			rc = add_to_pending_list(&mds->add_ctx.pending_extents,
+						 extent);
+			if (rc)
+				goto out;
+		}
+
+		current_index += nr_returned;
+	} while (total_expected > total_read);
+
+	if (!list_empty(&mds->add_ctx.pending_extents)) {
+		/*
+		 * Reached only on the success path (every error does goto out),
+		 * so rc is 0 here.  These extents are already accepted on the
+		 * device (recovered from a prior boot).  Pass existing=true so
+		 * they are not re-reported in an Add-DC-Response (the device
+		 * would reject a DPA already added by a prior response), and so
+		 * a failed online releases them rather than silently dropping
+		 * them.
+		 */
+		rc = cxl_add_pending(mds, true);
+	}
+out:
+	clear_pending_extents(mds);
+
+	return rc;
+}
+
+#define CXL_READ_EXTENT_LIST_RETRY 10
+
+/**
+ * cxl_process_extent_list() - Read existing extents
+ * @cxled: Endpoint decoder which is part of a region
+ *
+ * Issue the Get Dynamic Capacity Extent List command to the device
+ * and add existing extents if found.
+ *
+ * A retry of 10 is somewhat arbitrary, however, extent changes should be
+ * relatively rare while bringing up a region.  So 10 should be plenty.
+ */
+int cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
+{
+	int retry = CXL_READ_EXTENT_LIST_RETRY;
+	int rc;
+
+	do {
+		rc = __cxl_process_extent_list(cxled);
+	} while (rc == -EAGAIN && --retry);
+
+	return rc;
+}
+
 static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
 		     enum cxl_partition_mode mode, u8 handle)
 {
diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
index 70b086d50451..c614f5458330 100644
--- a/drivers/cxl/core/region_dax.c
+++ b/drivers/cxl/core/region_dax.c
@@ -82,6 +82,38 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 	device_unregister(&cxlr_dax->dev);
 }
 
+/*
+ * Process existing extents from the probe, not region creation: the probe is
+ * async, and attaching extent devres before really_probe() runs trips its
+ * "resources present" -EBUSY gate, so the dax_region never binds.
+ */
+int cxl_region_add_existing_extents(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int i, latched_rc = 0;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		struct device *dev = &p->targets[i]->cxld.dev;
+		int rc;
+
+		rc = cxl_process_extent_list(p->targets[i]);
+		if (rc) {
+			dev_err(dev, "Existing extent processing failed %d\n",
+				rc);
+			/* Process every target, but report the first error. */
+			if (!latched_rc)
+				latched_rc = rc;
+		}
+	}
+
+	/* Pre-existing extents are read; new add events may now proceed. */
+	if (!latched_rc)
+		smp_store_release(&cxlr->cxlr_dax->extents_scanned, true);
+
+	return latched_rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_add_existing_extents, "CXL");
+
 int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
 	struct device *dev;
@@ -110,6 +142,10 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
-					no_free_ptr(cxlr_dax));
+	rc = devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
+				      no_free_ptr(cxlr_dax));
+	if (rc)
+		return rc;
+
+	return 0;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1bb861bb23fe..07ecb0e1888b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -579,6 +579,8 @@ struct cxl_dax_region {
 	 * driver handles.
 	 */
 	struct xarray dc_extents;
+	/* Set once the probe has read the device's pre-existing extents. */
+	bool extents_scanned;
 };
 
 /**
@@ -959,6 +961,7 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+int cxl_region_add_existing_extents(struct cxl_region *cxlr);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_region_contains_resource(const struct resource *res);
 #else
@@ -978,6 +981,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline int cxl_region_add_existing_extents(struct cxl_region *cxlr)
+{
+	return 0;
+}
 static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 					       u64 spa)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 81498d47f309..414a20b3522e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -570,6 +570,27 @@ struct cxl_mbox_dc_response {
 	} __packed extent_list[] __counted_by(extent_list_size);
 } __packed;
 
+/*
+ * Get Dynamic Capacity Extent List; Input Payload
+ * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
+ */
+struct cxl_mbox_get_extent_in {
+	__le32 extent_cnt;
+	__le32 start_extent_index;
+} __packed;
+
+/*
+ * Get Dynamic Capacity Extent List; Output Payload
+ * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
+ */
+struct cxl_mbox_get_extent_out {
+	__le32 returned_extent_count;
+	__le32 total_extent_count;
+	__le32 generation_num;
+	u8 rsvd[4];
+	struct cxl_extent extent[];
+} __packed;
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index d885b6e698ef..54fa7630231a 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -114,11 +114,23 @@ static int cxl_dax_region_probe(struct device *dev)
 	if (!dax_region)
 		return -ENOMEM;
 
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
+	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_1) {
+		int rc;
+
+		/*
+		 * Run inside the probe, not at region creation: attaching extent
+		 * devres before really_probe() trips its "resources present"
+		 * -EBUSY gate.  The notify path adds the dax_region resources.
+		 */
+		rc = cxl_region_add_existing_extents(cxlr);
+		if (rc)
+			return rc;
+
 		/* Add empty seed dax device */
 		dev_size = 0;
-	else
+	} else {
 		dev_size = range_len(&cxlr_dax->hpa_range);
+	}
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
-- 
2.43.0

