Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38F3F54C4
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371815; cv=none; b=GvVcvz77TM2IJWtiEV0LP0+JQHyBzwCJfnCP3IJVQYpQBQUHf7hq9zoEJDTggGZSt4nQsmkybzyLG+IjxqYH2gSKUXtAgm4oaTzZUnWJZYjL8ze4eqI5UJ2y1DAFeFWHwSBxmyqlcvR5gMV8yFMETmkAQFGVkUST/esXgkGTNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371815; c=relaxed/simple;
	bh=fBmxLV6HXxFNCdbssUFGk+HfbStZpc+fHwBbY31qTEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqY0Qd9wRG0Vvz7nS3o9ALqFhl25xI+i38NGKjK9KTSUpLT7hzR2gMM6qnwByQYoh62ej8qH2iMeLKa+AIF1JdSLzO2ymN4YOK3LZ23DIYXL3pOK0Cwt7Z72u+6a3+yQK+CEflpEOxS7S//uPg1NMg2mhmaZceaE08eOHLB/+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffW/W1ar; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffW/W1ar"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso852497b3a.2
        for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789371814; x=1789976614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYJD7VTts/AH4L8FmbbSGUiWjAUaPCR6VveqwEnLy7U=;
        b=ffW/W1ardLkAqFhf8jmapRsAmUOA78R6fUv2M53ajoAzJ7XBoBL6pmj4/20Uqcoud4
         pazvA9NX2uqpTz9jDRaK7YBZYzcaMx8IZbzPL/vqqbwgKqSqfT58kocfv6RYr7PUxs99
         fkwdESK/eLEkMy6EoQzkBXmoi6zlqINOXntDheU/gHSzPxdAe1fAm4SHA7pOWltM9ov+
         Xqkzj3C+GsBQvuwdiFx25qub+I92PPTsrOMwbOFEqtxGq6w0mkU27WsjxKXbKmSqWnsa
         NGHcN9EHwNDQYvdMqySbnNg+47jKU5bqYy3wY2G2v5ztLKcD9nh7f4QQorITYFPOuK+/
         zOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789371814; x=1789976614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYJD7VTts/AH4L8FmbbSGUiWjAUaPCR6VveqwEnLy7U=;
        b=IKyf/OxVwh53llsFdbzQwCN8+r3u5b/7VBVUaCHZiZSX1G9PUxtCaPptgDVjpss/gV
         VfMLh2SCiUNdjuP22La+RzDYb9vNCTlv6s+KqSCWn8uhltZpnGwPwZbZ0F3UUuAJ1y/C
         8fRcBnDp4wsZMlUO4NJOrH+eu/HBlnGQrENl94iuu6YsY0cooo6pxSf7kqPfkmLzqAEy
         fy6fzDWnqZjOy/gCsWQGy7P4UozOC47+yAgW73PjWnD9zQMBptj2Y0hZ6oeXxLPgZEH0
         1qjOjkUouGzuEuY4MiSzxl4V5QkIfoxXwJEud/OaHq6Xg4N6yZhkVNz4gsxF9ajsSiPw
         3NdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMoxR1fdPhLtziUc4/uFyZJtpmimLWncbfp6VJEJx0WqrmQ/G0U5zvd0Du26XjkGpv7WjjKdyiylo=@vger.kernel.org
X-Gm-Message-State: AFuF++mJySYAZ24gAlbPnJwrULoHtAZZJ//rrt7gXCDc1t/qvPrpnn+D
	5+TWNA6tWDRfa/MqjQSo62uy69SM5S3uQPXLIhtzbymIvc2KsPC7BV4B
X-Gm-Gg: AYBFou31ypSvnuglQiH/V5QcHXHZDHtZnoHnhUn1i+YDMguygFuYQoJp+TBXJmvFULc
	MC/9RV+PoaUMNKtY7jtRni4IW3iWltP3MzX3+IvLi3ufkxD7/6MD0s1U0lAzr4hhzCnfmHNSsUT
	8xfh3Q9v+uNZ6AKotwAK1O6TtER8bnKAq/VTX56SSButqT3tQU0WFB4JTe3TKwlStzpV+0ck3bK
	2vmwo84yqHrtVJAnHB+/Vnu0LKSHWO3HvKG8jKomJi246CaDQSDt8IVfal6R1ZsiFmJKMTJ57Hs
	WwiEMazQJo/tO8ZzVup8Hd2DhfV/6mx3l0ASxlXUhO9zjiVJfgBMsNpfcSNsIgZ3a+X7s8/sUMK
	l3ow7PZ9FgvvNAKI9gP7GzTN0PQW3kyHW2GDFmyqmYgY5nThKuz98dY7UOEUHXevsZF34fbWxeq
	UpLqVePeZ6Q3V9u4OEYvLA+AkRatAIdlct8PYkn5avnbUfyzCa17xOoKL+vTvb1yiC2zNMZDj2U
	x5XC6v9l04Ddu9ynOFRMQGTW00UT92TiTUh3cQ=
X-Received: by 2002:a05:6a00:4c9c:b0:85f:b00b:8760 with SMTP id d2e1a72fcca58-86f82a5efbamr3533434b3a.5.1789371813846;
        Mon, 14 Sep 2026 00:43:33 -0700 (PDT)
Received: from a317-tower1.tail2eac45.ts.net ([59.72.109.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b250c544bsm4088751b3a.1.2026.09.14.00.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:43:32 -0700 (PDT)
From: "Zimo.Lu" <louis2665573906@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/memory_hotplug: use public nodes for migration targets
Date: Mon, 14 Sep 2026 15:43:22 +0800
Message-ID: <20260914074323.3567923-1-louis2665573906@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_migrate_range() excludes the source node from node_states[N_MEMORY]
and adds it back only when the nmask is empty. With private nodes in
N_MEMORY, this can leave a nonempty nmask containing only private nodes,
when the system has only one public node and others are private nodes.
Ordinary migration allocations use the public fallback zonelist, so none
of those nodes can satisfy the allocation.

Build the nmask from N_MEMORY_PUBLIC so that private nodes do not prevent
this fallback.

For HugeTLB migration during memory offlining, this also excludes other
private nodes from the nmask when the source node is private and public
nodes are present.

Signed-off-by: Zimo.Lu <louis2665573906@gmail.com>
Assisted-by: LLM
---
Should we use public targets for private-source HugeTLB migration during
memory offlining as well, or should this fix be limited to the same-node
fallback problem on a public source node?

Based on the author's node_features_v6 WIP snapshot (base below).
This is not a patch against mainline or the posted v5 series.
Private-source HugeTLB migration has not been tested.

 mm/memory_hotplug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 22d20ee96bb1..8a95ba26552d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1937,7 +1937,7 @@ put_folio:
 		folio_put(folio);
 	}
 	if (!list_empty(&source)) {
-		nodemask_t nmask = node_states[N_MEMORY];
+		nodemask_t nmask = node_states[N_MEMORY_PUBLIC];
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
 			.gfp_mask = GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
@@ -1953,8 +1953,8 @@ put_folio:
 
 		/*
 		 * try to allocate from a different node but reuse this node
-		 * if there are no other online nodes to be used (e.g. we are
-		 * offlining a part of the only existing node)
+		 * if there are no other public nodes to be used (e.g. we are
+		 * offlining a part of the only public node)
 		 */
 		node_clear(mtc.nid, nmask);
 		if (nodes_empty(nmask))

base-commit: 38c7f48162aa282dc6a9edfb7011378594057c10
