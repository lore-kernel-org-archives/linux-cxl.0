Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E934846C
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124808; cv=none; b=nnrUkrPrFfbbRPUWAGyqnNsaDLdnN8q1eZcuV183NMyb4cgUJoedhgmANCJNUXxtXhrOfV4pummOw5gSkW/AbV5NwlsvRMppmjTJOqAAV1nx8bTf01qKvNZCC4HMx1dK+a3r5/ESplZlW15TR1e4tYQflP2ZYwEkjSeqFyVxka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124808; c=relaxed/simple;
	bh=0o7bVmmzRFp2N7/OlVNvlYnXrmD3xdgI8R7r+xdEOBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpxsQqF2cQ9v6KgaF7kYujwkWPbZKcQsyFe+2QLPr0tB2OlAlE/NjFDabihKyE+QsKH8lcSkJ6cnDGGL6aQ7E6RS7CuBrktUmc/hf2hJyM4TaNaxVtRjScF6iF1BiPFSH8wn6vtKjR67S60hmkcNTlijkKFEgtelhHEOfeilaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k1EVktGz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k1EVktGz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c9f6b78ca4so204563185a.0
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774124806; x=1774729606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tEq3kR663AZN+wJIQdRtj/jb9LMYPMsRdvJZPaBgUg=;
        b=k1EVktGzIGzqy37Jyn+wP3atHpdSuiZE6Nf4tX2NVPBp6FVPL7HvSsBbBzITXBZLpA
         KqrGMU2i7/aMzsR8PK1b1dU5NK3YZij4UlnSfhdU3Aw/LuKSE6JRLQzVdQca710EGqX8
         7taIiPi0hQ+KuAFWF2E1x+qY1s40p9626WJ3FjQYTDKvopKTD5LSvtWZra0avgkwwtkR
         KUKYI6WgqgI+RJSnMefztpvyKDru2vKAkSQUC0B3ETXhEvmdsI0u//GSyui9LkBfrBl2
         9Y0LK2lN2aHKo9aPyuCiSycin9TCfsrYcX0MdxK6B9n4UBzm1YpX1+/9MOEGOJLKh2ST
         iemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124806; x=1774729606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tEq3kR663AZN+wJIQdRtj/jb9LMYPMsRdvJZPaBgUg=;
        b=QxoglLueqrG33AF/HPpHGvELN+AjivR5vtB1bv6yR1cei5r6G6dDtSv0CFE1RtWYqe
         6L9iSThiQqXB4OdPjcx5MuPGRvWkE9hPrR8ggjoK57BkPDgvKNZqq8QxVKuhADQZjQgl
         t3pWIL4edLFfqa3lGr/XhH8v4Q83gbwy95KbJ2MGPcoMj2ow2CthYrv0gBnhigBMkBOr
         /AxhzuSolSiLbsUM5XO3O/xR8ZuFL07dflCwlu2WFaa8gUQ7QgJpAGUJCDCp4ZG7fPIV
         jskH6xdqWHAIopAJorL7ohN5yC6QSujKBmdUejsPNReWVYsnHjccqZjWkaD7PkYEa/GU
         AcZg==
X-Forwarded-Encrypted: i=1; AJvYcCVzMVX8+HPPO2GBDxs32eGcEv6+65VXEbu+xB9EIUYM4Ri7agvvoKYjaBrvWse1k6LffR5Wvj793aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvEpaHmcH1Kdemi51VeD8+gtyqPu0jT5t6FR65ArN4Thh1gXbo
	TUEK0q50DwTR3fgS9jkRiHSOtgk8puhxbtvjdss30TvRyrI+RqBpP+v2XJhOBdpC9zI=
X-Gm-Gg: ATEYQzyS2YVFOqP6hmG0MlF2zXa7CKTTZvqHDAbg3QHfIpN3mBz29v5tipBz4HTsvdJ
	JQF284xgoLahKzBP1ZnsFIDZVYS26116Ou8r1Oe93GQamjTNqpxHubW9fxZdR0RCdFg7/OrU+g6
	HjfFQNn1ZfjmquNseQgHkbQ5VNqRQahrwu+V2hRBP6q/WIq//RjiHrPObJjHWjc7Ht+2f4BxOPu
	T+siuLH33MutiNoi3hpjuopcZ9+uqa/oymHqUJ/782mxIckDWtXGOKqkjtqd05YIhwmryGtYM27
	8TJ6xevTDDvxGeEx7vhVNtLWG5WmH51kk80HO1B4FYsUTG2yA7EgSPx7uqgk0Gw3wDDOLtW8Fig
	p9zVNhCBuW/Uh2h9va2M72giRHpyaeTAHPbdnnHinvlxMAgTrnhBpTrR2Afsnp1qQSVmWsT+ioj
	H5OmIGgMxbHbQ+iQzz/Ko2bmA+mBHC0dFDpWhP4ib3+oCRB4ELgQEqhLFThtnWl0QF6Fy1g9G9K
	Lg17XL6MA==
X-Received: by 2002:a05:620a:4010:b0:8cf:e19e:b4ce with SMTP id af79cd13be357-8cfe19eb50emr74563885a.71.1774124806341;
        Sat, 21 Mar 2026 13:26:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9089bebsm467118485a.27.2026.03.21.13.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:26:44 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:26:41 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	david@kernel.org, osalvador@suse.de, dan.j.williams@intel.com,
	ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/8] dax/kmem: atomic whole-device hotplug via sysfs
Message-ID: <ab7_AVLgzLaDRcv5@gourry-fedora-PF4VCD3F>
References: <20260321150404.3288786-1-gourry@gourry.net>
 <20260321104021.4a6074330131a2058e8706bd@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321104021.4a6074330131a2058e8706bd@linux-foundation.org>

On Sat, Mar 21, 2026 at 10:40:21AM -0700, Andrew Morton wrote:
> On Sat, 21 Mar 2026 11:03:56 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > The dax kmem driver currently onlines memory during probe using the
> > system default policy, with no way to control or query the region state
> > at runtime - other than by inspecting the state of individual blocks.
> > 
> > Offlining and removing an entire region requires operating on individual
> > memory blocks, creating race conditions where external entities can
> > interfere between the offline and remove steps.
> > 
> > The problem was discussed specifically in the LPC2025 device memory
> > sessions - https://lpc.events/event/19/contributions/2016/ - where
> > it was discussed how the non-atomic interface for dax hotplug is causing
> > issues in some distributions which have competing userland controllers
> > that interfere with each other.
> > 
> > This series adds a sysfs "hotplug" attribute for atomic whole-device
> > hotplug control, along with the mm and dax plumbing to support it.
> 
> AI review (which hasn't completed at this time) has a lot to say:
> 	https://sashiko.dev/#/patchset/20260321150404.3288786-1-gourry@gourry.net

Looking at the results - i mucked up a UAF during the rebase that i
didn't catch during testing.  Will clean that up.

I also just realized I left an extern in one of the patches that I
thought I had removed.

So I owe a respin on this in more ways than one.

But on the AI review comment for non-trivial stuff
---

Much of the remaining commentary is about either the pre-existing code
race conditions, or design questions in the space of that race
condition.

Specifically: userland can still try to twiddle the memoryN/state bits
while the dax device loops over non-contiguous regions.

I dropped this commit:
https://lore.kernel.org/all/20260114235022.3437787-6-gourry@gourry.net/

From the series, because the feedback here:
https://lore.kernel.org/linux-mm/d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org/

suggested that offline_and_remove_memory() would resolve the race
condition problem - but the patch proposed actually solved two issues:

1) Inconsistent hotplug state issue (user is still using the old
   per-block offlining pattern)

2) The old offline pattern calling BUG() instead of WARN() when trying
   to unbind while things are still online.

But this goes to the issue of:  If the race condition in userland has
been around for many years, is it to be considered a feature we should
not break - or on what time scale should we consider breaking it?

I don't know the answer, David will have to weigh in on that.

~Gregory
