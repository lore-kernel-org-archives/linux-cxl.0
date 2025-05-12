Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7E245022;
	Mon, 12 May 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074372; cv=none; b=nqbqYBbLdNXqy2oMt/AGuKjn1SKDxIRbJpwxHHB88GPbjfuYQvPXNS8vgH6j+Q05pCTkTGlU9ukcdNTPuyPhvwRu79jJJHNOV5a2E9q3Oi3W8A7J2Nt9/hkIwXnI0VZLq9WZGiI6s3yS0+qoGs6nj7bEIHYpm3dZQex2+ofIpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074372; c=relaxed/simple;
	bh=6Q2jz1G+bUKQsb4zfDpMbTExI9ep4BLneYtxWvwjmGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWIgoj+LtgXlys+78bwovQQmLhiZ7k9uq1mEv5Z7kD3UwGrsOxnNkKGeVf0fkeIwIYGBpUFrmypi+MaL5bpGlcYjUZZ462ywgkXnJZfO9uPaiRVFMzNy5U1ZQhtcJD4FWUYmfDTywVqU99zi9jEqfF6AdD/ux1dJ61f/rHrN5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ia5WLQRL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ia5WLQRL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EXLzzby17OeuImZpl0bn8vKeJixwwGVwH6DpLX/u2w8=; b=ia5WLQRLlkGcUXx76Ce9kHz5C7
	QBr15oHXn5J/+Z8KXVnNCHhaLafwmPZWLxE/n0KJ2c0LRePodPA7S/Sb/uYU+sAlOlqcmC3JyYJqJ
	tKft6FbTuqZjJLtfu+k/f3h9li1b8JfvlUdne8dg94G7sZlQ3Ad1kf/QnJ5Dot5fitPAv34lln4Ah
	Rkx8T/z9JyCzFewvg3zHC3LbKcMnRbRorRvgAMeRsuT1PbO3jYWJibaM5+e9a03VwLcIi8iVc16xP
	XrUqduRgYDDRVcsNJMkdu3wXk0x5a5HgyVfHB2pJMcJ5eIfN1OshIFvrDeOP6WUGN6ITSNWJiBrGW
	gOdrQMtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEXqh-0000000A8Kq-3urV;
	Mon, 12 May 2025 18:26:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82F05300717; Mon, 12 May 2025 20:25:59 +0200 (CEST)
Date: Mon, 12 May 2025 20:25:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <20250512182559.GB25891@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512105026.GP4439@noisy.programming.kicks-ass.net>

On Mon, May 12, 2025 at 12:50:26PM +0200, Peter Zijlstra wrote:

> +#define __GUARD_ERR(_ptr) \
> +	({ long _rc = (__force unsigned long)(_ptr); \
> +	   if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
> +	   _rc; })
> +

>  #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
> -	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
> +	DEFINE_CLASS(_name, _type, if (!__GUARD_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
>  	DEFINE_CLASS_IS_GUARD(_name)

GCC is 'stupid' and this generates atrocious code. I'll play with it.
