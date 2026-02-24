Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C182777EA
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902020; cv=pass; b=rGK4aCPcGsrcx9M7TTVcsttPawE4BB5ECcZwwUnkrWDqLtYQe2hcKO16G6ZH2IjChZWRfdh9jHyKKELdk5EdVb1uAWEYZOZIigNtA0RduTPjSsF1dc69mktLuEHvZ1E8y31UCLGgS5TkIoC6cFeBhUznwThYFngppvoQ2bWCIs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902020; c=relaxed/simple;
	bh=URG9p5PA0AV/5bQlXeYXvRn2vYf4zuMTvunUlPWBpFY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZMpDdLJ18MDmfWNEiqV+71oxPTfTdQpj5Tnh8aD3o8Dg1vgf6F7NQf+NBmO7G3i3gynokMhC3l2IPxYt9qFBAFcUf11jXE6KfUDDNzdVp4/A051nBqoNtl47SLVepz1dgkdSf/Z+0b0xN8cu732wM+z6JanlP1pL01ove9HHIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3ymAhxx; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3ymAhxx"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56743b33c67so2209208e0c.2
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 19:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771902017; cv=none;
        d=google.com; s=arc-20240605;
        b=gN1yBXqucOubyLjAavc0qzJz3e4zQDGddWfsv4AHK0b2/FcMSZe6+tKEIEXRErGONy
         FBBFSX305r8urNOHNuIqLzbN+U3hCXjCdt/dvV+FsSK7wOe9IpDce8T0iRebQHlBL2nI
         8MDRjnW0w0K2oU12s4mqXXC7jYCkFQKMjwVlrBgkTavR3Clr01AmiqTVwgFRoqqs0xyF
         RaikLY5JCcDyUV/QbuhKSXVq13lsouq7DWwKkN1aU9tJv4MHeKNQqowIwvRwKuP+uFsW
         3DUGQXS6Sjqs2Y3q5CwLPbJEzIbTMvvRPLw3SlvH0m3ojHJSZAeVoUnv0nERSXpbfpl0
         6aPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xFe8WdiYvRsGLyynpqXx4xXBoM9FyyzukwEjWl1pbts=;
        fh=+jFdAeOJodK5MrG50Dl5JFcfVatCrUX1a0GYH7hVHCE=;
        b=D5zV8lrUyxksEyseovQBdexz4Wn5SRORZK3klkVhTVgcX9zd1SSBCA8KthbgUSCsBT
         hV91K/oPtuNuN7+/H/+5aE6L1zUFM/0h4DLFIJtdE/+Mbv28SIRcndIL0fXJq2l2QSMF
         M5hIuS8I2yRbOxU/fhUohzDqJsNJJfD/S+Sb65O3paahPapTEpWGMYLsSQzYW3rUFiIG
         qhlIHeouHl/3Co193sm1vySsrk4Bv8XX0K+lffzaaNHfKs61oyn6EJyyJ8/kO2/WLMeK
         oPjz33GNMSlrgzNE8TdwZAxzHRCOODSC4Bds8H7MPUFI3RcQS28uut6UOxiWzMjGjceo
         nMYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771902017; x=1772506817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFe8WdiYvRsGLyynpqXx4xXBoM9FyyzukwEjWl1pbts=;
        b=B3ymAhxxWeoTfsl0KRnGRCZw0Cw7PoBJbPwy3MCpelHkkc67TCEWmEMkObdOJ7M63x
         aX2RR//RrqYDhs5WPF0G0EWfQ1CE6/aG+seMJBt31TstS8q18nx5tCnmFdQEah/GoF7P
         Ss079WND2GVySuBN8bDw9gDHvsG4NBE4TnNHOOQLGkWWYRR/7uYcWg4qgJCBNx4/UowJ
         gFnNLyjfvvBcOici+VtfIlJZQsW4j8pyEFjI3vOLDGpj2CqoWk/UuAdZblk8u+DoAL8Z
         f+bSQDDVDdQSw2aZ2YZimO2Ewz9wgcow+pdeYzKHDwLQFH/+mchjBx2p6Cbbm4VmA8lW
         GgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902017; x=1772506817;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFe8WdiYvRsGLyynpqXx4xXBoM9FyyzukwEjWl1pbts=;
        b=dHjzX6lpDHZ5Yn/NNihGt7XYaak2qdAuLmvkh8IiveVl4L42dxndJXSqjfw820RWNb
         JWEeFXjZXv8tktXeoehdapGevhNMESC3ql2N7AWfYXRDLP/3rlqKkRE8QX7OchTViXsr
         UDARLIuxHEG0UXm/s3ghjR6o4MgdZiv8TWkRs2Kgp+d0i1Vk1OYZFRLBzTO/kWobk3IX
         ZQsMlnDo5ikut5mt48FMe7bJ1BaW4ahwC61eGnh8wPN+3AndLzIpVo9IeBlbiEAePHg4
         mxTWmlZtCRsAZ8/z+M+87eipbMgeniICR1OGNzzuvKn9NjX3NXBf0oTcBr9AXKzoINTE
         k3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs42S9KGEmVZ9Fs0Agy4MbkCk+q9p/z/lyZDJwsF0MdSoCzJLTUU8homvCKFFQ8PAhXfdrbce2UmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JKWWjVNfV67ZBJMha2BfTAO6kW48hbGs5bLA1vL025uPuh5p
	9arE/3uqEoPGdA+Ad2OJuxQ0nurRTfBU3GUyK0N7uGj1xodEEalMkmcXuEIncVdrPnFwV3CMnER
	iE+rZAT9vX75PtAQth2yeKXJn5jWkrULT1rZhX/Pf
X-Gm-Gg: ATEYQzzbga8yGti5XXzU0zdyA/KxDf8FfaFDjjbEPKhHWTorbnIg9FcdyOAiT7v3Ysm
	fdgJQOD1uQVa5nDTpfEC3qK7lgK7VewRCpkgzgTg6CrU0cZXYrmB5JRNZBFZWEQUp06Yg472tsC
	65ntTy14/P0LBKwLGKeYQSoGhIJrj89kw9fcya4sP5fawKhvFfMYb7D94JP/kc1nVoJ6wwfUErz
	M/gWwyymcTml5gzGx+jASMnqAbgJNFsBoCILoB7jHOun2ReRSP1QjYjMaM4Cs+88jtaUOcNtOxk
	VJjeaMT6pBybbw6sy53mqZv1i05NMOr0sCUNE7fObTiXRKdo7DKJwJO0wRX8Swbgzg==
X-Received: by 2002:a05:6102:3048:b0:5f8:e2cb:d245 with SMTP id
 ada2fe7eead31-5feb2c23567mr4062890137.0.1771902016820; Mon, 23 Feb 2026
 19:00:16 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 19:00:16 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 19:00:16 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com> <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 19:00:16 -0800
X-Gm-Features: AaiRm52vebMvqU0lH0n0vOtDAX6OI7Y7um56VSKnaZ96AOmxaI9gmZymUaqHfu0
Message-ID: <CAEvNRgHmfpx0BXPzt81DenKbyvQ1QwM5rZeJWMnKUO8fB8MeqA@mail.gmail.com>
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
To: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

John Groves <john@jagalactic.com> writes:

> From: John Groves <John@Groves.net>
>
> Both fs/dax.c:dax_folio_put() and drivers/dax/fsdev.c:
> fsdev_clear_folio_state() (the latter coming in the next commit after this
> one) contain nearly identical code to reset a compound DAX folio back to
> order-0 pages. Factor this out into a shared helper function.
>
> The new dax_folio_reset_order() function:
> - Clears the folio's mapping and share count
> - Resets compound folio state via folio_reset_order()
> - Clears PageHead and compound_head for each sub-page
> - Restores the pgmap pointer for each resulting order-0 folio
> - Returns the original folio order (for callers that need to advance by
>   that many pages)
>
> This simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while
> maintaining the same functionality in both call sites.
>
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/dax.c | 60 +++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 289e6254aa30..7d7bbfb32c41 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -378,6 +378,45 @@ static void dax_folio_make_shared(struct folio *folio)
>  	folio->share = 1;
>  }
>
> +/**
> + * dax_folio_reset_order - Reset a compound DAX folio to order-0 pages
> + * @folio: The folio to reset
> + *
> + * Splits a compound folio back into individual order-0 pages,
> + * clearing compound state and restoring pgmap pointers.
> + *
> + * Returns: the original folio order (0 if already order-0)
> + */
> +int dax_folio_reset_order(struct folio *folio)
> +{
> +	struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> +	int order = folio_order(folio);
> +	int i;
> +
> +	folio->mapping = NULL;
> +	folio->share = 0;
> +
> +	if (!order) {
> +		folio->pgmap = pgmap;
> +		return 0;
> +	}
> +
> +	folio_reset_order(folio);
> +
> +	for (i = 0; i < (1UL << order); i++) {
> +		struct page *page = folio_page(folio, i);
> +		struct folio *f = (struct folio *)page;
> +
> +		ClearPageHead(page);
> +		clear_compound_head(page);
> +		f->mapping = NULL;
> +		f->share = 0;
> +		f->pgmap = pgmap;
> +	}
> +
> +	return order;
> +}
> +

I'm implementing something similar for guest_memfd and was going to
reuse __split_folio_to_order(). Would you consider using the
__split_folio_to_order() function?

I see that dax_folio_reset_order() needs to set f->share to 0 though,
which is a union with index, and __split_folio_to_order() sets non-0
indices.

Also, __split_folio_to_order() doesn't handle f->pgmap (or f->lru).

Could these two steps be added to a separate loop after
__split_folio_to_order()?

Does dax_folio_reset_order() need to handle any of the folio flags that
__split_folio_to_order() handles?

>  static inline unsigned long dax_folio_put(struct folio *folio)
>  {
>  	unsigned long ref;
> @@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
>  	if (ref)
>  		return ref;
>
> -	folio->mapping = NULL;
> -	order = folio_order(folio);
> -	if (!order)
> -		return 0;
> -	folio_reset_order(folio);
> +	order = dax_folio_reset_order(folio);
>
> +	/* Debug check: verify refcounts are zero for all sub-folios */
>  	for (i = 0; i < (1UL << order); i++) {
> -		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
>  		struct page *page = folio_page(folio, i);
> -		struct folio *new_folio = (struct folio *)page;
>
> -		ClearPageHead(page);
> -		clear_compound_head(page);
> -
> -		new_folio->mapping = NULL;
> -		/*
> -		 * Reset pgmap which was over-written by
> -		 * prep_compound_page().
> -		 */

Actually, where's the call to prep_compound_page()? Was that in
dax_folio_init()? Is this comment still valid and does pgmap have to be
reset?

> -		new_folio->pgmap = pgmap;
> -		new_folio->share = 0;
> -		WARN_ON_ONCE(folio_ref_count(new_folio));
> +		WARN_ON_ONCE(folio_ref_count((struct folio *)page));
>  	}
>
>  	return ref;
> --
> 2.52.0
