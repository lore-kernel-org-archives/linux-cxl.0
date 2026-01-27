Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484492F3C12
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556547; cv=none; b=KT7jI8ZJUi27yNpuu+PTCYi4a+raGgEMp8zB3EZBYqxpwfnTqCkyAclhLVhA6r1VL+1FRYe9GsJk8jok4mjVdgGhaGPxkJCaQXWArXDdSZpy3TSWf09O1F+pdOJpgCDDDIbuUuRkhmhRUQ3bXB2D54Gd0YOYR7LM0Qv40QJkuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556547; c=relaxed/simple;
	bh=ofHckpHSK4mfHbe6L1ZVH+h1/SSvRemGaI9zfgs1u/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiPw4ODlGQDcKZbrDvuMNisx2uTDlwA0wzTdgoqElI/KX5V0tYchO8rtrOdWJmmOgkTkD0u5y5nNhqAHoCG3h9OQ1FKrVXKvfScM/LcG85B47p76C0JSpK6DD+6Q5ex94KC3miqRi/fSeL1A6oVUIMc8zjXm1HOtjOMzMfiFKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8U7TuRd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8U7TuRd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a1462573caso15265ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769556546; x=1770161346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggQbKrh8ZyuooMxE9NUhGxSmgLEA7sxK0OqhmRkzBEY=;
        b=I8U7TuRdmnddLr13hly0xpTKB1bih6vDDfJua9/HxozplYZJNrKzumg2lFqIpk1aDn
         3Em+5RWvTUGigBDzBWfUqoc+/oD6ZXVzTRenNkSncT9cC7i+k1707dW1mlo7Hj/XhK8q
         K+mxmaYOj6XmwH9TjtTs74SYEi1q8C93GRGIk9mfM3cJa9Q+x/bbAPE0lKwXLDHDrucz
         wOANeE1FvjNKEki48xF1hge14wXNJBNG5M/t/zCYrG8pLHpGjDRhxFC4yJ022Sf45pgH
         DFmh9KByH/aASZLtQEACOrqTc/jRh0lzTZoU2u2YcIdtEtvaAe1orUY/LEHZzj+uhaPb
         N2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769556546; x=1770161346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggQbKrh8ZyuooMxE9NUhGxSmgLEA7sxK0OqhmRkzBEY=;
        b=Fq5+jEUGAfdtnuU2jjXG1/k5c0xy/KPerXrcw46e0yrU4N7BpKYYIGXiQJm3IbCIZJ
         Rb1T4C/L1WJgLusiub8Rn7pY01f/9ePtrvzp937y/g62Y5h3QzqMsbuXa7b21SvuGNvg
         M19ooMSqa6+x5Ubw2O+TZ8JkAZYtmhvXhdM+EOe1Re2ACko2PEhIOEcQ99eHKXG17BpY
         9oQj1ULC18f8a5BxCV707TPIdz21UFGj5Bb31m/As7tPV3vF4y+hHuV4GLT2yx8AEoIH
         7L3viVWGSiHjyDr7+YUEfrvlsGR4hs0jXWzPhL3DXPwnO8rvuKqCE36Qkae9cdaMlTwl
         nExQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYBcL17rmPomqJ7bgy5P4dvWvZdT//iCmwl7Oo/3bZDBF6x8PjNavSlsR+iDDjmW28cGq6SpyDH48=@vger.kernel.org
X-Gm-Message-State: AOJu0YywiQVsorhqXC1BZ6l4wtueDmDTNxTblcTyB1BxyfuxgVkx8meM
	1yrMykbCM0xJLOKMdSCezB0d8gaME1sO9K/266e3JbUKuiDQ+coD72HXAlQYu8BkQtqzjIH9nXF
	RZmP5AQ==
X-Gm-Gg: AZuq6aIaX/ZYN2+r0OI8fF5s7DKW2GuSO4wrRGHkoh22nwFuZcG98DPwpWyatOvxe5D
	kLzuU4kpMstCsVHfgyEM44xgRhR3NczBl5+nTb+fPdL5R2A7omJTHoguKKTu7OZMLmKTVCI3yiV
	kB+XCSM5IjUfaWIw6e+Hna/j9meMEbhA+HlGQyYxAQEQOm7GLPR0qi2Cf0ZAa23OvgOJL8GbJUC
	boRwkoK1ukW/kGmOwUv7AkNn8DXwfp2BsCV6i7jmLfO/dm3ZxAtWGiiqt2Sx/y0f4CGbqRBMyMn
	aY6BuQ8CLR7CkLGCHhHXsuYRPXkIvvG7KAsujwB43SAsIqhS8RhpsO9WmXOy7ROhy8Foprq8JB0
	P1IPWcQzThcw5IlzY5Um0fcq5380TGUefJda7BCaF6CfareZ27NuRz7HDaNSYhMpSLA4v8PZtHQ
	EjvqoHhy1HC6MFXrOTNC6F4H/sc6L9+r5B6Chs9/SVhPeCxbwCVw==
X-Received: by 2002:a17:902:fc4c:b0:2a1:3cdc:771f with SMTP id d9443c01a7336-2a870b97452mr3881485ad.20.1769556545254;
        Tue, 27 Jan 2026 15:29:05 -0800 (PST)
Received: from google.com (130.15.125.34.bc.googleusercontent.com. [34.125.15.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b417394sm4031265ad.42.2026.01.27.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 15:29:04 -0800 (PST)
Date: Tue, 27 Jan 2026 23:28:59 +0000
From: Bing Jiao <bingjiao@google.com>
To: Gregory Price <gourry@gourry.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXlKOxGGI9zne8sl@google.com>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
 <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
 <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>

On Tue, Jan 27, 2026 at 03:24:36PM -0500, Gregory Price wrote:
> On Sat, Jan 10, 2026 at 10:55:02PM +0900, Akinobu Mita wrote:
> > Since can_reclaim_anon_pages() checks whether there is free space on the swap
> > device before checking with can_demote(), I think the negative impact of this
> > change will be small. However, since I have not been able to confirm the
> > behavior when a swap device is available, I would like to correctly understand
> > the impact.
>
> Something else is going on here
>
> See demote_folio_list and alloc_demote_folio
>
> static unsigned int demote_folio_list(struct list_head *demote_folios,
>                                       struct pglist_data *pgdat,
>                                       struct mem_cgroup *memcg)
> {
>         struct migration_target_control mtc = {
>                  */
>                 .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                         __GFP_NOMEMALLOC | GFP_NOWAIT,
>         };
> }
>
> static struct folio *alloc_demote_folio(struct folio *src,
>                 unsigned long private)
> {
> 	/* Only attempt to demote to the preferred node */
>         mtc->nmask = NULL;
>         mtc->gfp_mask |= __GFP_THISNODE;
>         dst = alloc_migration_target(src, (unsigned long)mtc);
>         if (dst)
>                 return dst;
>
> 	/* Now attempt to demote to any node in the lower tier */
>         mtc->gfp_mask &= ~__GFP_THISNODE;
>         mtc->nmask = allowed_mask;
>         return alloc_migration_target(src, (unsigned long)mtc);
> }
>
>
> /*
> * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
> */
>
>
> You basically shouldn't be hitting any reclaim behavior at all, and if
> the target nodes are actually under various watermarks, you should be
> getting allocation failures and quick-outs from the demotion logic.

Hi, Gregory, hope you are doing well.

I observed that during the allocation of a large folio,
alloc_migration_target() cleans __GFP_RECLAIM but subsequently applies
GFP_TRANSHUGE. Given that GFP_TRANSHUGE includes __GFP_DIRECT_RECLAIM,
I am wondering if this triggers a form of reclamation that should be
avoided during demotion.

struct folio *alloc_migration_target(struct folio *src, unsigned long private)
...
	if (folio_test_large(src)) {
		/*
		 * clear __GFP_RECLAIM to make the migration callback
		 * consistent with regular THP allocations.
		 */
		gfp_mask &= ~__GFP_RECLAIM;
		gfp_mask |= GFP_TRANSHUGE;
		order = folio_order(src);
	}

#define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)

Best,
Bing
