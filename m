Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074942;
	b=lGr5sthwyqpKX/0XI73K0GaMXRJkk+aeLq2wqgu0rSioP9vzNeh17lDPBsjj5giPuJDw
	 s+qL58RERTqK2qzL14fooq4IUnRtp3OPRB0s0SBWL72snvkBOd3KfG6b4XcMZSeHlLZa3
	 GJ6m1gYEa6E6A1HAT0NbpOec6kSJA0NUwywzogiVzR4/eQX8+RyobM2VLSd5K05k75a7k
	 qADRTa3zPRFjatqE3eynvZCQuMZ0VNijz7PUIoRST3oroSqEfj1m/NJvyex420emHjLEX
	 Hmbg4ZsifwF6gFb8YFFh0RcWGww3pSsc5FOAka7HvKPd5mZ9W4uwZg+PZFA1NFRyqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JYR0kjWyeHwovzI94J0HLudxjoqlHJ5bLaQ4w5OVpbo=;
	b=L/+G3Abh4dLF4yXhfxz6wkVJfAdSHMhXqbto+dRV6pPcS4f0OeWmswI1TyTLZHNUU77h
	 kUe1Fnm0CMm6cof1TVkAIY3Mbz0WYwIZ2WSX+Ce0I9STdJob3riqnd5Ttvp9SCSqEBPJc
	 WDKzUrBGeiPsz2uteRme/EA6Ai8Y5U8n/B8UlZtAheGDP9vNp4hjB/vEoBVD5dtr6QvOf
	 Ib+hDsdwsNDqvU9fx0mg+rkA494ZNKTbBwrK4OFbIe1evaDhrLzJjG8YYrPbHjEkP3Njd
	 QuZMJPI/Dl8D0bPc+EQ7703Q6R41rW8qn5NJJTjT8EvHDpAzl4/hlgx8SL8QX+71ZfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="t9nVPwt/";
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50865606A32A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 04:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50865606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=t9nVPwt/
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c895a0eso287680185a.2
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 21:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074941; x=1793679741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYR0kjWyeHwovzI94J0HLudxjoqlHJ5bLaQ4w5OVpbo=;
        b=t9nVPwt/dYQcOhPQS9n24nTChJsxSN6cnfVwH7VORn5e/1tN0OohhOYyoPSTzhVh9c
         8w54DfO+Kj7vgoDjZszWvwaBIT29XXoYZpMNwfgrvrENL/WS4NBq/wSBTsi0TneRUM8I
         pXHaQlCJMA2PuZiUW4vQOhgnGee0R2znYuLTaofci15uG05KDQHIJSCDHX/r0BMxeALZ
         0PLGvmfrL3+PrSRs4p+xuj1Pza1lX0FomNOVMgT6NMXA8ncUBfkQOr6BI2b860oSI5l2
         mGPHXsST2Y5nIAPt/b1zjnQZQFR3RLGfIdUUito4NWTRgDv50W+wIKmmNnWdECne5w+k
         jTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074941; x=1793679741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYR0kjWyeHwovzI94J0HLudxjoqlHJ5bLaQ4w5OVpbo=;
        b=uiSmmjFZ4dBkfdviVl93cLFey5olNrHAp8g3Ks6/u81E2zclz0VlQCxLKLxyhpWQ2q
         fmM5DKxyqmtgZvbHMtiPI0k7sqd/QTzFQODWT5ZPf9iYb25yB04Mx1UltunrN9dVdOR3
         wcVOuWNd5+WjvtqmuCvK2KTPh/nuHtJ5/bhvk9mh7KJJuJTPU/4zIwbALUOKnhOCpg1l
         2CjtInU7ElnjA6JdJAOzUnSjsDILj3BHHwGC1Xp4MYFfZnxSK62kxzIoXRI4VPZ5slZj
         6vlZOQb9sOKQ6eI0zAahLbaD+NOEq/5/YZDvRE5H4yYmdKFqRJzcyxla9lSUJe2Q+/qC
         WtFQ==
X-Forwarded-Encrypted: i=1; AKwUvBykugNlZdqK+x9ZJXP5IKcsDGbz8eJZBG954mh2Y1vGMy9IVPXRmYFXeXQGoUMP5RIfwjEi0LTZ5Cw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIy/GgIXL0mC1sNo42XPag0sfaa+cdX4VyoQe8CgeWfMRITZf6v
	3DAtPqcLn2E4+pQtH3/B5YnrA6796R4+vsBiL1uApO87Y9DadVG3isfkxJogHMO9fpM=
X-Gm-Gg: AYBFou39GsJHG1fR0x+bsPS3CCtehW8MijKla6mibapNMXcwN0rKyfu9psxf4421Kfh
	d6TaCTjgfzzXpGCywatcx85sEOSMbFJXhCJ+jAiRkDUGfoFQb6G0+rgl2O64gU1z7qI9ToDzLWJ
	y1yD6HzWeLP9kSlZrlJcfKbfX163e+K5LNygHFUKdLRrodZSHvN3m2mkPlArfnIxWhPgIroNl0s
	kLCjgfMl/jmW0EZ22/GoVaYn5pLvPeHMOXa99f4/+hQnm/nzy8Qi0L7lRN/FdYA13C+ggZwHv7y
	9c0fSeyYZhqupRXZ90yXldpMIqVadw1bZ358lkE1IzBuEqEsvRk4mh7WR1iXJiLKmTbTI2E89Tw
	m88ad9lGK1jax79NyflKXArw29YB3MkUUtuU/PcUoVoM+LkAU/+daADTYOM31lmdSEde65Pnjuw
	OzXVf3Uoojryk/UiQ5DkcZM05ta8L7gt5Fliqo52wcudGjSr+3gMmWs2oouWdBjF7efjpZsZGAf
	oTAraNxjdMFFUuNTvfQ6odZjn9o4Coj9vi2mdIx02JM74bbTr+ARrhL4AP3XA4bPt3qeGlCTvXn
	Sx8DZ7jjHpYU4hBuu33XgtmBp4NH3PzRJG2pjXZ3jA==
X-Received: by 2002:a05:620a:440b:b0:93f:6375:aa97 with SMTP id af79cd13be357-940ef9df9damr1400486085a.83.1793074941325;
        Mon, 26 Oct 2026 21:22:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:19 -0700 (PDT)
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
Subject: [PATCH 3/6] mm/memory-failure: keep the page online while handling it
Date: Tue, 27 Oct 2026 00:22:01 -0400
Message-ID: <20261027042204.3741307-4-gourry@gourry.net>
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

memory_failure(), soft_offline_page() and unpoison_memory() check that a
pfn is online, then sleep on mf_mutex before using its page.  If the
block goes offline meanwhile, a DEBUG_VM kernel faults on the poisoned
memmap, and removal frees it on any kernel:

  CPU 1 (soft_offline_page)           CPU 2 (offline_pages)
  pfn_to_online_page()
    page is online
  mutex_lock(&mf_mutex)
                                      offline_mem_sections()
                                      remove_pfn_range_from_zone()
                                        page_init_poison()
  get_hwpoison_page()
    zone_pcp_disable(page_zone(page))
      zone of a poisoned page

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000069e: 0000 [#1] SMP KASAN
  RIP: 0010:__zone_set_pageset_high_and_batch+0x89/0x270
   zone_pcp_disable+0x28/0x40
   get_hwpoison_page+0xc2/0x1160
   soft_offline_page.part.0+0xe7/0xbf0

memory_failure() faults the same way.  unpoison_memory() does not fault,
but it clears flags on the poisoned page and returns success.

Hold get_online_mems() from before the online check to the last use of
the page.  soft_offline_page() took it only around get_hwpoison_page();
it now takes it once, earlier.

With a kprobe parking each entry point across the offline, base faults,
or for unpoison_memory() succeeds, in 3 of 3 runs each.  With this patch
all 9 runs wait and fail with -EIO or -ENXIO, and lockdep stays clean
over offline/online cycles mixed with error injection.

Fixes: 96c804a6ae8c ("mm/memory-failure.c: don't access uninitialized memmaps in memory_failure()")
Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
Fixes: d613f53c83ec ("mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory-failure.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0c96eb5119976..cdae2a1988bb8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2394,6 +2394,8 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
+	/* Keep the page online from the check below until we are done */
+	get_online_mems();
 	mutex_lock(&mf_mutex);
 
 	if (!(flags & MF_SW_SIMULATED))
@@ -2608,11 +2610,13 @@ int memory_failure(unsigned long pfn, int flags)
 identify_page_state:
 	res = identify_page_state(pfn, p, page_flags);
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 	return res;
 unlock_page:
 	folio_unlock(folio);
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 	return res;
 }
 EXPORT_SYMBOL_GPL(memory_failure);
@@ -2742,9 +2746,12 @@ int unpoison_memory(unsigned long pfn)
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
+	get_online_mems();
 	p = pfn_to_online_page(pfn);
-	if (!p)
+	if (!p) {
+		put_online_mems();
 		return -EIO;
+	}
 	folio = page_folio(p);
 
 	mutex_lock(&mf_mutex);
@@ -2833,6 +2840,7 @@ int unpoison_memory(unsigned long pfn)
 		unpoison_pr_info("%#lx: software-unpoisoned page\n",
 				 page_to_pfn(p), &unpoison_rs);
 	}
+	put_online_mems();
 	return ret;
 }
 EXPORT_SYMBOL(unpoison_memory);
@@ -2974,38 +2982,42 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -ENXIO;
 	}
 
+	if (!sysctl_enable_soft_offline) {
+		pr_info_once("disabled by /proc/sys/vm/enable_soft_offline\n");
+		put_ref_page(pfn, flags);
+		return -EOPNOTSUPP;
+	}
+
+	/* Keep the page online from the check below until we are done */
+	get_online_mems();
+
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	page = pfn_to_online_page(pfn);
 	if (!page) {
+		put_online_mems();
 		put_ref_page(pfn, flags);
 		return -EIO;
 	}
 
-	if (!sysctl_enable_soft_offline) {
-		pr_info_once("disabled by /proc/sys/vm/enable_soft_offline\n");
-		put_ref_page(pfn, flags);
-		return -EOPNOTSUPP;
-	}
-
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
 		pr_info("%#lx: page already poisoned\n", pfn);
 		put_ref_page(pfn, flags);
 		mutex_unlock(&mf_mutex);
+		put_online_mems();
 		return 0;
 	}
 
 retry:
-	get_online_mems();
 	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
-	put_online_mems();
 
 	if (hwpoison_filter(page)) {
 		if (ret > 0)
 			put_page(page);
 
 		mutex_unlock(&mf_mutex);
+		put_online_mems();
 		return -EOPNOTSUPP;
 	}
 
@@ -3023,6 +3035,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	}
 
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 
 	return ret;
 }
-- 
2.53.0-Meta

