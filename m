Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633C3B47EE
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863290; cv=none; b=cwBoNcVeTWArIRWZAXP78ilrg+JUBslTKbERzYXU8ZaUHSPd/GVgOv638CW3MOdgk+QY7P85iVQiqakHeI3yIeLnJoC2MD56TFG/jQlG9StGUuSss6rGC8YZejFr+Q1aCanP6ZiJUmBcPhPR4tmVNYgGNGkIUkX0mkjIAi3EshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863290; c=relaxed/simple;
	bh=MOgOgvvVHi7BgeERfeaf3lMEYneJuuMSvhmFZ7GhHr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1SdEae0TUZFZrcauNwgKMfAFEaqBEP5m7bUAPOovC6exwZXcjuejOvsG6SA+HvusNGBK4M/A/Pt6EkZiZKJbD9E8yghwp21vbaSV5KkBXAoek787oulFziIlcvazi81SLntJDD77dSfg585ZRgA5pFdXhQpdE/Q87vPWzKgRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJENXvRm; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJENXvRm"
Date: Mon, 30 Mar 2026 17:34:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774863287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGkDj1PBQwxhRCTzQSOpS9DEQZkCaWieM/DJwzadiGA=;
	b=HJENXvRm2Fd5wnRz+GYvxiRAnbc7T7Ywrpjz7wQVSnzC4SJzA+ElU6I+uvySgtS0wUd0OX
	/5ZQ/FxtYE/ipg+O8+W+ZWRQ75BcHQNaMS1S2Adasam1F1KZ9GDFUyZbjIqe0UwUEsOIpS
	VZQNjUbndz9fUXMBrnGZwhVfgxSHKbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org, 
	vbabka@suse.cz, joshua.hahnjy@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <23feu42lqvc7iymgaxmnywea7c3qie5vmjm4aijbgdiazwvrcb@mmlxjowgtotv>
References: <20260330035941.518186-1-hao.li@linux.dev>
 <aco0MtqpysMXMZdy@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aco0MtqpysMXMZdy@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 30, 2026 at 05:28:34PM +0900, Harry Yoo (Oracle) wrote:
> On Mon, Mar 30, 2026 at 11:57:49AM +0800, Hao Li wrote:
> > N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> > hotplug currently only updates N_MEMORY. As a result, a node that gains
> > normal memory via hotplug can remain invisible to users iterating over
> > N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> > incorrectly marked as such.
> > 
> > Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> > offline_pages(). Set the bit when a node that currently lacks normal
> > memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> > offlining removes the last present pages from zones <= ZONE_NORMAL.
> > 
> > This restores the intended semantics without bringing back the old
> > status_change_nid_normal notifier plumbing which was removed in
> > 8d2882a8edb8.
> > 
> > Current users that benefit include list_lru, zswap, nfsd filecache,
> > hugetlb_cgroup, and has_normal_memory sysfs reporting.
> > 
> > Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
> 
> The Fixes: tag indeed looks correct to me.
> 
> By the way, MM needs an explicit Cc: stable@vger.kernel.org for backporting.
> 
> Since this commit was introduced in v6.17 and we have v6.18 as LTS,
> this should to be backported to v6.18.

I had gone back and forth on whether to add the Cc tag, but I'm happy to
include it now!

> 
> > Signed-off-by: Hao Li <hao.li@linux.dev>
> > ---
> 
> Otherwise looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks for the review!

-- 
Thanks,
Hao
