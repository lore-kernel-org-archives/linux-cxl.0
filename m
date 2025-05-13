Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118211F2C52;
	Tue, 13 May 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166787; cv=none; b=m9SS1nlxWmx4ITd4oWTLB0F6VNxZ5u2m5gQp25Ao7xCHKWfbZBW4crcdPvTGMJsathk8mGxwnckp14gb1EsvtzQqN/CLWmO5O7fV0lSs+iZSnrkKmDUkPygD8mRhVwInBB8jQQ4sI1ZQR4ohtZ1DqoX/L7MzTHo43hWJUCRBC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166787; c=relaxed/simple;
	bh=ng+YX9BApQR488H8KetLwadJIrn2aF/yZKJx3lov6WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaRPNK+NxGJDIiyYswkr0F5on5osdfkj98hMdRmEB99dO1eHBP/adhuYM29r0t/pKcK415QygI8jEbPoqkAIBAKg5dD66/6+n8CGLsUWjzdgKY+eeWmBP13JHkFIla+CK6kx0lP067Q++uhkhme9YwEYqORJPaSHBEKDseiDpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MlhdN7EV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MlhdN7EV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SQZyyAr8jZgyxUvVcCvGAo5J6++1DDRlcOC5mdWNrSA=; b=MlhdN7EVAyDp3YKNoz0ZfleMJy
	GUBvVL2SPmwJm3XcKabsr5uDqsoqnvQ5cnQBYLXVdJ5s64iAB7k0zWKAmhwcVl2hFatgXRwkGZefn
	hpBwEneTqnNXAEPqmF1PAGcI7cjC/ypIlL1Eg/f3Iz4CTcWD3w/ax/bQ/RB1AIsRwZN87DHDcayCe
	TmD6AUoQtDyvfuvU9bLsltgw9zXwHQ/LPCwoCnWhQFQHUxrtQo4FViF4qFNja1R/mjO8/hbJpAZT4
	4CTLpkdPd6d0b6VeQ/5jm2jZ3iIf8ACzCL2cZdRZi8xClOiKkO8cSBhgQ0KURSAQNd7Jbn2iqNR+O
	nLP1+sGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEvtL-00000004FZn-4AY1;
	Tue, 13 May 2025 20:06:20 +0000
Date: Tue, 13 May 2025 21:06:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
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
Message-ID: <20250513200619.GJ2023217@ZenIV>
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
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 13, 2025 at 12:46:29PM -0700, Linus Torvalds wrote:

> Right now IS_ERR_OR_NULL() generates pretty disgusting code, with
> clang doing things like this:
> 
>         testq   %rdi, %rdi
>         sete    %al
>         cmpq    $-4095, %rdi                    # imm = 0xF001
>         setae   %cl
>         orb     %al, %cl
>         je      .LBB3_1
> 
> in order to avoid two jumps, while gcc generates that
> 
>         testq   %rdi, %rdi
>         je      .L189
>         cmpq    $-4096, %rdi
>         ja      .L189
> 
> pattern.

FWIW (unsigned long)v - 1 >= (unsigned long)(-MAX_ERRNO-1) yields
        leaq    -1(%rdi), %rax
	cmpq    $-4097, %rax
	ja      .L4
from gcc and
        leaq    4095(%rdi), %rax
	cmpq    $4095, %rax                     # imm = 0xFFF
	ja      .LBB0_1
from clang...
