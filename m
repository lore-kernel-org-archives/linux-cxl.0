Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014796;
	b=Fh0mWnQcTI20BpsAIYFWyxoKdWpGsrONqYsmG2hTFWIp4oEH6K3vh+EAKs3fnCeIMmfj
	 mrodYfooxv9ZV5wf/GZYe45kfPjVelwDHQDqFoWldIM85EnuGyaajtVVI3RsJZuBtBfd9
	 xR2HvgdV2nlh5ofGzralLhLaWuWMvBYA84B9gyax41JElf+ozJ8Kcbq3u9NsYqjxs5UWF
	 XIXdHuIp3gz3SHBXL6YUFRbdaFULWVS8mEdLWrqX8L1cOfj5lZNV8LH8cwf/frIsFSycn
	 6AO1A7Q1jallupsbxbZsHOkEWB3tHhr/VlTru+sEu092iCDVKRrNGjNbb9YeLiXNfuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
	b=XygDq2ZnAUxQu8mZKo0P/UFO/BXuFMnxHEEx+87XHqCO4uQVgwU8y305jlsiPDEONHnJ
	 TvYgGwJgYkQCehEsqg5uUm4TmjyU/Wx2uS8fet3jalale6CgCSfFbtRtflZHbYgUlvS9+
	 P1isklp5ly1SBq0Ks6KYYIh7GngUO3JlVuYwcV63v+ChkdKoIIC/u/3SOQYNf+L7VWLkz
	 j5v8yz6ozpAH6UHqf2FWLIvPG/DVc0GNpMOnlnyC3Eb1hEExfQGWQyBBq3qn81pm0BuRS
	 x01g+b2FuQ4hisn1tVewHh2o+O5v8vS1YpnjFj6JbL8rHjGGr1NBYz4n0feY1PF16RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EaNntw86;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085F606A320
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 15:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0085F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EaNntw86
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94961ed97bcso133557085a.1
        for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795014795; x=1795619595; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=EaNntw86OliWenC+AEw8YZaqX/CpkEbuj/R83uxmt0euRu7q4F2m0octKXwFVihjk8
         dg9+4SMbEuteeVIYXzzmNfX/GhJAD2I5TAVlrjYtVKgH9HZf3H9sOEWDi6erVJGPVQR2
         MOUDAtFaOSguVvmB6Aeyd+dyvpdoItqLgrfZkjmHPTZWLIi47UtkzxoGuplmxuiUXO0v
         tyGF3tjz3s4yV7eQvQapqnqBjZtdFZe/FW+VRXsn3qhQN1hGCbekIeZCld143MCK2+pP
         fZ/U2FUvwPZemSkqE/IxMsmjkki3bWHrx43vsMaI4rDk0WQbZdG7s4De/itz35E+w/xw
         0AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014795; x=1795619595;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=v3SHmO9tHKKV0tNct3eC1+lA6izZZmwN6dbRGjTiHZQGTNpLoI4U8Fs5ApTC0W7I5n
         PU8siGCNVc+1DfSMJWSWL1Tlm9uwyN9vtjEHhPgqBSNucRLV156qZzJgTiyMBGP3Sro8
         xe3JScyadK2V3KRy4GwOm70nyTj77kxZF1pFC+2eUsJZBUtZPDcgaHNiQNa+zTxK1CuY
         0Cdff7E0l0MksLs4EmRgf2U6fe1R+DDDDZOAPv5ucxQeonP+fERh4T4DGwxIVUdet6E8
         I5X7mifmlmqR2tKv+Og/pSBFdU2yQ9NIqB+aEnyo7Me0hEDtyikgfeki7SV1f3jz/DSr
         5x9Q==
X-Forwarded-Encrypted: i=1; AL+hErEy0efOXGj89gdEWa7FkgYR0e7sSrP22gHigfo0LOcf3Hn1Q9OcmOKDoPYNgiLQfn9yJ+IXhf1A+28=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GSPWUQzHY++DDjQpL7q+5CQdEWnnI1AdwtzQXv165X90OH/Km
	GiUKEP1mELeoY64dojsi4W5xihAePbXiSRBICePfRT1NBqgz0yuXPwS7L368OR9uI3o=
X-Gm-Gg: AYBFou1xxMGjaKVk0Y9dnctQm7CMfisM2iP0fRCXaqUDZO/J3ALblXroM/B4VNXgw8b
	P4e96gxyww/3bZY5x3BpGm0DxCVyIe/MMZcpkUDeLnGAqwlxW/Cq2aN+tHB6NtEznm9URkgSgRC
	lwWnayIbK/4JsohogDD9WdEp/mtVT3AtCwsLM7J4kv5zk3YfT5FXapH2fSVjxoLdkRmr4BOu8Pq
	ddXTdg8WJ5LbVdSlbzrqWAYhD98p0co2FXWd2IvaNfaRcA88mBd8Lgur4B7Z3sKyKfGPkedoEYT
	PKBC/0jS/MFQbOMFuCk+APMywU5kaQibRSTEZms33PwvBG2PEsXU92GT9+60caoCPQTuqYJCvsP
	3sS23OzFZzq15Az69F6O6XDVy8HrC3SrkuTGxvZVIeaWE73VO3Dr3Vd3jXx7ADpqdGr9Zg/dhx8
	A3RUY8IDqGcZvzprNiHKTd8+gjE9CBfvDpCWJU59fb4hNjDnKnL6Q61hwgTAeObkWQsmJbYhrw7
	rcy/Qeerfexayws0sj09gPr22u5OX+pEKk/AXw1xQerjZWE0TKoTgyLm5pas6fNug77yHDr9rJj
	IixSmW7SXofz/VvzTp1tZh/tqqOiTUxy+ivPAmt9gzd/F3d3i77emutYw9zZ5S9j0PdABYjeybv
	Jds/mvd8=
X-Received: by 2002:a05:620a:444b:b0:949:6d95:f63a with SMTP id af79cd13be357-94999810096mr508584985a.78.1795014794676;
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d70a8fsm23976506d6.30.2026.11.18.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1DvCQd_OvkGgLU@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <av1DvCQd_OvkGgLU@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:13:12 -0500
Message-Id: <179501479267.1206716.268867271510310543.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:01 +0800, Richard Cheng wrote:
> Hi Gregory,
> 
> I've browsed through the serie, I'll go into detail in each patch
> in the following days, for now I have one general question.
>

Thank you for the read and the feedback!

> I wonder how the "common memory only" rule is enforced ?
> 
> As far as I read it, there're 2 ways:
> 1. The zonelist, you build them from N_MEMORY_COMMON, so non-common
>    node isn't in any zonelist.
> 2. A check at the call site, e.g. node_state(nid, N_MEMORY_COMMON) or
>    folio_is_common_memory()
> 

Those are essentially the two cases, which are already present in the
code in one shape or another in the existing shape:

   node_state(nid, N_MEMORY);
        or
   folio_is_zone_device(folio)

With the exception of one or two places, the series largely modifies
these locations to use N_MEMORY_COMMON instead (or in addition, in the
case of zone device).  There are a few places we add common checks where
zone device checks were not already present (because they were missing
or did not apply, usually PMD scenarios).

> 
> Code reaches a node's memory in 3 ways: zonelist, node id, or by folio.
> I couldn't find a statement of which mechanism is responsible for which
> kind of path.
>

Being a bit more precise: How do we reach a node's folios/pages?

 1) through some kernel structure, obvious examples:
    - page tables
    - VMAs / pagemaps / xarrays
    - LRUs

 2) pfn walks
    - memory hot-unplug
    - contiguous allocation
    - DAMON

 3) page allocator
    - freelists (page allocator)
    Sort of its own category since you ask it for folios from a node

> I see some consistent issues,
> 1. zonelist paths are covered by way number 1. Some of them also carry
>    way number 2, some don't
> 2. node id and folio paths can only be covered by way number 2. Some entry
>    points have the check, and some do not.
> 
> I can't tell when a call site has no check is deliberate or missed.
> This matters once non-common node gets its own zonelist, as patch 4 metioned I think?
>
> Could you clarify the rule ? e.g. which zonelist users must filter on N_MEMORY_COMMON
> themselves? and why the zonelist alone is not enough for them ?

Some of this is obfuscated by the fact that the existing code already
does this filtering for you.

I suppose I have some premature changes to add additional filtering
where it isn't needed yet to reduce the complexity of later patches,
but I can see why this is confusing when introduced by itself.

Consider this:

-       for_each_zone_zonelist_nodemask(zone, z, zonelist,
-                                       gfp_zone(gfp_mask), nodemask) {
+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_COMMON) {

This is a bit of a preparatory change to later convert this to:

+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_RECLAIM) {

It looks like we're filtering by N_MEMORY_COMMON, but we're actually
iterating the fallback zonelist (constructed from N_MEMORY_COMMON)

  struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);

Later we update this node_zonelist() call to determine whether the
private nodelist should be walked, at which point you do have to filter
for service support.

> Whether every path that takes a node id or a folio must check N_MEMORY_COMMON, and
> which ones are left for the feature bits in phase 3 ?
> 
> Let's get the rule settled down and make it as the foundation as well as phase 2 and
> phase 3 ?

So:
  1) If you're walking the normal zonelists, you're already filtered

  2) If you're walking nodelists, you need to filter on N_MEMORY_COMMON

  3) If you're operating on folios, you need to check common_memory()

  4) If you're walking the private zonelist, filter on N_MEMORY_COMMON


So let me do this:
  1) i'll restructure this phase to omit premature changes like above
     (they'll move into N_MEMORY_PRIVATE and N_MEMORY_<FEATURE> commits).

  2) I'll restructure N_MEMORY_COMMON commits here to handle cases 1-3
     above in that order, and that'll hopefully clear up the confusion.

-- 
~Gregory

