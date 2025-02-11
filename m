Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376D26BD87
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739238806; cv=none; b=Y63/vQdfqMJmhS/V6kDH1wFgqtAVJO2N6BysMt288saadiLWy7i8T7UUQDu3tSt+ylbxEVGx89P5NhVJkAPABdu1bHNDLwi/GhBXpManKFrmHqkTZpDGoWSCidG4HXqHv20obFt1bbzDI2H+fWyeXLSwiS45cOljnbwW+Xth/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739238806; c=relaxed/simple;
	bh=mcEGYcztBHAzVlJ3W1rwV9igpMItlRZ1eXa+NaWeGTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lanrt4nBW2mTCe3wgLfE7aCHP+wWWTX0xQHqKxGzv8BnGIpTKmjp+QtMHdDuOHh0p2g7zM0IFhQ/wnkWucjGX7ToINoMtfUOLeM82vAg9lybWi8BcPgO2JEKif2I++rkicnBMWJ4XO6wXytuBJmPUD1i6fH79V/NT6zKOOM4h1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-94-67aaad8d83b4
Date: Tue, 11 Feb 2025 10:53:12 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250211015312.GA21555@system.software.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
 <20250210071741.GB39454@system.software.com>
 <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoW7v2lXpBgtPSFlM7DGw+Hn3OLvF
	+VmnWCzurfnParHv9V5mi98/5rA5sHnsnHWX3aO77TK7x+YVWh6bPk1i95h8Yzmjx+dNcgFs
	UVw2Kak5mWWpRfp2CVwZLzZdYS14yVfRdXU2UwPjLe4uRk4OCQETiamTN7DA2Of+PASzWQRU
	JRZ/P8QEYrMJqEvcuPGTuYuRg0MEKN52xb2LkYuDWeANo8S/jRuZQOLCAmkSb3/4gZTzClhI
	3F89gxWkRkjgKLPE7SOzWSASghInZz4Bs5kFtCRu/HsJ1sssIC2x/B8HSJhTwEzi5odrrCC2
	qICyxIFtx5kgTtvDJtGyzx3ClpQ4uOIGywRGgVlIps5CMnUWwtQFjMyrGIUy88pyEzNzTPQy
	KvMyK/SS83M3MQKDelntn+gdjJ8uBB9iFOBgVOLhdXi1Ml2INbGsuDL3EKMEB7OSCK/JwhXp
	QrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhgFa8L83rTe
	/esov/rA2i39B1bPZBT9aLy1VdL9952DnLWZ+03SVq545bG4oG3K03dXtq2sNM9xPpOaLH1M
	yCnPXWhNyMvLNXvW3p+0Ji3xvXhOsWrmm7siVfuXaMTrunUE7rOaNqnAlPvDYoXLlavUVr78
	V5r1y2jjl7kCNseCp6eeX/58Z1aIEktxRqKhFnNRcSIAOUxD7GYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXC5WfdrNu7dlW6wbRXghYTewwsft49zm7x
	+dlrZovDc0+yWpyfdYrF4t6a/6wW+17vZbb4/WMOmwOHx85Zd9k9utsus3tsXqHlsenTJHaP
	yTeWM3p8u+3hsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDJebLrCWvCSr6Lr6mymBsZb3F2M
	nBwSAiYS5/48ZAGxWQRUJRZ/P8QEYrMJqEvcuPGTuYuRg0MEKN52xb2LkYuDWeANo8S/jRuZ
	QOLCAmkSb3/4gZTzClhI3F89gxWkRkjgKLPE7SOzWSASghInZz4Bs5kFtCRu/HsJ1sssIC2x
	/B8HSJhTwEzi5odrrCC2qICyxIFtx5kmMPLOQtI9C0n3LITuBYzMqxhFMvPKchMzc0z1irMz
	KvMyK/SS83M3MQLDdlntn4k7GL9cdj/EKMDBqMTD6/FxZboQa2JZcWXuIUYJDmYlEV6ThSvS
	hXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhir9p5KSVAP
	kQkUmOFUc2SyDufLr5cV6vcdfpgnWyDKefWx1I3Wt+uy5+xISLv1OFSx8/4qr0NSP8IblCaL
	eB0//VX91o9/szczbjzjv6pa+mNNjkb6nukvDnR+FZgs+Ndv8pecs2yrGpf5/bRbOufJkytx
	dgJqyzWvcz5Z/DL4seorpX2XT16+pMRSnJFoqMVcVJwIAGFpnHFXAgAA
X-CFilter-Loop: Reflected

On Mon, Feb 10, 2025 at 10:47:58AM -0500, Gregory Price wrote:
> On Mon, Feb 10, 2025 at 04:17:41PM +0900, Byungchul Park wrote:
> > On Mon, Feb 10, 2025 at 01:00:02AM -0500, Gregory Price wrote:
> > > 
> > >    You can probably actually (maybe?) collect data on this today - but
> > >    you still have to contend with #2 and #3.
> > 
> > Ah.  You seem to mean those works should be serialized.  Right?  If it
> > should be for some reason, then it could be sensible.
> > 
> 
> I'm suggesting that there isn't a strong reason (yet) to consider such a
> complicated change.  As Willy has said, it's a fairly fundamental change
> for a single-reason (CXL), which does not bode well for its acceptance.

I have observed performance difference depending on page table's
placement between DRAM and slow tier, that doesn't have to be CXL memory.
We should place page table in DRAM as long as possible, but when not
possible, we could do either recaiming DRAM for them or temporarily
place them in slow tier and move to DRAM for better performance.

But yes.  If slow tier is *NEVER* allowed to be huge, then reclaiming
DRAM would always work.  This topic is valid only for the other case.

> Honestly trying to save you some frustration. It would behoove you to
> find stronger reasons (w/ data) or consider different solutions. Right
> now there are stronger, simplers solutions to the ZONE_NORMAL capacity
> issue (struct page resize, huge pages) for possible capacities.
> 
> I also think someone should actively ask whether `struct page` can be
> hosted on remote memory without performance loss.  I may look into this.

JFYI, struct page, page table, and kernel stack were just example.
Let's exclude ones that you don't think are feasible.  However, I'd like
to tell at least page table is an interesting kernel object in the topic.

	Byungchul

> ~Gregory
