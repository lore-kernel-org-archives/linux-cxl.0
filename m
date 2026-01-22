Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C274392808;
	Thu, 22 Jan 2026 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117289; cv=none; b=M49jS+IqlnnizKHB4Yo2KrGovdbUuprdLB88imFv/0ZX5SUCvx/O0v0tnWGGLA/PGn4FsZon9Yub8zK6TBpXHg/oGJMDQX66Aw9B91wDB2RkgGKRLh7IcpmO85JoPFlcyv39A6zbcz5JU6XcrcRog+sLAwH3vYdMTfNDfT6w1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117289; c=relaxed/simple;
	bh=knqv3YaYhXLjzVaLE6iKL0LxzIm/k75UNIsgiKoIlIU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QWmAb47HN/1LHQgvLKydxiTG+iuNdhWhRd/Vxxp7lqU6BA5vFY5KPxIX1m9Xy1HEBunuwKcdSDoQ7DsghdN1A/DYZm7WUEa69Mj3mjfzPsWh51DCuqOZEdlcRncERfhMnQVyYvQV5L44A2wjQC8Vj3xg3OprC8VofOKfNClSv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=13YXjGm8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="13YXjGm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36606C116C6;
	Thu, 22 Jan 2026 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769117288;
	bh=knqv3YaYhXLjzVaLE6iKL0LxzIm/k75UNIsgiKoIlIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=13YXjGm8umxmJamt0Zl1nKi6FNc3yziP/vjSEGG91+vsNi4OogHLRxY7Os18riT6j
	 xSB1wtQTgLsp2E+D4CjtXNYBRWoJb6FbDoLA75BqLwuEZ73BxJni5ECzExUPT4C57K
	 NjFDS57rLQ2ZgcD+FsaZEXwed9MX9I3E9DrRSicA=
Date: Thu, 22 Jan 2026 13:28:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: dan.j.williams@intel.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mike Rapoport <rppt@kernel.org>, Wang
 Yinfeng <wangyinfeng@phytium.com.cn>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-Id: <20260122132807.7204b83e97e33290f6eb7d82@linux-foundation.org>
In-Reply-To: <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
	<20260106031042.1606729-2-cuichao1753@phytium.com.cn>
	<20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
	<9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
	<20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
	<696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
	<2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 16:03:49 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:

> 
> >> So please, tell us how much our users are hurting from this and please
> >> make a recommendation on the backporting decision.
> >>
> > To add on here, Cui, please describe which shipping hardware platforms
> > in the wild create physical address maps like this. For example, if this
> > is something that only occurs in QEMU configurations or similar, then
> > the urgency is low and it is debatable if Linux should even worry about
> > fixing it.
> >
> > I know that x86 platforms typically do not do this. It is also
> > within the realm of possibility for platform firmware to fix. So in
> > addition to platform impact please also clarify why folks can not just
> > ask for a firmware update to get this fixed without updating their
> > kernel.
> 
> Andrew, Dan, thank you for your review.
> 
> 1.Issue Impact and Backport Recommendation:
>
> ...
>
> Thus, I believe a kernel fix is necessary.

Thanks, I posted all that into the changelog.

> Therefore, I recommend backporting this patch to all stable kernel 
> series that support dynamic CXL region creation.

It's helpful if we can tell -stable maintainers which kernel versions
"support dynamic CXL region creation".  We communicate that by
providing a Fixes: tag in the changelog.  Are you able to help identify
a suitable commit for this?

