Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201012;
	b=yMGfoWklGmjxGN4FMJ8QStvk+FlvhOTAZaWSXYdb7j4S94WGXVD3fwfRS1HZD7pOElqq
	 m/hY7vMD2IDvOBvGzlnhveBDJKOVrPgsIT01UVfj4KmUlToc/CnTHOJCuRlJNri6BWPsv
	 wl9yxsWXKVmjk8tVa79vaKsY9ez4WQrQEyxyj76qiNEEDO8J5VACWIFfB6paHSkRf+8Yo
	 r8Q3roR3RQm1kzXU3yAg5PXeCp5dHmVVNDGvE6TFecvu/bqrPL56GW5QWij9bT7pee9Zw
	 5jOSa/UvcwsuooUy7HDS+kIJt9Jo7+5E0B39KlP3bY7CWpZAxn+pcsNwNGiza4ktBrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=CO2FmI+t47mxhoA5B32c/6+xEdoEj1zDOKWg0tAGKfI=;
	b=UTmyK9TUk8uzk+IDvK0LcmU2vrIrhm/QjD3ozIdWsWw8BL9BRKCJgKVEi4XHTEOq2/sd
	 3k2ilZKQuia77RSw+t1aRSG0aXCfLmC3j24ALBeRw5LQryHs9M0vUGSQkghJUONss3Rkz
	 zENtCvDRwAViXYT0jq41uQmuEa56edKn82I3u71t0KVYsJjszRumDYwtmyFNvRPp3SlZz
	 Wk+d3ntfY1dlsfdbTmNCvUg2Vk91JnJorATnkQ5Fj/dAZvT7uPDG6wR++I6OfCjITAzMm
	 AF3BGgqe3dspqQaj4cg8JlmLt8YRD0GQ7S6xbdkBbuMZekziHQsIRas1T9Sa5wOGooQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EItwh9YN;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271960A2637
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 18:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E271960A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EItwh9YN
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9212dac247aso14137226d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795201001; x=1795805801; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CO2FmI+t47mxhoA5B32c/6+xEdoEj1zDOKWg0tAGKfI=;
        b=EItwh9YNKW9pf3i/0vZ29SiS9P8j0QntBkSZlZWkAbgPf469odvYPi59InAkSI+FHj
         oJH1cI9uRxoEpG/9Jw6zrjqXbCWu2B/T7yOurq7TU5R+/jIZwViFq8biaqHAfQzt//Hi
         Zz8LYriCwByz3fv69UXxOW2X4hHN1a4ZSnDxNWObfy3X3AWRD4GQDAezhNQKexBztOAO
         P0Bied3oVorOFbttkeYH3mAV0beqC2Yp0W4Xrc4EEdg9Qqw2RIkmdSrrYZZ4gUdvn0/4
         13Va7FSAQ9FuYLOE9UcA8WQO5n1uzscOJReJBfV2ro1cYtaZ7iEfQku4yAipDNQic4eV
         qQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201001; x=1795805801;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CO2FmI+t47mxhoA5B32c/6+xEdoEj1zDOKWg0tAGKfI=;
        b=VT9THUnef2OWG+TxP60rfA1s+D0l2hQqvm2wpxiWc/Q31nj2A7NOZuWgE9SIwECdCD
         ADrLRmZ2o5cCsW+9Xru5ivdUaNB2KPpQZYmEp3Bi1GFoHEUvM5vMvHiCGyIpQ04mAe+f
         ZSY9XRrpX/ZJc3llJG2ozLam4qCui88EPlDnA7l37sAlGdxPZpj89xBhFFna6LoW7JwN
         wvkYoSVFdC7INZ2pUdx8bHOOXH/WwAqzTOPHXLFhHyNKGGKbqEXa9tk6cEkRVqVIQxZG
         BCNyiJufHbfGU70pc+Oet0q/EJWwVi+YcdUw4yQ3uFoBICYEPl5FrSraZPGt21f6sp7F
         3y8Q==
X-Forwarded-Encrypted: i=1; AL+hErGySJXn3zZBnD/VmgmEnU8fLtMSTRWMc+0VHrU8UxKPyM0XGrecVC09QaT1En+XzO7kou2i2coawN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BM3GYJKZRaSy+0G/p+b+rPXsV+2K7HOMjRPSE4zJmgaNyLaXc
	AhYikjotjKCwlgh46Q64HCsiinnlmAaKUX7pbgAWlLBvLf9DgQrnpwz15wnYdFh5Ajc=
X-Gm-Gg: AZFdTZcI0G1hzrj0uKmYG8EWZSgF+RAM77qpWUppMhLGNGKZk5SFoqyuD9ElcVkVeJ8
	/NghkKIaWFWewXsk5r6+8mnipBaruO3FrC0D0UFWLAlq8PGC0ZEEdMOzlj1JFBomDhdQCL8UHxm
	hLYzYbB1FQ62pTxjcON0K36GHILSvOc4WJNTFHum5z6S4M5QZShYHDFFFSQSZGXxHasbYsUt5l7
	6Ujz6b8oyq54Gf3Nw4ttKFKb5CTPvINRmef2mX8q533LK55NDg7e7Ahhle3cACwfG/bGqXZUpvT
	cS29X/7sYrZC38MiomhudcH+R9YenS8Oiu0tORQ/O1LTBRlsD29GY6DRH8TFHBTpLZmu6YfwwdX
	dxQxhkJDmVzzB7IMq/xBIHc1Lzige3JMOYlAEM/heafH/SGtPgEF0q0bV7QGrwhOsChIpapNbxr
	PHimzRzOZIt/sDFQigiBlr83kBk8ir5vu6a5es95YS/aXvEPt0L04Vkf4ROrK5NoOedhAM1rP+x
	DDKT2Qrp7SyNWmHY/PdAeT67jYgy75QzJQ4WoS1ThIgHRrs9x9fVqyOWlxjYYvkyPzIhq4D/AF9
	b1+HEbXrrwkhLyH8M9Rq8wqpLi6Z/3l69LuC84vbjb2aaqHc44ND4zHNj5hsVAHAVBFUEhKKBJB
	TuXxrU2A=
X-Received: by 2002:a05:6214:320f:b0:921:3541:ed1a with SMTP id 6a1803df08f44-9213541f3eemr56576466d6.32.1795201000560;
        Fri, 20 Nov 2026 10:56:40 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm26687146d6.27.2026.11.20.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:56:40 -0800 (PST)
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
Subject: Re: [PATCH 54/60] mm/migrate: route explicit NUMA migration to
 private nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, damon@lists.linux.dev, nvdimm@lists.linux.dev
In-Reply-To: <sashiko-outbox-225861@kernel.org>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-54-74f5f9a115c2@gourry.net>
 <sashiko-outbox-225861@kernel.org>
Date: Fri, 20 Nov 2026 13:56:34 -0500
Message-Id: <179520099481.412063.3035407964761903218.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 18:42 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/migrate: call to undeclared __folio_alloc_flags() in
>   alloc_migration_target()
> --
> 
> commit ca3cf1708bab40e7c2c443ad00cbc882e2163cee
> Author: Gregory Price (Meta) <gourry@gourry.net>
> 
> mm/migrate: route explicit NUMA migration to private nodes
> 
> This commit routes move_pages(2) and migrate_pages(2) allocations for
> N_MEMORY_MEMPOLICY private destination nodes through the node's private
> zonelist by passing ALLOC_ZONELIST_PRIVATE via migration_target_control.
> 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 6791834f14fe1..eda961d43df0e 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2250,6 +2250,9 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
> >  	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
> >  		gfp_mask |= __GFP_HIGHMEM;
> >  
> > +	if (mtc->alloc_flags)
> > +		return __folio_alloc_flags(gfp_mask, order, nid, mtc->nmask,
> > +					   mtc->alloc_flags);
> >  	return __folio_alloc(gfp_mask, order, nid, mtc->nmask);
> >  }
> 
> [Severity: High]
> Where is __folio_alloc_flags() declared?  Neither include/linux/gfp.h nor
> mm/page_alloc.c defines __folio_alloc_flags() or
> __folio_alloc_flags_noprof(), so building mm/migrate.c with
> CONFIG_MIGRATION=y fails with an implicit function declaration error.
>

b4 dropped a commit on me when i made the prep branch because it
it was tagged Author: Brendan Jackman and I filtered on myself.

this commit should have immediately preceded this one:

https://lore.kernel.org/linux-mm/20260923211041.3127588-4-gourry@gourry.net/

the branch in the cover letter has everything

I will respin this again, but i'll address the sashiko reports and
let this sit for a bit.  The first 2 chunks are still largely
reviewable.

-- 
~Gregory

