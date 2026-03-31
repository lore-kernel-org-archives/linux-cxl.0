Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02761EF39E
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774931103; cv=none; b=AfNdeUgvEazAkcWYwWdRQ9/OciYRlw+bI/f4KfB3FPqF2SJ/q20ttnLaClUdJ1QkBo2AnEoHZ5EpGKdrXfHDnfaot2Frm8Q904pgIpH9yblCEprQMaOXYP4JEXMpzqZj7oYD/mcDbsuzTzxDrh+0JdoHh/SA6rVlWDoExP1O9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774931103; c=relaxed/simple;
	bh=JPezqEn5KMMWtllKch0Zz9RaP7YlaR5/bmJnGIIY0O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE3I6qDfrIo346kyNF9niqjJ9UBKRYJXDfltGL8Jv3SSs0isx2qAPBJWaPHGzkhHDrRav9mboB88olXrOuv7S9QCOSNPEeLJUTyQkNwj/A5+bMdhyAXVNsw19P5bqjGHMv66JpqqeH/3+g2E3C30+N9/u8ZbnfLpK5l3QiGrcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CWwxbEs+; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWwxbEs+"
Date: Tue, 31 Mar 2026 12:24:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774931099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Y6o5j93R7sTJgQpUSEqOpWjTfzF7tRF8MdJiE9tik=;
	b=CWwxbEs+Qf7usdMzhi3bJHLVHjx+iHXGgFxDj37SYp5Z0a5YzbzxUAJf0STnFi3/6s2Lsj
	tt9fW4FHy9d+uwgHEyiQlzWwIZSOUn0x9lSd3exrZ+Dd4Me4mvO702/lQCiFbiVsLbaDbY
	6+HmyebYsosRgi1kdp+8zGe9ob3Dhjk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, david@kernel.org, 
	osalvador@suse.de, vbabka@suse.cz, joshua.hahnjy@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <ceqmspe2x2p5uv5bk3jyiw67qkyweaviclcjdp6kgwpg6v4kdq@f7yd6rr2lpkl>
References: <20260330035941.518186-1-hao.li@linux.dev>
 <aco0MtqpysMXMZdy@hyeyoo>
 <23feu42lqvc7iymgaxmnywea7c3qie5vmjm4aijbgdiazwvrcb@mmlxjowgtotv>
 <20260330144640.161ca53e94b37b3252de2e95@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330144640.161ca53e94b37b3252de2e95@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 30, 2026 at 02:46:40PM -0700, Andrew Morton wrote:
> On Mon, 30 Mar 2026 17:34:21 +0800 Hao Li <hao.li@linux.dev> wrote:
> 
> > > > Current users that benefit include list_lru, zswap, nfsd filecache,
> > > > hugetlb_cgroup, and has_normal_memory sysfs reporting.
> > > > 
> > > > Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
> > > 
> > > The Fixes: tag indeed looks correct to me.
> > > 
> > > By the way, MM needs an explicit Cc: stable@vger.kernel.org for backporting.
> > > 
> > > Since this commit was introduced in v6.17 and we have v6.18 as LTS,
> > > this should to be backported to v6.18.
> > 
> > I had gone back and forth on whether to add the Cc tag, but I'm happy to
> > include it now!
> 
> That's OK, I'm very cc:stable-vigilant. Thanks,  I'll get this upstreamed during
> this -rc cycle.

Thanks!

> 
> I do like our cc:stable patches to include a clear description of the
> userspace-visible impacts of the bug.  Two reasons:
> 
> - To explain to -stable maintainers why we're requesting the
>   backport.  If they care.  Heck, and to explain to me why I'm doing
>   this!
> 
> - To help out someone who is using an older kernel (there are many)
>   who is dealing with a bug report.  They're looking at this changelog
>   thinking "hm, I wonder if this patch will fix that bug".  Let's add a
>   few words in there to help out with their pattern matching.

Agreed, and thanks for spelling out the rationale!

> 
> So, and not for the first time ;), what are the userspace-visible
> runtime effects of this bug?
> 

The most visible effect is that
/sys/devices/system/node/has_normal_memory does not report a node even
after that node has gained normal memory via hotplug.

Also, list_lru-based shrinkers can undercount objects on such a node and
may skip reclaim on that node entirely, which can lead to a higher memory
footprint than expected.

Feel free to fold the above into the changelog if useful :)

-- 
Thanks,
Hao
