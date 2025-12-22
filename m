Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18D198A17
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364571; cv=none; b=G6aAIfXJFWeJSss5LGcEuVevddsTVwCaXK+WcEpHoXNq3o7W3yXuyjQCxsVBFxqOzUOCgVZHMC7IL1BUWlHZyL+m/4XpPmAIPznXnOJ/r4tYu8FS5lD8a70oyb8HbyfgLvjIHRB/Q4OQLUWhoyrs0hE7GzqBdN+zqYkqsFYLF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364571; c=relaxed/simple;
	bh=uW6yl7/YVIR0hnsVUPmYmxbr6X3Mpwe2rvnTEr7sd/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUzugfbgsUsiepu2HjKgn6p/yvWUNvlMmp4v1UnrPrRr6wpi5c+BGX1wRiz8camZF7jQ6ZODBjwTbf8aujPXDrRtaEWZkCgmk5w5/NIzMqYOK43ejuVtMSD1THOywVZ1acReVPyA0RtcY4UG9LdRK9vzmVXWv7hXy1nw+cYtIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9+Htyqw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9+Htyqw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so2531393b3a.0
        for <linux-cxl@vger.kernel.org>; Sun, 21 Dec 2025 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364569; x=1766969369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O11NpgEudbETTqMQr23yY3JLGVYTvh4uSvV3m2jKMg8=;
        b=l9+HtyqwY46becPzsMALhR6F5fCS/nli58aH5k45IXCVrvKGkoJiWIazQRrOYY7Ntu
         UKS8qgYTBqdDsYPNO3ZWUtDMxegTstwUKHBywNBvrQEN/lFxhTLMVhCv7xoTJCeMaI9w
         Pz6GQGP+umbpZE5SyePhAWuAeKRziPLyQ2nWL/avhiVeDjfLq+gZxLZUWPdRmLiFm4AD
         fy0DFlgJKGYXKhutkjMMJa28ndZ7XBhHN9Qkp1KqBIboNtyuQk+KhPUw73LLhIp3SS6r
         ohiqGbrXmOzlKkYyvKMMwTFGEELHjB6CD9DaamBeuf++Zbpc7Onq99s2hLsHyx7nYI/L
         RkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364569; x=1766969369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O11NpgEudbETTqMQr23yY3JLGVYTvh4uSvV3m2jKMg8=;
        b=mK3vNYt+R/VnEq0A97RxHqiZJ/XuQCTPsVyG5nrHs4FblzKGWGpgnz5Segj5V1Ya82
         12RLRTYsT0eC3KcM7thqGFvIJLXwGajwY4Xs1Igjh4c9MIq1IZ2FEynwVhtAC2PxT793
         SAYEB+HtcjPifVjVt5ZJElWphS2jpi2XbCEiflR63Wcp3cOvI4OBmXwR4SP1P3t145YV
         iiQTYbDIExSd9UQd6Y56y+POhFk4un/GeHAmWwSjzPEL7H+ue1f0nfAfTiIhp/vg1g7A
         293m5IAVEBVGLyer1O5lLyQ5MTxDuY+LAnzEPYkqmPIKkNnkx2/LnYx1aqS1fDMxyWdL
         ErSQ==
X-Gm-Message-State: AOJu0YyYTHI+1mCxEw/U80hvYTkrfCUGZXpQ0qTPlNYZNoW9XywgapCs
	IlLspIKwTcnNIG9WjWvSETtOzcNuYnw6oeAYaBnkre2O53Y5Bh5GNGS5
X-Gm-Gg: AY/fxX4MOoVOXsVYUhqNV0HCNSjQQGYB6CYGY8EXr9UL8yYGieimhGBp6k9tmjK5B0h
	R7FYADXsaulW+3kANOL6kheFZ7CDKJIPXbZi3yWlM9cm1XxpRAfiID2X/wTsVg+QVuRvZeMmPL0
	6/8WhjVtYvQVVP2FcRrEr+8XeHxwiQiP226CZNJ3mTOExvyPcgtIr60CNjW0tY/7c+wXqm3XXUl
	yjDY0A9yLxOafv/sREoW5Xkb0jRRWbqIWCbYzwORYGLy+DwNSBMDXxTQaMlZbQHYX+9aEt27m2Q
	7jUItb1lbckckkPPStpwUcrehQOoqt+uDgNMLu5jO/MFE2FAtmRhXY+ntvkgovbu9kggSsIr3Us
	DJ4WwDoZdqXbIJMpLYEbqDp7Tl4nrZwKhEnzUyn4IbuYrff5yWVO9JFNrRk9yTibJ+vn8fsZ+Ny
	bgDpgKvfwf6b+8nSJjElOmOvdoAA==
X-Google-Smtp-Source: AGHT+IG8HmbbKxbFNUbBIyvPC/wqo5S8q0fmYrBfBYMPa9s7jMVxNEhlbTkPAWQV0fM658EICPtxTA==
X-Received: by 2002:a05:6a20:7d9e:b0:364:be7:6fe9 with SMTP id adf61e73a8af0-376a83d884cmr7849186637.32.1766364569009;
        Sun, 21 Dec 2025 16:49:29 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:df7d:b611:ffaf:6d45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm7461832a12.4.2025.12.21.16.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 16:49:28 -0800 (PST)
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
Subject: [PATCH v2 3/3] mm/vmscan: don't demote if there is not enough free memory in the lower memory tier
Date: Mon, 22 Dec 2025 09:48:34 +0900
Message-ID: <20251222004834.10539-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222004834.10539-1-akinobu.mita@gmail.com>
References: <20251222004834.10539-1-akinobu.mita@gmail.com>
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
/sys/devices/virtual/memory_tiering/memory_tier<N> directories exist)
and /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will
not be invoked and the system will become inoperable, regardless of
whether MGLRU is enabled or not.

This issue can be reproduced using NUMA emulation even on systems with
only DRAM.  You can create two-fake memory-tiers by booting a single-node
system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
parameters.

The reason for this issue is that memory allocations do not directly
trigger the oom-killer, assuming that if the target node has an underlying
memory tier, it can always be reclaimed by demotion.

So this change avoids this issue by not attempting to demote if the
underlying node has less free memory than the minimum watermark, and
the oom-killer will be triggered directly from memory allocations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
v2:
- describe reproducibility with !mglru in the commit log
- removed unnecessary consideration for scan control when checking demotion_nid watermarks

 mm/vmscan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76e9864447cc..0362026e66a5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -356,7 +356,18 @@ static bool can_demote(int nid, struct scan_control *sc,
 		return false;
 
 	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	return mem_cgroup_node_allowed(memcg, demotion_nid);
+	if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
+		int z;
+		struct zone *zone;
+		struct pglist_data *pgdat = NODE_DATA(demotion_nid);
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

