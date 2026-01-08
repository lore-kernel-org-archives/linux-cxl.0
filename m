Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFD4611E5
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867403; cv=none; b=MytyOdcp+ew+zmGrquLnHmNaJxje+8XKSZ0Ams13mmQD6RV6p2+I3EAlwKAWpMEPjp2vLn0DGmf5LSJnpo8z2Sdp89O/h0GURLdAP8nNP9WUYynLMiaNNtw9AKDgHdLqgV1M49DFasD7U4wtCySji9fB7z8yM/xtlaMmzOcnTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867403; c=relaxed/simple;
	bh=YYf+X5c8xRQHOIoiVkNKohN/SGgRXpW0mOrRpxFNnJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmNYPH+XFooQMyulmabfjjLwDUKHQkSefMCJ4klfiX62EXWSUGTs0FMmcexXhCOLBf+VsTpRGI77vzmTvHxKfBuX+p/3qABHdyliCpZtYzP0bYvR4KUa2KaE88glQABCogVS2BTCr0rVT39Ojkda82cacu6uxK4vD5uqjepKFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imB/Yzn4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imB/Yzn4"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so736820a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 02:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867395; x=1768472195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suTkrZ1EkPHRVVH34Oml2yxp+xWgDllJvbX0nsQJyK8=;
        b=imB/Yzn4EKaWXIG92ZpWJAM9kF5qZdKuXBpAwy6BK3qh2Rous2EtDXKRrTC/IzoHKY
         vOqp6o03EjQxR6Ok5uAKmczFoUS1q3um+IDJqGGc8IqFxmt0bSVVVW1yv3CfKcjjgyOo
         n24SEEdW809TaZXgtHJXBtkCrk4EDIQ1MjcoQBLh/Cdq/fGS1STsLAKdB5zZw/YpwzcE
         Wm145S9pghGumtDNirh1GjNbblFxm8pYIrrxK61KFvieBNmdYOjrYqC7BPPoaCfrNWEP
         BfMCxzqb2eXjnD0J6+jSb5tywRC+C5cNF1YDbSZtoBb3wfg7knvJ6u9GWGYAaaXZiZAY
         VDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867395; x=1768472195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=suTkrZ1EkPHRVVH34Oml2yxp+xWgDllJvbX0nsQJyK8=;
        b=ZqBBQtqzQk0jSA+pvaDkb69LbaPYXLM1JuO8MC4X5BWEap1YSYhbet6eFG3Jx8fiBY
         +3tNy1hGJMnC2/ePXVmaOoEpqRM8yLULXEgqbKyY0ZhfXsrX6+zShSM1t5SzvhVaD+Fm
         dKoBZSg9PWAsmkgt+g1sQLYG9J9WrfAW14+felWh+g/NVWLsLHfT8q+qBSYzCqe6L01f
         gWkVKrnv9Tk7XijNY5CVuE557THDzCb1Fj8Ig9JXTgX5RLNOtgQh7mBB3uua1XjZdduX
         BfMj7otMKWszMtYGZNgh+STtr7rgLaclx88P86eNggjIJMGdWWhT0zMRXnAknyrrQRuo
         LuOQ==
X-Gm-Message-State: AOJu0YyOTCQ4Ql565VT23Xg2nCI2g7xGoQ7oIhqODDj20qIP+ZxINClH
	BbPRBfliRis2UXKUeMCCU66vObGuPlXFbikrdjd43lzX9ACIf0DjcHpn
X-Gm-Gg: AY/fxX6jcZv1dfNl4px43Rnf9BPoHEQeKTsaqaZKSJnYge/PJAw5twIO6eVSXmIpDEv
	QutmmGOq22e33rO111vks1DKHdwt6ka5JUkz1a0WBXxNlDko2Nko3TmsHFkLh/gguc9Qz/LD06D
	mJSZ9zlb/QCXqob04CL9iySuYXKmF3u3tiSmwvXtswplgjJ5JBV+zEtUeH3AQko6wciaYpxCAyt
	peUopYbczSnNxPEAGtaMjgFDPJrldKAtJNGvXw0et2N+qYQmxClnIiOs1ux4dL6cq8iYVkc99D7
	fxi0rt5uQt9LTUhSxv6N9Lci2c6mHA5sG82hnR9O9AGCrmO4ef+TacFka8ZNWxUnXvlbmwrGFOp
	l0V6BB+Get/BJOwRqaF519GNYys4AbpwMEpTw3BXjOtYmFiJ79PF1wgRZ7j0LzhB+0SYgbYIOSA
	hJ2bNwng2sdO4SYOVxy0jgYzb4
X-Google-Smtp-Source: AGHT+IEjPBmAvzyeXCoA9/7yT7vSwivlYjHbfpR026nkIclI0cizfQblaziO9HyuHaaz+q4kQ2IDPw==
X-Received: by 2002:a17:903:11d0:b0:29f:1b1f:784 with SMTP id d9443c01a7336-2a3e39828f1mr90701885ad.4.1767867395489;
        Thu, 08 Jan 2026 02:16:35 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8352:dfa:3b18:eb4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c49299sm73785245ad.42.2026.01.08.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:16:35 -0800 (PST)
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
	surenb@google.com,
	bingjiao@google.com
Subject: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough free memory in the lower memory tier
Date: Thu,  8 Jan 2026 19:15:35 +0900
Message-ID: <20260108101535.50696-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108101535.50696-1-akinobu.mita@gmail.com>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
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
/sys/devices/virtual/memory_tiering/memory_tier<N> directories exist) and
/sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will not be
invoked and the system will become inoperable, regardless of whether MGLRU
is enabled or not.

This issue can be reproduced using NUMA emulation even on systems with
only DRAM.  You can create two-fake memory-tiers by booting a single-node
system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
parameters.

The reason for this issue is that memory allocations do not directly
trigger the oom-killer, assuming that if the target node has an underlying
memory tier, it can always be reclaimed by demotion.

So this change avoids this issue by not attempting to demote if the
underlying node has less free memory than the minimum watermark, and the
oom-killer will be triggered directly from memory allocations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
v3:
- rebase to linux-next (next-20260108), where demotion target has changed
  from node id to node mask.

v2:
- describe reproducibility with !mglru in the commit log
- removed unnecessary consideration for scan control when checking demotion_nid watermarks

 mm/vmscan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a34cf784e131..9a4b12ef6b53 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -358,7 +358,21 @@ static bool can_demote(int nid, struct scan_control *sc,
 
 	/* Filter out nodes that are not in cgroup's mems_allowed. */
 	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
-	return !nodes_empty(allowed_mask);
+	if (nodes_empty(allowed_mask))
+		return false;
+
+	for_each_node_mask(nid, allowed_mask) {
+		int z;
+		struct zone *zone;
+		struct pglist_data *pgdat = NODE_DATA(nid);
+
+		for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZONES - 1) {
+			if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
+						ZONE_MOVABLE, 0))
+				return true;
+		}
+	}
+	return false;
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-- 
2.43.0

