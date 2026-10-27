Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105497;
	b=vUxyD76fzN0hdCQZfqq+fmYCBBrIojRO0Ku3oRUD8PkUlxTF5bYAIy7D1pSpJri9E8Qv
	 ELKTP35c1sN19jgbauQxxZzkyR+Y5eZpLYeHaq9IP6tDjlt6s4WIET/WhsnG2h2nw2M4u
	 bj9ApFdg6dRJft3xgslpL/TDI+xAeWXEnl4vRwfWU2I4U1mwti23XPRJuaEz5SJwNNXtp
	 ptowssyeNjpcBR84OX0qW0Fj1y5eUfxz3lipGfNNCKEap4NBkyOi5MsYkQ/6drFMGCUgy
	 Z9fpjNFuC4NgxL1O299COZxBkKhNmbHDNoN99JMAn47gk7djQKRZuY2bjblgwqUJtLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105497;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8+uXv1eTUrQghL/izDMabbpVY73PTdHTwOJoJlIUerY=;
	b=sGLUNOSqAZdLg/BWK4AjNme70VsSGBYciJ2VX49S95uie7ntDRxjoJ/Dm2q1WiH0ptnt
	 E6xylJufzo+IOo6rIiy0NLM+wZ9tUpx9lqIa1t9FHi1MRZsJ2jEvizcUfz2QKHtwPvmqb
	 Av3SwyLAZl/wJW5bP1W61otmxVg4MvEk0XfAGPhb2jl4bPmqSF7FWAv+wN8tV/1zKWBjb
	 qulxXR/8jhm/BCB5lCnWHQoy0O8CCSGR1vOa6Pz/BMkgZA8GcBE4GVD3kcIoOpwC4Yl7F
	 lQOaeLhno5wg4g88E9oNgorNmL1dNAObU5M0+dfrbymGD1G5/FBUgozH3ASjsNhGJgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhL4d8Zu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A7606A31D;
	Tue, 27 Oct 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhL4d8Zu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC36D1F01825;
	Tue, 27 Oct 2026 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793105496;
	bh=8+uXv1eTUrQghL/izDMabbpVY73PTdHTwOJoJlIUerY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RhL4d8Zu1trOGOtBxu31hp1z9kcJI8StIU9PdApiow/lWbyJJBgk7hPgSOjQi+nAE
	 AKRePsFov/ULoC1TkpsBYIh6pWvxp8cze0hi1b2Wj8sLc9y3xwHg8T0wDhk0ansqEn
	 xFcuEFexIhMX1R7GeGxuEMbA0gzNR2uL86P4NnOrvqPqGKbhNY533fFW5lgDp3HMkO
	 504rU/EFttXr0YSzHwfQbLXRy4PfREzzWOw4vyCXu8y4Crjzx/Lypni7HK9LVH3BLR
	 jeWfadnld7ZEOg5OWEy6erd+YZ29bgw202P1j9QdjZ/At4MBlPey/BdaPcmJfXSfIR
	 LjesHhmkVS7rQ==
Message-ID: <9051ac3d-60b9-4ed2-b781-b7191898bc83@kernel.org>
Date: Tue, 27 Oct 2026 13:51:28 +0100
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: fix pfn walker races with memory offline
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org,
 vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com, ljs@kernel.org,
 liam@infradead.org, rppt@kernel.org, osalvador@suse.de,
 muchun.song@linux.dev, iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com
References: <20261027042204.3741307-1-gourry@gourry.net>
 <01d7d54d-0047-4eb6-a1d2-5b3f113f26cf@kernel.org>
 <179310071902.664110.12994053710961856591.b4-reply@b4>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <179310071902.664110.12994053710961856591.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 12:31, Gregory Price (Meta) wrote:
> On 2026-10-27 09:57 +0100, David Hildenbrand (Arm) wrote:
>> On 10/27/26 05:21, Gregory Price (Meta) wrote:
>>> Several pfn walkers check that a struct page is online, then use it
>>> after memory offline has poisoned it (CONFIG_DEBUG_VM) or removal has
>>> freed the vmemmap.  Five of the races crash the kernel; the sixth leaves
>>> an offline spinning with the device hotplug lock held.
>>
>> I have roughly the exact same list of AI garbage fixes here from a certain company.
>>
>> And I consider this all extremely low priority.
>>
>> So this is something to discuss throughout the next months and do it properly.
>>
> 
> I actually have a reason for these fixes other than "bot said bad".

So you found them on production kernels?

We did not have a single real report of that for probably a decade or
even longer in production.

Recently, we had the single first report about the compaction case from a
stress test (no production):

https://lore.kernel.org/all/20260903095543.3752338-1-yuan1.liu@intel.com/

"We are not sure whether this race is reachable under realistic
workloads or only under this synthetic stress test."

Where I motivated that we need something clean.

> 
> We leverage ballooning and hotplugging as VM memory overcommit tools
> and are finding that some of these race conditions crash them with
> large MTBF.

yeah, that makes sense.

> 
> While most of these are insanely narrow, they are not as unlikely to
> happen as you think. A vCPU can take a vmexit in these windows much
> more easily than a host can take an NMI or other interrupt.

Jup, that's what I would expect.

> 
> Thankfully none of these (or the other series) appear to be obvious
> security issues, but they are stability issues.

Right. And DEBUG_VM reports are irrelevant in production.

The thing is that the race between offlining and actual memory removal
is extremely long. Poisoning is just a mechanism to find these theoretical
issues that could cause issues faster.

And with all the other things going on, this has lower priority, and I
wanted to get back to the AI patches I have once the other thing is sorted.

> 
> I have a reproducer for every single one of these (and the other
> series) - but a handful are unreachable due to a 2-statement read
> being emitted as a single read by the compiler (which can be undone
> by a targeted compiler flag). Those were included for completeness.


In general, I think we want something that will protect all
pfn_to_online_page() + zone->contig thingies, not just selected ones.
We discussed in the past using some sort of rcu for that.

get_online_mems is usually the wrong approach.

The infrastructure for that should be added in a clean separate patch, not
mangled into a patch that fixes a DEBUG_VM splat.

This is nothing to rush in or to schlop around.

The AI patch for compaction I have here does something similar to your first
patch, with a bit less churn, and converts a handful more users.

E.g.,


+/*
+ * Nothing keeps a section online once pfn_to_online_page() has returned. A pfn
+ * walker that holds no reference to the page does the check and looks at the
+ * memmap under this guard: remove_pfn_range_from_zone() waits for it before the
+ * memmap is poisoned and can be freed. That wait cannot be interrupted, and
+ * whatever a walker sleeps on under the guard, memory offlining waits for as
+ * well: leave the guard before copying to user space. mem_hotplug_lock is held
+ * during the wait: never take it under the guard.
+ */
+extern struct srcu_struct memmap_srcu;
+#define memmap_walk_guard()    guard(srcu)(&memmap_srcu)


and then


diff --git a/fs/proc/page.c b/fs/proc/page.c
index 260772b20bd99..c5f6d7fe12d9a 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -58,13 +58,39 @@ static u64 get_kpage_count(const struct page *page)
        return ret;
 }

+static u64 kpage_info(unsigned long pfn, enum kpage_operation op)
+{
+       struct page *page;
+
+       /* The page is not ours: keep its memmap until we are done with it. */
+       memmap_walk_guard();
+
+       /*
+        * TODO: ZONE_DEVICE support requires to identify
+        * memmaps that were actually initialized.
+        */
+       page = pfn_to_online_page(pfn);
+       if (!page)
+               return 0;
+
+       switch (op) {
+       case KPAGE_FLAGS:
+               return stable_page_flags(page);
+       case KPAGE_COUNT:
+               return get_kpage_count(page);
+       case KPAGE_CGROUP:
+               return page_cgroup_ino(page);
+       default:
+               return 0;
+       }
+}
+
 static ssize_t kpage_read(struct file *file, char __user *buf,
                size_t count, loff_t *ppos,
                enum kpage_operation op)
 {
        const unsigned long max_dump_pfn = get_max_dump_pfn();
        u64 __user *out = (u64 __user *)buf;
-       struct page *page;
        unsigned long src = *ppos;
        unsigned long pfn;
        ssize_t ret = 0;
@@ -78,29 +104,7 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
        count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);

        while (count > 0) {
-               /*
-                * TODO: ZONE_DEVICE support requires to identify
-                * memmaps that were actually initialized.
-                */
-               page = pfn_to_online_page(pfn);
-
-               if (page) {
-                       switch (op) {
-                       case KPAGE_FLAGS:
-                               info = stable_page_flags(page);
-                               break;
-                       case KPAGE_COUNT:
-                               info = get_kpage_count(page);
-                               break;
-                       case KPAGE_CGROUP:
-                               info = page_cgroup_ino(page);
-                               break;
-                       default:
-                               info = 0;
-                               break;
-                       }
-               } else
-                       info = 0;
+               info = kpage_info(pfn, op);

                if (put_user(info, out)) {


protecting individual pfn_to_online_page is just whack a mole. Likely we want a
way to check whether pfn_to_online_page() is called from the wrong context, and
maybe we need a variant that can be called from "wrong context" for a good reason.

-- 
Cheers,

David
