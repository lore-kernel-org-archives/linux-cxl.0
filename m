Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1833A9F8
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465823; cv=none; b=dGvf4iGPz0EXxO/V/Rulio2Jpzs2SZSbRd0lPTQwwMFE2/CsCSmofESEI5d6neGoqq/QM8/JzKArTOsc0LGDqICqknN0h6PZoRu0Gsw6qABT6qHyOaTq6pG0lnHfac9eQJbgXFTniUyubZvzka6bxr9GOM6gHRG5gXhWBR/qo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465823; c=relaxed/simple;
	bh=yuBh8Ro8tvjLy1L4hvyFN3vMCfyqtskBpuYFLofd/VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcbbKinZ0yI83vTq2nGyC5sxcn83P97y2hHibpNZkOIFs0hBG5lVFYQfjuqY9jSPlHuQuj7wshCL+WUoynXWtdq9gffgiYtplzZ0gZJjgq9GuQRW53CN6j53IM1e+Q/rBPbQk8VB+Rjj6k4LC/sz7Z6MSWTy9Es1FCjkVB5NP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Faf4SKtr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Faf4SKtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EC2C19424
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465822;
	bh=yuBh8Ro8tvjLy1L4hvyFN3vMCfyqtskBpuYFLofd/VE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Faf4SKtry0MHYQLXb/cYVjcByQ5K7hokp8xFFBshG/AjD2NnZW5X9hWsv1m66tDNW
	 VVUwCe6AIZ0BCbsgybP3trX7bDds4lFFkgH5HbW3bj2MD4CobwhWXR9oM71fO+cixh
	 uaQOGCDcFUYd4Bp8AczIEFkW9exz8YHAGhxMjVNs0YmFgzZ2NJRUcxzxLpWoMwAHd4
	 Xb1eceBxho/Q9Y6e/x6mUCLojC9BhlR3+mul2njpqaS2Oh5LPhE2DJsN1vXvFYukpr
	 oQD6T4eZqeGIlaR2mCpBs3oio0oLY4S+kAvAf7fSGa/stbbMK3g+W+vhTRKG31/fZq
	 r+fq1Cv3+/2Nw==
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so688762a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 00:30:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8SI5ncMKWYt1w1bMMz4popr5L92vWv0e/Gy0o+rvhf4KbEXxFUHj4MJtPSqxwYqFq85yOx287UZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6+5oobfagr21p9D9sCpt3lKdQqzvrCw/Q0ihqPcwcjZcZK6v
	C/tavzRk6wI2HYapRZR/7tt7GBuRvfcqTBUDSmd5YRLdTg3EUsMmj0FVFhIJDiQGYb1gWzGNuOx
	hVxa4W4utZlBvNMxRZMUF5JJOjujtTlM=
X-Received: by 2002:a17:90b:1b08:b0:32e:8ff9:d124 with SMTP id
 98e67ed59e1d1-3526788e074mr2160235a91.15.1768465822006; Thu, 15 Jan 2026
 00:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110114705.681676-1-rrichter@amd.com> <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain> <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com> <20260115080444.GD830755@noisy.programming.kicks-ass.net>
In-Reply-To: <20260115080444.GD830755@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Jan 2026 09:30:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
X-Gm-Features: AZwV_Qin7nQ06adxmNME2NfXhXjExfmuxZiydWrCccnZYzRg_Gr24NBpLGMXqME
Message-ID: <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Robert Richter <rrichter@amd.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 09:04, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 14, 2026 at 06:08:59PM +0000, Jonathan Cameron wrote:
>
> > Do we have a potential issue wrt to merging this as it stands and improving
> > on it later?  i.e. Is this a blocking issue for this patch set?
>
> Well, why do you *have* to use PRMT at all? And this is a serious
> question; PRMT is basically injecting unaudited magic code into the
> kernel, and that is a security risk.
>
> Worse, in order to run this shit, we have to lower or disable various
> security measures.
>

Only if we decide to keep running it privileged, which the PRM spec no
longer requires (as you have confirmed yourself when we last discussed
this, right?)

> If I had my way, we would WARN and TAINT the kernel whenever such
> garbage got used.

These are things that used to live in SMM, requiring all CPUs to
disappear into SMM mode in a way that was completely opaque to the OS.

PRM runs under the control of the OS, does not require privileges and
only needs MMIO access to the regions it describes in its manifest
(which the OS can inspect, if desired). So if there are security
concerns with PRM today, it is because we were lazy and did not
implement PRM securely from the beginning.

In my defense, I wasn't aware of the unprivileged requirement until
you spotted it recently: it was something I had asked for when the PRM
spec was put up for "review" by the Intel and MS authors, and they
told me they couldn't possibly make any changes at that point, because
it had already gone into production. But as it turns out, the change
was made after all.

I am a total noob when it comes to how x86 does its ring0/ring3
switching, but with some help, I should be able to prototype something
to call into the PRM service unprivileged, running under the efi_mm.

Would that allay your concerns?
