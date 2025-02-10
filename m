Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1D33E1
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157597; cv=none; b=Gh3Gs+tjzrV1N1JZ5jCuJ4zhGZ/0+PQWBzCLlfOOP9SQfQIBOQ4rA3Ymc+ljAMtXRdUdcXgX9StehE66P9mfHpGyEBzUXSEkWUDIN3YiR7KnlGWOUXw4edbRIo5qx2yILbI5CsOcVCllR9QaNHkYlKRGwwKGLOw2kyLrbbBTxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157597; c=relaxed/simple;
	bh=uvaZ1fPZAlnTLWF+80/MndXKu3T2GEEHDiGyD5Buzoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRdfwTlLU/yQINPSpyuXDhJ/lYitcOzmWKpC8P0LsvlCb8vClcSxWVJ/JWsd7bxEWHNS9md0EWOqSGY58gUnq+rK4R1yPNUdtmD+z6A4T5tzujseg3sM4pG1z67AgV95zlYsM9J9GpHrIeLCJuri4cukMJJpWJNxgWBqNp6G9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v5T0Xuwp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v5T0Xuwp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=81QMFsBtwsH+yykszxn1E6ZFsqLFAbCVhQDafqF/ILE=; b=v5T0Xuwph3y1r52xw3m6Ze3Ke7
	g5ZSU3IRYNnR8si6bdFsmFotEF77pq5AD4c9tG6FrU7tiAUZOQab9r/7F7MIb8bpQjqKp0WixXStq
	icsNrTGh/p//ZTKotlLxg8nahT676rmjRRG4KgeJrCMzsybl431tlFDo1rDv+m67fLHZ3spibe8Gq
	1yRZtD7qSDst5kNuy1pIgn6ZuWZLKzUsuCS8hNhzWxz0XgYlTCgAKqqP9g24FF4U9j9fQr/OFifLP
	T9s2z4M5rv3i5Mydi1jWyvqeNisnfhKBP/v3qbIwG8wcjChk70jiNrPhZaYK+Ngsoa3WQtUf+kfbt
	+4utVckg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thKKg-0000000EbQO-0UxH;
	Mon, 10 Feb 2025 03:19:38 +0000
Date: Mon, 10 Feb 2025 03:19:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, Honggyu Kim <honggyu.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>, kernel_team@skhynix.com,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6lwSaKmwwFjx5ID@casper.infradead.org>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>

On Mon, Feb 10, 2025 at 11:33:47AM +0900, Harry (Hyeonggon) Yoo wrote:
> Premise: Some ZONE_NORMAL capacity exists on CXL memory
>          due to its large capacity.

I reject your premise.  None of this is inevitable.  Infiniband and ATM
did not beocme dominant networking technologies.  SOP did not dominate
the storage industry.  Itanium did not become the only CPU architcture
that mattered.

Similarly, CXL is a technically flawed protocol.  Lots of money is
being thrown at making it look inevitable, but fundamentally PCIe is
a high-bandwidth protocol, not a low-latency protocol and it can't do
the job.

> > There's a reason most kernel allocations are not swappable.
> 
> Because most kernel allocations cannot be swapped, with a few exceptions.
> 
> However, there's non-LRU page migration functionality where kernel
> allocations can be migrated.
> 
> I don't understand why we shouldn't introduce more kernel movable memory
> if that turns out to be beneficial?

Because it's adding complexity for a stupid use-case.

If you can make the case for making something migratable that's not
currently without using CXL as a justification, then sure, let's do it.
zsmalloc is migratable, and that makes a lot of sense.  But there's
a reason we only have three movable_operations structs defined in the
kernel today.

(also the whole non-LRU page migration needs overhauling to not use
page->lru, but that's a separate matter.  except it's not a separate
matter because that's needed in order to shrink struct page.)
