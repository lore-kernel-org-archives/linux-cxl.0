Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AA1EFF80;
	Tue, 13 May 2025 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120178; cv=none; b=ivLnz0mNznFeEKs9vabkbzpAejiIy+rO4xXhIOJUT8Evo9kwUkAc3xQ93LzB6w69sjkt4rve/BQZaVRbVwWeDyMQ2O0D0Gn6QCuBz9q8A9XAGALciOpDtciQBetnerjKKB/AUdkSv7XzjD9rII4nK+jGo+tS88BtSIjyoo+KBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120178; c=relaxed/simple;
	bh=BnLUvLhL2FvhqqoA6EoGOn9aCbdj9hV/DYOi3xUwBGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9IUv+NSSA3k2UA9l5QaKbDsXC0IS75Wdbk6UngOLbngYtXo0WTM0GPfG6fRMgtyF/M29UXQZvW3KDyTju0ws7NQDd4vCw9JyAAv37GGzvYLbLx665cHfSlsiITZ4nEQTsyqOYE56MxAdJ3nfOT6SosEwkumLg9oDs8HrUJwzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RTsOUb9g; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTsOUb9g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wYBg36SmVUgDeEoMpeszFvbRSHm137CPtQZZ7RUh710=; b=RTsOUb9g6LhcXhntIWMwMkACvH
	tvlfxTGnHbrW6+gk3tEZtcl2RG0HuAnIdoVRxYyKwGb/AlCNosGlLKz5ApbZ7mR/rMX5+ZoYKHASW
	LtxemB0jBC32hPjOz1hsVkvU1+Ztwd9ziYfES/w05HIrOrXAUy9mFKLDIM5HxPh/eEbE+BnVM+h3Z
	ibbvZ9d4wm0nRlC2L8gkTcLGUDtR2oqV0LcBrvTovTBQ2q1s6jHJzHVpzPkaJx58GaxO6m+08bj7T
	zBKUSFypJxTFsCjKZJIbRw83+cFgAYnGiUen7PNhCo1e2KIkVvkVys0uYBU7Ho7MiGx6fDjygfh0t
	r1vl7Tmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEjlP-0000000GtLS-1ilu;
	Tue, 13 May 2025 07:09:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C704630066A; Tue, 13 May 2025 09:09:18 +0200 (CEST)
Date: Tue, 13 May 2025 09:09:18 +0200
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
Message-ID: <20250513070918.GB25763@noisy.programming.kicks-ass.net>
References: <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
 <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net>
 <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>

On Mon, May 12, 2025 at 01:39:19PM -0700, Linus Torvalds wrote:
> On Mon, 12 May 2025 at 11:58, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > GCC is 'stupid' and this generates atrocious code. I'll play with it.
> >
> > PRE:
> >     bf9e:       48 85 db                test   %rbx,%rbx
> >     bfa1:       74 1a                   je     bfbd <foo+0x5d>
> >     bfa3:       48 81 fb 00 f0 ff ff    cmp    $0xfffffffffffff000,%rbx
> >     bfaa:       77 11                   ja     bfbd <foo+0x5d>
> >
> > POST:
> >     bf9e:       48 8d 43 ff             lea    -0x1(%rbx),%rax
> >     bfa2:       48 3d ff ef ff ff       cmp    $0xffffffffffffefff,%rax
> >     bfa8:       77 11                   ja     bfbb <foo+0x5b>
> 
> I'm not convinced that's actually an improvement.
> 
> Yes, it's one less instruction, and three bytes shorter. But it uses
> an extra register, so now it might make surrounding code much worse by
> making register allocation have a harder time.

I was going for the one less branch, but yeah, register pressure :/
Typically this is at the end of a scope, and I was hoping this is where
you have free regs etc.

> If you *really* care about this, I think you should realize that the
> non-error case is a valid kernel pointer.
> 
> And we could add some architecture-specific function to check for "is
> this a valid non-NULL and non-error pointer" with a fallback to the
> generic case.
> 
> Because then on a platform like x86, where kernel pointers are always
> negative, but not *as* negative as the error pointers, you can check
> for that with a single compare.
> 
> The logic is "add MAX_ERRNO, and if it's still negative, it wasn't
> NULL and it wasn't ERR_PTR".
> 
> And while 'add' needs a destination register, 'sub' with the negated
> value does not, and is called 'cmp'.
> 
> So I think you can do that with
> 
>         cmp $-MAX_ERRNO,...
>         js ...
> 
> Sadly, I can't seem to get gcc to generate that code. But I didn't try
> very hard.

And so try I must :-)
