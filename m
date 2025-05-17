Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554519047F;
	Sat, 17 May 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747473475; cv=none; b=s8mt3+07Ti2VzyEoVwGpxHEfSZuS/HtzhoOA7rqnNIOlqF2uNkmBWy9PJ7OV3RJFfJYvKgtgK71vLC30M5Q2ZC75/FjDW/qstadl2I3+aQGork7z913V852BG+ejHX/W5XASQGAB4KhqYKnNQS5RZllilO8C+iKJ4IaVMeWDdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747473475; c=relaxed/simple;
	bh=mlGw4baBHcuGzKKcXIjXAlBHQn5xgue6L+L5AIrLztg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQQKUxsuWYjNnAOABFod80zU+iP6YRTINOtmo5f5TODA7CwT/4aDZqCK+L0RnMAPLz7qsJq5eg5TLfC+9fkkuzICFoRRrHGJ3DZF1LdJMqxUCWaU6etriKkaScafON2hdYu2ycedRtR8y6g1YtppkGNoTlPupoWr7hmISAwADMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVgoUFBt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVgoUFBt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso1843012f8f.0;
        Sat, 17 May 2025 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747473471; x=1748078271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCNZGeVTvUfkhsqTTITz24YrCObP488DGNwghcBg3qw=;
        b=iVgoUFBtX1tEmwPE28oGyY0OrdAv5nBKPBVPIlJ48W08tJmWoaOpNQkUZDcRFIEgGM
         C8+iYZqHq7uTMy/lwhs7jfLCW7m4tAz9wSZSIAG+0vhumCy3H1XKoubkk0IGEqKN7/1a
         7/nJ1hvwGAB12CBPAA/B1AuO8MbhGQQ8rDzSVb6IXJYOcjxJA1adtbI5JiiDRz+iHgTl
         XvbXZ5wVXhGiq5nTZX6FDSdrBWsAJuaQMT2AFtzLERi9Z9XmkmXxXTEcypsEhVvNywd7
         Oyh6r5rG62GMPOh4+J5QXiymEY+eSJ8u3nypW8XYmYoUU+1aPPIRTSRcxgBbteXknufc
         KJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747473471; x=1748078271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCNZGeVTvUfkhsqTTITz24YrCObP488DGNwghcBg3qw=;
        b=UXyEJox2sZNMMt62drplGAwVPZkO5d/OxUq3rEkNuzCdetnPH2MeR8dmfSNKP85HW9
         iDDBIHlx1848Bg7KUl8ZabdxJLZDQXTy3x3rlnK5ty8CnHpnxHjevsC2CeIn5DPM/dOF
         oJbBCLPx7tjDQixssgemxyf7F4+CpxE8zIS2aQfcMKq5X0xkf9+miRBJ2qipsP6xWOWT
         MTx4ednmXKDQwoz86/e/gS+UiOW/1BjEdD2bfPv22UinFVKgRD6da3+YYr0+Qmkp9tZd
         w6Kk7X4/8ZCiVMLHCSRn7T6VvsLMw7C7UpGTtZxccR0qn95piPCf+dBfYUjU2LtYkw8k
         +dRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIZ6p8ZplNoIPBmHDz9YYG/HddU7Cy8U7g5ODhs0O7NW/3hyvsZ7m3hBx2SSgWElZkVvCj+02i5d1nslQ1@vger.kernel.org, AJvYcCXguSYQik2tKZ925p7x2rktW+Q/B0E01GaGL5oPYtI0emsPR3rD86U36nh1Nu3ssFLYgLAIvirdFk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVT3GfIbuyadzXn7dKxtrGY2AmZ8DFBJQU8L212da6SZmFe6B
	PADKwnWifbZYXHnJHoXol4bpbEkjNPQ2WOnHBHWNtYl04hO73l4dZL0m
X-Gm-Gg: ASbGncsob3TXP1RJ+JrQZ8cvy6ASqRlDN8LzOjvXVqkxSGT2gAMX8w2IdPMzVIw9XJn
	vgz5Uu4OHh3BmVYlqiPbuP0k3d7uGJa2NJALGJtjtvl7PILa8nqx8RRajQoNU5MCDYULHt+kucl
	Rq2AWziJHoo/YQvlwnUMkgocivqMHNMNR554kjJLdYs/gVS7P4th5b/tXXIBv/fJZ/OeAzIgDoj
	x4KJRHr6L6I/CZvKIb6+hR7B0NTYiChClbEw8BEyQP6Bh/ofNfnAAISWigmBCxiCEisSdI+2dJ8
	MZGikLyaL9K84r2Wm/DXLStEM2PM8bwXg6DMzbLcHELpRCgc0wdUYIJt6MEdJRUAgeLQ9IEXQ0s
	EIaFukIr1NHvweA==
X-Google-Smtp-Source: AGHT+IHhh+pdhB1FhvxRipbZUThiSYVgULom/LCBN5hMnR/bf+Apv1l5+vUWeTIWH5jBiODpHWvCmw==
X-Received: by 2002:a05:6000:1a8f:b0:3a0:9fe1:c298 with SMTP id ffacd0b85a97d-3a35c821be8mr5839376f8f.18.1747473470570;
        Sat, 17 May 2025 02:17:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm5743204f8f.18.2025.05.17.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 02:17:50 -0700 (PDT)
Date: Sat, 17 May 2025 10:17:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra
 <peterz@infradead.org>, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Ingo Molnar <mingo@kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <20250517101742.4c38830b@pumpkin>
In-Reply-To: <CAHk-=wjxtRUPLhMXvj7Y_RpMVyVEMSiLd8ZeoroQ+_A8M=BQqg@mail.gmail.com>
References: <20250509104028.GL4439@noisy.programming.kicks-ass.net>
	<681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
	<20250512105026.GP4439@noisy.programming.kicks-ass.net>
	<20250512182559.GB25891@noisy.programming.kicks-ass.net>
	<20250512185817.GA1808@noisy.programming.kicks-ass.net>
	<CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
	<20250513070918.GB25763@noisy.programming.kicks-ass.net>
	<20250513085001.GC25891@noisy.programming.kicks-ass.net>
	<CAHk-=wjBiAqaWnXG_44ajMCqU3nNQOC1RQ6SUmKYC03Y1G=r1g@mail.gmail.com>
	<20250513200619.GJ2023217@ZenIV>
	<20250513203114.GK2023217@ZenIV>
	<CAHk-=wjxtRUPLhMXvj7Y_RpMVyVEMSiLd8ZeoroQ+_A8M=BQqg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 14:28:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 13 May 2025 at 13:31, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Nevermind - should've read back through the thread for context.  
> 
> Well, your comment did make me test what I can make gcc generate..
> 
> I still can't get gcc to do
> 
>        cmpq $-4095,%rdi
>         jns     .L189
> 
> for IS_ERR_OR_NULL() however hard I try.
> 
> The best I *can* get both gcc and clang to at least do
> 
>         movq    %rdi, %rcx
>         addq    $4095, %rcx
>         jns     .L189
> 
> which I suspect it much better than the "lea+cmpq", because a pure
> register move is handled by the renaming and has no cost aside from
> the front end (ie decoding).
> 
> So
> 
>   #define IS_ERR_OR_NULL(ptr) (MAX_ERRNO + (long)(ptr) >= 0)
> 
> does seem to be potentially something we could use, and maybe we could
> push the compiler people to realize that their current code generation
> is bad.
> 
> Of course, it doesn't actually *really* work for IS_ERR_OR_NULL(),
> because it gets the wrong results for user pointers, and while the
> *common* case for the kernel is to test various kernel pointers, the
> user pointer case does happen (ie mmap() and friends).
> 
> IOW, it's not actually correct in that form, I just wanted to see what
> we could do for some limited form of this common pattern.
> 
> Anyway, I am surprised that neither gcc nor clang seem to have
> realized that you can turn an "add" that just checks the condition
> codes for sign or equality into a "cmp" of the negative value.
> 
> It seems such a trivial and obvious thing to do. But maybe I'm
> confused and am missing something.

Doing the signed compare (long)(ptr) >= -MAX_ERRNO generates cmp + jl
(sign != overflow) which is a better test.

To let user pointers through it might be possible to generate:
	leaq	-1(%reg), %reg
	cmpq	$-4097, %reg
	leaq	1(%reg), %reg
	ja	label
which trades a register for an instruction.
It wouldn't be too bad if the second 'leaq' is moved to the branch
target - especially for any cpu that don't have inc/dec that doesn't
affect the flags.

	David


