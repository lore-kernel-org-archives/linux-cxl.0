Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833382;
	b=GXPxbgwQaSaP3B9h55V3v9SfLtO0ffJMMHZZOu/eQ/P94WnVTShaA69mQR9WmfcRgHdX
	 MdvCBUPPzKGksULKEgP4u09QCI7a22vC9ExmpQuh2N0g5TXenY1agwJ8t77z12SdTQRlI
	 iuKMRe+QvHJwS74vYozvpiFyZRES0guLcQNnZXIK42Lfh9tBEViX8cbnVx1xHXrm2a6+c
	 5BCwtPYZuZigk+RPLvZaxsQmeCODSS5abWafd3orp1PscOgVJsiUCZ4LsapYjdkNFRUYZ
	 rmuYtO+1ptQ+9GXaBoS2IYp8jpRXrmm/AVAKld99qLKYy9g4RoQJ/bWxPtMpBEscIHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mt4NXnFUgai2Xnc1lF4x0zhTMSSIiHVRUW1YIB9DFa0=;
	b=Dq/kt9Z3vTT6i6OfPr8PFFs3wiwboBDblFpM2PX3+OATuB38ZmbsrqxoPhH/dvAfK/qz
	 LxPXup1O7ZYB0nTchlLGdETQYK46IHBu3/r6OACOLIo77L8ISujZHcRoBYDo8hE1gNTqB
	 JoN1//WPNwhNWU0R5d1CBJMOflEFOAw0EUV0MlS5UOPC6XhXzoobawkzbOrrNdChRJg/0
	 pOoHlzYfNlA3uO7QM9/fj0ZBOQ5bpho03W7AJhYEg5AYogbdGzWeaINNce2hse+MHhiM6
	 UEv+hjheh9Q36M2V8i3Z2FYwOupLLzesTbL3GVUO0LDq3RtXJL8rOEC8bDt9oXw29Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cxdpbMGE;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CD6083607
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C7CD6083607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cxdpbMGE
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987b4a710so394745ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833381; x=1794438181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mt4NXnFUgai2Xnc1lF4x0zhTMSSIiHVRUW1YIB9DFa0=;
        b=cxdpbMGE5AVjDZ+LSBz4D3dibrk9J77OyybgnH3wFb2qdZDq9u63NlpvXkIJ0UgY1z
         cd7BhGLs3MRiZQxvoldeao0bOXTYCeB6mGnrAU84PS4KD0pShDEXWR6vjTMVk33PtogQ
         zUcizm8zwXxg+RFYxG3w+Dhv5oPkCGNqfLTKysRJRrvwYsUc1hiKvNFzg1+tk1hplP9A
         f+9EUMSuuuQrQ/G0hTVi+9qpfbB4yPsVqkCXPojoMtfNKF57c5Q8svJblEJ5Rd5TUDci
         Vvtj/gM5UE9XWnF8KOGx7Lq7nbgrFSxM1j7RBkpBHfmJOdQXAkeyTlWvf4DeWZ6j1VQ5
         oYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833381; x=1794438181;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mt4NXnFUgai2Xnc1lF4x0zhTMSSIiHVRUW1YIB9DFa0=;
        b=HtIXidB7LlYuPlQv1AbYCzaiOjeieghYcoSbzMku08uI96j5rogm2gAsyefrpBQ244
         4/r+X0TauD/T7o/aRVp16sapNBE24OMbEwTEHNY1iYrF0L+4S+kX6Y/N+gNwoIiQEEl6
         BEBJsFO3HeOtWg1++ko3hsukc43GPRFXGunTvP/R1nzdCrSjB0R2Yy5d/ry5Xjzmtwln
         W9zMGCyourE/S1yzB0kYYuwljuBWy7ncCQmi33qPHppSET1Jzgm8ZXPRqVaUtJ6TOQUO
         RMmmMRWU7WaXzGcTL8s6psigRNKJq3SkiGS1B+SlfAoVjcA49VEiOUU8Y/7M1SHOtMDc
         1ydA==
X-Gm-Message-State: APuU4Z9lyshdVb+FrL7gdCwRSV/JgoWxAhAYuddAGVHIneHxsuGQEr5F
	GRpcPdvZ41s6h6t3LgccfBkRS+AfhKVUwtJhuicj1dSVjALkNOl57538VfZRg+08
X-Gm-Gg: AYBFou37ezOWUZ9DnUWxVRJcsBmwihWanpsINL9YJRTK5ZXY25sd+alkuAt+jVQoPni
	p44yF3aA0boys9dUvPxc1cPqYxxbXxa6YVJplif1J3BuMuA4D+FvqXIbolvW/MtH4CZJKSsT3J8
	0jPXxoESKh7llMqw+xjAJ2fxFIjAlSRcrNkc1SCokZ3pEzPgghqYzrFENAJ0i94Oy9qqWnI3LbA
	HqpxO/4vIEFEFLMwKGZUn3emNkVkQsAz1i5WVyAe7GDOBM5ixlc5NWdTW1LdIi9R03J64LnX3fn
	Q2j3wSFNg8sANUe4oxMFruAN/Du85fIAZ0X/qvsRbnwjS7ew5Dy5dvmLOzI6BjKb5MkhGywsMDn
	icYm1Ol9hJE7+RQXIYf5vt1y5mKj/wat+exf4Pzm2d/QRx8rTmRdvZcZ5k4spVPdbzaFFinIIyw
	QDtS9ifwqV/RMpSvJIFAJiBGRInE0KhwpW64KF/HXS5Do+xZxryHRSbDNi+IDeeU45geP7vnMGG
	J7fAMFtqwz9QEZsh7g4jhFHvZe/XcdRpN4iHFnjUZJuHxnU5S9taZxAfSI7S5Wc8rpfZNYGrpkt
	3AMKbwNeJ1jSJxP/XT9oDrWWk4BatyzQWJ0IInjrfPHnz/EZ0Tw=
X-Received: by 2002:a17:902:ce02:b0:2e6:2023:29fb with SMTP id d9443c01a7336-2ed244dcbe3mr5438885ad.29.1793833381225;
        Wed, 04 Nov 2026 15:03:01 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:03:00 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v1 09/14] cxl/mem: Enforce tag-group semantics
Date: Thu,  5 Nov 2026 08:02:33 +0900
Message-ID: <20261104230445.66625-10-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous commits added validation for individual extents.  Add
two group-level checks to cxl_validate_group():

  - Sequence integrity (cxl_check_group_seq): sharability is taken from
    the group's DC partition attribute (cxl_group_is_shareable).

    For a sharable partition, extents have a shared_extn_seq number,
    which must be 0..n-1 for a tag. Any gaps or duplicate values are an
    error.

    The field is reserved for non-sharable extents, and
    cxl_validate_extent() rejects a non-zero value there when the group
    is realized.  Therefore, cxl_check_group_seq only applies to
    sharable groups.

  - cxl_check_group_partition: verify tagged allocations
    don't span DC partitions.

Each check drops the whole group on violation.

Tag uniqueness checks land in a subsequent commit.

Based on patches by John Groves.

Co-developed-by: John Groves <John@Groves.net>
Signed-off-by: John Groves <John@Groves.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
---
 drivers/cxl/core/mbox.c | 138 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a605ffc4c64f..a1d3e04a1e1b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1452,6 +1452,119 @@ static void extract_tag_group(struct list_head *pending,
 	}
 }
 
+/*
+ * Validate shared_extn_seq across a tag group from a sharable partition,
+ * already sorted ascending.  Per CXL r4.0 Table 8-230 the device stamps
+ * each extent of an n-extent sharable allocation with a unique value in
+ * 0..n-1, so the sorted group must be exactly 0, 1, ..., n-1.  A gap,
+ * duplicate, or out-of-range value is a device firmware bug.
+ *
+ * Non-sharable extents must carry 0 here, which cxl_validate_extent()
+ * enforces per extent when the group is realized, so only sharable
+ * groups are checked; sharability comes from the partition, not the
+ * seq value.
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
+			dev_warn_ratelimited(dev,
+					     "Tag %pUb: sharable shared_extn_seq must be dense 0..n-1: expected %u got %u (firmware bug)\n",
+					     tag, expected, s);
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
+			dev_warn_ratelimited(dev,
+					     "Tag %pUb: extents span DC partitions (DPA:%#llx and DPA:%#llx), firmware bug\n",
+					     tag, first_dpa, ext_range.start);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /*
  * Realize a tag @group: assign each extent its dax-side @seq_num and add it
  * via cxl_add_extent(), then online the resulting tag group.  Returns the
@@ -1460,7 +1573,7 @@ static void extract_tag_group(struct list_head *pending,
  * the caller to drop.
  */
 static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
-			     struct list_head *group)
+			     struct list_head *group, bool shareable)
 {
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_extent_list_node *pos;
@@ -1475,7 +1588,12 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 	/* Each extent gets a dense dax-side seq_num, 0..n-1 */
 	seq_num = -1;
 	list_for_each_entry(pos, group, list) {
-		seq_num++;
+		/* Sharable: device-assigned dense 0..n-1; otherwise by arrival */
+		if (shareable)
+			seq_num = le16_to_cpu(pos->extent->shared_extn_seq);
+		else
+			seq_num++;
+
 		rc = cxl_add_extent(mds, pos->extent, seq_num);
 		if (rc < 0) {
 			dev_dbg(dev,
@@ -1517,11 +1635,19 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
  * added, or a negative errno if it must be dropped.
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
@@ -1559,6 +1685,7 @@ static int cxl_add_pending(struct cxl_memdev_state *mds,
 	while (!list_empty(pending)) {
 		struct cxl_extent_list_node *first;
 		LIST_HEAD(group);
+		bool shareable;
 		uuid_t tag;
 		int cnt;
 
@@ -1581,13 +1708,14 @@ static int cxl_add_pending(struct cxl_memdev_state *mds,
 		 * the stable sort maintains arrival order.
 		 */
 		list_sort(NULL, &group, extent_seq_compare);
+		shareable = cxl_group_is_shareable(mds, &group);
 
-		if (cxl_validate_group(mds, &tag, &group)) {
+		if (cxl_validate_group(mds, &tag, &group, shareable)) {
 			drop_extent_group(&group);
 			continue;
 		}
 
-		cnt = cxl_realize_group(mds, &tag, &group);
+		cnt = cxl_realize_group(mds, &tag, &group, shareable);
 		if (cnt < 0) {
 			drop_extent_group(&group);
 			continue;
-- 
2.43.0

