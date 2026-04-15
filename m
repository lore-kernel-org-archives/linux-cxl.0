Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF13FCC
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219834; cv=none; b=dzTi/OJklvfQTiMXQWkPz0cfVfmvcp6I2mJa3wdqujKpzmlB+hdSX5QWGsmO296vTH+Ot+DskMZZDipQkt4oux8Uh7IG+kphHTVzp1LpZKHDpzlbESSxCV8wtLdSSjHAg37hZRMwovFsdOlbHzFvyxcP1KM3pP+IGvNy1S7TiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219834; c=relaxed/simple;
	bh=1qYzuPfEiagDAJsWVpKR2GhgDpXMsF1bWLnPT/gVGyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4i96Vo+ZK53fxbWMpgEBhbDAaj6zUWUTWTBQVzCWh7+NDl/Dx9w9XNvU6AOCcu65XG7CrYUPzMhBC6Cem9RaZ984dLB2Oe4Cyf+4vU06eYc7xAOuVB0U2LwPt4xNzBasxqKb8U9WPpzWGOFONeRw6DqoyQ+hn/4aVwH/FP8tZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bQWmCSQ6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bQWmCSQ6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso3083222b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 19:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776219831; x=1776824631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AS7olroNFEXattkGrKD+rS7tU+zP8C4dXdnIq/RdScM=;
        b=bQWmCSQ6xBvFvYK4SC5b+SjtAZFCF8Az/Bi2HFfLctCNuflpsLhay8mVG0rYlDwUHe
         BaipAsRpGFw/X1QE8oe6KVDcbK4ayIj9xMgdb4U6H/QAU5q9rQLt3LvA6wduqV3fR/9B
         kRjJnJL/FG0BXZowz7sefhE9edmeuv1lNGxwWbzIwdHxJP4pkW6vgRNGUD4aecx+M2nr
         4Dg5UvZ3SY2gYM+vocwLWzACSrV+1+4DLGkV4Gsah2csZtn/njnPdhTpddISUlaqfMmZ
         zdbXHqaTdZwrYDRL4ADeEWg1wDD9zvEEfKgSb510RzPNCKZ2vZyoRVEUXF1ruvc6LqAN
         vRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219831; x=1776824631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS7olroNFEXattkGrKD+rS7tU+zP8C4dXdnIq/RdScM=;
        b=N67M9cSJpZnisf98GfXvKY6stHAS7q2UXBvohOHh2rElA33JN+bniAkcqfNVc8Gr3c
         f7OOCBfGJUDQ/j1eS34up43/LNfojlx/6X9vwv4u2Frb0rx+WHTgVGvGZ0E9jolkJ5lN
         Q8CY4ptXCwjvQw7JHZT2rRfl7+CYXQ8SxPZVza1q/ZPlT0opmt6IJ9oEXTQJ9IkGzIVx
         4FCkS5q//NLrzeCB2z6si94fEzNiJ952iZtAKNaCKfPIR2obHG6lehOW+LgFDeObkO2M
         2R2iBZdrMmjof9mCxXpOQCBq1bjU/63hp2wb6q87rHWTkQY98JaK0oOC6tkUsza5wDdp
         E9/w==
X-Forwarded-Encrypted: i=1; AFNElJ97NkZFmp0cjgoU3C8j3L3HL0CieRxxdYCFi4MkOb13yg7EcK2JPdglzMMKmw9EC5tPFLkz+7u/08A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzLXfVkiP8/NpYEXEUy+F1b1Wp2PzaklAIW/gmOsbAwZEyFgQ
	Qvn0OWNUQEvS6w5umnMWrLI3OGmKux0sv20bOIKBRfTUbgqzAGA08dbsYHjQslE41jk=
X-Gm-Gg: AeBDiesXTa0HsbGXssye82bpvrp15YOmxIvkOrcPXz34xdXQ62ZUCiYbDTGRkg+Yccr
	eh+v6oUau4wM8J/n1yUpF1JoXwAbZgfklJ07U2Z8LGomPXMB6i5GRRPcsLKKqq4qaqlhEVSoxBP
	JO9SKFdFT7JBHwnqfKYCRf2Ay41EjMO533TbpEnc2rGYx6S/rHrjQpbaxRWNx07KrXbuSeei6OX
	EeDz9skllUX+jCTbQMHi0mhON1d16jKaF2Xr3csIPjHkOwVic7HFfyN0ZTMV/TUC3GViTc9I/uB
	iwG2NA5++KZv8KOAplDRyUm24MCzIiM9Ny5dIk7XoVPmLm95gXVk2mzeOmUKiiHmoMLY+Qd86QY
	eTpP7CQAvUyJA4Omhx6YUAh1zfNS12YsLI8CGe/s3Wmlo98vq7FGePfRFsAsnV7i/My5W39VRcT
	aX7JHm/OZAByqvSbEckQ==
X-Received: by 2002:a05:6a00:cc3:b0:81e:1b77:9e61 with SMTP id d2e1a72fcca58-82f0d379ba8mr16521188b3a.25.1776219830661;
        Tue, 14 Apr 2026 19:23:50 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::347])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f69ef0b34sm102517b3a.31.2026.04.14.19.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:23:50 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn walkers
Date: Wed, 15 Apr 2026 10:23:26 +0800
Message-Id: <20260415022326.53218-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When memory is hot-removed, section_deactivate() can tear down
mem_section->usage while concurrent pfn walkers still inspect the
subsection map via pfn_section_valid() or pfn_section_first_valid().

After commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
memory_section->usage") converted the teardown to an RCU-based
scheme, the code still relies on SECTION_HAS_MEM_MAP becoming visible
to readers before ms->usage is cleared and queued for freeing.

That ordering is not guaranteed. section_deactivate() can clear
ms->usage and queue kfree_rcu() before another CPU observes the
SECTION_HAS_MEM_MAP clear. A concurrent pfn walker can therefore see
valid_section() return true, enter its sched-RCU read-side critical
section after kfree_rcu() has already been queued, and then dereference
a stale ms->usage pointer.

And pfn_to_online_page() can call pfn_section_valid() without its
own sched-RCU read-side critical section, which has similar problem.

The race looks like this:

  compact_zone()                    memunmap_pages
  ==============                    ==============
                                    __remove_pages()->
                                      sparse_remove_section()->
                                        section_deactivate():
                                          a) [ Clear SECTION_HAS_MEM_MAP
                                               is reordered to b) ]
                                          kfree_rcu(ms->usage)
      __pageblock_pfn_to_page
         ......
          pfn_valid():
            rcu_read_lock_sched()
            valid_section() // return true
            pfn_section_valid()
              [Access ms->usage which is UAF]
                                          WRITE_ONCE(ms->usage, NULL)
            rcu_read_unlock_sched()       b) Clear SECTION_HAS_MEM_MAP

Fix this by using rcu_replace_pointer() when clearing ms->usage in
section_deactivate(), then it does not rely on the order of clearing
of SECTION_HAS_MEM_MAP.

Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
This patch is focused on the ms->usage lifetime race only.

One open question is the interaction between pfn_to_online_page() and
vmemmap teardown during memory hot-remove.

Could pfn_to_online_page() still hand out a stale struct page here?

The new sched-RCU critical section ends before pfn_to_page(pfn), but
section_deactivate() can still tear the vmemmap down immediately afterwards:

mm/sparse-vmemmap.c:section_deactivate()
    ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
    usage = rcu_replace_pointer(ms->usage, NULL, true);
    kfree_rcu(usage, rcu);
    depopulate_section_memmap(...);

That looks like a reader can observe valid = true, drop sched-RCU, race with
section_deactivate(), and then execute pfn_to_page(pfn) after the backing
vmemmap was depopulated.

Callers such as mm/compaction.c:__reset_isolation_pfn(),
mm/page_idle.c:page_idle_get_folio(), and fs/proc/kcore.c:read_kcore_iter()
dereference the returned page immediately, and they do not appear to hold
get_online_mems() across the pfn_to_online_page() call.

I am not fully sure whether that reasoning is correct, or whether current
callers are expected to rely on additional hotplug serialization instead.
Comments on whether this is a real issue, and how the vmemmap lifetime is
expected to be handled here, would be very helpful.
---
 include/linux/mmzone.h | 6 +++---
 mm/memory_hotplug.c    | 6 +++++-
 mm/sparse-vmemmap.c    | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 238bf2d35a54..0e850924cbeb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2014,7 +2014,7 @@ struct mem_section {
 	 */
 	unsigned long section_mem_map;
 
-	struct mem_section_usage *usage;
+	struct mem_section_usage __rcu *usage;
 #ifdef CONFIG_PAGE_EXTENSION
 	/*
 	 * If SPARSEMEM, pgdat doesn't have page_ext pointer. We use
@@ -2178,14 +2178,14 @@ static inline int subsection_map_index(unsigned long pfn)
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
-	struct mem_section_usage *usage = READ_ONCE(ms->usage);
+	struct mem_section_usage *usage = rcu_dereference_sched(ms->usage);
 
 	return usage ? test_bit(idx, usage->subsection_map) : 0;
 }
 
 static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long *pfn)
 {
-	struct mem_section_usage *usage = READ_ONCE(ms->usage);
+	struct mem_section_usage *usage = rcu_dereference_sched(ms->usage);
 	int idx = subsection_map_index(*pfn);
 	unsigned long bit;
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0c1d3df3a296..335835abe74c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -340,6 +340,7 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	unsigned long nr = pfn_to_section_nr(pfn);
 	struct dev_pagemap *pgmap;
 	struct mem_section *ms;
+	bool valid;
 
 	if (nr >= NR_MEM_SECTIONS)
 		return NULL;
@@ -355,7 +356,10 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
 		return NULL;
 
-	if (!pfn_section_valid(ms, pfn))
+	rcu_read_lock_sched();
+	valid = pfn_section_valid(ms, pfn);
+	rcu_read_unlock_sched();
+	if (!valid)
 		return NULL;
 
 	if (!online_device_section(ms))
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 717ac953bba2..05f68dcec0f8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -601,8 +601,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
-			kfree_rcu(ms->usage, rcu);
-			WRITE_ONCE(ms->usage, NULL);
+			struct mem_section_usage *usage;
+
+			usage = rcu_replace_pointer(ms->usage, NULL, true);
+			kfree_rcu(usage, rcu);
 		}
 		memmap = pfn_to_page(SECTION_ALIGN_DOWN(pfn));
 	}
-- 
2.20.1

