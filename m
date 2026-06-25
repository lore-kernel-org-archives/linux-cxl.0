Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D63DB303
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386935; cv=none; b=Ad9mud2WslO9qc/bp30IMvkRwy7lbmiXxscGcPZRjmOfORkhCdIfE374bGbcdghaa5aQT9PI26/As60cvWX7ln0sLbl2ULvTs5RdKZ68QFbDEM5WsxD6bQA0akNcjlKeFU2cw4YM6BPAi5yKLVGzDH9Z/UP45Hg8oTs/g+PDgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386935; c=relaxed/simple;
	bh=L8HB4zGuZz/+x5KOIC1yOzYA2+ZydTWctPcvbVtCcSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PI5nUi9Nl2PwSAf+H6M6CNBRpTgf1nwYkfRu5xcuKsIXPYjI5K6mZFOCgngsv2odYiVGCM6/v+DjrnSIyrk+iVwFzY0aqYM4nq6Zv66Ppq2bOMX9qcuNqceX06dqjSZ8aLYl3kp+SSuFy+l1+3q0zwiilAL12WQb4EYdxK+Rc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1luvpKh; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1luvpKh"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30bc806fcf8so2618027eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386933; x=1782991733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0f7m3I/gyXJngH6U6zNCpZRIgKLq7oekxM/6WhxAAk=;
        b=i1luvpKh2LQ93DVT9YrdeXnDiQm/IqL5DaesbNl34mHalcZREz5Wzy6IKaxoFh5NsR
         UJot+Iegs5bKgQh+bi/JwUZ1wIu4mbw46e/NSOJ/RjHXh6EYhjFQ96EdTALMs61kQFp/
         to2W3F7uFztIGQPbgZ6LyMaccqPZnplMQ6cm3bUYnrDL4Zbu4UmcmWT0ktWtOHW9Q5to
         L9J2R0/BpePrneCB3z0Z58xkDBYGeCZXu0+so1KClINjgCHmT+IVOp9O7cDwk7Q7V+oM
         A6vqoJGZNR3fxkN6YxcMpKcZbUSHPia7gb+84ZK7tdg5id07LZeBWcYk2rWwbmpf6RRL
         +Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386933; x=1782991733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0f7m3I/gyXJngH6U6zNCpZRIgKLq7oekxM/6WhxAAk=;
        b=NQn6vylNLoXwK8lvPo8NbsZ4HND2sz1bIUXRJTdCDdXUvCFrB0zQ95EMlwABeIQe5Q
         41SH/8UMpFnJuJg6DlxuNvY+2Vnlo0K3KxtLqJ7dbLqbkXxQmv2bfuaOsM6ib99yz5w5
         YULk1/OOiNcdxZmIC8bbEoHHKm9sqqloaIztqMi7J0HtzWwZAUpv3s94NIdnGr0Bdlyh
         TbZVxoVIVsynMUoq8+YQyI5Qk3eXiUZsa7lGzxVUghms2xKNePVebgtd615P7Z8NsyJh
         gIonnncrohIz2fUCMFjvT/AbmBBYxUmBwiS2APJL5MZ+WUhuD3+R+CR/jFfevCALDJEc
         Z+PQ==
X-Gm-Message-State: AOJu0YxQ82K8fghpDNx3PD3CyniSx5wS1BsHfpP3XVfMkIsn2r61ZH4j
	mjsqh8xftFJprVC6kSfWiRwAWj8vbAZtpyUtiA4YPj1BjxkaZ8nR05Fql1aLBQ==
X-Gm-Gg: AfdE7ck/m3piynKYUonIwdTALo+hJY8q/zLaoP+Uzc3bLg5KpHwekvWpoxJUWHY6bVU
	cg9nDgJfU9oJbUYtRFzJcrnJDXdTvfzoQBkgkTKx8IFEyKiwikSvH4L2sE9IYmK5Hiz92CNXVCo
	wkqNH1V2LOysdN6+8FTdKZ60HizCrj0KSmL+KGEeRXkLhXTbk7WPFK5fTCCbZhu46GX+7FvBf+U
	6COIhbejAaA9wO6GmrfLMwKdPkRp8+btzkssiN3tj65lbBqU5Nhzl/mJtYM1ne7K7/+i05ILSll
	os3pYoJzimuPB6bGQo7fh7OCl8PDcuQoushhPRMfwAMSebiLwhyjEM29OZACPT5c9qlLE1G6PVk
	BLAVdIWQoJX9Z7y521gCLnE92dIjPZYQbvZmLx7DzR0LbWDyPoR66xdI6mJHLdmaHDtUNwIZT09
	fmnw7ZIShGoYDVt61XNPOvFh/NY5riv0lRiU+mh763uSmZVThTZuJC0u4A9JSGyXAnsG5E
X-Received: by 2002:a05:7300:2310:b0:2ef:8b72:1b9 with SMTP id 5a478bee46e88-30c848a9246mr2577318eec.0.1782386932693;
        Thu, 25 Jun 2026 04:28:52 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:52 -0700 (PDT)
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
Subject: [PATCH v11 17/31] cxl/mem: Enforce tag-group semantics
Date: Thu, 25 Jun 2026 04:04:54 -0700
Message-ID: <20260625112638.550691-18-anisa.su@samsung.com>
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

The previous commit fully-fleshed out validation for individual extents.
This commit completes tag-group validation.

Add two group-level gates to cxl_add_pending() that
cxl_validate_extent()'s per-extent view can't see:

  - Sequence integrity (cxl_check_group_seq): sharability is taken from
    the group's DC partition attribute (cxl_group_is_shareable).

    For a sharable partition, extents have a shared_extn_seq number,
    which must be 0..n-1 for a tag. Any gaps or duplicate values is a
    firmware bug.

    Non-sharable partitions leave the field reserved and are not checked.

  - cxl_check_group_partition: verify tagged allocations
    don't span DC partitions.

Each check drops the whole group on violation.

Tag uniqueness checks land in a subsequent commit.

Based on patches by John Groves.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: John Groves <John@Groves.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
1. Fix sequence number check

Previously, it was assumed that shared extent sequence nums
start at 1, which is wrong. The spec states "For extents
describing shareable regions this field shall be within the range
of 0 to n-1 where n is the number of extents, with each value
appearing only once." Fix to start at 0.

2. Use partition->shareable attribute (from DSMAS flags) as the
source of truth for extent shareability, not sequence num.

Not only was it assumed sequence nums start at 1 for shared extents,
it was also assumed that unshared extents have a sequence num of 0.
So seq num was used to determine if an extent was shareable, which is
wrong.
---
 drivers/cxl/core/core.h   |   4 +
 drivers/cxl/core/extent.c |   2 +-
 drivers/cxl/core/mbox.c   | 168 +++++++++++++++++++++++++++++++++-----
 3 files changed, 154 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2c1df75ebbc5..6ac68f46a18e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -178,6 +178,10 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range);
+const struct cxl_dpa_partition *
+cxl_extent_dc_partition(struct cxl_memdev_state *mds,
+			struct cxl_extent *extent,
+			struct range *ext_range);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 2e770c5279c2..0ebb581ca833 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -82,7 +82,7 @@ alloc_tag_group(struct cxl_dax_region *cxlr_dax, uuid_t *uuid)
  * The returned pointer is owned by mds->cxlds.part[] and lives for the
  * lifetime of the memdev.
  */
-static const struct cxl_dpa_partition *
+const struct cxl_dpa_partition *
 cxl_extent_dc_partition(struct cxl_memdev_state *mds,
 			struct cxl_extent *extent,
 			struct range *ext_range)
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 14ba263044f0..7967b0db2c51 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1362,28 +1362,148 @@ static void drop_extent_group(struct list_head *group)
 }
 
 /*
- * Realize a tag @group: add each extent via cxl_add_extent(), then online
- * the resulting tag group.  Returns the number of accepted extents (>= 0)
- * with @group left holding them for the caller to splice, or a negative
- * errno on failure with @group untouched for the caller to drop.
+ * Validate shared_extn_seq across a tag group from a sharable partition,
+ * already sorted ascending.  Per CXL r4.0 Table 8-230 the device stamps
+ * each extent of an n-extent sharable allocation with a unique value in
+ * 0..n-1, so the sorted group must be exactly 0, 1, ..., n-1.  A gap,
+ * duplicate, or out-of-range value is a device firmware bug.
+ *
+ * Non-sharable partitions leave shared_extn_seq reserved; sharability is
+ * determined by the partition, not the seq value, so there is nothing to
+ * validate here — the caller assigns assembly order by arrival.
+ */
+static int cxl_check_group_seq(struct device *dev,
+			       const uuid_t *tag,
+			       const struct list_head *group,
+			       bool shareable)
+{
+	struct cxl_extent_list_node *pos;
+	u16 expected = 0;
+
+	if (!shareable)
+		return 0;
+
+	list_for_each_entry(pos, group, list) {
+		u16 s = le16_to_cpu(pos->extent->shared_extn_seq);
+
+		if (s != expected) {
+			dev_warn(dev,
+				 "Tag %pUb: sharable shared_extn_seq must be dense 0..n-1: expected %u got %u (firmware bug)\n",
+				 tag, expected, s);
+			return -EINVAL;
+		}
+		expected++;
+	}
+	return 0;
+}
+
+/*
+ * A tag group's sharability is a property of the DC partition holding its
+ * extents (cxl_check_group_partition() separately enforces that the group
+ * does not span partitions).  Resolve it from the first extent; an empty
+ * group or an extent outside any DC partition is treated as non-sharable.
+ */
+static bool cxl_group_is_shareable(struct cxl_memdev_state *mds,
+				   const struct list_head *group)
+{
+	const struct cxl_dpa_partition *part;
+	struct cxl_extent_list_node *first;
+	struct cxl_extent *extent;
+	struct range ext_range;
+
+	if (list_empty(group))
+		return false;
+
+	first = list_first_entry(group, struct cxl_extent_list_node, list);
+	extent = first->extent;
+	ext_range = (struct range) {
+		.start = le64_to_cpu(extent->start_dpa),
+		.end = le64_to_cpu(extent->start_dpa) +
+			le64_to_cpu(extent->length) - 1,
+	};
+	part = cxl_extent_dc_partition(mds, extent, &ext_range);
+	return part && part->shareable;
+}
+
+/*
+ * For tagged groups, reject allocations that span DC partitions.  A tag
+ * is an allocation identity; the partition's CDAT DSMAS entry is what
+ * tells the host which attributes (sharable, writable, coherency)
+ * apply.  Untagged groups are skipped — the spec does not define a
+ * cross-chain identity for them.
+ */
+static int cxl_check_group_partition(struct cxl_memdev_state *mds,
+				     const uuid_t *tag,
+				     const struct list_head *group)
+{
+	struct device *dev = mds->cxlds.dev;
+	const struct cxl_dpa_partition *first_part = NULL;
+	u64 first_dpa = 0;
+	struct cxl_extent_list_node *pos;
+
+	if (uuid_is_null(tag) || list_empty(group))
+		return 0;
+
+	list_for_each_entry(pos, group, list) {
+		struct cxl_extent *extent = pos->extent;
+		struct range ext_range = (struct range) {
+			.start = le64_to_cpu(extent->start_dpa),
+			.end = le64_to_cpu(extent->start_dpa) +
+				le64_to_cpu(extent->length) - 1,
+		};
+		const struct cxl_dpa_partition *part;
+
+		part = cxl_extent_dc_partition(mds, extent, &ext_range);
+		if (!part)
+			return -ENXIO;
+
+		if (!first_part) {
+			first_part = part;
+			first_dpa = ext_range.start;
+			continue;
+		}
+
+		if (part != first_part) {
+			dev_warn(dev,
+				 "Tag %pUb: extents span DC partitions (DPA:%#llx and DPA:%#llx), firmware bug\n",
+				 tag, first_dpa, ext_range.start);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Realize a tag @group: assign each extent its dax-side @seq_num and add it
+ * via cxl_add_extent(), then online the resulting tag group.  Returns the
+ * number of accepted extents (>= 0) with @group left holding them for the
+ * caller to splice, or a negative errno on failure with @group untouched for
+ * the caller to drop.
+ *
+ * A shared extent carries the device-assigned shared_extn_seq (dense 0..n-1).
+ * Non-sharable groups have no meaningful per-extent sequence, so number them
+ * by arrival order.  The counter advances for every member so a failed add
+ * leaves a gap and the partial group is later refused rather than carved.
  */
 static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
-			     struct list_head *group, bool existing)
+			     struct list_head *group, bool shareable,
+			     bool existing)
 {
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_extent_list_node *pos, *tmp;
 	struct cxl_dc_tag_group *tag_group;
 	int group_cnt = 0;
+	u16 seq_num;
 	int rc;
 
+	seq_num = -1;
 	list_for_each_entry_safe(pos, tmp, group, list) {
-		/*
-		 * Pass the device-stamped 0-based shared_extn_seq through
-		 * unchanged as the dax-side @seq_num (0..n-1).
-		 */
-		u16 seq = le16_to_cpu(pos->extent->shared_extn_seq);
+		if (shareable)
+			seq_num = le16_to_cpu(pos->extent->shared_extn_seq);
+		else
+			seq_num++;
 
-		if (cxl_add_extent(mds, pos->extent, seq) < 0) {
+		if (cxl_add_extent(mds, pos->extent, seq_num) < 0) {
 			dev_dbg(dev,
 				"Tag %pUb: failed to add extent DPA:%#llx LEN:%#llx\n",
 				tag,
@@ -1412,15 +1532,22 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 
 /*
  * Validate a tag @group before realizing it.  Returns 0 if the group may be
- * added, or a negative errno if it must be dropped.  Further gates layer in
- * here in later commits.
+ * added, or a negative errno if it must be dropped.
  */
 static int cxl_validate_group(struct cxl_memdev_state *mds, const uuid_t *tag,
-			      struct list_head *group)
+			      struct list_head *group, bool shareable)
 {
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_extent_list_node *pos;
 
+	/* Sequence-number integrity */
+	if (cxl_check_group_seq(dev, tag, group, shareable))
+		return -EINVAL;
+
+	/* Partition equality (skipped for null UUID) */
+	if (cxl_check_group_partition(mds, tag, group))
+		return -EINVAL;
+
 	/* Alignment gate — drop the group if any member fails */
 	list_for_each_entry(pos, group, list) {
 		if (!cxl_extent_dcd_aligned(pos->extent)) {
@@ -1439,9 +1566,10 @@ static int cxl_validate_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 
 /*
  * Drive the pending Add-Capacity records through cxl_realize_group(),
- * grouped by tag.  Per group: extract from pending, stable-sort by
- * shared_extn_seq, validate, realize the group, and on success move it onto
- * the accepted list.
+ * grouped by tag.  Per group: extract from pending; for a sharable partition
+ * stable-sort by the device's shared_extn_seq (non-sharable groups keep
+ * arrival order), validate, then realize the group, moving it onto the
+ * accepted list on success.
  */
 static int cxl_add_pending(struct cxl_memdev_state *mds, bool existing)
 {
@@ -1451,6 +1579,7 @@ static int cxl_add_pending(struct cxl_memdev_state *mds, bool existing)
 
 	while (!list_empty(pending)) {
 		LIST_HEAD(group);
+		bool shareable;
 		uuid_t tag;
 		int cnt;
 
@@ -1466,13 +1595,14 @@ static int cxl_add_pending(struct cxl_memdev_state *mds, bool existing)
 		 * the stable sort maintains arrival order.
 		 */
 		list_sort(NULL, &group, extent_seq_compare);
+		shareable = cxl_group_is_shareable(mds, &group);
 
-		if (cxl_validate_group(mds, &tag, &group)) {
+		if (cxl_validate_group(mds, &tag, &group, shareable)) {
 			drop_extent_group(&group);
 			continue;
 		}
 
-		cnt = cxl_realize_group(mds, &tag, &group, existing);
+		cnt = cxl_realize_group(mds, &tag, &group, shareable, existing);
 		if (cnt < 0) {
 			drop_extent_group(&group);
 			continue;
-- 
2.43.0

