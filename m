Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EA348C47
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683139; cv=none; b=Q088v1YVtuCUaBDxCeQkPQUYvm2c7ZuIK3BOJgoIzNUZx4EKBDp+KmXduek6nyhrCXOs4+MxKKTJJAp3yCUB7h6Aa4NDlrL/Hvrt7J9LUA0stpT14nreKWUHWShxehxtu9nh+/N7fUZ4l0S2NbCk4wUOeXfzLnV0JIwneAZ0Hh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683139; c=relaxed/simple;
	bh=BZC0rGREYDdz8ACkjyFyW5Qa+P9wYb1QujVYCeT996o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YpZqsp7TSlORdd0SXzHjsYdFQK/uiQL8okF1YqeqFdTuFQPnG60ltiXFXugC5nhDA+kaGmq5kYliqQ1CKFNvVXat4up37cQyyeGLpDlAq45C6LaNlMDbXIwGsEZjXRBXFvt+HnjghqQO9l8Q2E68LnbD2VjpKU4ECnPWemE78vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHA3IEK4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHA3IEK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782683137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SiJhyXhNBfsAzo8nGoH5kDNlW+30TFjfN78Hcf1BrTc=;
	b=gHA3IEK4nW/kLHy4m7C70726+gjXBOo5plDktHdwuOJnh0wnnppSgcMffqBFMH04fF/h0R
	ZDxkXKLQ/VPZDftBZEE0NyJc6m8qeAXdztPT8adcv+LRmiupvc3eM833mL9uNkQ7iUMUZ5
	iyN9NycYZL/jFsFAFk+rh5PbpuoQi/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-JMfSuul7OYuoqsJ0NNPzTw-1; Sun, 28 Jun 2026 17:45:33 -0400
X-MC-Unique: JMfSuul7OYuoqsJ0NNPzTw-1
X-Mimecast-MFC-AGG-ID: JMfSuul7OYuoqsJ0NNPzTw_1782683133
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-469218e618dso1541207f8f.2
        for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 14:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683132; x=1783287932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiJhyXhNBfsAzo8nGoH5kDNlW+30TFjfN78Hcf1BrTc=;
        b=o+cvLN+v7iiOIJL2+G9DJuzyDc5ZmxujcWBqXEnnRjTvLoGsqXmFPm+bc2Qp8JKM7d
         zIIEoe0tiAgitHEwE/oirMo4M4p3D/vTlIE+eKtCTcz704JS6D101ghxR/bh805TrbnQ
         lp1wWHDS1JIaf4nUHC2dzavxQshVywoADZU+VebE+MXHz7nnPAuhbz5TRpTftoMvGeZ3
         IuLvdhjpre51Vz99psWvJLQzbavyLqDwUhG9IeQSWW8pvyt6ksbKEb3YNYOE1wFtOmJ8
         d0oSzR6CNUsPwaOH/4Tg/pTDyVvyyXe2Q6XSMc7ITZXmYwIuEeAXFmzZOoogw3f9t98e
         vHPA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4AUAFrN3yjrZYN4SJMAMxA3jQ5xB0dDPcF8uFsytNJpSlOtnhXHYgVV6clANcfAFnbx/mzuP2C9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6iNFCQ3Iw0Z1yt0Ix16EJ5UCGZhWRHanGhhphdl1QRgeF5F1
	zTK4YUDv9+2XJz2rvJGL2kEJFaVmbG5yFBQPPpwolhX0LO3Dvpsi2uAXIM41VC38mwvdcgVvQMj
	JlTjXIfNAHU2mo+0FCAIASWRx+1BCj9h+JKVcGCTSxtc+x6ixxEO04XY0Mjb2ug==
X-Gm-Gg: AfdE7cn/TLFDJZYpjO1IH9zI9XCz5gVXuuB9AmZOb1jlppLJFPl8vRUpdxY+Sxw6T/H
	5W0J1Etb3h27AvMFbv8SVQGOfip+C2rvTzvs7DCsCQz0oqSfkS4TKqrA9sR385oJcH6B5HpoHSc
	0D0e+62lwGO7R+dFIVXrjIXmxyp9ndZGdBMLxgkphoVfCTjS/ZhSkna9ETJncSXAGNlnFoYA70t
	3rm66p19qy8xLKr7Q6wQ6of9StB3lPcM9tsvblF9QtXbZG2e2zDMybfyxOO1eCZ5zwtLPjNWL3V
	JGLTr89yWA2058JxNsd7meQb1cfYvQOAJJtt8LsB9FUOKh526X3VaCwrH9jIr50JLPPYZUY8+Um
	L
X-Received: by 2002:a05:6000:4285:b0:45e:fa7b:a7d2 with SMTP id ffacd0b85a97d-46fb6bf2caamr14037858f8f.7.1782683132489;
        Sun, 28 Jun 2026 14:45:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4285:b0:45e:fa7b:a7d2 with SMTP id ffacd0b85a97d-46fb6bf2caamr14037797f8f.7.1782683131891;
        Sun, 28 Jun 2026 14:45:31 -0700 (PDT)
Received: from redhat.com ([31.187.78.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f978dc0a9sm20747231f8f.15.2026.06.28.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:45:31 -0700 (PDT)
Date: Sun, 28 Jun 2026 17:45:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/2] mm: memory-failure: use RCU to fix HWPoison flag race
Message-ID: <e2d32b6bd7322f855ec8ae4ddda4b5ced27f261d.1782676497.git.mst@redhat.com>
References: <cover.1782676497.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1782676497.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -PFPvdnhTYfXt0v61WIiTnSWRiXo3GIxBV9eKCCiFiY_1782683133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Non-atomic page flag operations (page->flags.f &= ~mask, __set_bit,
__clear_bit) can race with atomic TestSetPageHWPoison() in
memory_failure().  The non-atomic RMW reads flags, memory_failure()
atomically sets HWPoison, then the RMW writes back the old value
without HWPoison - clobbering the bit.

Add synchronize_rcu() + retry helpers for setting and clearing
HWPoison, and convert all memory_failure() call sites to use them.
Follow-up patches wrap non-atomic page flag operations in
rcu_read_lock/rcu_read_unlock so that synchronize_rcu() drains
in-flight callers.

Note: the MCE handler in arch/x86/kernel/cpu/mce/core.c also calls
SetPageHWPoison() and is subject to the same race.  It cannot use
the drain helpers (MCE context cannot call synchronize_rcu()).
For recoverable MCE errors, memory_failure() is queued via work
items (kill_me_maybe/kill_me_never) and will re-set the bit via
test_and_set_hwpoison_drain_rcu() if it was clobbered.  The
mce_panic() path sets HWPoison for kdump right before panic() so
the race should not matter there.  The MCG_STATUS_SEAM_NR path does
not queue memory_failure(), but the affected page belongs to a
TDX guest whose CPU core has already been marked dead - the page
is not subject to concurrent non-atomic flag operations in the
buddy allocator, so the race does not trigger.

Fixes: 6a46079cf57a ("HWPOISON: The high level memory error handler in the VM v7")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Cursor:gpt-5.4-xhigh-fast
---
 mm/memory-failure.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..351f8bbda248 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -76,6 +76,44 @@ static int sysctl_enable_soft_offline __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
+/*
+ * Drain any in-flight non-atomic page flag operations that could
+ * clobber a concurrently set HWPoison bit.  Retries until the bit sticks.
+ */
+static void set_hwpoison_drain_rcu(struct page *p)
+{
+	do {
+		synchronize_rcu();
+	} while (!TestSetPageHWPoison(p));
+}
+
+/*
+ * Drain any in-flight non-atomic page flag operations that could
+ * restore the HWPoison bit from stale data.  Retries until it stays clear.
+ */
+static void clear_hwpoison_drain_rcu(struct page *p)
+{
+	do {
+		synchronize_rcu();
+	} while (TestClearPageHWPoison(p));
+}
+
+static bool test_and_set_hwpoison_drain_rcu(struct page *p)
+{
+	bool was_set = TestSetPageHWPoison(p);
+
+	set_hwpoison_drain_rcu(p);
+	return was_set;
+}
+
+static bool test_and_clear_hwpoison_drain_rcu(struct page *p)
+{
+	bool was_set = TestClearPageHWPoison(p);
+
+	clear_hwpoison_drain_rcu(p);
+	return was_set;
+}
+
 static bool hw_memory_failure __read_mostly = false;
 
 static DEFINE_MUTEX(mf_mutex);
@@ -211,7 +249,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 			return false;
 	}
 
-	SetPageHWPoison(page);
+	set_hwpoison_drain_rcu(page);
 	if (release)
 		put_page(page);
 	page_ref_inc(page);
@@ -1756,7 +1794,7 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * Use this flag as an indication that the dax page has been
 	 * remapped UC to prevent speculative consumption of poison.
 	 */
-	SetPageHWPoison(&folio->page);
+	set_hwpoison_drain_rcu(&folio->page);
 
 	/*
 	 * Unlike System-RAM there is no possibility to swap in a
@@ -1801,7 +1839,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 			goto unlock;
 
 		if (!pre_remove)
-			SetPageHWPoison(page);
+			set_hwpoison_drain_rcu(page);
 
 		/*
 		 * The pre_remove case is revoking access, the memory is still
@@ -1878,7 +1916,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	head = llist_del_all(raw_hwp_list_head(folio));
 	llist_for_each_entry_safe(p, next, head, node) {
 		if (move_flag)
-			SetPageHWPoison(p->page);
+			set_hwpoison_drain_rcu(p->page);
 		else
 			num_poisoned_pages_sub(page_to_pfn(p->page), 1);
 		kfree(p);
@@ -2390,7 +2428,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (hugetlb)
 		goto unlock_mutex;
 
-	if (TestSetPageHWPoison(p)) {
+	if (test_and_set_hwpoison_drain_rcu(p)) {
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2420,7 +2458,7 @@ int memory_failure(unsigned long pfn, int flags)
 			} else {
 				/* We lost the race, try again */
 				if (retry) {
-					ClearPageHWPoison(p);
+					clear_hwpoison_drain_rcu(p);
 					retry = false;
 					goto try_again;
 				}
@@ -2441,7 +2479,7 @@ int memory_failure(unsigned long pfn, int flags)
 	/* filter pages that are protected from hwpoison test by users */
 	folio_lock(folio);
 	if (hwpoison_filter(p)) {
-		ClearPageHWPoison(p);
+		clear_hwpoison_drain_rcu(p);
 		folio_unlock(folio);
 		folio_put(folio);
 		res = -EOPNOTSUPP;
@@ -2761,7 +2799,7 @@ int unpoison_memory(unsigned long pfn)
 		}
 
 		folio_put(folio);
-		if (TestClearPageHWPoison(p)) {
+		if (test_and_clear_hwpoison_drain_rcu(p)) {
 			folio_put(folio);
 			ret = 0;
 		}
-- 
MST

