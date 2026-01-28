Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076A255E43
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610111; cv=none; b=BaTyl9nWC0jkJIP+geE2dwW9eGccZSEDo3mq0aK9yMepBkPMnG9d45c1VzfUatbL4ErYJ48fXwS6E9PgvgSt1X8aE4nCCFda1HgTjy+KovaKq/O5A1cBu1VvyHm8eDU7tWwrjJVE3VIwkSz8e8OMAp0YW9JVnx8vgZ1NLfLm0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610111; c=relaxed/simple;
	bh=zhfWj1IrgUZ63mHxugpYC8ANOdmzStBz/dvKdAHJx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6Mf3gUjl1tOTN2SWkr2e8TnKF+dFFlq7MQEVbgph3yimZ+bySQB2tszl1s7G/0spxDUZuyB18/r1PmaJKAgTxjl0u8Yo5dSbqiwGS0vsL1cg2pAvQoArjApuo0g2GHWIkdYmIc2RY+0grBtvXuaHHmIgdY1eFNC+WBedCiEB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NP04pcm1; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NP04pcm1"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c531473fdcso911261185a.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769610109; x=1770214909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFnWufKdjRl1LzlNBH4foXwRJEqqXwbSTG5Sb2CxZBM=;
        b=NP04pcm1etjdsLAEKKj2uoQ8gkGx1TGwHDxNEjv5hRogvIIGZIuzR/+BHT6ZHSeECC
         ItRrALJBy5GCW9f2rdFdE8DphN8KyRjnH3MlwyTN4tJxCLKPzpbZdzkts+L0vVhzvcNU
         8Nmfim7sliRNPbEcmWtRybj1Z33smLhybqtEHmEhV6pVd2zqUPXmbx3K5Y59vX7+2HNN
         Ytza0O5XIM9GrtSm3vHTqo/FOQUJYMltTOMipk8Zdprz7LqITJ+6jJV7anSH42vvlJA5
         vsj3v1Qv7Hcn4qY9QLXnge5FfavFmiBq4ooGXaOEfNq9k9nxlbQ6V5yYQkvx60J9Uhd3
         VymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610109; x=1770214909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFnWufKdjRl1LzlNBH4foXwRJEqqXwbSTG5Sb2CxZBM=;
        b=WjqOSAJidj1IvRJyldHxtd7HlyfC948waIrJ/tQ0C5u1OS9jvOv0raRGp6HaS8OYrZ
         e6WST40OJMMA0feMnmezmd25IEf5zmZw/GJzKbTRvBDBT3vCYdzA83T+N7umGXOPszq+
         3aN+TM7re7jCSpWw1WgWzBJ1sGshDjnFxIUIV7C3mgmyjXut1CvPsVhfcl49B/29K+IY
         HbT41bFxC8aC65g0mZNO1blwEpswaeKpfHEizDyLqbE69AnDl/5MLScSUEox5XArxjXK
         bGrHjuOn3UBlVQ8wJ7Klcaupz3hzjgIqccvSZkAkcem5xfwft63TE5KcyzJW4QkociMB
         yLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY9uBiHf3oyC5lbqovc3NUz6Kvn0kJh3VRTJEWu5jhcjGoFvHnERm8MXdHdagwiXSrTum8Mx3kgvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1m2TR5Sba0rETsrmAlU+FEMnUcYYWwIJIiXo62rpLkJ/AXyBS
	3jYXb33F+kzjPri2ummTcKTLIVfgg2vwW9cJEftFxtLmQHOKvjBC4ep0xT89NOUoCzY=
X-Gm-Gg: AZuq6aK/Ncjd0G7hDBFfdCUjJQwYwBDwCsT1qaZ4TA1VcUUv5X2Tuc6je61owsVu2+G
	0CBf99I+ppG/eiuZhjxHpyHH7k40P08O3B/p6s1oYE3W8yVfYLHOUMF/pIs59xCZRVId6kExG5V
	a6OtD2mUC+qtvYFuK++VqXUvaN0tGc04+W6UuuBzsafZ+TFlppueoYC9zy62dfZTMsJrJUmI9d5
	giJnMcX708/7XQamqyRE1XhjW7gZe9NIZfgAGgk3ZikwmZasinWMXPhc3FpCGsqvUv+yU5hKB9t
	6V0M6y3TfW+FP/OSCPiJXxy6oNewmD5wwzO2sdqK6vaPUcWmyKyCRCzykwKY7jya8kEGl1aOPAE
	YriYW3KGQDMiYgIFzuFMG3Z6HjIoNlVn5QwM1+G48n6zn3qcuMzIeWQNNsgD4M7xkQah2LSvsEH
	q04CURI6bgmmqfTz1wzLg7y1HOwnZZh7j0vdjPG1BECkT02Do4FrHSk8ujuwZWUiFjpHDJuYOkf
	q3wdEKy
X-Received: by 2002:a05:620a:5dc4:b0:8c7:139a:bf66 with SMTP id af79cd13be357-8c7139ac6dfmr250534485a.50.1769610108659;
        Wed, 28 Jan 2026 06:21:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d49c2bsm186932285a.46.2026.01.28.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:21:47 -0800 (PST)
Date: Wed, 28 Jan 2026 09:21:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Michal Hocko <mhocko@suse.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, bingjiao@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXobeWtnJVrTmxlV@gourry-fedora-PF4VCD3F>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
 <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
 <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
 <aXndXPMFK2fhLA4p@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXndXPMFK2fhLA4p@tiehlicka>

On Wed, Jan 28, 2026 at 10:56:44AM +0100, Michal Hocko wrote:
> >                 .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> >                         __GFP_NOMEMALLOC | GFP_NOWAIT,
> >         };
> 
> This will trigger kswapd so there will be background reclaim demoting
> from those lower tiers.
> 

given the node is full kswapd will be running, but the above line masks
~__GFP_RECLAIM so it's not supposed to trigger either reclaim path.

> > Any chance you are using hugetlb on this system?  This looks like a
> > clear bug, but it may not be what you're experiencing.
> 
> Hugetlb pages are not sitting on LRU lists so they are not participating
> in the demotion.
> 

I noted in the v4 thread (responded there too) this was the case.
https://lore.kernel.org/linux-mm/aXksUiwYGwad5JvC@gourry-fedora-PF4VCD3F/

But since then we found another path through this code that adds
reclaim back on as well - and i wouldn't be surprised to find more.

the bigger issue is that this fix can cause inversions in transient
pressure situations - and in fact the current code will cause inversions
instead of waiting for reclaim to clear out lower nodes.

The reality is this code probably needs a proper look and detangling.

This has been on my back-burner for a while - i've wanted to sink the 
actual demotion code into memory-tiers.c and provide something like:

... mt_demote_folios(src_nid, folio_list)
{
	/* apply some demotion policy here */
}

~Gregory
