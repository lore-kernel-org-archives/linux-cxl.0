Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D439C63A
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398027; cv=none; b=kd/jkQUxXYFyji4wsppE+t0LHI8i+FUgYGd5E2rin6OLQAvITAhho7/pvAhj+wjol6N27YSF2G65Y1EJGHmdAXwZScO2M78zvbX0xnnryuNMg+c233IOZIdGlfBRFETbNqwMu8DxfZCedoP0YdcWc98I2XLSy3r/tSxF/qP6iX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398027; c=relaxed/simple;
	bh=aNEFYJ2ZdTfHXcX8KrZPjabgpkhfQt8wJUgJuNV3NTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf7kMaVGaD5uZDDQIZCaINo8kv466AwmT1/s8m1YihGfImEtMhPZE7zBEgnpDZ/t8QsCQb6+qG4ibZkXd6ZlppZ13Bz3yAoRu5TJ2zZvIRV3FvqU3RCXQ6pAtFMa7umFZSZL1np7p45z6Go2GcgAvg59PJg6RhFjDh9V67rYLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K1tq98zw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K1tq98zw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edffe5540so13495585e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768398011; x=1769002811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5nEm7X8GKJZArjA3XXNFLR3YBACGijl/GdrWDkzdOs=;
        b=K1tq98zw3lhpxplSsfJT1kt1G/BzlYQq7REsxveZwaBuyyLk6IGp912OmGUxAFuTXw
         Z4aPMjIN4yuZ0ZPlQGThK3zcQY/y3Q5F/dZwwkzZFdMjju5RK6O9Asgxl9i2HxAvyk8z
         Elg2vhQc8ix3+quSLL4+WQIxnJXMVKWtghE/GGK1fORjZIQk5dWUbNlpu0Es3xILvALd
         gUFKZpIVbmx1UFzviGgxBjyvYZuDL7TZwZtCzO8TNLQFov6AfrSly4mirMylXqOJM1aY
         KjXcs1rcXMCWhR3XI6Py46JXIM53GQyvq7Vu6veQIPAKcmA//JkX2amo5vUciDzdvOTb
         w8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768398011; x=1769002811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5nEm7X8GKJZArjA3XXNFLR3YBACGijl/GdrWDkzdOs=;
        b=UMD93izKJFI4OUHVyS/YgZM+aEPkYy0pU6u3tAnRTZ/P/oNMaTtRR1ldyzn1nfFG0N
         TzYI1lu0Iy2lfLpdHph+pMM7ElPswbNkoxDrOyQ/uGoSSS3CmTDHcETNSZoq8EqdmGAj
         x/rMOnD8p15xGsYXOXdP15UeLf1SsYhj3EXIPsDwKMvcpx9AVBuzAM9xf3H2BKXeGRz0
         YNmAo+IJyyJFlq+na04KND9CaED1jtFQ6xr9K4/OA9Yp2n0l1B3CaYzH/brsfoQhtSbk
         yuRV4H0Q+EYRkjzY2ARBqXDxibrqenx9VCOlVuNQ4DKXlXVJMuyyjX+0VTHE3olrbSiw
         1+NQ==
X-Gm-Message-State: AOJu0Ywex1rZMtlMezLBPQETubfHrDNiQ1JOgeP5EiVl5GBIaZ6vR/5j
	Z7Q2qhg9fh92ojdSEWvLund3jX/y7BETaTZFt+qkzl2fg9jvDZsEfnGkKGDk3YjSMn8=
X-Gm-Gg: AY/fxX7nILh89TOuvo9Ehf/eDGkXdmSpOIYrO5a0Gbl0YKgEmhJug6QS6fTAhdanIb5
	+8RdLRAgjDdTGXfz6w53rB9QfhleiSiiPWAs2obaK7ayjzLBpsYx+fcEQqh2PPwe6EdBULVJCIL
	ZMn1UCjwZcL9ewypHwmI92iGuaaappQTouPWaGkFOx5t97/A4UKJ2Z+TeM+46bDMN9/8IH4ZiOa
	a7rKotP9aMYOHs17jlXTiZ7nDvCw4+nGU06NeYOMgv7iV7IO6J7y942phWwaI1G7SdXagin0Eb4
	1CrA/gf9d8TagsSipetHtpmt6/+TVGHlTfB2uUV0SmSnt8kXedu6BYA4A7n7Yv0aH45niyeK0St
	vBH4GkK2J1YUKaKLxL79G8LT9s+vZ5DYnmIclkfdgv1PQMMTcXflE8uiYpE75YN7oE3Cdwik12I
	ETbVoHok1cTq1F/Y4itF2jSVc6F4EiCr+ZyPM=
X-Received: by 2002:a05:600c:c16a:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47ee334d0aemr36493285e9.17.1768398011351;
        Wed, 14 Jan 2026 05:40:11 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27dffcdsm21221875e9.6.2026.01.14.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:40:10 -0800 (PST)
Date: Wed, 14 Jan 2026 14:40:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aWecuccS9tGZgXe1@tiehlicka>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
 <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka>
 <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>

On Wed 14-01-26 21:51:28, Akinobu Mita wrote:
> 2026年1月13日(火) 22:40 Michal Hocko <mhocko@suse.com>:
> >
> > On Tue 13-01-26 17:14:53, Akinobu Mita wrote:
> > > On systems with multiple memory-tiers consisting of DRAM and CXL memory,
> > > the OOM killer is not invoked properly.
> > >
> > > Here's the command to reproduce:
> > >
> > > $ sudo swapoff -a
> > > $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
> > >     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> > >
> > > The memory usage is the number of workers specified with the --memrate
> > > option multiplied by the buffer size specified with the --memrate-bytes
> > > option, so please adjust it so that it exceeds the total size of the
> > > installed DRAM and CXL memory.
> > >
> > > If swap is disabled, you can usually expect the OOM killer to terminate
> > > the stress-ng process when memory usage approaches the installed memory
> > > size.
> > >
> > > However, if multiple memory-tiers exist (multiple
> > > /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist) and
> > > /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will not be
> > > invoked and the system will become inoperable, regardless of whether MGLRU
> > > is enabled or not.
> > >
> > > This issue can be reproduced using NUMA emulation even on systems with
> > > only DRAM.  You can create two-fake memory-tiers by booting a single-node
> > > system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
> > > parameters.
> > >
> > > The reason for this issue is that memory allocations do not directly
> > > trigger the oom-killer, assuming that if the target node has an underlying
> > > memory tier, it can always be reclaimed by demotion.
> >
> > Why don't we fall back to no demotion mode in this case? I mean we have
> > shrink_folio_list:
> >         if (!list_empty(&demote_folios)) {
> >                 /* Folios which weren't demoted go back on @folio_list */
> >                 list_splice_init(&demote_folios, folio_list);
> >
> >                 /*
> >                  * goto retry to reclaim the undemoted folios in folio_list if
> >                  * desired.
> >                  *
> >                  * Reclaiming directly from top tier nodes is not often desired
> >                  * due to it breaking the LRU ordering: in general memory
> >                  * should be reclaimed from lower tier nodes and demoted from
> >                  * top tier nodes.
> >                  *
> >                  * However, disabling reclaim from top tier nodes entirely
> >                  * would cause ooms in edge scenarios where lower tier memory
> >                  * is unreclaimable for whatever reason, eg memory being
> >                  * mlocked or too hot to reclaim. We can disable reclaim
> >                  * from top tier nodes in proactive reclaim though as that is
> >                  * not real memory pressure.
> >                  */
> >                 if (!sc->proactive) {
> >                         do_demote_pass = false;
> >                         goto retry;
> >                 }
> >         }
> >
> > to handle this situation no?
> 
> can_demote() is called from four places.
> I tried modifying the patch to change the behavior only when can_demote()
> is called from shrink_folio_list(), but the problem was not fixed
> (oom did not occur).
> 
> Similarly, changing the behavior of can_demote() when called from
> can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages(),
> but not when called from get_swappiness(), did not fix the problem either
> (oom did not occur).
> 
> Conversely, changing the behavior only when called from get_swappiness(),
> but not changing the behavior of can_reclaim_anon_pages(),
> shrink_folio_list(), and can_age_anon_pages(), fixed the problem
> (oom did occur).
> 
> Therefore, it appears that the behavior of get_swappiness() is important
> in this issue.

You have said that there is no swap configured in the system, right?
That would imply that anonymous pages are not reclaimable at all (see
can_reclaim_anon_pages)?

-- 
Michal Hocko
SUSE Labs
