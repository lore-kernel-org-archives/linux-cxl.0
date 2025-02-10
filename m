Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06813176ADE
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739171874; cv=none; b=IOO1XBgOjab7+zknyvj3EuUYbFSfpDhj7EPUT6LHsYK+e8d10L7kcSz/aMXkxS1+NQvR3ZD254ahkg7LjPJ3qQEOD6OnjJ//homE2Vqg/NOC04gPAdbYCLuF13Ftq5A5LmDAcYrxSvJvy+cntzustMaCKPxJr0/B6XD22XdxEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739171874; c=relaxed/simple;
	bh=nid2nrusmZTr3RkMjEyyChPzPy8CI3efI4843DJgr38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGTg66UUFvS2Jtd7rPSIkyT/PEGSb918ag3OyisIHLPVHcqXijGn3Qt7TJD1XMY3JgKoEPJDAjgBLz3JZEjQXF5EhjRA1n7j/MeZjHVqjkpz9zvGAerf01oCUrw7ZEhOXkyXvhsDxhpZYQwsupkmkOzAw83BiR+THmDC+I1sPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-26-67a9a81af303
Date: Mon, 10 Feb 2025 16:17:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250210071741.GB39454@system.software.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka7UipXpBi1nRSwm9hhY/Lx7nN3i
	/KxTLBb31vxntdj3ei+zxe8fc9gc2Dx2zrrL7tHddpndY/MKLY9Nnyaxe0y+sZzR4/MmuQC2
	KC6blNSczLLUIn27BK6MdR3n2At+8ldcn9zP2sDYwNPFyMkhIWAi0fLnPyOM3djxlQnEZhFQ
	lXj5dwJYnE1AXeLGjZ/MXYwcHCJA8bYr7l2MXBzMAm8YJf5t3MgEEhcWSJN4+8MPpJxXwELi
	wbQlbCC2kMArJonlu8wg4oISJ2c+YQGxmQW0JG78ewnWyiwgLbH8HwdImFPATGLSpGPMILao
	gLLEgW3HmUBWSQjsYJOY0XqFDeJMSYmDK26wTGAUmIVk7CwkY2chjF3AyLyKUSgzryw3MTPH
	RC+jMi+zQi85P3cTIzCol9X+id7B+OlC8CFGAQ5GJR7eAzNWpAuxJpYVV+YeYpTgYFYS4TVZ
	CBTiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAqJ18ePaD
	cGcB9X3un2sNn7Wy7z+gn+W/6/nvC87iLw55sAVJH8wwjeB5eOI/z5m30XfP+QaGnJVUK8t6
	bmWZ3923MHGCE49v+OJ+h5bDm748vTLrrUMwb0i2C8/x+8zbOk+5FgXttG2y+JXUmFSXvLlL
	IMI28YQ51022JQzK3V+yeDlEfokqsRRnJBpqMRcVJwIAn4ZuOWYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXC5WfdrCu1YmW6wZ8f3BYTewwsft49zm7x
	+dlrZovDc0+yWpyfdYrF4t6a/6wW+17vZbb4/WMOmwOHx85Zd9k9utsus3tsXqHlsenTJHaP
	yTeWM3p8u+3hsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDLWdZxjL/jJX3F9cj9rA2MDTxcj
	J4eEgIlEY8dXJhCbRUBV4uXfCYwgNpuAusSNGz+Zuxg5OESA4m1X3LsYuTiYBd4wSvzbuJEJ
	JC4skCbx9ocfSDmvgIXEg2lL2EBsIYFXTBLLd5lBxAUlTs58wgJiMwtoSdz49xKslVlAWmL5
	Pw6QMKeAmcSkSceYQWxRAWWJA9uOM01g5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU
	5mVW6CXn525iBAbtsto/E3cwfrnsfohRgINRiYf3wIwV6UKsiWXFlbmHGCU4mJVEeE0WAoV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYnU885Kx/vYR/
	rrbMMudPzxf++frr7meek7u2pFwX6/v+7JRv/jTBtjWfhKvKZ31mcFqget+gkyt9RteKiNLf
	0fF/tvmvO3Rtqm9hsGib6dX7Wu0X7Kbf7X6wLfz0mWemdz8sbRWwPVEw21RVflqja+u6p74T
	eradOntmo6Df3GTlJrsWj6jcVUosxRmJhlrMRcWJAHZl8DtWAgAA
X-CFilter-Loop: Reflected

On Mon, Feb 10, 2025 at 01:00:02AM -0500, Gregory Price wrote:
> On Mon, Feb 10, 2025 at 11:33:47AM +0900, Harry (Hyeonggon) Yoo wrote:
> > 
> > Premise: Some ZONE_NORMAL capacity exists on CXL memory
> >          due to its large capacity.
> >
> What you actually need to show to justify increasing the complexity is
> (at least - but not limited to)
> 
> 1) structures you want to migrate are harmful when placed on slow memory
> 
>    ex) Is `struct page` on slow mem actually harmful? - no data?

Then we can hold this one until it turns out it's harmful or give up.

>    ex) Are page tables on slow mem actually harmful? - known, yes.

Defenitly yes.  What can be the next?

> 2) The structures cannot be made to take up less space on local tier
> 
>    ex) struct page can be shrunk - do that first
>    ex) huge-pages can be deployed - do that first

I'm really courious about this.  Is there any reason that we should work
these in a serialized manner?

> 3) the structures take up sufficient space that it matters
> 
>    ex) struct page after shrunk might not - do that first
>    ex) page tables with multi-sized huge pages may not - do that first

Same.  Should it be serialized?

> 4) Making the structures migratable actually does something useful
> 
>    are `struct page` or page tables after #2 and #3 both:
> 
>    a) going through hot/cold phases enough to warrant being tiered
> 
>    b) hot enough for long enough that migration matters?
> 
>    You can probably actually (maybe?) collect data on this today - but
>    you still have to contend with #2 and #3.

Ah.  You seem to mean those works should be serialized.  Right?  If it
should be for some reason, then it could be sensible.

	Byungchul

> > I don't understand why we shouldn't introduce more kernel movable memory
> > if that turns out to be beneficial?
> > 
> 
> No one is going to stop research you want to do. I'm simply expressing
> that I think it's an ill-advised path to take.
> 
> ~Gregory
