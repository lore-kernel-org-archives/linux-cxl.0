Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9F221F1F
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647231; cv=pass; b=Mww/tt2mHitbg9XE868KrMzv54dAEvvoVGKNXWb6ypCqxzaItRzaUF0vePcVZU/CRc/tkNcTFhsH9KAuHGjEmyN0lVS24emhATs1mTEpCfaPW9S3xmOJMWihgWjHTDaP/uqRapTlUk2EcPi8AcuTUepxQZZydOyN4uip6djTjXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647231; c=relaxed/simple;
	bh=eFSljOmycAzGBIj6l7hbhOEz4RoKi+i4IrqpEvzU9IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcgwCx/u7Jl8PiHVjZZn4+3HJIiOs799RdjTN5g6eTlMGo9HdqCrTxomazTeWu9KEULOV9mkRnjE12SmMwhpZphDnGPSheAIznnbczp4bO4wC6lKaDGInaXB7ct7YuheZCLHutuiHeCtuJ8Ctk/ujhaUr464c+ehHeEIzpVn2nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqcuQFpZ; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqcuQFpZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502a789834fso3109341cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 16:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769647229; cv=none;
        d=google.com; s=arc-20240605;
        b=HTeMrexrK24S5bAKK6g7tIw3Liyr+yuQY6NtxleQzZ9Ux9jxRZC5+O/cmypNP82BVt
         QXIOukixnhUEWoeOw1x+EsB6ykOrErUoywTGNcDgf+EUqNWtEy0mlvlPoA8hHvoK2SQ0
         r+YtGH4DdPlFuFVkn5Pmk9TePcko4vZ8B7JmiS+o8z3CXsSo8uHKD3Sva4Chm4TYnpIp
         I0YfeFQDipoZaBThq0D3E9g5nR6/sqEfsAgCdLbZb/8P2D+gG19k+2LKq21MpazMu5bO
         jyfJTwUQkKppnu72QGZ8WE9spRukMCyP7aVn2aM0kAs+6+Ws73Jean5+zoYF0/3XhsyE
         HVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mwNqkQIHtdixZxJdXARWDpGYyi08Np4wXzrAxbn40Ig=;
        fh=25P0tNe+QCWYUPr2npuzVWeBhxvZgkG+XwzoOKFiLe4=;
        b=B0vlWbWkWZ0O9CchICPRFlHpk/tYNXpFHgVw20AN+DoLXK1iDvJsAB5zRxvzdywojL
         brCUF2CmSSg2MwmFEIXWUJhos2LEoxlFDIMOVe2TjMQE5PawLrHPSWhdwG4Kh0n1DczN
         Ii5xJePheIFtO6NXYMyeihXFLyssjXGp4HXzcHLgOFqiljG2FmqYrLoz4/wm2gcKPURI
         cvzAa9n0bOTBAMffwWkg4MO+VwAHsgLnZYB4X9pG/tB7mVZjSOpco7KYOyLlhNbiTBmI
         QZ5Qa8+tAUSlPz3vw5LAmMlApIMcnRlk2hzhRpTYlibWC6mgJJzHMB8+CV5cxhdJsVyW
         bk8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769647229; x=1770252029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwNqkQIHtdixZxJdXARWDpGYyi08Np4wXzrAxbn40Ig=;
        b=KqcuQFpZ3z8Q8pXo69cLoZJnWHLbZBifJaVYc7xM0nOY6eDLCkG2M9sp9Lib3ka8sy
         Pq3tY5bmMhI8/1kYfo11vZlnQPpJEquUqAH3+9YfSe0eieXnOfj5AICiUaZQp8C5ft9Z
         tOwtxKht3w7uqU6PwqQFI2/q7kG7Q05x2LJwU7bM1WOzemD+yhYLwJV2e9s+5G4RO4E1
         qaTzOVqfi/lZq8+5d9ugAIjDYPc7qpsxcSgoNuiEGL/wtbBad8W1z51vgdyfdM9Kq1uK
         bYWgsK4UpYRUbm7OYAnHcNjYG6HzXmi9l35nchSs6NeIldncdPAhVBDN1c9BZ/Ra0Qa2
         JPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647229; x=1770252029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwNqkQIHtdixZxJdXARWDpGYyi08Np4wXzrAxbn40Ig=;
        b=qJ6hZ8USjSIjVngBvGRxTuXYwsnJA81LUs7LpPgQi0Z6ie4i44WhqUyRxgsv5RK7cI
         pkVcMqrne9ywqk/0gg/4QtOCDybYc5pFeuvNFvv51l5cBOZB6B1EnP+i1X9ry4xhb/Of
         xe/I3CrPDDzNgUbWWm6rOAM95j02IX9bJWy5wpd+9F6jRaAAoFdAFKQvP+1BPEOqxESB
         hP0+EwkzBuqo6du+iT8cTnTU2VCjU+OrZpz6BmnR9Pk8N51YAiZTKAM1fDsIVyhL1uEz
         s7EIFyhBSH1HSjt7g9R0Vz4nw0ePS0O1aT7RaCRTDUvtN0P/FIbje57wwKhv3kRazAMg
         1J0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEbH9KhXKuZEnpaxot+sSJ/Nd8qORc4uknnqDyNl65zEd4uMuJGor1sKHe/hXlULN3AzodU+DPlbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29FI0HVFyIbpHsl0g9sKFKZxZflKftXOhv60XnEjVJ29KWNco
	XNSVglEiiI4CDgzaoNDqoe3vlYJ3kkDA8WnBMj62vhBGTirCvwzniV+8qoVKAuRNBwwGi+AJ2lL
	LbFlZvFqMI8+Q97DYZBS/DF0ZZ4lGIYU=
X-Gm-Gg: AZuq6aL3UbI+sTlwr0CJWElTU56Kj7Vqs8Q0HUjFNYlMIluTcZwzOItFLzt9o9dx5kv
	/UNs9iV11gRWDYNQjXPqSFVXrmUcQs3CMFoq4ZwoQ89FhZ2eV/FuzqC9FhgmMDNBVvdg/pQnJtt
	QHXas+/zl1dnq2MWQDMf79bRUN30ykSa133iTjNg605+wpp53GLeMi6gEv0b4LZMALOO3XdoOMF
	/ZBoraPJkqNp0C3gm55MV/DTwI9zn7QFT0xV8HZW1uRgCrmZnKWArHOTwyGZW7t/jtYAr8LCMzv
	y96cBNzheyg5ttyr/tDvoqs=
X-Received: by 2002:a05:622a:189f:b0:4f3:5658:5428 with SMTP id
 d75a77b69052e-5032fa093ccmr96242771cf.38.1769647228685; Wed, 28 Jan 2026
 16:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
 <20260127220003.3993576-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260127220003.3993576-1-joshua.hahnjy@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 29 Jan 2026 09:40:17 +0900
X-Gm-Features: AZwV_Qj__I4vHnFSmY5jPXjrwbiwV_xAA-Q71O08pEvAwMhpfmf9VHUOS0TQ9-U
Message-ID: <CAC5umyhqbW_qXaApO8OGg1wo706GfVPuak5JwdBfBgS751Ka5Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, ziy@nvidia.com, 
	matthew.brost@intel.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8828=E6=97=A5(=E6=B0=B4) 7:00 Joshua Hahn <joshua.hahn=
jy@gmail.com>:
>
> > > > Therefore, it appears that the behavior of get_swappiness() is impo=
rtant
> > > > in this issue.
> > >
> > > This is quite mysterious.
> > >
> > > Especially because get_swappiness() is an MGLRU exclusive function, I=
 find
> > > it quite strange that the issue you mention above occurs regardless o=
f whether
> > > MGLRU is enabled or disabled. With MGLRU disabled, did you see the sa=
me hangs
> > > as before? Were these hangs similarly fixed by modifying the callsite=
 in
> > > get_swappiness?
> >
> > Good point.
> > When MGLRU is disabled, changing only the behavior of can_demote()
> > called by get_swappiness() did not solve the problem.
> >
> > Instead, the problem was avoided by changing only the behavior of
> > can_demote() called by can_reclaim_anon_page(), without changing the
> > behavior of can_demote() called from other places.
> >
> > > On a separate note, I feel a bit uncomfortable for making this the de=
fault
> > > setting, regardless of whether there is swap space or not. Just as it=
 is
> > > easy to create a degenerate scenario where all memory is unreclaimabl=
e
> > > and the system starts going into (wasteful) reclaim on the lower tier=
s,
> > > it is equally easy to create a scenario where all memory is very easi=
ly
> > > reclaimable (say, clean pagecache) and we OOM without making any atte=
mpt to
> > > free up memory on the lower tiers.
> > >
> > > Reality is likely somewhere in between. And from my perspective, as l=
ong as
> > > we have some amount of easily reclaimable memory, I don't think immed=
iately
> > > OOMing will be helpful for the system (and even if none of the memory=
 is
> > > easily reclaimable, we should still try doing something before killin=
g).
> > >
> > > > > > The reason for this issue is that memory allocations do not dir=
ectly
> > > > > > trigger the oom-killer, assuming that if the target node has an=
 underlying
> > > > > > memory tier, it can always be reclaimed by demotion.
> > >
> > > This patch enforces that the opposite of this assumption is true; tha=
t even
> > > if a target node has an underlying memory tier, it can never be recla=
imed by
> > > demotion.
> > >
> > > Certainly for systems with swap and some compression methods (z{ram, =
swap}),
> > > this new enforcement could be harmful to the system. What do you thin=
k?
> >
> > Thank you for the detailed explanation.
> >
> > I understand the concern regarding the current patch, which only
> > checks the free memory of the demotion target node.
> > I will explore a solution.
>
> Hello Akinobu, I hope you had a great weekend!
>
> I noticed something that I thought was worth flagging. It seems like the
> primary addition of this patch, which is to check for zone_watermark_ok
> across the zones, is already a part of should_reclaim_retry():
>
>     /*
>      * Keep reclaiming pages while there is a chance this will lead
>      * somewhere.  If none of the target zones can satisfy our allocation
>      * request even if all reclaimable pages are considered then we are
>      * screwed and have to go OOM.
>      */
>     for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
>                 ac->highest_zoneidx, ac->nodemask) {
>
>         [...snip...]
>
>         /*
>          * Would the allocation succeed if we reclaimed all
>          * reclaimable pages?
>          */
>         wmark =3D __zone_watermark_ok(zone, order, min_wmark,
>                 ac->highest_zoneidx, alloc_flags, available);
>
>         if (wmark) {
>             ret =3D true;
>             break;
>         }
>     }
>
> ... which is called in __alloc_pages_slowpath. I wonder why we don't alre=
ady
> hit this. It seems to do the same thing your patch is doing?

I checked the number of calls and the time spent for several functions
called by __alloc_pages_slowpath(), and found that time is spent in
__alloc_pages_direct_reclaim() before reaching the first should_reclaim_ret=
ry().

After a few minutes have passed and the debug code that automatically
resets numa_demotion_enabled to false is executed, it appears that
__alloc_pages_direct_reclaim() immediately exits.
