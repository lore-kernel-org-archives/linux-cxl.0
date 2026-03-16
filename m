Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C22FE075
	for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690329; cv=none; b=H9uNj6/i6pD0ChVeLwuRbL2d9vuWOYgrJrfAQ92qjmoCfv7wagr19CQfjyP8KqRYRJqHvoeqb3QgmRnSiw2AD4rb6RQVf2hfCQJ4sBdNgyGdqw0W41fFZbSyblPPX6RJMMJOVkpN3EAvjulQVfeEyg3ZSGB/RY+38qz6Fb2XVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690329; c=relaxed/simple;
	bh=Jq8L0sAlCjSsz8gxHLpfDK392Ye36i1FJP6/cVcwFpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M19y0mVzDKSNjk1ZBVwTNw/cq61Y3Qda4lJtQR25SC1wkG6KH/obquOyRu6idLhQbIL+yCMxOUG2XfArpw+6aDr1O3Jl56n5TDkHn5+UlpP1Uoma+B1arMfJCSjIYCAsUh4pEjfPwGW8YusJ4Rl27JJzb6WOHe1Gb94RLOLvd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EoOHXcv/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EoOHXcv/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb4136d865so666060385a.1
        for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773690327; x=1774295127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qruEfGCCxBMe/+AzGeTxCnKPyDw9xbJgeNI3pnvogwc=;
        b=EoOHXcv/ZzkpSj6ApjeOka+pE5VXguzn7F3MNnXlFyYGrZdM21L7g1U9YALu+bM9Z/
         LK4iLnlfrwmikK7XcCQwfsGup3t+gDpx9XCraa6myK3U+8Yo17H5/12tELmG22vaUdRH
         ncAfbC7VtgkrrURpJpZHAoYV/czQMUG892zqTXUc6FVHS1xEqYcw0J79Ct61O19imvys
         4FDUbkehBdAaF0j0m7MgRNQvUURtarT9pdQ0jN0LNzp1qgL62g5KKQb9D+VzRxYoOFJp
         3aBODB8T6gNSijJWi7L8Z5I/twML+d3xGa0zouZ5wOz4mI53QYoCFkX4Q3dXDwxlCjjp
         rFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690327; x=1774295127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qruEfGCCxBMe/+AzGeTxCnKPyDw9xbJgeNI3pnvogwc=;
        b=goDbE6f1UxfxU7oN0M9WjaYL30rqia0LNsabwaTbeHhzFDKiie1RvO/ViVdlvO7HcY
         B9+uq1PhSqhCYgWY/Zpclmkml3CBMLpDO7ARnXyeN1yEVkjI4JORcwjK3/A5S5+/hm1v
         0dIiw3cRfz8QkeEXh677Smcmd7+fZ5d5uVbXot6y3HwS4scAAR2p+oohqIGQEnjhOMY5
         Oks6G+IzfeYY6DfzwISp50IrsiTcAFF8V14U5r7Vwd4vaTsT1RbL3Lygi+c3kBIdMcLF
         sYd1gX5/nd2741dgImVnm9afHFoK2FE9NpamNeZhI9Oh8EVOqeV3RPlBbXpWar/0gav0
         ZENg==
X-Forwarded-Encrypted: i=1; AJvYcCWHKUo/eFBKoSL3p/Yy8Q/4wUd5PpCRAGedC/yf1AuaRbzHVGJvClK4RO9Em9wnKPKouTMnqRZ0rEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5emoBKLJq4AvaoaKD8HjhrssmC7Ow05XgNKE0QECRpHs6ZMLA
	d9dkUge7ZrKd2yAKs8Bzm8BSNUBsm2xEua6EV33iBx6ywiM3CDgHM8WYsN20oV6lI9c=
X-Gm-Gg: ATEYQzyIE3siixUmDhW86PQ3B/sL7/reogmjEN5H7CR9e0iNvNGORPncqzxbkG7aLY6
	ezvNuToOdGz2vPql19fWR2l8BNf5J8W41NcNeJ7gW4dluZR/Haq+DnbVL77mA7gqNK+yntXYvWH
	Uti5LqTQnXuv43gSMTS0/24FHphgODKW+ZsOWt+3V7+4NtGIzarO68bWoNSreqoPBpN6iyUdgwG
	+PhbL/gBFnKu5r03VhJZmaEGzpuL3CeAJ7cTDuaKmemTdLmhELnMwgkCVxvdiH9uwcApCsbqgVe
	FB8p4iW6SBilik8OAozajSOVsXPnooibDSe0YAXV3WV8QL8QrgNSaGlHg14ruEpH/PyKdsuBjfQ
	HsM9ee3xrI8yoKaXCqhg541szL0b8BXJoepODEl87lLaG6E15LQAC7/DS4eU6fSgUmnn3IKcJKB
	/13JxWZPnXNqcFrqu+6jEm4XVvTKjxZY9SLgwE6CCMyq/UqT/PAKKmQOc5nyeW+WiRHuviPBllO
	z2IY8IjHg==
X-Received: by 2002:a05:620a:4627:b0:8cd:94f9:1bb1 with SMTP id af79cd13be357-8cdb5a9729emr1904634185a.27.1773690326947;
        Mon, 16 Mar 2026 12:45:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fe19d3sm1245799585a.19.2026.03.16.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:45:26 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:45:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
Message-ID: <abhd1BXSST0BTDaN@gourry-fedora-PF4VCD3F>
References: <20260316051258.246-1-rakie.kim@sk.com>
 <20260316151933.3093626-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316151933.3093626-1-joshua.hahnjy@gmail.com>

On Mon, Mar 16, 2026 at 08:19:32AM -0700, Joshua Hahn wrote:
> 
> In that sense I thought the word "prefer" was a bit confusing, since I
> thought it would mean that it would try to fulfill the alloactions
> from within a packet first, then fall back to remote packets if that
> failed. (Or maybe I am just misunderstanding your explanation. Please
> do let me know if that is the case : -) )
> 
> If what I understand is the case , I think this is the same thing as
> just restricting allocations to be socket-local. I also wonder if
> this idea applies to other mempolicies as well (i.e. unweighted interleave)
> 

I was thinking about this as well, and in my head i think you have to
consider a 2x2 situation

cpuset             |   multi-socket-cpu      single-socket-cpu
==================================================================
single-socket-mem  |     mem-package            mem-package
------------------------------------------------------------------
multi-socket-mem   |       global                 global
------------------------------------------------------------------

But I think this reduces to cpuset nodes dictates the weights used -
which should already be the case with the existing code.

I think you are right that we need to be very explicit about the
fallback semantics here - but that may just be a matter of dictating
whether the allocation falls back or prefers direct reclaim to push
pages out of their requested nodes.

~Gregory
