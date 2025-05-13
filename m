Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D1C68F
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165614; cv=none; b=nVYPrEMTwi2Z6Ta/1Mtt5znji3GDOL379S1R2nc1SiBbieX200094/UDany82x2i7q9hUERrwSunKS/ZhCHmJanOxYDORojRPg0eTW5/IUD5Jz1YJdthQQiv43uHR+HT8OQfEYReYHaK8+12RMRYvwWJ0sxV41mZki2EXdYbOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165614; c=relaxed/simple;
	bh=6To62uGcZQK9appizY45ArRLRBgOVTSRVl6vAQqFx8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJWrZc9yMWqbw+XjYu3JovU6dmJzl4xuKY1RK8Iu7+G/jDqXQqJ3fGX5KjUnjnK3EJhNEx6lA7qKm/lAhtj8fpZl/xy77wc1X9d52iiahFRIXbUj4vc4qLAoob+nE6O1w1XIk7v0xwMwpmD6X5KUlafbO+ePKtuBdMgJaE5vXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bDoPJuyw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bDoPJuyw"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5feb22e7d84so3293715a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747165609; x=1747770409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=osowZHiCh4FTRJAovq7d86Sc/0+MJzT7LiUAm+X/OlY=;
        b=bDoPJuywRazxvFdg509DWN7ZVJ4QY1n5rlJNuuHiEH3nFl/B7e9cX5A6csHxyI4krB
         hFEuRVQW4/2lCQOHV6viJyOs41mrSU9vRT2NAIqYFEZ2oSKAXk31xuzJVBtYSPeltyCJ
         aTQ7P/PnZKGIsZ1pbBHVvedS3GK/K8yHQPiNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165609; x=1747770409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osowZHiCh4FTRJAovq7d86Sc/0+MJzT7LiUAm+X/OlY=;
        b=LwXlYu3voZY35K4J+DLc+fINux9qULQRPhuWbuLd9sVLU6CFmTqZyfAbNZjxDkusrb
         IXLfBUJr8ChYTWLTkybGLIcy6dUir3tm5v8SKcFqhdDHvDVZMW1JAYZVVq6NBFOtnE6f
         Ysf7WsjSG9lT1qRq2gLRJ3yjFa7w6GnKzPglLSayHe5fMoB8RuHkVf1darqDj6+mtqXa
         PhKiXuumv+ffMtcv1tjo6rQIqC05Hwje95fKeIP/g5gstjA52Jnfq9JjYci/slvH5rOJ
         jSGUaF/TE3w/ikK9EIeAcz2StTUnnYxP5hvlzsY18WjRuOq/vYmovOV5WwNFoor2jqVX
         guKA==
X-Forwarded-Encrypted: i=1; AJvYcCVzC/g4Wc4Pzykccjg/8Io4D3jIjV/rke6EcDFL37BaL03QMREWJElDkceILDddi3g5QdRFpWXAsp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguDhD6TJbvvtisXUUDCsXFzfoRAsVed8CN5ne81H7/+Ml00Fh
	5PDB+4WXvRrz5xSltRBvSfpRp8DBWXeGPCmqQlxcUghE8k/BStoAH/6hV4PvJlN/r6fCxv8GziI
	iiAE=
X-Gm-Gg: ASbGncvDQ2alSzPC5stCywQXkO1DImIHwaO6kcvvpkxxqG0TkbHX2xai0FbbikqghJd
	22zB9+gt51aQAQlxwWT+f9Wv3uOVQdrBCS0GiK+3zckK3LX6cPc2Kry8LsIoPqw5xrOdzg1AWCl
	zje2Nn3BKWoi9Ug8AufHsftOxBPHmGPwQmxkd0L8fpBta+PcenTvqz9xWl9aZHg34qS1bptgqs0
	F35E/vURog74zak4xHR4raKi5k4SNZ8cS4S78UGRgR2ljvV5/rD56eoZkRbYUWWszPumSTTC7VE
	G6qSU0cmwVDm2zZ8dg+lLtq71UgDhuCop/zp14iPm9DQNAjEmJM83DlXttUkujkLPOlAQ2sOYJj
	9PvXiSvyP5BW6dvEDK9gL5uNGsQ==
X-Google-Smtp-Source: AGHT+IFyKGH9PTboe7wSzvBA5tbSw2BmhQWnyVtOoydV1WiGin3rENM78h2I/mq6MuXBR0THrrxBbw==
X-Received: by 2002:a17:907:86ac:b0:ad2:39a9:f1aa with SMTP id a640c23a62f3a-ad4f7550e7fmr81506966b.47.1747165608766;
        Tue, 13 May 2025 12:46:48 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22f16271esm681049166b.103.2025.05.13.12.46.47
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 12:46:47 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso12243967a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 12:46:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUfRKavCYa7t7UfzGPntIfm7Ij8Cg/TDzjXZEBZGhPwV5AfMXBze6nGfH4YcK/663jxSPsUr8yPZo=@vger.kernel.org
X-Received: by 2002:a05:6402:51d0:b0:5e5:bdfe:6bfb with SMTP id
 4fb4d7f45d1cf-5ff988b09cbmr377585a12.16.1747165607045; Tue, 13 May 2025
 12:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net> <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net> <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net> <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net> <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
 <20250513070918.GB25763@noisy.programming.kicks-ass.net> <20250513085001.GC25891@noisy.programming.kicks-ass.net>
In-Reply-To: <20250513085001.GC25891@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 May 2025 12:46:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBiAqaWnXG_44ajMCqU3nNQOC1RQ6SUmKYC03Y1G=r1g@mail.gmail.com>
X-Gm-Features: AX0GCFslz14saMekTGJPQNGTU2UmwQF8S0KGif2G5A5hwICwjStllVCXsNnUObA
Message-ID: <CAHk-=wjBiAqaWnXG_44ajMCqU3nNQOC1RQ6SUmKYC03Y1G=r1g@mail.gmail.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
To: Peter Zijlstra <peterz@infradead.org>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Ingo Molnar <mingo@kernel.org>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 01:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> +#define __GUARD_IS_ERR(_ptr) \
> +       ({ unsigned long _var = (__force unsigned long)(_ptr); \
> +          bool _s; \
> +          asm_inline volatile ("cmp %[val], %[var]" \
> +                               : "=@ccns" (_s) \
> +                               : [val] "i" (-MAX_ERRNO), \
> +                                 [var] "r" (_var)); \
> +          unlikely(_s); })

I think that this might be acceptable if it was some actual common operation.

But for just the conditional guard test, I think it's cute, but I
don't think it's really worth it.

Put another way: if we actually used this for IS_ERR_OR_NULL(), it
might be a worthwhile thing to look at. We have lots of those - some
of them in important core places.

Right now IS_ERR_OR_NULL() generates pretty disgusting code, with
clang doing things like this:

        testq   %rdi, %rdi
        sete    %al
        cmpq    $-4095, %rdi                    # imm = 0xF001
        setae   %cl
        orb     %al, %cl
        je      .LBB3_1

in order to avoid two jumps, while gcc generates that

        testq   %rdi, %rdi
        je      .L189
        cmpq    $-4096, %rdi
        ja      .L189

pattern.

               Linus
