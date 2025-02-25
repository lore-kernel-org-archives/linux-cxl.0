Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197E149E13
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740460017; cv=none; b=kz1SdApym/Vm0uYQ1OchVK6FUKpS3+qKsRG+M2ajSF1K7pur9Hf9flTenT3eaJlwBD7dljhakbIE1bst9tuUXfmRDitPwR/4RPjfcTm3dYsHc62IbbYfOk/Bsxjba6M0vxZIbl18vfpMAc/MdyI3Ez15clHgV0gQQutdLR5VsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740460017; c=relaxed/simple;
	bh=TqkkJHJ4Apr4fnYAioTq4w8FNQv2PLVO1gjZ87qud38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjqzYRidwcYBQ+5Y1TDbNBkCvyAGxYpGaMmcV2zfd7qjRCFbuEd1bjIwWq07CzYblL8WOB3mJ6iFIO2tphXHYlGTOMJuYW4xWCvVEPAm9WlsKM+saAX0CTkk+8b3IdYGf1OBPMkZml8w0O/zsYEPxLXNP0yv05WQPwrjX3+NeCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-fd-67bd4fe9fbfd
Date: Tue, 25 Feb 2025 14:06:43 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250225050643.GB38036@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnke5L/73pBncfc1tM7DGw+Hn3OLvF
	+VmnWCzurfnParHv9V5mi98/5rA5sHnsnHWX3aO77TK7x+YVWh6bPk1i95h8Yzmjx+dNcgFs
	UVw2Kak5mWWpRfp2CVwZqzpvMhfc4KpYeU2sgXEdRxcjJ4eEgInEuY4DLDD2nnczGUFsFgFV
	iWXzp7CC2GwC6hI3bvxk7mLk4BABirddce9i5OJgFnjDKPFv40YmkLiwQJrE2x9+IOW8AhYS
	76Y8ZAepERI4yixx+8hsFoiEoMTJmU/AbGYBLYkb/16C9TILSEss/wd2DqeAmcTND9fA1ooK
	KEsc2HacCWSOhMAONonPx08yQdwpKXFwxQ2WCYwCs5CMnYVk7CyEsQsYmVcxCmXmleUmZuaY
	6GVU5mVW6CXn525iBAb1sto/0TsYP10IPsQowMGoxMPrEL8nXYg1say4MvcQowQHs5IIL2cm
	UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVANjQ/jE3Y3n
	Ap+Jb/Y4stvzYZueSHjLp9Rv0j9sg3vanizZ8tiwZ/ap2pfTNE4xRKivzNqe2SfXGzHBse6Y
	994Dezob/z/MWObZ+OVOu3PypdnRRX8C74YW8RxZXq1kfn9KV1q9h25NYGywndRJgUKdWg0f
	A24DxuVLnvjJ3095uC6yrKrieKsSS3FGoqEWc1FxIgCE1ZhYZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXC5WfdrPvSf2+6wa/vjBYTewwsft49zm7x
	+dlrZovDc0+yWpyfdYrF4t6a/6wW+17vZbb4/WMOmwOHx85Zd9k9utsus3tsXqHlsenTJHaP
	yTeWM3p8u+3hsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDJWdd5kLrjBVbHymlgD4zqOLkZO
	DgkBE4k972YygtgsAqoSy+ZPYQWx2QTUJW7c+MncxcjBIQIUb7vi3sXIxcEs8IZR4t/GjUwg
	cWGBNIm3P/xAynkFLCTeTXnIDlIjJHCUWeL2kdksEAlBiZMzn4DZzAJaEjf+vQTrZRaQllj+
	D+wETgEziZsfroGtFRVQljiw7TjTBEbeWUi6ZyHpnoXQvYCReRWjSGZeWW5iZo6pXnF2RmVe
	ZoVecn7uJkZg0C6r/TNxB+OXy+6HGAU4GJV4eB3i96QLsSaWFVfmHmKU4GBWEuHlzAQK8aYk
	VlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MD4Q7l0ranlbb9UH
	ucz3846elDi+Zx7TqR97toeonbuo48X0r0+57wRnWM6y+uO802v+nHoc3HMu5PHhexeYTNN3
	Z3W83MoVkTYzy7Fsqvvmb1fqahudwv9t7WwJ/brm8eEdC49fz7dUUMo/nJMusVYkqGVF3PS9
	vVvt1pomCUhxBc94rSqQtkCJpTgj0VCLuag4EQDQvLRVVgIAAA==
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
> 
> Honestly trying to save you some frustration. It would behoove you to
> find stronger reasons (w/ data) or consider different solutions. Right
> now there are stronger, simplers solutions to the ZONE_NORMAL capacity
> issue (struct page resize, huge pages) for possible capacities.
> 
> I also think someone should actively ask whether `struct page` can be
> hosted on remote memory without performance loss.  I may look into this.

Could you share the plan or what you have been thinking about it?

We'd be happy to discuss this topic together, and furthermore, it'd be
even better to work on it together.

	Byungchul

> ~Gregory
