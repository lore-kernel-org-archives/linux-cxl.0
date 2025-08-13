Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63586212561;
	Wed, 13 Aug 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098511; cv=none; b=eYN6qiz7iuF9r987SFW4H7kJJkk7nUdVuMeyXwDFrKF5keAtXVIhGlGV69MeK4U0kwONOVgYSyBJViPOyW8cfm1gKqVbU9op9H2w2X85TrnkT4/mmP/5tXuUp4diOk7x6nt5OMVtpORnMj+MBDMdYVf5dJOQqWkhSNvfLopeiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098511; c=relaxed/simple;
	bh=8LFrW3guuwb2IcNJ2od7+Q/ZDwWj+qQtQTeJhnHJbPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGo1cBS9xuWsGKY+6Y5SwmK6/MyTjRiJYhzVrVkRtRVkLfk92ebymlEpT1x0I/lNk7AcorqvLL6t/F+Tuvq8hOiLGW7BST+TkNDcDgV0GvO/ZmXkOU+5Cakp8KNaqmHl5LjL2RSDnBECWyfaMb3rMJHIEUWge9liHmz/x9h88c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ep9sWrKE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ep9sWrKE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZOEO7stEQhTzUvpam5wL1tINe++TmhY1cYaUmWqJbJI=; b=ep9sWrKEaBcboMvP8t6KrBMbiG
	Rvq1a4SFNX9ql54appDo6JJkGIDn9UzuedYYeMW5Ghjm+LF7ikI8hE5m7rp6PdwApVN/fCEdMBIyi
	DmEpj7j1vuvlkIIC/2rUK32sH21Bx0bXik+Kzf6dmVoErfFWKj/hG+PZPY4v33Mq9PG1PH07z1xXa
	AN5mQll187H41RLYoxd5Abs+vizYon73+bWM94VovPUUZmWQtybf05enSkyqJHyJh97HQ8N4ADYjN
	MhyPZrI7+jKAPV5jH0fQ9Rp1X7NVEjLXRXJ5VHObufD/N1s1Eqv5/akfMNzOF3lyJw1irvkG/GLf3
	OnqN7how==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDIO-0000000G7RG-1DQw;
	Wed, 13 Aug 2025 15:21:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28C303001D6; Wed, 13 Aug 2025 17:21:43 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:21:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Message-ID: <20250813152142.GP4067720@noisy.programming.kicks-ass.net>
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
 <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>

On Wed, Aug 13, 2025 at 08:14:59AM -0700, Linus Torvalds wrote:
> On Wed, 13 Aug 2025 at 07:13, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> > >
> > > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > > find unused static inline functions for W=1 build").
> >
> > I so loathe that warning :/
> 
> So I entirely ignore W=1 issues, because I think so many of the extra
> warnings are bogus.
> 
> But if this one in particular is causing more problems than most -
> some teams do seem to use W=1 as part of their test builds - it's fine
> to send me a patch that just moves bad warnings to W=2.
> 
> And if anybody uses W=2 for their test builds, that's THEIR problem..

Right, so I've had patches that added extra #ifdef gunk because of this,
and we've sprinked __maybe_unused in a few places just to shut this up.

I think something like the below will do... totally untested and all
that.

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 16755431fc11..12b8b5d81459 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -253,7 +253,7 @@ struct ftrace_likely_data {
  * for W=1 build. This will allow clang to find unused functions. Remove the
  * __inline_maybe_unused entirely after fixing most of -Wunused-function warnings.
  */
-#ifdef KBUILD_EXTRA_WARN1
+#ifdef KBUILD_EXTRA_WARN2
 #define __inline_maybe_unused
 #else
 #define __inline_maybe_unused __maybe_unused
