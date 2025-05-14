Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A4189B91;
	Wed, 14 May 2025 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205195; cv=none; b=sC86pboSSW8CyjMMqfN+yGmKsUse489qmvKUCHnBliLECcRkxCPcHo/wJ2rbY7ax+9O2bf8nDARzUkNNeNnJm9iDZOxN/2nqxQ7NrHQwFEPkEESkRv6kIh/Z9l3sSIdjuVd+WQtsi51E0FUMwShpDN/1q0FcCu7HoKE1ykpIk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205195; c=relaxed/simple;
	bh=FzGNWUXaTGFCsKM26TvwH4ODCe27nbD10lyCM1jLg5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHp8kXtmEpyaCdMGN0SsYXww1UVWXh0MNOhNm73xdGvMAQovArDswB/WUiKY5+MC5601Y2KmshZ6HVl9kQILzO5grY4tnXjX4vAZajRvUpm2RxQ/05FhBIkFIS1f6BrXRAF/KRg4jVClsis4ceV/V00Bo/IIBYhcV7L4ygf6duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RW5E0WU9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RW5E0WU9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ov3BrHnMc54FiJziPsXfPfJ1Oc7ryhefOuk35kozoE=; b=RW5E0WU95KQRmEF8BPGEMuYuYT
	iPsC5xWyKEr1Ak3spD7rKwXv/a8wV52mgqwguq60OItVvrj/qgEBwhqKrHuuGrgo6oXhGdKEOHdRh
	lav9E8NjG0qp0UDvh86a/PUfr/UkTpKKnW6ugXFl5mZ84k16jIBrnA18zaAi+BQC+znrFwLcZcTVv
	lXDJZCSZtd+Zt6KAJTumoN8kdXNLYOKM2ypE+5sYNQyPgaGMg2OJogJzetgwfeDSXuMMtxLFewuZu
	Ct+pbtqgILdfgXQ1hSwDWDkoBmbPoB88Ho5m1qPzteHYSft2IIv+G3wzLi6rekac1J3pNfSlCvsk5
	FT0l5Gpw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF5sn-0000000BsCw-0hO7;
	Wed, 14 May 2025 06:46:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8DBA7300717; Wed, 14 May 2025 08:46:24 +0200 (CEST)
Date: Wed, 14 May 2025 08:46:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
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
Message-ID: <20250514064624.GA24938@noisy.programming.kicks-ass.net>
References: <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
 <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net>
 <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
 <20250513070918.GB25763@noisy.programming.kicks-ass.net>
 <20250513085001.GC25891@noisy.programming.kicks-ass.net>
 <CAHk-=wjBiAqaWnXG_44ajMCqU3nNQOC1RQ6SUmKYC03Y1G=r1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBiAqaWnXG_44ajMCqU3nNQOC1RQ6SUmKYC03Y1G=r1g@mail.gmail.com>

On Tue, May 13, 2025 at 12:46:29PM -0700, Linus Torvalds wrote:
> On Tue, 13 May 2025 at 01:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > +#define __GUARD_IS_ERR(_ptr) \
> > +       ({ unsigned long _var = (__force unsigned long)(_ptr); \
> > +          bool _s; \
> > +          asm_inline volatile ("cmp %[val], %[var]" \
> > +                               : "=@ccns" (_s) \
> > +                               : [val] "i" (-MAX_ERRNO), \
> > +                                 [var] "r" (_var)); \
> > +          unlikely(_s); })
> 
> I think that this might be acceptable if it was some actual common operation.
> 
> But for just the conditional guard test, I think it's cute, but I
> don't think it's really worth it.

Its actually every guard, the destructor is shared between unconditional
and conditional locks.

> Right now IS_ERR_OR_NULL() generates pretty disgusting code, with
> clang doing things like this:
> 
>         testq   %rdi, %rdi
>         sete    %al
>         cmpq    $-4095, %rdi                    # imm = 0xF001
>         setae   %cl
>         orb     %al, %cl
>         je      .LBB3_1

Whee, that is creative indeed :-)
