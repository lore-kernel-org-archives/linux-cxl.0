Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC914C041B
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192196; cv=none; b=klXPgOEudoyUQC2VXhHXFVukbmKt5O6NmAFdL/dS2aR64LUYHIeO6688A3wZ4r5DP2ip5TiuDMHHkglmHuBRSfItDsoz0myg12/hhiT+VAthHLVS7BdLgOVYKk+nv+7eXat9JN9r+tvhGMUUt/ijwUKcnfLfjzvKLzIqPtnbWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192196; c=relaxed/simple;
	bh=z1cvbmh8HU38fYrPr4YTydW0K8lfCAeiL8g/BSP15vY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQjO2ZOlaD31EA0aEGW+HQQ5Mhe4Y5BY6zRVlNhg7MmyTf0wHMLMLLzH9CEJmrki4dnl9O0+T4L08cyqrOXSp6HXGJAZTMQaeGuAgkJbjRZ8bSZgUOkg07smly+tMyIF677YkcEaHrASsuFzd924njFTp4pWZkBI3gM9JeQlQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUSi9G8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUSi9G8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366D9C2BCB8;
	Tue, 19 May 2026 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779192196;
	bh=z1cvbmh8HU38fYrPr4YTydW0K8lfCAeiL8g/BSP15vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUSi9G8AoSbnk1xNV6PLhdRCqCd8tYBh7DniHpPbjbXbZR78DWYlTv2aJ8o7f9jZu
	 G3picV+B0qoF1fd9c223V7LKZCs+rpjKPZ3I3zMHmcMe+Ql4MTKpucuou3qqH1ucQI
	 Lw10rWw2zfcvDq6GsE3UrNi4IzUYYXvRHzMlXIheOf8aOjyFc4Y47urj9FI+r7Xy4p
	 oZhWFP3I8PNMtozB8N7WFgbsRz8e7o1AzkYEnn52tPBW/QrfN/2q42Xr14fC1k+P1h
	 lOFuoueL7L1NzBhKRlyr1Q5IecL3i1WlKj4v08T5+c65jLzopkwbetwj2ESnY8wzMa
	 pAa6YNWXb8Myw==
Date: Tue, 19 May 2026 13:03:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, ira.weiny@intel.com,
 dongjoo.seo1@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Message-ID: <20260519130307.4b1d42b3@jic23-huawei>
In-Reply-To: <20260518190026.am3p5acxooq7o75u@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
	<1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
	<20260502193429.hztbijgv3bjwit5k@offworld>
	<9f73073f-09f0-4e08-b1d8-746be33fd674@app.fastmail.com>
	<20260507120938.yyfn6hxjobr64xa7@offworld>
	<20260518172303.0b210abe@jic23-huawei>
	<20260518190026.am3p5acxooq7o75u@offworld>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 17:53:45 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 18 May 2026, Jonathan Cameron wrote:
> 
> >On Thu, 7 May 2026 05:09:38 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> On Sat, 02 May 2026, Dan Williams wrote:
> >>  
> >> >However does userspace really need to pick ranges? Would it be sufficient to start with a "sanitize / zero all unmapped" semantic to walk all not mapped DPA. Or perhaps a "sanitize / zero on unmap" flag to the decoder to make it similar to a storage "trim on delete" semantic. The nice thing about that, you can defer freeing the DPA until it's clean to avoid reallocation races. You actually know what you're zapping because it had some recent prior association.
> >> >
> >> >Otherwise I do not trust the security properties of policy wanting to clean a DPA range but an unsuspecting thread can race to allocate between lock drops. Looks like a footgun.  
> >>
> >> I agree that this is much better than having the user explicitly pass the range.  
> >
> >  
> >>
> >> As we discussed at lsfmm, for this we will need to move to the asynchronous bg handling since we can no longer control the size of the range.  
> >
> >This confuses me a bit.  The kernel can do this in any sized chunk it likes
> >whatever userspace asked for.  So why isn't it controlled?
> >  
> 
> Because we need to hold locks (ie: region/dpa) while doing this
> if not done asynchronously.

I'm missing what form of async you mean.  Do you mean async on
hardware side - i.e. break current constraints on background ops
and allow them to be cancelled?  Or do you mean async wrt to region
locking - i.e. wrt to any changes in the region state / mappings
etc.

> And while you can breakup the work in
> chunks and submit it synchronously, each iteration would need
> to drop the locks and retake them, which is a no no (yes then
> other checks can be added but ultimately defeats the purpose).
> 
> FW transfer, for example, where the work is broken up, only
> requires mbox_mutex, so retaking that is fine and you avoid
> chugging the lock, but this is not applicable for ranged
> media ops.

Hmm. I'm missing how either form of async helps you on this.
We need to track when the operation is in progress whether it's
one op or a set of them as can't allow new mappings to be created.
Given that tracking is possible I don't see a problem dropping
and grabbing locks. We aren't talking that often. Maybe size
each block to 1 second ish.

> 
> Thanks,
> Davidlohr
> 

