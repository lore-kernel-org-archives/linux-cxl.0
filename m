Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015527;
	b=iNVj4rsx5P9hkZRNMDmfq9SFYRL3NrfchCL4dGlwr17Z63rDL3IJqffBqF0wsRf7qBdW
	 0xTrECQdYJvYnRTxLSKS7ouc9qYXqqtVAhT5ob9ounbzXxKxDBuYyYUWXCdYLn1Gdc6Rt
	 wk9zMaAJvyBA64oi5i+g1XYohJ8wQ2WFLHvETANSJuogjJjYCG+pQl5+TJwI2kK9GIB+/
	 g1gMbnqiIE7qoQvXwD2ELY57ej+Mr7laBCUe8mvagfQC68hSpXdz8m1DF5VCN8TSOTgtE
	 fcaVfTC9DhjQpyyeVjbKLSfmveaPkYVGQOnojIjddDjnKUW2B171l0uPmGg592C8yTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
	b=lQtSYL3uqJIkHSuglJa/PCFC+0tjaxMgW6tTwGg0nXpyByQyFJN0rIJEmKfcTMbkSZV4
	 uOcHsknxfm3jqZAP9YedHXe6caE8trq4J68cqqm7S5ST6z5mQ28g03tyjfJz1HRER4k6O
	 JzArhBCSMACS6klSNVxrSvUvvHnc3NXnSpfg9QaSbs+RsE88RuID7sFJ8vDfON35zCsYT
	 6+NPYpd2LB3QBFsh7xyS3CHi43IoYZgziEvrHsWgjJtYan1EUDKMFwpbk+OtUHaij/KBR
	 936s6vlJ7B59kfV8ZpHia9EopDWHVfDzhrn4DO8no2oyhij1MoXMthvcMcOISKIvD9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jkZEPAu8;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4A60A262F
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C4A60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jkZEPAu8
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91e7af9a67fso6558726d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015525; x=1795620325; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
        b=jkZEPAu8G20dCMvp4wOqgPO0yASbJPGo6TZFMEVOnKUdDpBmEyKfI01QGahGYUWTgZ
         6rvG+N243czLM9HKkvkmHsiJb9ZvM4M/fZyW2BhlVIye2uekD8TTxu+s1qLJIpSDQ7cP
         9hi45s8gqaY67ARzEu79KD7plOLEcTzwXFpRdPyxa7RESrACnv7wXvjGt2mToZGmnehS
         JSqOZ7ighA+zighnUNhC6662LdHcCZjcdWBkLgyzEbo3qSBV9DplCJ5sVYDimiwNOJ/l
         z6IGWGVC1ADaY55tKPi7ed3N21OLLXvs8O7Ai3vdZL5AbhWkgCdNRI2ur8QP/ofCfRdn
         y9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015525; x=1795620325;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
        b=bANh8tBhhS/j9JPzmkuCqPbzqitPEvaPD3HlFbWHgVufz8mSAHCmPjIeTRBy0nL2Tm
         aGhjR82SC3ndY7/gPMk91pvRiaztGcI+wJSQIkFm/DgxJcqQzI9AVgi6Y8YTHCKvo9aU
         L1iZ6XLOStoZ20jCB0mgSkOi7iB0TN0Af8lQfyKo8FGF77ixvCrUpQihRYHk1eYie73P
         threbZuWApByO+hS8uRZKAEzfepKj6JlL4ESUOlUhJU6my8KlSI0Hm5zPETfFl3yv0HA
         mzjT0klcm7NeHq7R6V2Os4iJqsORjMqhA8qnDl33Te8VDjpO31XRCbELa8wWGWXwNvua
         C3qQ==
X-Forwarded-Encrypted: i=1; AL+hErF7KGH9BD51kcCC1Q5VE9NhkTG/qZeEdjMVYow9SHwwImTYJZhb0jkRBwvPF4WxbUSIYnzi9oPZNEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Aeu4pFj5sSPH0FKkzoH1VdmlyozdUL0c53lO/Fpg3riIEWt15
	2CIEzMKdmWlAgxi7g9ab6TxUr+OyNUsOEOvT46lZNqyyegzFyHpxWmem54Ir+lYLV/o=
X-Gm-Gg: AZFdTZfs3K5J2dEhdKQ1VAi6TFb/HiJV9+g1gdjE0MKAAUMzChzQSvuvQeL6Ck2R1S1
	nsDsp/r4H37NkbhXFV8WdhEv46lOWkwcPjSctBk+s1mG78aoyk9C8jDH6bxkmTZOA4c2LrrOUYs
	5xeFeDOK7VY/kWQamtoIA2Nv8wD/uYXT+QsBGJV67yMAXpRp2CLTjeOe2eQFAC6EmyQT4xXVv/g
	zUpsAaIPxynwQdXnWJ+PpOg5RFT+3VNN59nSKxHb7AvNhC7YsAWXhYUoIZvI3gp64+zNXKFrc1P
	75TBsjqLJWGzZbi0gFOLDuZtRqvy6rA2FQ4JiVFjkZkclzCS2cOd68p2ITMrQSv8X6Aj0m9LWDF
	pNWHsHSIfFtBCiHFn1gw8kFMJZ3a6gJmC/bwd/eWQYR0NgxbSUSH78fNnTmUhH7dUEOJNELEWOI
	cxNbQvH1ZUfhsYHebJ/WT1D1s8TSNmIFustK4abkOvJYlK6VTHWRpzQTi2ZbACHY96QxDkritDR
	TtS3ELBbGLZa0GI4ZLKzC16Gm79w4VOFi1HKbJY/SLiWgTBscnEorb2lmbF4UnVjeRW0sL9klGr
	r9wkCdKWvXYJVgT+ZRYKrfAIvsU0BaZx5iG7FMb4CwFkuaoqebmq6u+ofMEvtVsKZeBIkJW7aAq
	1NyyQDZ4=
X-Received: by 2002:a05:6214:240d:b0:91f:12a4:27f2 with SMTP id 6a1803df08f44-92114c4e8f8mr45557396d6.6.1795015525386;
        Wed, 18 Nov 2026 07:25:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921149f9c36sm24415306d6.5.2026.11.18.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:25:24 -0800 (PST)
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
Subject: Re: [PATCH 13/22] mm/hugetlb: restrict pool growth to common
 memory
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
In-Reply-To: <av1PyBvUVJcy_Psd@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-14-gourry@gourry.net>
 <av1PyBvUVJcy_Psd@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:25:22 -0500
Message-Id: <179501552287.1206716.17381960047395782233.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:32 +0800, Richard Cheng wrote:
> > @@ -3802,23 +3801,21 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >  	unsigned long allocated;
> >  	struct folio *folio;
> >  	LIST_HEAD(page_list);
> > -	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
> > +	NODEMASK_ALLOC(struct nodemask_scratch, scratch, GFP_KERNEL);
> >  
> > -	/*
> > -	 * Bit mask controlling how hard we retry per-node allocations.
> > -	 * If we can not allocate the bit mask, do not attempt to allocate
> > -	 * the requested huge pages.
> > -	 */
> > -	if (node_alloc_noretry)
> > -		nodes_clear(*node_alloc_noretry);
> > -	else
> > +	/* Scratch masks for allocation eligibility and per-node retries. */
> > +	if (!scratch)
> >  		return -ENOMEM;
> > +	nodes_clear(scratch->mask2);
> >  
> >  	/*
> >  	 * resize_lock mutex prevents concurrent adjustments to number of
> >  	 * pages in hstate via the proc/sysfs interfaces.
> >  	 */
> >  	mutex_lock(&h->resize_lock);
> > +
> > +	/* Fresh pool pages come from the ordinary allocation domain. */
> > +	nodes_and(scratch->mask1, *nodes_allowed, node_states[N_MEMORY_COMMON]);
> 
> For a global request the caller passes &node_states[N_MEMORY], so before this patch
> the grow loop read the live mask on every alloc_pool_huge_folio().
> Now the mask is sampled once, before the loop.
> 
> The loop drops hugetlb_lock and can run for a long time. If a node gets its first
> memoroy in that window, the old code would start using it. The new code won't, until
> the next write to nr_hugepages.
> 
> So the pool can end up uneven, or smaller than requested if the other nodes are full.
> 
> I think the nodes_and() should be placed inside the loop to keep the old behavior ?

I can make the adjustment, but the concern is that previously we'd
start spreading the distribution of hugepages differently when there's a
race between hugetlb allocation and memory hotplug?

That seems like a pretty innocuous corner case to be worried about.

I can see about retaining the old behavior, but i'm not sure what you're
describing is reliable behavior already.

-- 
~Gregory

