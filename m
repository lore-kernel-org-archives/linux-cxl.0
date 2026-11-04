Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833389;
	b=1EQD2bqMGnTvy95mgMN25YBAdUlnrQMkCjqBM2rOX0tY5nKSIRsJYlvVpqf+8d99m/71
	 wEEvfRWzrYez+pxfSrhT+7hQO+4XG90QjisjrsLwzKYFptZ1EYrkM4TH1Xn8YS09FRWu5
	 gw21VP+9ftG7yvYvR5gjOlGjDDxzL2PmIrXQeAt9ytgHQd4+sSOe0mbI4eXONCYvbsT9N
	 w2qfywEpWVfQBR6sVHcOBXSz3MKelnCCl/toL7nCupuRkd21EdB8shsXmglEYVJNmKKIG
	 VGdn1mZ6S8/aLmmNvYkojK6/6hjHnbj3Rl2WfoJZid2XrSjI6hIcSjIFworafWhWUug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TKJiDQjGTDS1Uu5JbaoMuAR/igqtqnQjf6ylYCVp2S0=;
	b=DWuhC3s8s8BZiU8io0bqqg6siq3LUg0TNgVh7ZuqWhN84nsb3DPviNKjzADvijwIscdJ
	 YthWnThy5JECPG6GOkvCn2A+A2XwQSqVmaj0+bpJJJ2vTbhySps3UQRTbLmqoPvJQyj3L
	 Xx/g+HPLOfOEiojlW42FZRJfrGhEksnhbzz/dyBrn3uE9oI0HgCa3kKvxdytFCG8aADeK
	 tcFhbLxj5TS2S1i6KQHDmeqX2cn272fRCjBuaFEbAvof0PJrBB/kIVk4YkFOOLKODguSX
	 qi7sIRD8iKPdwwA54k824jQeiC/Gp71M/poAdbtKLZQIx9v8T3vxnSTsOJzNGko81ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Te5SdTM4;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82656606D82C
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82656606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Te5SdTM4
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e946155442so11283295ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833388; x=1794438188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKJiDQjGTDS1Uu5JbaoMuAR/igqtqnQjf6ylYCVp2S0=;
        b=Te5SdTM4e+g9I7egjibGqTqmJAcmo9jhz1Hj68ABXVlHmt7qWdd7X6gzfIad3LKhSH
         SSXGTxWvDDqJuIlfjna9RnhwPeGyy75DNDYJNQfE7OKhTHsgCTL7un6uDYChg8BTLmph
         Mth9e6utcz4IPmwDLS8p82gVcGuH6W6mwkmB2uu//HTVoRTNlNTEzgDumKev75YlGTWi
         WQ9k9hxSSOZotyVmr+KGCT5rDJtDWKweksNUbN53/8Vg3IpZKRQek8zV3VUgm8QQUewN
         rVwoOJGsm/Oj9vbnoANdw1ieh1lHgiMTJ5Ls4m1VtYTu2kgnf0dzntJ/UAsZhIyLsT07
         fiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833388; x=1794438188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKJiDQjGTDS1Uu5JbaoMuAR/igqtqnQjf6ylYCVp2S0=;
        b=bHWTxnONEGzzzjkA5TWO7g0Gl4fgNYgPlwibPB4eQNJq7NVtRsD4m5mcbQiWDvFX4b
         1U2dh8cYxgzvvreCyeJCp7bE0Z9qdFkynV1xCmSI/uaO4DHdxnrZ0/sSfuJ8fxRHVobq
         pVHK3NbMaNXZ4SOIMC5UT2FXZZkyp8ojIFzMtrNaqCMWhYIEDLl2sIlkEiN6lPel3ULV
         F168EKReRZ7icHI1lnDSpv+QvjsgPbOBVuVIzVlQ5g3IoSSsvRF6QLQn9vqbWiOEZXZJ
         0kG0Xb+FuVzG6b/ER5vDI0RFle4ztBkcEZqXGBpWVuPyZ1ZjK2PefwoRW5imoOcM62ip
         EHsQ==
X-Gm-Message-State: APuU4Z+qUO1Tm2B6T6BH7XYeNiH6y2Z72S7koNk1SnzCeNb6CZPGEOAN
	q5e46EviRzuJTV9gj6HXhAbD+mWdVtRwvGhehoCQXSvqbdGVa45jkWaYbwPJaH2e
X-Gm-Gg: AYBFou0OYq6t5UFjF3EBCpTqYW7VS2nTL0nyAHAHOnavksMgkvGaA52ta1NmXjaDNWD
	AXrKk9rZ+gHnCcXLVGWfykxVLJwQ3yS5f6NFzvM+IneIlcSJ1M10B0LI9xE0iq9m+aBGh+onNaV
	LO0PCNfiTl350Bca/Bim4GDidDsxcUIHNILbwRsnw3SJzgOB6e4Po0ivwTno6WQci+hbV+16ZeS
	rvx0GvLDke66Lv/TODKgRTObPlpbIZzr7fRJGya83609568RxisT0tMAfAF98MeU5L4EH9sRxnX
	yek0YXhuXpV72a1MaXHEGmJ7aFHRcQaBWLk9/CKC9H3xBYXdh8jUSGRfEDihijFYZ7J6VmImrBf
	HTBXYlsUQlklQefRafRaEaVVi7wLIPiolGqxPdmyb1iluCwfSAs3CTmVRB1Suy/N0wm8adLe2G6
	PyHNGU83MBr0XIle1uozfC5ETdDDfsV39Hst4rPigN/l1t2CQpAgjf3nPli+mysWJqoJDPw9Qji
	t/kx8R3RQbFxgHTIt/8dZIgIj41jnU+DpyMUn3176fEB9XkeygMy3rVUOlUyg6IP4muKtLa/z8f
	2fgs+72Idg0e30NAF3UGCnN+jQZUe4Y=
X-Received: by 2002:a17:902:d2c9:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2eb3641505dmr171641505ad.1.1793833387921;
        Wed, 04 Nov 2026 15:03:07 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:03:07 -0800 (PST)
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
Subject: [PATCH v1 11/14] cxl/extent: Handle DC Release Capacity events
Date: Thu,  5 Nov 2026 08:02:35 +0900
Message-ID: <20261104230445.66625-12-anisa.su@samsung.com>
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
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Replace the ack-all stub for Release Capacity chains with the real
teardown.

Similar to add capacity events, Release Capacity records arrive as a
More-chain and are staged in mds->dc_chain until the chain closes;
a chain whose closing record never arrives is dropped by the 20s
watchdog without a response.

A tag group is one logical allocation, so a well-behaved fabric manager
is expected to release all members of a tag group together.  However,
CXL r4.0 Section 8.2.10.9.9.4 permits the host to issue an "unsolicited
release" of extents not corresponding to any event.  So as a generous
policy, the kernel releases all members of a tag group upon receiving a
Release Capacity record containing any member of the group.

Extents are matched to what the host owns by DPA range and tag.  An
extent not matching any host-owned extent is acknowledged for release
so the device knows the host is not using it.  An extent that overlaps
owned capacity without matching any host-owned extent by tag and DPA is
left out of the response so the device keeps the capacity for the host
and must retry.

Extents are not usable until exposed through DAX.  The DAX series that
adds that capability also adds the check that an extent is not in use
before it is released.

Everything a chain releases is acknowledged in the Release Dynamic
Capacity response (opcode 4803h), split across several commands chained
with the More flag when the extent list outgrows the mailbox payload.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: John Groves <John@Groves.net>
Signed-off-by: John Groves <John@Groves.net>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
---
 drivers/cxl/core/core.h   |  21 ++++++++
 drivers/cxl/core/extent.c | 103 +++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c   | 109 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 229 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index b7f8886db498..f0edd0100c72 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -79,6 +79,11 @@ void kill_regions(struct cxl_root_decoder *cxlrd);
 
 int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
 		   u16 seq_num);
+int cxl_resolve_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
+		       struct cxl_region **cxlrp,
+		       struct cxl_dc_tag_group **groupp);
+int cxl_release_tag_group(struct cxl_region *cxlr,
+			  struct cxl_dc_tag_group *group);
 bool cxl_tag_already_committed(const uuid_t *tag);
 int online_tag_group(struct cxl_dc_tag_group *group);
 bool rm_tag_group(struct cxl_dc_tag_group *group);
@@ -101,6 +106,22 @@ static inline int cxl_add_extent(struct cxl_memdev_state *mds,
 	return -ENXIO;
 }
 
+static inline int cxl_resolve_extent(struct cxl_memdev_state *mds,
+				     struct cxl_extent *extent,
+				     struct cxl_region **cxlrp,
+				     struct cxl_dc_tag_group **groupp)
+{
+	*cxlrp = NULL;
+	*groupp = NULL;
+	return -ENXIO;
+}
+
+static inline int cxl_release_tag_group(struct cxl_region *cxlr,
+					struct cxl_dc_tag_group *group)
+{
+	return -ENXIO;
+}
+
 static inline int online_tag_group(struct cxl_dc_tag_group *group)
 {
 	return 0;
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 4a59db823af4..1873a3dfe8e0 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -449,6 +449,109 @@ int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
 	return cxlr_add_extent(mds, cxlr_dax, dc_extent);
 }
 
+/**
+ * cxl_resolve_extent() - locate the tag group a released extent belongs to
+ * @mds: memdev state
+ * @extent: extent from a DC Release-Capacity record
+ * @cxlrp: returns the region owning the group
+ * @groupp: returns the matching tag group
+ *
+ * Pure lookup, no side effects.  A record names the dc_extent that contains
+ * its range: the host cannot split an extent.
+ *
+ * Return: 0 when @extent matches an extent the host owns.  -ENXIO when the
+ * extent doesn't match anything on the host (no region, no dax region, or a
+ * range that has no overlap with host-owned extents), so the release can
+ * simply be acknowledged.  -EINVAL when it overlaps owned capacity without
+ * matching any single host-owned extent: it straddles multiple extents, or
+ * the tag doesn't match.
+ */
+int cxl_resolve_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
+		       struct cxl_region **cxlrp,
+		       struct cxl_dc_tag_group **groupp)
+{
+	u64 start_dpa = le64_to_cpu(extent->start_dpa);
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dax_region *cxlr_dax;
+	struct dc_extent *dc_extent;
+	struct cxl_region *cxlr;
+	struct range dpa_range;
+	unsigned long idx;
+	uuid_t tag;
+
+	*cxlrp = NULL;
+	*groupp = NULL;
+
+	dpa_range = (struct range) {
+		.start = start_dpa,
+		.end = start_dpa + le64_to_cpu(extent->length) - 1,
+	};
+
+	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
+	if (!cxlr)
+		return -ENXIO;
+
+	cxlr_dax = cxlr->cxlr_dax;
+	if (!cxlr_dax)
+		return -ENXIO;
+
+	import_uuid(&tag, extent->uuid);
+
+	/* RCU keeps entries live during the walk; teardown happens later. */
+	scoped_guard(rcu) {
+		xa_for_each(&cxlr_dax->dc_extents, idx, dc_extent) {
+			if (dc_extent->cxled != cxled)
+				continue;
+			if (!range_overlaps(&dc_extent->dpa_range, &dpa_range))
+				continue;
+			if (!range_contains(&dc_extent->dpa_range, &dpa_range))
+				return -EINVAL;
+			if (!uuid_equal(&dc_extent->group->uuid, &tag))
+				return -EINVAL;
+			*cxlrp = cxlr;
+			*groupp = dc_extent->group;
+			return 0;
+		}
+	}
+	return -ENXIO;
+}
+
+/**
+ * cxl_release_tag_group() - tear a tag group down for a device release
+ * @cxlr: region owning the group
+ * @group: the group to release
+ *
+ * The caller acknowledges the group to the device as a whole; the group is
+ * dropped without a Release DC of its own.
+ *
+ * Return: 0 when the group is gone, negative when the caller must leave it
+ * intact and let the device retry.
+ */
+int cxl_release_tag_group(struct cxl_region *cxlr,
+			  struct cxl_dc_tag_group *group)
+{
+	int rc;
+
+	/*
+	 * Invalidate CPU caches for the region before releasing the capacity
+	 * back to the device so it cannot reassign the range while stale
+	 * cached data lingers.  On failure do not release: leave the tag
+	 * group intact and let the device retry.
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * An unbinding dax region has already collected the group's devres
+	 * teardown; let that finish the release rather than race it.
+	 */
+	if (!rm_tag_group(group))
+		return -EBUSY;
+	return 0;
+}
+
 /* The group's device may already be visible: readers walk the xarray under RCU */
 static void cleanup_pending_dc_extent(struct dc_extent *dc_extent)
 {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0fa501f5800c..c3236fe9e7c5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1747,6 +1747,109 @@ static int cxl_add_pending(struct cxl_memdev_state *mds,
 				    pending, total_accepted);
 }
 
+/*
+ * Tear @group down and queue every member on @acks.  Members are queued
+ * before rm_tag_group() frees them; on failure nothing is queued and the
+ * group stays intact for the device to retry.  Returns the number queued.
+ */
+static int cxl_release_group(struct cxl_region *cxlr,
+			     struct cxl_dc_tag_group *group,
+			     struct list_head *acks)
+{
+	LIST_HEAD(members);
+	int cnt, rc;
+
+	cnt = stage_group_release(group, &members);
+	if (cnt < 0)
+		return cnt;
+
+	rc = cxl_release_tag_group(cxlr, group);
+	if (rc) {
+		drop_extent_group(&members);
+		return rc;
+	}
+
+	list_splice_tail(&members, acks);
+	return cnt;
+}
+
+/*
+ * Flush a staged Release chain.
+ *
+ * A tag group is one logical allocation: naming any extent of a group
+ * releases the whole group, and members the chain did not name go back as
+ * an unsolicited release (CXL r4.0 9.13.3).  Each extent is decided on its
+ * own, so a group that refuses teardown, or an extent that overlaps owned
+ * capacity without naming an owned extent, is held for the device to retry
+ * while the rest proceed.  Extents the host is not tracking at all (no
+ * region, no dax region, or nothing owned in range) hold no capacity here
+ * and are acknowledged as named.
+ *
+ * Everything released is acknowledged together in the Release DC response
+ * once the chain is flushed (split across More-chained commands when the
+ * list outgrows the mailbox payload), so a sharable tag is always returned
+ * whole (CXL r4.0 8.2.10.9.9.4).
+ */
+static int cxl_rm_pending(struct cxl_memdev_state *mds)
+{
+	struct list_head *pending = &mds->dc_chain.pending_extents;
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_extent_list_node *pos, *tmp;
+	LIST_HEAD(acks);
+	int cnt = 0, rc;
+
+	/* cxl_resolve_extent() -> cxl_dpa_to_region() walks every decoder's dpa_res */
+	guard(rwsem_read)(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	/* Untracked first, before a teardown below makes a sibling look untracked */
+	list_for_each_entry_safe(pos, tmp, pending, list) {
+		struct cxl_dc_tag_group *group;
+		struct cxl_region *cxlr;
+
+		if (cxl_resolve_extent(mds, pos->extent, &cxlr, &group) != -ENXIO)
+			continue;
+		list_move_tail(&pos->list, &acks);
+		cnt++;
+	}
+
+	list_for_each_entry(pos, pending, list) {
+		struct cxl_dc_tag_group *group;
+		struct cxl_region *cxlr;
+		struct range r;
+
+		rc = cxl_resolve_extent(mds, pos->extent, &cxlr, &group);
+		if (rc == -ENXIO)	/* sibling of a group released above */
+			continue;
+		if (rc) {
+			r.start = le64_to_cpu(pos->extent->start_dpa);
+			r.end = r.start + le64_to_cpu(pos->extent->length) - 1;
+			dev_warn_ratelimited(dev,
+					     "DC release %pra (%pUb) names no owned extent; holding for retry\n",
+					     &r, pos->extent->uuid);
+			continue;
+		}
+
+		rc = cxl_release_group(cxlr, group, &acks);
+		if (rc < 0) {
+			dev_dbg(dev, "DC release of tag %pUb deferred: %d\n",
+				&group->uuid, rc);
+			continue;
+		}
+		cnt += rc;
+	}
+
+	/* Updated Extent List Size shall be > 0 (CXL r4.0 Table 8-352) */
+	rc = 0;
+	if (cnt)
+		rc = cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC, &acks,
+					  cnt);
+
+	/* The caller frees @pending; hand the acknowledged entries back */
+	list_splice(&acks, pending);
+	return rc;
+}
+
 static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
 				  struct cxl_event_dcd *event)
 {
@@ -1793,10 +1896,8 @@ static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
 
 	if (event->event_type == DCD_ADD_CAPACITY)
 		rc = cxl_add_pending(mds, &chain->pending_extents);
-	else	/* Nothing is tracked yet: acknowledge every release */
-		rc = cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC,
-					  &chain->pending_extents,
-					  list_count_nodes(&chain->pending_extents));
+	else
+		rc = cxl_rm_pending(mds);
 	clear_pending_extents(mds);
 	return rc;
 }
-- 
2.43.0

