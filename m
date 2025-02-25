Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDF634
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459314; cv=none; b=NQjIruQ27UB71ezjfDhFNkC1OtTXSAqawNqo42o9P4Lld5GRt5qUWVS30rxmEYTYlDZ8NpmI6KoFKoQJOIcgOY4iHjLPfUdSrlgymbrqJiIeb4j6z4o/+q1dGWKQceaoNW7rKTs5BspNQuY5iH4oWOld0+EhVf2SB52VlusXaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459314; c=relaxed/simple;
	bh=x5NPjNFnmXrVJuIa2XaEdpiukoCQTRH8GgRFf7Nznsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrXR6d3us84d7HEeuwLu/8gp1pBDZIZPuOr3Hnyp278Zp2R9hzS+t9aZSTyRaS6LBvWnP11biarPuA8C0+TOvodY5TG4Link57Pa8TQ8vevjWiRkRHF1z+/KXQW55lAoOCzHeQzcjb2Rnu+3VMY/My35g1krrR7eaHbYGJkd5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-e0-67bd4d22ecea
Date: Tue, 25 Feb 2025 13:54:53 +0900
From: Byungchul Park <byungchul@sk.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Gregory Price <gourry@gourry.net>,
	"Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Gathering ideas to reduce ZONE_NORMAL cost
Message-ID: <20250225045453.GA38036@system.software.com>
References: <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
 <20250210071741.GB39454@system.software.com>
 <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
 <Z7fcSSaa4CKvxQ3V@harry>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7fcSSaa4CKvxQ3V@harry>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnka6S7950gw0PNSwm9hhY/Lx7nN3i
	/rJnLBbnZ51isbi35j+rxb7Xe5ktfv+Yw+bA7rFz1l12j+62y+wem1doeWz6NIndY/KN5Ywe
	H5/eYvH4vEkugD2KyyYlNSezLLVI3y6BK2PxxilsBb0SFRf+bGdrYHwv1MXIySEhYCIx/ch3
	dhh78+rlzCA2i4CqxN4Dm5lAbDYBdYkbN36CxUUEVCTeHjvE1sXIxcEsMJFJYtGy10AJDg5h
	ATeJU1MzQGp4BSwkJv9cC1YjJLCVWeLY7zVMEAlBiZMzn7CA2MwCWhI3/r1kAullFpCWWP6P
	A8TkBNp7vT8CpEJUQFniwLbjTCBjJAROsEnMfd3PCnGnpMTBFTdYJjAKzEIydRaSqbMQpi5g
	ZF7FKJSZV5abmJljopdRmZdZoZecn7uJERjqy2r/RO9g/HQh+BCjAAejEg+vQ/yedCHWxLLi
	ytxDjBIczEoivJyZQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2Cy
	TBycUg2MHkInY0Q7FkTEbL0Vw/fDSGNCTHHfz6ULhCNepJt8nXWxTXvdqzf7tzxZJtn5V/cN
	Y4L15m0NvKd2/Q9l6D56WjAlaob8rv27T0cbbl5SZFR8IFvKTI3nvudtzxYTppOVnUkNr7/u
	WrFgKVftlD0fjrKf7JcXYsq59EScZaVmZ9iEhUfu9Z1VU2Ipzkg01GIuKk4EAFU3RwxxAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC5WfdrKvkuzfdoPeIvMXEHgOLn3ePs1vc
	X/aMxeLzs9fMFofnnmS1OD/rFIvFvTX/WS32vd7LbPH7xxw2B06PnbPusnt0t11m99i8Qstj
	06dJ7B6Tbyxn9Pj49BaLx7fbHh6LX3xg8vi8SS6AM4rLJiU1J7MstUjfLoErY/HGKWwFvRIV
	F/5sZ2tgfC/UxcjJISFgIrF59XJmEJtFQFVi74HNTCA2m4C6xI0bP8HiIgIqEm+PHWLrYuTi
	YBaYyCSxaNlroAQHh7CAm8SpqRkgNbwCFhKTf64FqxES2Moscez3GiaIhKDEyZlPWEBsZgEt
	iRv/XjKB9DILSEss/8cBYnIC7b3eHwFSISqgLHFg23GmCYy8s5A0z0LSPAuheQEj8ypGkcy8
	stzEzBxTveLsjMq8zAq95PzcTYzAUF5W+2fiDsYvl90PMQpwMCrx8DrE70kXYk0sK67MPcQo
	wcGsJMLLmQkU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRq
	YAybdORS2c/X1u5uawtXHjl6Yc+hufNYrZZdnqCiUzhxtvTr61Pn7/M5c6qxaGKU1MalD4N2
	LryzTPDffokazg2TtWtb46PX/q2cezlAvO+I+Ne9PwMz9qc3SVxkXpPilSGrweh7yz5/7jpl
	vhJPSd4vK17tsppgOo3RJo/5fdsW6wC5NpYLv+YpsRRnJBpqMRcVJwIAMyz+jGECAAA=
X-CFilter-Loop: Reflected

On Fri, Feb 21, 2025 at 10:52:09AM +0900, Harry Yoo wrote:
> On Mon, Feb 10, 2025 at 10:47:58AM -0500, Gregory Price wrote:
> > On Mon, Feb 10, 2025 at 04:17:41PM +0900, Byungchul Park wrote:
> > > On Mon, Feb 10, 2025 at 01:00:02AM -0500, Gregory Price wrote:
> > > > 
> > > >    You can probably actually (maybe?) collect data on this today - but
> > > >    you still have to contend with #2 and #3.
> > > 
> > > Ah.  You seem to mean those works should be serialized.  Right?  If it
> > > should be for some reason, then it could be sensible.
> > > 
> > 
> > I'm suggesting that there isn't a strong reason (yet) to consider such a
> > complicated change.  As Willy has said, it's a fairly fundamental change
> > for a single-reason (CXL), which does not bode well for its acceptance.
> > 
> > Honestly trying to save you some frustration. It would behoove you to
> > find stronger reasons (w/ data) or consider different solutions. Right
> > now there are stronger, simplers solutions to the ZONE_NORMAL capacity
> > issue (struct page resize, huge pages) for possible capacities.
> 
> Hi, apologies for my late reply. I recently went through a career change.
> 
> I truly appreciate your and Matthew's feedback and thank you for saving us
> from frustration. I agree that we need a stronger motivation
> and data to introduce such a fundamental change. And I also agree that
> it's more appropriate to pursue what can be useful for genral MM users
> rather than introducing MM changes just for CXL.
> 
> With that context, Byungchul and I agree it's a better direction:
> Reducing ZONE_NORMAL cost for ZONE_MOVABLE capacity, which is beneficial
> for ZONE_MOVABLE users in general, regardless of whether the user is using
> CXL memory or not.
> 
> Let me organize a few steps to pursue:
> 
> - Willy's shrinking struct page project
>   - https://fosdem.org/2025/schedule/event/fosdem-2025-4860-shrinking-memmap/ 
>   - https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
>   - Side note: Byungchul started working on separating the descriptor
>     of the pagepool bump allocator
> 
> - Slab Movable Objects: This makes sense even without CXL
>   as migrating unreclaimable slab will improve compaction success rate.
>   It also has been tried in the past by others, but was suspended
>   due to lack of data.
>   
>   I'm looking for workloads that allocate a decent amount of unreclaimable
>   slab AND performs migration frequently - for evaluation.
> 
> I might be missing some projects that could be useful,
> please feel free to add if there is any.

So..  Let's change the LSF/MM/BPF topic slightly.

	Byungchul

> And for page table migration, while it might be doable even without CXL,
> we need strong data that suggests that it's actually makes MM better
> to pursue this.
> 
> > I also think someone should actively ask whether `struct page` can be
> > hosted on remote memory without performance loss.  I may look into this.
> 
> Did you have a chance to look at this?
> 
> -- 
> Cheers,
> Harry
