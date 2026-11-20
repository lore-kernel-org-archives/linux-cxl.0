Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200127;
	b=Y96xO4VVZmyITgm9NP292uhZkddw7ZLxFOGK0VjcCRxbAJ/syaLGThg7YYveDLPmLSuG
	 YYsHfRq/d+eSsCaLa6Z0MbD9zzQyB8w60JVSk4eufmQ4mRtfHT/JM44P6YlQ0sAe9/dxI
	 IqPOEmof/jjizebqhhc9z0TFiHMcD3OeSymRoGO7G3VXuf8EM6fPv2HRavXtbRJch2qUT
	 PuhNUFWZInXY3lBm9v2CvhzKJq6xDtihJIG7zcL+u58XQ2Kdd9NlGgegT6q77Sc0lTB6m
	 2JYmUklrmdUfaKs1BMrCmBBDBwvDtfUzTwTkRzoQyYLHDK6Y9F2F747uEYzxPMENaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ZZVKFrUy8TyPqGvyWghVYdubKdFhARMdxJahZ4dEGHE=;
	b=IgnsCx5AxZV3bggXDKp1DBUWu9KGcvFx8z0U80iYzkfk/RR+6K4Sc8GVaIY7UTOFp7Xs
	 R503v4e0vhqxYtBHJh1rg85/1N8BQL2ERWwM4KYuaGSNQJbykuh37WFRH4SXbzw4YU8g/
	 rd1MQ1wS+f0t1BXE52Zq33lyx0bNXHBtCexUXYpFCk26ZKf5fDHd3N6/c8K3k/4mQ/DzV
	 G7E76UCtP5tI33DBeNmLQSNCCq60MOR0UDyV0eg9zy9JSYe/F72FFld1czxeBsfrHloYv
	 ZDr7ayz2faD9t/tyKGnza6F7VBtgBoBbiyy3B66mB1gWxx/AFp6tb8ZHk0bfjQTDxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=izrzK6ET;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934460A260E
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 18:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1934460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=izrzK6ET
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9211bbce3abso9725676d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795200117; x=1795804917; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZZVKFrUy8TyPqGvyWghVYdubKdFhARMdxJahZ4dEGHE=;
        b=izrzK6ETvDuDoIalItUUFN9L8T3DxcG7hXILh2Nr5ju49aaoM8UkLKuoc4q7lRS4l/
         drN1+haNdvwK0M/gkrvgBVcRMPq3/KKh/USFqNkGT3IsJudQD74L7Km2y0JQAj5ljCy3
         CIHlhDoQFwrU/55hGs98KqbstdoTvQSkxsZ68OnI4jsODDOMUzBqKLXA/6gN683MoJm7
         ljoJFcYKmoQbIz0WhpmNmeovyBflocsIYtK+YUV4reRq1o9bHFePBXSMl7RnF23xCCZo
         05P2CkEG0AyLuh8tdKk175ibHGOq76g5nImdWKYty3uuISLIXcQJZHQZe95MFHU8+hQa
         Gbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795200117; x=1795804917;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZVKFrUy8TyPqGvyWghVYdubKdFhARMdxJahZ4dEGHE=;
        b=glWnM1dnJhwtD98jV9RywpzhlYn+KLTCK6l90mXKCDrMgXMxE7hqJOQZlrf8esstzT
         EP4lmPll8edTZq9wmcCtA7P/C9Zqs0s2BdJ3C8et6iszyrRfJf13AZnC+esH7BsVdipt
         YrtaVHWw5dC9mVO4QAfvzD4zZjOxjR0Eamk0bBHsFeoBP3nLGvJy/y2GXtnWhlGA1rSW
         5RxccU+EvolIEGjdmrCdVWGKg7+NVG6Bkj02oPkKnqv/7k9vIhcqoKJyC6jzegaXDHjH
         hGMVyn/XFZ1RdFFprXRQBFedvWYi0E/6v+8pw5RcUarE5iGQz9UTo+qHnr7AZ52qeL93
         7Acg==
X-Forwarded-Encrypted: i=1; AL+hErEBAR1AU04qxuZddKLSVfNw6gT2wdr0I/iqimh7l5eBx/6y6tmAcP0KAi+XrANsbBF3zs/lMy2whqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z86zWpbH/GuTy9dDUNJ8qWVJrrNsMQQW+9nNL8+Y5oYmVKqIp5h
	sU2hHfkFoFKOKh30AtrzZ1jQeTsZwaooGlsHwg/cnnnOTKRT/qX8kbJG0otSQpzFAQ4=
X-Gm-Gg: AZFdTZdwSa8+G2lPdhPlhFOhexu/37xYjJ0eyvQX0yyX7m18F+Lc7uXyFS8dpUwX5Cr
	y00n2g9UTs28ze2xLd5NdAfENunCnVD6BpaZ9HsiIIPopuQlyogCupD4h2CjkQctb17n5UJ2zfW
	6u/HFhH1MWzkOT0D5v5YSSevhR0riKKqIG0y0nNbcIgpLzSSSk1oSXPMOKf9WlbjEmaH/xe+Z0W
	QtI8CruKPGUcdZ8kOj/W+ljg+fFxoxGXwVdi2LzU3HHmgaB1priqmoVIljQz40vK5WdPW+ENOaD
	Q5ovEg719aM1nYkIh0EdK4cNcMFLanYDFTiw09CyOZZasRjnw+GqHQ2AKLr7UvI+QWpRGCw5VCO
	OS+RHa/xQckogr8iC0S+QPfJT381YTzgAfzh7YGBfvpfMM6QEmDG41pE6UqdYUp0cT6Nmu7p+HG
	7yWJ9JToB+MdeW9QSskK+JWLufNMH0Yb7Gh8l3GL8+vhgWnTvhcpBqRcK0ZsFLncufhc3cbJrTl
	cHVv4W7RGsAccZZ3GPof2NS7itUh/wIs3+vIEP0/Bxc1oHIcNSuk/gBAK4T8ivA2IBza5Y1K1EK
	yLmQWfM7NgqxDOyIEAw/X8aKGvsjpwsO0YxgI/tSINlfUaz0ogdD3nun6Zr+IVjOoZ5eguNkLgd
	dieyJuEDisPMeYjuGeWrZQ94zods5
X-Received: by 2002:a05:6214:8207:20b0:921:33f6:8a51 with SMTP id 6a1803df08f44-92134b3e14cmr55307796d6.49.1795200116964;
        Fri, 20 Nov 2026 10:41:56 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm33275916d6.18.2026.11.20.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:41:56 -0800 (PST)
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
Subject: Re: [PATCH 47/60] mm/vmscan: restrict reclaim to N_MEMORY_RECLAIM
 instead of N_MEMORY_COMMON
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
In-Reply-To: <sashiko-outbox-225854@kernel.org>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-47-74f5f9a115c2@gourry.net>
 <sashiko-outbox-225854@kernel.org>
Date: Fri, 20 Nov 2026 13:41:54 -0500
Message-Id: <179520011480.412063.14337787866519317378.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 18:38 +0000, sashiko-bot@kernel.org wrote:
> > @@ -7907,7 +7907,7 @@ static int __init kswapd_init(void)
> >  {
> >  	int nid;
> >  
> > -	for_each_node_state(nid, N_MEMORY_COMMON)
> > +	for_each_node_state(nid, N_MEMORY_RECLAIM)
> >   		kswapd_run(nid);
> >  	register_sysctl_init("vm", vmscan_sysctl_table);
> >  	return 0;
> 
> [Severity: High]
> Can starting kswapd on a private N_MEMORY_RECLAIM node trigger a global
> OOM kill when MGLRU min_ttl_ms is set?
> 
> When kswapd runs balance_pgdat() -> kswapd_age_node() ->
> lru_gen_age_node() and every generation on the private node is younger
> than lru_gen_min_ttl (or all lruvecs on the node are too small or below
> memory.min), lru_gen_age_node() invokes out_of_memory() with an
> unconstrained oom_control:
> 
> mm/vmscan.c:lru_gen_age_node() {
> 	...
> 	if (!reclaimable && mutex_trylock(&oom_lock)) {
> 		struct oom_control oc = {
> 			.gfp_mask = sc->gfp_mask,
> 		};
> 
> 		out_of_memory(&oc);
> 
> 		mutex_unlock(&oom_lock);
> 	}
> }
> 
> Because oc.zonelist and oc.nodemask are NULL, out_of_memory() selects the
> highest-scoring process across the entire system, even if that process
> only uses common memory and holds no pages on the private node.  Should
> the out_of_memory() block in lru_gen_age_node() be restricted to
> N_MEMORY_COMMON nodes?
>

I haven't been able to generate this condition, but I can adjust the oom
control here accordingly.  This should be trivial to adjust.

-- 
~Gregory

