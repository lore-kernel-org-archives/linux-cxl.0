Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074948;
	b=NqjD3GUxCHF8lzVF+qZW4bfOHnA407gSv6HNKVWxggFqiRLCKhVNWXBxN5YIthDdpWEL
	 g72OKS1NEWXlQ2SfNtzsUZHPtzeCWSRM4Q+bWkbjXMrsVsTa/FX+6HQHB0IxQwY/2Ggdo
	 b8VJTHzHGZngwKM8R8YgkX5DVGVU3SNM8/Deu/+vz3t4njloFB7duuwcEKkqN4K1cAZQ2
	 Y2lWh69OlEuYHMOxualgetPSyQunHeWsuEzkIMLZGtKO/mHgCUPHZ3PIPzxmvDsHd60Yj
	 OOEmjNC/VmMWpgt0QDxJ4Ga9BHgTLKvWq2lmwl1XQ851vQNJmsXwxbj7le5t4NuGSRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fgx0S8/0sycDsnMopzoyCblR7NpYYIVN3Htks6C0yAA=;
	b=OIMmRzK8TcuNqsgRwpyUyUYzF74BKrEvG86XUMKii3uLFsBnA2QnOA6OuwZ4xwncubp9
	 2u452ZtC6b7v9Gu6paLJbPtYt9MygQ5YvgCf9wHdL1enUQB4SNF+pVZ8lj03N/VBThE45
	 BmFCSLkG8TFOnuG0rs54HaBgk6uKaRWxYQm1gohMZpH7vChxYnhN7g1Jz7FheK4vfaqeZ
	 GBKbUZFaKcHO4AHEZMCvQCQKl8B1+9fNHPPhvCKmF92/FVlRc7+l59lU/2H53k4Tn/uvW
	 OCvr7f9FK+NH6qM0s8jGvr7G/Uzz3/RHrznScKwTxpGl4iRahHvcAITBrYLIhlewKuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZNfbJNjS;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833A60A260E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 04:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8833A60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZNfbJNjS
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53e1d40628eso5799511cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 21:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074946; x=1793679746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fgx0S8/0sycDsnMopzoyCblR7NpYYIVN3Htks6C0yAA=;
        b=ZNfbJNjSwh4iuFBugs28Lgd2LQudZPCl8nsuNLBP8R2y4RjjjVdHq9uS6qMTNhgqaE
         H0Gvav/Ed1apakX5n1rlwq5Tn4GoBP/ckAi4y8FupjLgzrj5z0UC+hMLG4KvzQjP7fut
         1EdrIhPRQ/m17bNkHNewaJAFlZAF8WDtocpswbDloJCK23NRZj4VSpTPuLsORmH1TbmB
         tVMEndigGJ7sqWmjqcfk+TQHLlG45PL3MmQnFtxLyX15O0WZ8RmKOaw44/Zn8i/m8ho/
         PH6GY3IMJRlxrjT6yINoZcusYiV+U00dEMakQ4LgqeWtiCy7bX8ZTL5gX9aqKxXyt+JW
         WmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074946; x=1793679746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fgx0S8/0sycDsnMopzoyCblR7NpYYIVN3Htks6C0yAA=;
        b=s+QLburM4k2MSyWNth5kNo64lnccpxDYZ4XOEqkIbGrJfMrbBnfVJjBrkq4HGJemxi
         eS+LrmQpNerbJWYiZaQfQPO0bHaRAhfS0/aRdVK/ZaZo07I0n5DK95iIKgW5cHXDRySm
         s4dRXnbiYHtGumf7ffJLOvHR53zdkTzq6d7ISEwmeIWjb+25EMA+uFRppZnObxuxySzj
         Pc0kmTyaJFJ8Fm1A0pTqJBc8zQw2yNEhPAmguNx5ae4tEcqn5TRHNh9YpiojCWMIFBlK
         mQ8Mii/2pcZWJtjchNXklOUfyzDMvZYQC5Tss8iUgsXnVMHyzta3E2mz5ThyzLyuOLb+
         Aimw==
X-Forwarded-Encrypted: i=1; AKwUvBypuBub2oSQdsmHCk5SsAmzUwn+BI0UqugJJaknolQyq+JkAD3AxLlfp8iJ3FbOy7t/UuSu4q6L+T8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcYlQKB4F/qyCCtC6Yjx9i0DvV4IPkozpP1xZJtk+0aMO9GArd
	KGIB2A5Ry+jnkMQH9JnbMYDWxfq1duk8+sXWIuxLOh55wZfTQMTMZOQXYC0/x7oeCgs=
X-Gm-Gg: AYBFou0bHwy2nqTzX+Jbaw/5/c6ZfMJAdRcyLQVUmLgGsOZ2D+ulvWRdrSS/NFBfIKE
	bL3NAZz/oVWG2QiCTPhIMkDvK2qcHTVm8VFNglJaylDxG0X3dfH+NrIUXKJmhy4NYpsNfbleAC9
	p4kcQzXSbv2cKCmUAaaeIChbD1ircpbWFH0sZS41HYOQ4xB+drFPn1CC/QEac5cYiXD5zfvCT5w
	t1OITWPP+9Vy1n4DTDma8FwOfob38SNUE3VgscfB4jr2fVVLYmcEwDKuZVKgTaymWJsUh+CbADC
	w0IAeA7EZUmmxsepxNIfjGGdQvW6vZ+olwzl7/9jMB/FkS68MXfWOFbi54r16mS0+l7fNY2xDTh
	3k62I5NgIDyL7teF8zLSmp52uXSEt4Kj2UPDpdjUhs1Y1o09IFvpmYqM99X9itf97p0D1e0Fl7p
	OJMjDk75iEkImBk8T9Ee5ck3wN0U00YHKJHGIj/qEQOYDuRV+1PX0UPdGrLNThPrBg0s2MBQKr7
	7mV4XkRtiO+VCLcDcn//zNxN5b21CgPkMKuFY8nMJW0ecm85cQP439/MeCOtExRLY4qdjuv/0ii
	SDvKcfIk89cwT5PPVLWiq2AEf0s9HDWeD29vON/hHA==
X-Received: by 2002:ac8:5ad5:0:b0:536:723f:5de7 with SMTP id d75a77b69052e-53e3bd81b50mr32491021cf.4.1793074946632;
        Mon, 26 Oct 2026 21:22:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:25 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 5/6] mm/page_alloc: keep the range online while alloc_contig isolates it
Date: Tue, 27 Oct 2026 00:22:03 -0400
Message-ID: <20261027042204.3741307-6-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027042204.3741307-1-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
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

A gigantic hugetlb allocation racing with memory offline can crash.
alloc_contig_pages() checks that a range is online under zone->lock,
drops the lock, and alloc_contig_range() then reads the zone of its
pages.  If the range goes offline in between, a DEBUG_VM kernel faults
on the poisoned memmap, and removal frees it on any kernel:

  CPU 1 (alloc_contig_pages)          CPU 2 (offline_pages)
  pfn_range_valid_contig()
    range is online
  spin_unlock(&zone->lock)
                                      offline_mem_sections()
                                      remove_pfn_range_from_zone()
                                        page_init_poison()
  alloc_contig_range()
    start_isolate_page_range()
      isolate_single_pageblock()
        zone of a poisoned page

  Oops: general protection fault, probably for non-canonical address 0xdffffc00000006a2: 0000 [#1] SMP KASAN
  RIP: 0010:isolate_single_pageblock+0xe5/0x820
   start_isolate_page_range+0x74/0x1a0
   alloc_contig_frozen_range_noprof+0x21c/0xcc0
   alloc_contig_frozen_pages_noprof+0x4cf/0x700

A range that goes offline during isolation is no better, since
start_isolate_page_range() skips offline blocks.

Check that the range is online, isolate it and check again under
pfn_walk, and look up the zone only then; an isolated range cannot go
offline.  This adds one online lookup per pageblock on each side of
isolation.

With a kprobe holding a 1G allocation at start_isolate_page_range()
across the offline, base faults in 3 of 3 runs.  With this patch the
offline waits for the allocation in 6 of 6, and both finish.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bb3c7e95f2ed4..82f35816a0711 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7319,6 +7319,16 @@ static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages
 	__free_contig_range_common(pfn, nr_pages, /* is_frozen= */ true);
 }
 
+static bool pfn_range_online(unsigned long start, unsigned long end)
+{
+	unsigned long pfn;
+
+	for (pfn = start; pfn < end; pfn += pageblock_nr_pages)
+		if (!pfn_to_online_page(pfn))
+			return false;
+	return true;
+}
+
 /**
  * alloc_contig_frozen_range() -- tries to allocate given range of frozen pages
  * @start:	start PFN to allocate
@@ -7352,7 +7362,6 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	struct compact_control cc = {
 		.nr_migratepages = 0,
 		.order = -1,
-		.zone = page_zone(pfn_to_page(start)),
 		.mode = MIGRATE_SYNC,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
@@ -7397,13 +7406,29 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 */
 
 	/*
-	 * On failure this has undone its own isolation, and any other
-	 * isolated blocks in the range belong to someone else, e.g. offline.
+	 * Part of the range may go offline under us.  Offline cannot poison
+	 * the memmap while we hold pfn_walk, but isolation silently skips
+	 * blocks that are already offline, so check before and after.  On
+	 * failure, start_isolate_page_range() has undone its own isolation,
+	 * and any other isolated blocks belong to someone else, e.g. offline.
 	 */
-	ret = start_isolate_page_range(start, end, mode);
+	scoped_guard(pfn_walk) {
+		unsigned long first = pageblock_start_pfn(start);
+		unsigned long last = pageblock_align(end);
+
+		if (!pfn_range_online(first, last))
+			return -EBUSY;
+		ret = start_isolate_page_range(start, end, mode);
+		if (!ret && !pfn_range_online(first, last)) {
+			/* Every online isolated block in the range is ours */
+			undo_isolate_page_range(start, end);
+			ret = -EBUSY;
+		}
+	}
 	if (ret)
 		return ret;
 
+	cc.zone = page_zone(pfn_to_page(start));
 	drain_all_pages(cc.zone);
 
 	/*
-- 
2.53.0-Meta

