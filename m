Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813B364EB1
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121391; cv=none; b=MExc8OVdwJI5e5O4XehuucLsHI2HYOv7B5O8wwM6lseCpcXzBL+vk5cg21cAiqQghN1YpLft8KdgD1yIW3a8WhDSRHRwNaqPDfucicbQykPvVkBcgMKq/ee+BvyZeYbrXMA0ZnmzExoBDlpGN+h2+PCzp8EbOjLj6+VPupai38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121391; c=relaxed/simple;
	bh=l7121VK/4kT1N63Xs7n7AbTcL5QFd4jlrBDoXyhUX/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXxQIgKR+zd1SM/d0pT7oG8w0zDDgkv+m6D4Yehrq1344po1unZvUyiohtL9Bonr3RLYHeibNciInGEeglfU/XihQmQYQoPxuBoxAmfKyZbr+K46IHLyzoGMOw/9jRgcARREMEgKGldYucIsLHsw2TEhUV8QAzUPCAJxkndWqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC/zAF7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC/zAF7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB5EC2BCB7;
	Mon, 18 May 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121390;
	bh=l7121VK/4kT1N63Xs7n7AbTcL5QFd4jlrBDoXyhUX/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KC/zAF7Bx5vfyo02+214zJw/3+igVncG57huJqq/g90Bg75ynPOIVf3OZRXKB8Yl1
	 c/McKt/JCSZvNCkSGR48dpWnP8yomdw0uQU7/2Gb7xfwQ8HvCGNqk/xhGZe6yjlQxp
	 F4Gyp9vyy5ZcK2TX61TQYxj27GDUpbZkx44zDxtLJSCpA/zZGKIHBdD+oVlMKOBdCF
	 LfOHG6qBasBdaur50MKIUDoVrkbdhvxrTdXaCU/vjTgTrUxYtXxBsIR+1hiI5sbCXP
	 9tPR0LuB1TzjhQtkzhNRb/lpmXEOBqHC/wdKVzrJZ9febrPIpAlgKjbuIbPiXT3LtB
	 vv8BpPP8857Ug==
Date: Mon, 18 May 2026 17:23:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, ira.weiny@intel.com,
 dongjoo.seo1@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Message-ID: <20260518172303.0b210abe@jic23-huawei>
In-Reply-To: <20260507120938.yyfn6hxjobr64xa7@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
	<1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
	<20260502193429.hztbijgv3bjwit5k@offworld>
	<9f73073f-09f0-4e08-b1d8-746be33fd674@app.fastmail.com>
	<20260507120938.yyfn6hxjobr64xa7@offworld>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 05:09:38 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Sat, 02 May 2026, Dan Williams wrote:
> 
> >However does userspace really need to pick ranges? Would it be sufficient to start with a "sanitize / zero all unmapped" semantic to walk all not mapped DPA. Or perhaps a "sanitize / zero on unmap" flag to the decoder to make it similar to a storage "trim on delete" semantic. The nice thing about that, you can defer freeing the DPA until it's clean to avoid reallocation races. You actually know what you're zapping because it had some recent prior association.
> >
> >Otherwise I do not trust the security properties of policy wanting to clean a DPA range but an unsuspecting thread can race to allocate between lock drops. Looks like a footgun.  
> 
> I agree that this is much better than having the user explicitly pass the range.


> 
> As we discussed at lsfmm, for this we will need to move to the asynchronous bg handling since we can no longer control the size of the range.

This confuses me a bit.  The kernel can do this in any sized chunk it likes
whatever userspace asked for.  So why isn't it controlled?

> 
> >
> >What use case is missed with a per decoder automatic cleaning on unmap setting? Zero before map policy might be nice too...  

Agreed.  Do we need userspace control at all?  I'd definitely thinking of this as offload
of stuff we'd otherwise do on the CPU.

Going to be fun if we have a decoder tear down / reeenable (or DCD remove / add in same DPA)
The memory that comes back might not be the same memory (or someone got it inbetween) -
so even if we thought itwas zeroed, to be sure we'd have to do it again.
Now the hardware might keep track and noop the second one.

If it's just OS unmap / map then that problem doesn't exist.

Jonathan


> 
> Agreed.
> 
> Thanks,
> Davidlohr

