Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE347A0A7
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576112; cv=none; b=FVkJTXCFZ1mC2Nj4jS6WUgAvkEwKqbIkjpasZ3w3Hm5zV8oXMx/t+1uNhVt8THCle+UnV+WvKTRStne8LB4mMQqkPzm07st0hWKyzGoFLfGS1X2PZAv33MmOW86kx7NHATZa61pm44kneHWv4hzgXMe7OezQvEp8McsZAdv7F7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576112; c=relaxed/simple;
	bh=w0eKiY4I5uQufyW64Owv7K7jj+Cw2kBSZ0H/fUn8aTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSZleRY5hscmOfXU+4czDjuzHho+hEMS67Yfhy35lHMhtcIydwl5IcaN+IRsS4C7gtH4dER1IdfVSB4095OHsEvVfID9rtdpsA21i1xI7ilHk7uWYwZm+ZmQmMDRNNcregC9aTHv9phkNjxEopGGfILsgVRhQsD9gPO4Ye7RWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cweaukzy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cweaukzy"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5c9211d2so926775985a.1
        for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576107; x=1785180907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbvY/gXh+2/u61eyWpGKI13cVvWaG4WQkB8wV0sMVYg=;
        b=cweaukzy0xSkEdWhxhls4M00xcE3RdBAkeV+RCtuuVZxeneDh3Lj5w8ubJO/Zrwmrl
         Nln1/CsNKB3whOnU0gxZ+UN+TowVz1+VyoBzRmPx71CReyduVjO8hRWd+ix+3AG25bCd
         Jo4l2RfJyskjI16bDjfDvujp/h3XGJmZwJUCOc4ssvpFAg6+yqWRNpIz54cZxcAEk1Ss
         tqiTLiQttYsOCn1T6APRUcDBYv8WeBG8oj+dTrbYpE4Hcqo98s9Wx0IRMYUFPfOVfa4X
         +r58eMj9l4k5hmuOCFsUm+kzKS2qaNwm/AGbvQC/IXrDAJlkiVxlWATNJk7i9QyP3kDL
         x6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576107; x=1785180907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbvY/gXh+2/u61eyWpGKI13cVvWaG4WQkB8wV0sMVYg=;
        b=Mw03M1meV1vAd0pvB8dM98rb81oM3vii1huv68LuqzFOIsPed49Rf2cgdfye0p9w7Z
         apqnBI8pChuWrej8kjxna3WiE68r+iDbyUdr6tFLPySH/A51RaM6INgh/F61HHM7xlay
         Bpcy403TQ/czERVeeO3iYJdeT6mRjap/i4LtfkvkeLX4i/WyVBOpgys7eiWT1AmJ6Xap
         OBp9UB2J+ePU/G39AbMUGXDrS2OXcjUcbujSDdfWw+s0T156ZguncAKMrQl6DF9BoICF
         8xaQkHU0I4SwxPNkdYhjoA2BIOzmwySNtHnftmJj5kQ3MosApfYfWY3F8Wbx8/MjYIcp
         GqiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUksvZBDIrP/6Exr9GkaFCEeT8uppveOM9TZ+0+rVISnSgV6swJWif7RGFKCVpSmGDwRIdigjkih8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZdcB0vtF0ECJKx2a9PrHux541btaoUNqf9yrKriS4094e+7l
	xcZl9Ldh2npDKFVa991iLYaIqKiI1uzwzYg1iQll+qefSjy2CVts2lI4V8C8ZXDyH4Q=
X-Gm-Gg: AfdE7clyTLdnfVEjRdJmL1zPBIwsBKhEMXIWecMYJ6FCGj3wQRZZ2LkLiFBxwvI+EmX
	+2y1Hf7vLyNdMLv6tC48dlyWc1LOm0o2h5nja2lbsxhg33pxVeHU80Z4u+jp9Ap6AaA8XRg1I68
	JTOTZLdsHkHPKSVf9V9ey0ysick4HNiqzBGP63zFZImWEIqxqbOtrjsrZipGIg3a9J/KRML9ii9
	0m7xD6U+mwod2UrWEW0sr84BEw/yOXPmAtDCCm2eOoyBvUYQCdnqERbrTt19gVjWjOae4uVDiUH
	A4fxBXAfx55ELws5tUe8ET72NNU64esuTobFgmXKK3ibNL/bJ7n9ec5pHkFlRH94Hmnf2YJi7y3
	T51TEQsatIZcMRzG9I7ZBKO/JGW6Y0DPItVvpy6QS3y5UMuihyv+w99tGGhlikws9jEt1AWIOKK
	qp/5m3HTzZzDD5iqArwiLxDyrjF8MnU016fIIFN8B3SCD6Mp9OV6h+lMSBugqZ+eU=
X-Received: by 2002:a05:620a:44c2:b0:92e:6b95:237a with SMTP id af79cd13be357-930b3f45487mr1592960485a.32.1784576106925;
        Mon, 20 Jul 2026 12:35:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:06 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 11/36] mm/compaction: disallow compaction on private nodes
Date: Mon, 20 Jul 2026 15:34:05 -0400
Message-ID: <20260720193431.3841992-12-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip compaction on private nodes. Compaction requires the ability to
migrate pages, which is not yet supported on private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/compaction.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9f81055a358ed..8c1351cce7bcc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2462,6 +2462,9 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		    !__cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 
+		if (node_is_private(zone_to_nid(zone)))
+			continue;
+
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
@@ -2853,6 +2856,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			!__cpuset_zone_allowed(zone, gfp_mask))
 				continue;
 
+		if (node_is_private(zone_to_nid(zone)))
+			continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
@@ -2922,6 +2928,9 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 		.proactive_compaction = proactive,
 	};
 
+	if (node_is_private(pgdat->node_id))
+		return 0;
+
 	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
 		if (!populated_zone(zone))
@@ -3017,6 +3026,9 @@ static ssize_t compact_store(struct device *dev,
 {
 	int nid = dev->id;
 
+	if (node_is_private(nid))
+		return -EINVAL;
+
 	if (nid >= 0 && nid < nr_node_ids && node_online(nid)) {
 		/* Flush pending updates to the LRU lists */
 		lru_add_drain_all();
-- 
2.53.0-Meta

