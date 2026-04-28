Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F563D75C6
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366366; cv=none; b=d9OfXHMcn46Ws4hDRPuFmm5zTpVHOahCxh4NhtoOkh8B7401SSUgbrjSC49lQwdtTHSIBAP1waiDJ5+BQjHjj3MDfiyojOtg2oEHFhO99/5o1aKYKL03dFUS13P1nRGe/fxxpGxHBLaBaKvLUEpbTPazeAZkHDLT79OnA/4O6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366366; c=relaxed/simple;
	bh=iuwtwcgHq3raBwyHyUBxeAqB9w0cY8KY67dh1gll2ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruzJnb3g5gwgdnpkAXiP6c5WckFuAUQPN2Xjt2QMBBra0PL6ZI4X6ApQoXhz7fEDc/Fb+6sJYh+bXT+cgYgZnK8IAlBNNq0JN5XlKs1bBCrb0QsgXvDVZMK8ybiS5QxU2sQePwCcsCaZ79X2p6InWRrC3el8MDa744gqwWGgEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kOByzhFP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kOByzhFP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3591cc98871so5137154a91.3
        for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366364; x=1777971164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSJ/Zlq/U4yHk19v3uYTHivwFzozYncFCgI5ZpuZJfE=;
        b=kOByzhFPX/q1ULrXheyyTe7xYjJI+jpR9TPJv4TMg687wAWdTx853MgeLdJkK2cepa
         w6v5svS+337LAiuHfSX133NZT/IICOxTPT5yBGtiIZHiP/wIizRBsjIg+cTXfDgI5EtH
         SIPlSAyudZFGxzQ4LunKSQicp9E3st/EOcXYE5Q/hb3+EEmgrCUd/6rn2/+m/NoNtqs7
         45tQo84VlxTDdUOyhVYsv8vogD6yc3w78eiuR6dn8KI4JdiYaFHz/bed9APCsuPu3xeg
         DDHiQeEe0vg7VoW+n9dl6h0rcydF8s5iMW3UA6C89gLLb9x05jZSyS3jjM72KKOMPENO
         AGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366364; x=1777971164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MSJ/Zlq/U4yHk19v3uYTHivwFzozYncFCgI5ZpuZJfE=;
        b=cB5d3i1NfI/rA2VPvo23Svz+qh0Qq1j6+PS35LNXFwCw4Lk7FGCJ/SYWP7wSyp7eZh
         lnZr0ohXEZ+fjqCAlm/PzrwJJZGX0vFar4da4nwlrFqxnvVpur+yJ6IcyvHrEWp9oSJk
         2uQLHG4Y3eC/gGqxpG+vjGOL31qB+WBvYmLtV13wIOXsXfPAg2ybJFtyCdthhV5IhM/3
         n/+RYHZqGDw1mM5Cx4U12DemmSJLprjQMzkl/hchIinLtkKpDoHAKGHWavq6vYY0SvoC
         FFbhM4qv44I31I2uW31sZSDxjeUVUMJ3S/pb/GfPouk+8feGWkfiyQ7EyP6ieVpc8UZ5
         wDmg==
X-Forwarded-Encrypted: i=1; AFNElJ/DBaNt2RkW5JoDOFoCAwdo47GRGgESNFwxWqfFtVdRj3pzFcnviDxV2pYsLwQn+ivmqS9mTDvq22E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BlttP+1LkQZVtL9JzyPIMa84MUsx51Y21GraXFo4OdntAQDR
	mns+wevp1MvQScUIfz3W98F3lFzeqPHxEMwZHH55VgdsLEoVjqkQmPJlS4RJw23j5CI=
X-Gm-Gg: AeBDievk9jRgquniyI3OPzYw+UkNliFA+c/6ZeA5eSHGc9fXMynee+3EjQ17opRT1Z/
	pR9UpE9CReXHUj1pqTm1P+RER9tJT+W2t4C0WQ2bE2RRTzo9p6fD+kltJUHUOolvoLCWGfz1kAv
	BxnFNnXBMouvf4g2OqTK9wvDXBcZjairHoqITJMAFGTPz9+sg7EY470GETcZoAW764RovdqN5Me
	eKLiz5sjDS3bEnV8hiC1fXfznweZXPcmoaLaGpE+D88G8ejxtjnx6bXiu8qrbR3y4uUz6OZ+Tjn
	8iCyipyxZkvh0v5PQlB+XiNJi9BQi7vzcr5PvduYfh+PRFbiNT8hO3efxGbRxlhrMN3RH5vcE6j
	mBdhzQziJErYkHwrm9+Gb8FKWpdgJoYLyRNqAt58mBoPce/YBzclzd9f6QLXlGN5n5qgRyvMFiO
	pDXL1blm71vl3YgqWrWbWkdkHrkvu1/nUqfXddFTAc9mwRZnm5uIL0aeY=
X-Received: by 2002:a17:90a:fc4d:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-36492068746mr2311671a91.25.1777366363725;
        Tue, 28 Apr 2026 01:52:43 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:43 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v2 3/3] drivers/base/memory: fix locking for poison accounting lookup
Date: Tue, 28 Apr 2026 16:52:19 +0800
Message-Id: <20260428085219.1316047-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428085219.1316047-1-songmuchun@bytedance.com>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblk_nr_poison_inc() and memblk_nr_poison_sub() call
find_memory_block_by_id(), which requires device_hotplug_lock to
serialize the xarray lookup against memory block removal.

Take device_hotplug_lock around the lookup and nr_hwpoison update so
the memory block cannot disappear between xa_load() and get_device().

Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6981b55d582a..f76aee29e9a5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 void memblk_nr_poison_inc(unsigned long pfn)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem;
 
+	lock_device_hotplug();
+	mem = find_memory_block_by_id(block_id);
 	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
 		put_device(&mem->dev);
 	}
+	unlock_device_hotplug();
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem;
 
+	lock_device_hotplug();
+	mem = find_memory_block_by_id(block_id);
 	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
 		put_device(&mem->dev);
 	}
+	unlock_device_hotplug();
 }
 
 static unsigned long memblk_nr_poison(struct memory_block *mem)
-- 
2.20.1

