Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6E358384
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919258; cv=none; b=JZbdac0/OPGkaB9hAjr7zwwPVIAU7j9v+yisP6aNWTSJMW5GFORskRlqPzloyY3e+UAKVdigLjcFY6e3mpRaCT8DSaljAt5A5HQ3BCakMawnYj0QHph3zQjZyXkkPlhvn+Tbm3yxds8JfgILgCZDC6nxFKu/P+FF5nE0T2Sxopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919258; c=relaxed/simple;
	bh=B5OtZj/lBZyOnuuuCWdlMKPRT3npcqUb/grocb0Ceik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssnHs+WhuMcMpaiWHMYmkAFS4jxM6NSAz75infeLco9Ttcir6kY6wG8vS3VvitOFmYkrgED1Ndj9u1fSE7GppYwYhaIQk/2JL5Ccy2ho9oxQCprKmVmrugQB4V28yu6V/MGgQyU8fZ90m9YN1yYhllEVmDvVg2aHMY2+JGGjZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ufxlAByw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ufxlAByw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e602d2c0fso156516585a.0
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782919255; x=1783524055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSMdskJ/XVsebZBQ8sHZxAPdt7ILVugrW/olreDrl4I=;
        b=ufxlABywSsz5oik0DwZQI8l3TVtoOhz4T/8mPkNocZCngVRiRVC7QdMijAKZOkhi8H
         yQdiqi3qN9PYLQYAlzvEjgf8mp/bPJa8m1V0NX0uRlnhzDL9qZkHnuBGGDU9GhYbwlEY
         oGWFQ8hCSPmGBqI7mL89dBV2VfLaeq8PNsAPx939s6qw/kRqOTTBurXVDGQ4XWmrAxSJ
         rLp95vNLyPUJdB5xRY2lSQhIQzxBHLK29Fv58ZYNJVhWMYj5HDEsSfcw54sytQvuzpL1
         Ac2StMsVKRQb1QeTaNdZyig8dUCvgshFOxGZOWiB8w59eMop4cAK6ZUc96osShIcVySF
         5h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782919255; x=1783524055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSMdskJ/XVsebZBQ8sHZxAPdt7ILVugrW/olreDrl4I=;
        b=VlEYqfuM8mKcXCUImcm5SFuzqp5iKZKtFhwLifn2JXwZCpbb56j/+Km+XsNDyQH4EX
         762OTpN1ZQN7VLaJ9imnD07nxkQmXqWBsnPm0S38Q03HFHHk9h7gdOLM1UbLv1ehoCia
         rV6h7jME0dD5ZriY9IvRlAAhqodFmU/F1xBZYOh3a2HpADQoHyJpu2IM0E1eq1F4pFPQ
         v3wHJHKieK1BDCCah41EvvFJFNgHK7KgLa5QJ+/RM0YwqXGg0ypxt9fUyXRC8WCrCJGx
         hZ9kdrDrCdpIQaY8WNWCkVJocyDYERljHJLRuLp52Ejt40BFRSj61wd6k0reG9eWgPup
         CdTA==
X-Forwarded-Encrypted: i=1; AFNElJ92iLdaCEEt9iSWRK38g9eXeq67HSZ0YXB1ze6pytK014J6AEIN1bdDA4Mg9iTO6lgEPh80vmrVlIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3u7k6ViQ2T+ezJP/n/kSuN7Msp5jORIrV+kAASUiFO7GtKV5
	y/EUsDJ5Du38FUx12fW9Stb5tusjrn21gLfV2IlGZ3pXoMeHAtkb5tpYBQqXURT3FjI=
X-Gm-Gg: AfdE7cnLu930bHWU016c11aVSWdT0UdX5XGe3fUD4NQkLWF5NUrzNj2fzOfFUQcbxQi
	34p2XuAhvGNuyPZKhz/gtJ/QLeBeDyCLpXOPtJE0tWy3mYtOClyrjz0wbfK9+uUGC1UCDHBxUkZ
	5JdRosgnD+VW0LDWiuIzHaykQa4dKeWEOIYvKxz5QID8Q5cCG2k/AmOwubooLbdN330yU6guTEJ
	nE2fm3ZbKPWj8kaQy+jXfyFpBnfF3VNunyjEQ0l/Ncmrg3FOVE6k75/sNwE9mz6xdKXxTJFIuN6
	MeMgpLfaaTd02yL43L7kBRbxts3rmNy2MqV5FmyHB8D7hQEXsmxNFM8WakyePjoLcbmx4V8eIqX
	2n/0tF+Hmkysbyq75v6db4u3xCpg+gNjdiltyo5WBt6jOYA2lGY85n6lJsSFjfF8xszJOprCbPg
	u2mNcLrtCZKg2U9plx9H6B4CJWjszs76AwxMezrt6XE31ytXVqCvU2kqHGGusFwkaVV+FA
X-Received: by 2002:a05:620a:178e:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e69821ad8mr849855185a.37.1782919255344;
        Wed, 01 Jul 2026 08:20:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e623379easm595581185a.32.2026.07.01.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:20:54 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:20:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com, david@kernel.org,
	osalvador@suse.de, akpm@linux-foundation.org,
	mgorman@techsingularity.net, hannes@cmpxchg.org, vbabka@kernel.org
Subject: Re: [PATCH] mm/mm_init: handle alloc_percpu failure in
 free_area_init_core_hotplug
Message-ID: <akUwUv_rrgmRP4bK@gourry-fedora-PF4VCD3F>
References: <20260630214039.2263562-1-gourry@gourry.net>
 <akS2AYLzOzlJ8tIO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akS2AYLzOzlJ8tIO@kernel.org>

On Wed, Jul 01, 2026 at 09:38:57AM +0300, Mike Rapoport wrote:
> On Tue, Jun 30, 2026 at 05:40:39PM -0400, Gregory Price wrote:
> > We miss a failed allocation check for pgdat->per_cpu_nodestats, which
> > results in a NULL deref when we offset into the per-cpu area.
> > 
> > Propagate -ENOMEM up the stack and leave per_cpu_nodestats pointing
> > at boot_nodestats so a later online can retry the allocation.
> > 
> > hotadd_init_pgdat() returns NULL on failure, which __try_online_node()
> > already maps to -ENOMEM.
> > 
> > Assisted-by: Sashiko:unknown-model
> 
> I suppose it's rather 
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>

I honestly wasn't sure here, Assisted-by is the tag for LLMs lol
i can change it

> 
> > Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  include/linux/memory_hotplug.h |  2 +-
> >  mm/memory_hotplug.c            |  3 ++-
> >  mm/mm_init.c                   | 14 +++++++++++---
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 7c9d66729c60..f04b915678db 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -289,7 +289,7 @@ static inline void __remove_memory(u64 start, u64 size) {}
> >  /* Default online_type (MMOP_*) when new memory blocks are added. */
> >  extern enum mmop mhp_get_default_online_type(void);
> >  extern void mhp_set_default_online_type(enum mmop online_type);
> > -extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
> > +extern int __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
> 
> Nit: we are trying to get rid of 'extern's in the headers, even though it
> makes the declarations inconsistent.
> Can you please drop the extern since you anyway changing this?

yup no problem

