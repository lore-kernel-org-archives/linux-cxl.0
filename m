Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A81F5F6
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738418665; cv=none; b=Wloj/gY0Zoz8sJb/uE2G9Ga4SBjlqLhLO3TKidbYOBCJqa2H+GZ4649egOzivzQu0vtkzbB/Enbn11EtPs2AsYV/FxPDZ8eg95TCLIUZ7J6yfTPSKC0HeuwqLsTdqXQ8hMUkH0pfOFq8FUkOWRA+tQ9W55swuG7bLwouB8Gu5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738418665; c=relaxed/simple;
	bh=ImF5bNWRDx+GmA1NSeCPZ113ytFRv3UOoDTpwe2uLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBEYZvHDOMTvL9gkAN7IjF1ERZCGlsLp2Qg8ValdQ6hX7KINhriktBwWUvgaH240TdbzynpebMkBvUVgni2SlD/rxWXKAn+4oa05E2JTrXa9B5l4EwCnmlUPFpCr/fSQmzCNwmj1Fw8I6EpVZtrDllBbJkRBftDcs+M5bUwH360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eGIUcCma; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eGIUcCma"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJ1G7pUr3By7yXgMdoF7Bkl84Q86WzINHDB+IDr7o2E=; b=eGIUcCmaIpAMR9ArfLy53FnTuB
	D8tqnMnjZnszG8OOcjlmEIvb7chkPQQppUAdN8Z21YY79MlQ1cZZ/zSuZlRneOuWKuttdXl5I4lj0
	qmnmMYJaFMlfP5e7F3AL3fjVutqEhhJvGS80DIXHPVdSVJd00vMycIO9Gh+bMTAyRPxho99pbVwdm
	SH1OKTO52ivjxd7KY9imPDRFReC0lmZhRCeIK78Jn3vsPBAdIicV1rds29A6W4ASUzIo38bs8rBhY
	MEb6glAvzQeTQviJaROg917g2O4vd/51c81QLizKc74umqwQLEMD3ypGlDb1eJkCBM00lGGcAgPY7
	TyHQ0OtA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1teE6b-0000000G6LV-3WyH;
	Sat, 01 Feb 2025 14:04:18 +0000
Date: Sat, 1 Feb 2025 14:04:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Byungchul Park <byungchul@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z54p4QOnAlTYm6DG@casper.infradead.org>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z54hUTXRsw0LYQ8b@localhost.localdomain>

On Sat, Feb 01, 2025 at 10:29:23PM +0900, Hyeonggon Yoo wrote:
> The Linux kernel supports hot-plugging CXL memory via dax/kmem functionality.
> The hot-plugged memory allows either unmovable kernel allocations
> (ZONE_NORMAL), or restricts them to movable allocations (ZONE_MOVABLE)
> depending on the hot-plug policy.

This all seems like a grand waste of time.  Don't do that.  Don't allow
kernel allocations from CXL at all.  Don't build systems that have
vast quantities of CXL memory (or if you do, expose it as really fast
swap, not as memory).

All of the CXL topics I see this year are "It really hurts performance
when ..." and my reaction is "Yes, I told you it would hurt and you did
it anyway".  Just stop doing it.  CXL is this decade's Infiniband / ATM
/ (name your favourite misguided dead technology here).  You can't stop
other people from doing foolish things, but you don't have to join in.
And we don't have to take stupid patches.

