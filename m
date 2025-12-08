Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9C3148DD
	for <linux-cxl@vger.kernel.org>; Mon,  8 Dec 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186891; cv=none; b=rtJqdCLO3g+eaXfBGrw19Yj6lHDc5THk/V0AHywOOXcfmLNMXMPfr7fx04Zy+uzAg3G3B81i3TDogb1sMiZ9yusMXb9+RCl7/7SphTD2apyJWdCL7NuJlYeuqzEsHwNMk+K/6jKFTJ3gY8hKobBGDoMMF6f5GcH130gW2TStnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186891; c=relaxed/simple;
	bh=vaRn1KfT36KE3FEN/+Bf12Zbj9vhejAeH1OmduUjF4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP3VlOFCKgJ5UA6YtURn/UnJGbYjZ3CNe1ISiD1psNB6jKrWvdZd8g2NkLNX/bJIhuFhfFtAFLNh2YD+8dlcNAR/tcM4IBboKCMopJPiMOfDHuZ15Z+3/kyHNSoKyK4g8wtJDsQjr8uP7h5tWJvo/IqqQUfUnnEj9/K/U5ivR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbOxDbxq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbOxDbxq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so3062500b3a.1
        for <linux-cxl@vger.kernel.org>; Mon, 08 Dec 2025 01:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765186889; x=1765791689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bExisJd2rawtEUNYxhwuMVIv9x+cEHj6grigFw1J+tY=;
        b=VbOxDbxqhxFfad/uYI8S2RJHYoEde3IUbvqYyxj8GojEYzhXXBzaOmzonaGKyxiL+S
         2qn2C1npNUyd/eJBcgs4Ligzyawsi9YdqOMeUnIgwHx+LBwycvM599Z8BkST6vmJX4bA
         xH/sJTbqVbf8iJrttOb461pUY4jb2OHFnd+4TSVcx8xJ4JscmI8tOFU4vT0JzKYE8HN9
         JiJ9EwkVDMnsxcWQxqoZl5SQtYcgP/UE9A2WBsccLRJhD2aozHFe9HN1zEvNtG7S47wS
         CAhbMHvD4UCpjdtQfvUYyMuI/qtCuGFVtutCcUTPeeihOcwwKcP6hhos/mtEygLjmPlr
         opjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765186889; x=1765791689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bExisJd2rawtEUNYxhwuMVIv9x+cEHj6grigFw1J+tY=;
        b=h0X+WLqh1Dvk2yEsfzvuudmLcsqILX2JHOUalYYHCwCTOtcBCfvyyD13w15N9LuLb3
         wNF2HSxDSlj276bXC4yusAw1tZE0DiygdXV1DPWWRFaFaSZLLvhko8Izj2IvWjcibgAM
         POyC79dn/YBAsZRUr0j5NmkOMGc+za/g1I9WCL2eiQ1/7aDzCS/dSrLe4Gf+s+zVZRFG
         1PVLjeZwQfHLa5zBC6rlULHBcWGByhL/Mo84ve2awMN8ablrnf7kfASoFSTrO2iBlWDz
         uGVZy/G1D+D1D8ji+e4SL7N+9JgfBQBjezfNEk4JSjt/TsFgHZ2Wy7tzp8BLRXo3aobV
         eGGg==
X-Gm-Message-State: AOJu0YzAZ1t9C2sVHePorwmKbo+nT6/xbwzNUfT+jxthArwlUeFqw1Rh
	92NmpDscPJyvrrmwgGIkGGlm3k1PV+lNSeHE+q5dGV4nYvXfnYG/nd3O
X-Gm-Gg: ASbGncsvcigxD6PQLWZTOhYUjDiYgjwk8fbX1NYKKl6kGdHDa9zkMKIbTxIACbQZ+ZD
	QtskUhs6UMoO1Xk9CrQ9bEFcZdEKg0HmXhdirkBBfjPQmnp4UXGPK8bELgk2vhiQZTp5qxHKUWD
	aNUvlagCi4UYdMrwvCVpotPSjg0/bS4zp7aIUQCw0SosNtQ/hLqIG3b1inJ3qnfE7HUCKjGBoNL
	AmYqSzo/vVRLcysfaqUVvP4LUTJJtbDPb1C49H2a5I6SQjGBGkviCnY5yS6hgsiHvscSGkjxDka
	gkRVt2FVXUko3L1Nd6uQXyW6EcPzHJ/8ckaiP0WCAL6PgRu1G8nLbOBTTEHbi6pHTR190MyVV9h
	jkd/W7zdX2PVaLXPVGHsJZFEGr6bWBnT1IW/kKMWuxSMDemitwsBnydM1jOnKyD5HgfDfVqh+7U
	D1JRfdtDzpFoNMOA0saa3fQYFt
X-Google-Smtp-Source: AGHT+IFqvRUGIwFEaNgQfl/NTg1cwY2IZM60Uy8TIHC22S07N4FVSlZj92GMWE1sIDQ0qozblkpCYw==
X-Received: by 2002:a05:6a20:ed0f:20b0:366:1e42:630 with SMTP id adf61e73a8af0-3661e420638mr4892693637.1.1765186889147;
        Mon, 08 Dec 2025 01:41:29 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:e251:d9f:c2ef:caf4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a36bbc60sm11675279a12.36.2025.12.08.01.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 01:41:28 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com
Subject: [PATCH 2/2] mm/vmscan: don't demote if there is not enough free memory in the lower memory tier
Date: Mon,  8 Dec 2025 18:40:28 +0900
Message-ID: <20251208094028.214949-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208094028.214949-1-akinobu.mita@gmail.com>
References: <20251208094028.214949-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with multiple memory-tiers consisting of DRAM and CXL memory,
the OOM killer is not invoked properly.

Here's the command to reproduce:

$ sudo swapoff -a
$ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
    --memrate-rd-mbs 1 --memrate-wr-mbs 1

The memory usage is the number of workers specified with the --memrate
option multiplied by the buffer size specified with the --memrate-bytes
option, so please adjust it so that it exceeds the total size of the
installed DRAM and CXL memory.

If swap is disabled, you can usually expect the OOM killer to terminate
the stress-ng process when memory usage approaches the installed memory
size.

However, if multiple memory-tiers exist (multiple
/sys/devices/virtual/memory_tiering/memory_tier<N> directories exist),
and /sys/kernel/mm/numa/demotion_enabled is true and
/sys/kernel/mm/lru_gen/min_ttl_ms is 0, the OOM killer will not be invoked
and the system will become inoperable.

This issue can be reproduced using NUMA emulation even on systems with
only DRAM.  You can create two-fake memory-tiers by booting a single-node
system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
parameters.

The reason for this issue is that if the target node for allocation has
an underlying memory tier, it is always assumed that it can be reclaimed
via demotion.

So this change avoids this issue by not attempting to demote if the
demoting node has less free memory than the minimum watermark.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/vmscan.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fddd168a9737..f4748f258294 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -356,7 +356,20 @@ static bool can_demote(int nid, struct scan_control *sc,
 		return false;
 
 	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	return mem_cgroup_node_allowed(memcg, demotion_nid);
+	if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
+		int z;
+		struct zone *zone;
+		struct pglist_data *pgdat = NODE_DATA(demotion_nid);
+		unsigned int highest_zoneidx = sc ? sc->reclaim_idx : MAX_NR_ZONES - 1;
+		int order = sc ? sc->order : 0;
+
+		for_each_managed_zone_pgdat(zone, pgdat, z, highest_zoneidx) {
+			if (zone_watermark_ok(zone, order, min_wmark_pages(zone),
+						highest_zoneidx, 0))
+				return true;
+		}
+	}
+	return false;
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-- 
2.43.0

