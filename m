Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7F37BE7A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292143; cv=none; b=QqkmHdAITCTrX6shpBqlVIf0l96hWcDVAkrE4n2hZlt/4pCyUktGirAfaUIE1QmotsDGFMsMD9ZEBIculYSvebf4pLwCoa30RMXhQTyZaq3mNK1rzPAUF4w0nKx/v0NMsrr6zTX70XgY95C+NseBq7JHso5V5JCjyQb7LVOrSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292143; c=relaxed/simple;
	bh=fp4REK6J/MVZYC22Z2TU+pzeMJxeOKqpDFyn0zcX3KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5HtNEBqQTZqIFoYa6fYs/mLc2hwLtxR9bc+xssSacCHKPNMz2xxUzLeCyTXGsyfr4T+NJfZBh1bMLc2J7wYOdHPA+pmBxOKE9MMd0S+WUCzH6xijVnB4n7nlH7sZ3WcpJFjs/v7537eIbFf3SLZUACnH8KiNvqzyAO6bh8wF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKM+7dq5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKM+7dq5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b553412a19bso3276627a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768292142; x=1768896942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn+2HMuW53bWkoRvrsYzvFUGyuuVFRazgaZ3DqLSbig=;
        b=FKM+7dq5LtVXfWMnkPk9bhrTl9tndOTOTmCsf1pGWsegz+cVsePAPstJpj2U7rbNkC
         A0bny0Dg6t8vZCl+zkU2vs/wK2JuRbXvpSbOecz1ghIZH1P+OrZg9Lsy3IQeEvv+ba9h
         F0yjEefvqEQ4nCJMSDoClfwDodNKufWBN6eKN8i8L431T5Mg6/hF8adzQipBIG56ypwu
         9PrA/zQlIRvHM+fQz4tZHw//PabB3rzLCXxksS+/KXeKlgb/FZkj0odP1ZDsdAtrM/1Z
         CWLprO6cM4G5RYjnuyjspp0lDXSqq3087KWrii3pxaRx55RiPOerWxHKllKVlUktauwc
         U+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768292142; x=1768896942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fn+2HMuW53bWkoRvrsYzvFUGyuuVFRazgaZ3DqLSbig=;
        b=bITUj2fFcm3tvINUQyQm32N7243Qw3njGR8b5c+zQyBYdZkactHRcBvpBKrLSjLCJc
         rZx87hmv4QJLQWZaiUNRHpYei2ZJVybCJ7EAzc3OlgXA49Luhm7DaD9fdGAc9L89dDet
         ZKa10cTrZ+FgCKdC6tiQG2RRXgf9HdyI1vtaU8uyZfWoAap/4877KedeDoTzN1bQ3DYW
         3G1QkkPL+9D5SgNsQLg/B1EvMAwCPncFRKFrGYxSYI1hJWTPSiWX7TSxcqt4oLmR7/YI
         8VqNG1RWn8raZu41m1DCDDEA5msdby1ZxCDzrWLLlqwn9FbkG/eVfBbY8PPNS17no85w
         t24g==
X-Gm-Message-State: AOJu0Yw3PrTR3A4QlpsFLnI3hDt/i8V5STRqFvbof5A2zHYfEo0wOKx/
	vxgX2YvnUq++O3tgO3j5Y2Rqz9v95sHg3AslborYsfJCpSoC5mQ9CRv5
X-Gm-Gg: AY/fxX6+HyD3Bicxz302yhc8C3d72ma0um3wNLo+4TCpt9BM1dlFWqFiiQnPZsFqwiB
	1sDIv8J240N/n3OTmNg9KYzAE3SFwmsWG7MoVG9l5qlJYyoxXfOvxyYlAHxZufTiD0qbuFkD/10
	NQoH9mJkyXKRqx4sb6hx4ACR5X+Uo3MNzNtmkwKDQaLV4Q2/ZUkOgBbaYDDhCDd0mAxn6+jXL1p
	rUuYEsoyhtNsFQtVpmnjrO4hb/ajzHdUSC976YcTMxR89jkVWGCb6/c1Qt+mWqyqh9QH63ZvQIS
	LlwpqTWZIkuHFosMFOiMy9qlYaeNel0rzIemjf6Fgp7a8cyUV//thbvhMTKw79SECLg5H1cCqVr
	JSyKLWWrkmZXNWqb7ymlWgBpH26ZtqLaqwQqca7NQY7c9xkR1y9wD6n7uM7p5fgxoaE15PeNKzz
	QwXPL9JyEUA+t6B00RgR8s62zNhg==
X-Google-Smtp-Source: AGHT+IED9gfPtbQO5QOad8Z+7M8wVwtLncJwWLcyW2QnowsMI6f260Caic2klkdpN/rarjVFLNQLMQ==
X-Received: by 2002:a17:90b:3852:b0:343:b610:901c with SMTP id 98e67ed59e1d1-34f68cb9036mr19913726a91.26.1768292141715;
        Tue, 13 Jan 2026 00:15:41 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:180a:3788:c683:2f64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350ff05492dsm657199a91.3.2026.01.13.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:15:41 -0800 (PST)
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
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bingjiao@google.com,
	jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough free memory in the lower memory tier
Date: Tue, 13 Jan 2026 17:14:53 +0900
Message-ID: <20260113081453.8293-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113081453.8293-1-akinobu.mita@gmail.com>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
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
v4:
- add a code comment in can_demote()

v3:
- rebase to linux-next (next-20260108), where demotion target has changed
  from node id to node mask.

v2:
- describe reproducibility with !mglru in the commit log
- removed unnecessary consideration for scan control when checking demotion_nid watermarks

 mm/vmscan.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f35afc5093dc..f980c533c778 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -358,7 +358,22 @@ static bool can_demote(int nid, struct scan_control *sc,
 
 	/* Filter out nodes that are not in cgroup's mems_allowed. */
 	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
-	return !nodes_empty(allowed_mask);
+	if (nodes_empty(allowed_mask))
+		return false;
+
+	/* Check if there is enough free memory in the demotion target */
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

