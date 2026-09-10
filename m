Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4E32FA18;
	Thu, 10 Sep 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047201; cv=none; b=DVZgIXNTHyz2F+xBU4FfEXqVqOiH/n8hjTX2EiDcG6+khbiqbAcPscfhJli1muA5IC5ra4agu7HP/XjJRJ6TPU43s6VKHJIjLj7of8T0p7ehlOgP342akAeTa3je6X0egLNkZxpoA9xAJ+Uh8bLPT3GV24P0Dl01O/I56rbQTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047201; c=relaxed/simple;
	bh=7XFuTR4712JGvPapZpi7dAjxzQbr/FtUGtRkZTrtLM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjSk0JkS63DDOr+IMcUaVcKIrQjjtPrAA+lZ4v2883WELuk72MyNygyr2eVGqwNV6IAW4FgEJgYpr27BHat0V9VXCpnPUZRnTOxGwjemJ6hx5rE3KnR+dPYbhJm7YOxA4MOAUgzX+adI7lDg8cUmlCtfczBkp4OrBBSIQpiyhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9J3F+S3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9J3F+S3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C815A1F000FF;
	Thu, 10 Sep 2026 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047199;
	bh=Lftml6AJcq9A3OGxnesrZC+T3UxNownm0IfBvjzdSl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P9J3F+S3y8d1fPxy39R2EfAtPQImCqmyD6WsXLMnoyJ03DnwMyvctJAqB2jE7EOj0
	 ii2cRCVuHh9iN3bOwEi89Tgop2GwedqfXvOTzRPZr7D1BhukAduO3wMzErYtGxTSUo
	 +z/7OY0BUD/NEy0f6s2GSKpF9zJJrDgpSTmc3uhPk7tiJfrEgdrJ2m27sKSfjUM/Id
	 V1cuje2kQEJMmzoSeZMXSR3rkDvr/3ks4VpRtLMTgrBnH95B1RvADu+l6+q2xkk/wK
	 U/BiJF1tlvwNC/9YCo2mIYe+Kn0DTBvXMItKlm8jYbRpRu53wb/aGb8SbEcUGpXI5G
	 TJ02MPWKnfc3A==
Date: Thu, 10 Sep 2026 14:33:10 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/12] mm/sparse: move mem_section init to
 sparse_extreme_init()
Message-ID: <aqKxAhOGpUxyjycf@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-1-008fc8d579fe@kernel.org>
 <aqKnDa6ukWwAXs19@gremlin>
 <ff5ac35e-1dfa-483c-82b1-0e542a850550@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5ac35e-1dfa-483c-82b1-0e542a850550@kernel.org>

On Thu, Sep 10, 2026 at 03:13:26PM +0200, David Hildenbrand (Arm) wrote:
> On 9/10/26 14:52, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Sep 09, 2026 at 03:32:54PM +0200, David Hildenbrand (Arm) wrote:
> >> Let's just avoid another pair of ifdef inside a function. While at it,
> >> switch to INTERNODE_CACHE_BYTES by just defining a fallback in cache.h
> >> as well, given that the x86 variant already provides one.
> >>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > Nic ecleanup, one nit below.
> >
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> >> ---
> >>  include/linux/cache.h |  1 +
> >>  mm/sparse.c           | 19 ++++++++++++-------
> >>  2 files changed, 13 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/linux/cache.h b/include/linux/cache.h
> >> index e69768f50d532..b6e857b985bca 100644
> >> --- a/include/linux/cache.h
> >> +++ b/include/linux/cache.h
> >> @@ -89,6 +89,7 @@
> >>   */
> >>  #ifndef INTERNODE_CACHE_SHIFT
> >>  #define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
> >> +#define INTERNODE_CACHE_BYTES (1 << INTERNODE_CACHE_SHIFT)
> >
> > NIT: 1UL?
>
> I decided to replicate the existing
>
> arch/x86/include/asm/cache.h:#define INTERNODE_CACHE_BYTES (1 << INTERNODE_CACHE_SHIFT)
>
> If the shifted value would ever not fit into an int something would be
> going really wrong ;)

Yup, fair enough!

>
> Thanks!
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
