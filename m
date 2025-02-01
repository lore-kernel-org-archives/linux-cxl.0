Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998441C5D73
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435742; cv=none; b=pIW3AUrNX5BnWD/oBmQPLbNTSJxq05HlOxD2XbdUs4D6S8IdoRT+AMT3JS3LtQ9KCmHKbVLSRxlY1tgitZJsd9hdClBXnarMTNwoRn3112NPcxCH8HUBXvsk4Qqoe2uahWNWzMrLff3zSumaqMDaS4gbqsK1YOT506veS3dEuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435742; c=relaxed/simple;
	bh=GeUqeuSbwFkZpgEIwhiOcngn9Ct5YoN7GFhdRTR/NIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbA0rwad6hEI8Ns6BZPiINtNjshsBrGxenRLMlSPngPMtWW0TjRx+YXxITIyMJka2uibc5+fsH0hwJIVjdYiyLfsX3prUHiSQpYnEKPQKzSEspuNtvGywscgm5VhQZaqhNvhA3Ej04RrzoIQcrYnObKexIiDCala706IXgVW8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NV8NqObD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NV8NqObD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6XTLJP6/F61nHWkP7dtkXo/rOgVgMoJSZWYn2PrE3iY=; b=NV8NqObD3rMMqD259EEy6xsTdP
	nPjtliyQs3bhOPmfOZ0j9WLbgx7My/M5aXd2ZEf8FAgHKHr8l+xsTOYTB+1lRAvtpu1Ljr1UhgxEV
	cJ9J/yr5TuVP0mAUZxv9z2+2kb9N5H+WbdGHRk4bLVBwi6qR24tsaklKBc27LeTCZhDdI582JlLlF
	EqnydB0WExKg/QB57ID7789eN/9htzorTf8HgMNtOX5+bHIvVG6pajZUVpOuDWhvMhzZhQ8LH/GyD
	6Ov+a/xFYCw2pNE5Zw7Y7EYT6Q0saUqvPYTaoulVsG7V7LKXLs4bnCrMS+tit2i8y/sVmzhcIpFQe
	cqKXwn/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1teIY3-0000000GKYd-3JDg;
	Sat, 01 Feb 2025 18:48:55 +0000
Date: Sat, 1 Feb 2025 18:48:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	Byungchul Park <byungchul@sk.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z55sl9HRYX3xcP-b@casper.infradead.org>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <CAB=+i9T15XXbbZsvz2sg7JQNOVjaHzpj0LtCW9QtOQfwqq8W_g@mail.gmail.com>
 <Z55MILLApIoPh0A1@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z55MILLApIoPh0A1@gourry-fedora-PF4VCD3F>

On Sat, Feb 01, 2025 at 11:30:24AM -0500, Gregory Price wrote:
> Rather than ask whether we can make portions of the kernel more ammenable
> to movable allocations, I think it's more beneficial to focus on whether
> we can reduce the ZONE_NORMAL cost of ZONE_MOVABLE capacity. That seems
> (to me) like the actual crux of this particular issue.

We can!  This is actually the topic of the talk I'm giving at FOSDEM in
about 15 hours time.

https://fosdem.org/2025/schedule/event/fosdem-2025-4860-shrinking-memmap/

I'm just going to run through my slides and upload them in an hour or so.

My motivation isn't CXL related, but it's the sign of a good project
that it solves some unrelated problems.  Short version: we can halve the
cost this year, halve it again in 2026 with a fairly managable amount
of work, and maybe halve it a third time (for a total reduction of 7/8)
with a lot more work in 2027.

Further reductions beyond that are possible, but will need a lot more
work.  Some of that work we want to do anyway, regardless of whether
the reduction in overhead from 16MB/GB to 2MB/GB is sufficient.

... or we'll discover the performance effect is negative and shelve the
reduction in memmap size, having only accomplished a massive cleanup of
kernel data structures.  Which would be sad.
