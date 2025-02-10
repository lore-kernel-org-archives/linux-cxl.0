Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D623645A
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202961; cv=none; b=oYhuJ0qGfkrLjIesOQHEiJp3yKEsiXC0jVrr1wgGlXkV0RrqscWr2pK1XfNRK69JhnAKIMGUNFj42GuYPGq36exvdgVRwkTIa3ugOBIg4jDrUb5UMhk+JnOZMeqGnTK13T5C1ywf/p1JYIM0aIBi8QH/0dqPoO0udzGkz4t/XYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202961; c=relaxed/simple;
	bh=Pdfw4pv8c1abCSWG9UD7/epuSoMzsAHn/jm06rGJEDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6r0XB6tyIXVD0BhftCK+YoS0ZB357Lu5Ia3mzT3JzVVXSCLslnNZZL3hIXI7vJdJ2yg18SKzvs/6g+MhryZwdyXvzVrJA48djjbuXYxXSJpKtglE5SB24wQrhnAp2w2qYPcXMUsBgmulFfC0wzx+T09XMaoT8rsg3zdT74Ii18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h1booOwA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h1booOwA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKs870qSBK/vUQn//FX4xDrIiY2zRCfkPF6ez/cuC38=; b=h1booOwAZAbYJMO1XpPw1C83tO
	NPdTN3FDfa0rM2jNyQsA9ibPEoZFNiT//cc6GMNKcL2lM/lszTb9olxfsn+bZF8JVc5lkh5KTuYw8
	eD9brXxpiqVyeNbNZhonVJmLYB3PUBzKd6y5WwPhZKEZKFiWqD6XIM++BDt/UCpMxPmVWWBICko/B
	yXgVhiasvdN7Sjy5+PfURXF0p9DxHR39OKcFySv32XeiLAKczpYMHVQ3Qi03Z3n8PEe6u+EcQY66G
	RowdTVMSjpWensljhuTf7u30mudX2hD9qmShfMtCFBL2nLw3zdUooga5OAj7Cp45W1enix2autU/7
	S95GJQdA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thW8R-0000000GDt3-3qwI;
	Mon, 10 Feb 2025 15:55:47 +0000
Date: Mon, 10 Feb 2025 15:55:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Byungchul Park <byungchul@sk.com>,
	"Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6ohgwNuLUGsaTi5@casper.infradead.org>
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

On Mon, Feb 10, 2025 at 10:47:58AM -0500, Gregory Price wrote:
> I also think someone should actively ask whether `struct page` can be
> hosted on remote memory without performance loss.  I may look into this.

Given that it contains a refcount and various flags, some of which
are quite hot, I would expect performance to suffer.  It also suffers
contention between different CPUs, so depending on your cache protocol
(can it do cache-to-cche transfers or does it have to be written back
to memory first?) it may perform quite poorly.  But this is something
that can be measured.

Of course, the question must be asked whetheer we care.  Certainly Intel's
Apache Pass and similar Optane RAM products put the memmap on the 3DXP
because there wasn't enough DRAM to put it there.  So the pages are
slower, but they were slower anyway!

What I always wondered was what effect it would have on wear.  But
that's not a consideration for DRAM attached via CXL.
