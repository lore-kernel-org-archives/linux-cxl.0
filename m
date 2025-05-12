Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A982185BC
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082383; cv=none; b=NNMdp27JUUEVeO4NvIvXz92cKo+cZiBjw39C5QZXxhHagNC+WUASEa8OEwZZN2GO28540sFzeYFMD+pI5DVT7zKu3XtIXZxGQTbbTH3Hd1B0P/Pl21A/vxIUZOu68sCIU41MLPi5zsP7OB6uAyTUJVz1SOBRwSGmjSNuuquiYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082383; c=relaxed/simple;
	bh=OWkH0J1ZOWK9WBmRgjhK1xQLkFYeWQ0bVo0U5xAyXFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EONsKqOvyAUkZA53+q4wspTBSayub+mdYnya9r6SB1ZygPsRg8iYt69xfjj51N5kp9NkgnvNIPzMJ4jmckJ7psdg+r/x5SXu2kOaWOek1rbX2ghSkZuN96cOZpohGuojS7IBtDmJuTcVnL9OhVf1F8vhR8Pokzmb3vl8MX6syRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zxl0yn63; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zxl0yn63"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acae7e7587dso770723166b.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747082378; x=1747687178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VB82LSl3X7/sYwlaQo+70F0TQOP7V64K466YMaAygoY=;
        b=Zxl0yn63pCeRAh3nvgXJ5RAejG/O3I4ePFTBnD9Psehl60gzcCwbfjzvI+6Qoih6XD
         xVja+Ww3ZD1Up7YI5OoQ3vIdPJ+tGECWOemJDovEVChszKdIVfgqARxYhcfLMAJiNW4N
         SsGsF13WWkaVGI+VsBoMqoLe5jdE5jLPvK52I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747082378; x=1747687178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VB82LSl3X7/sYwlaQo+70F0TQOP7V64K466YMaAygoY=;
        b=Odm/mPicx8i9fxBS2xGmytmOgCvwtebezXqBJ5ouBcmF8WKM+XRg8LFHwkCzBg0HPG
         JKzrVajqcFjlpaqlS+KtIgJmAJqImEaaTQwdBNwA5yPseoiwRqe2GdkRlKzQmA8ciRt5
         OlogRFnn6+jmE4UFJwdl/TvxxNq+QnNFcuHn7Cr6jeMifMEdlCIQ+1JVn5praWsYgetX
         /Lo7de370DEyOf54QHYElIRdSvR/EYrdAk/ysgV66N7/0EfOBKIWQRr7TKaiXJuwJ/1M
         Swk+UNX9vIIWxe1GDqV4j4oziRW17h73YaSfNg8Dv/tRx3x1A9adm/CgcIhPXZBPrY7o
         vQKA==
X-Forwarded-Encrypted: i=1; AJvYcCUqHk8p7q+5NN/lWebNHkJ6mBUpAUQpSwu4H26QkzkozRYIxKzK7qEPokFzlWYX4VJ9c2N1Vq4R84w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9HxTt0nxKcOJx0rZX5ttxar9W/47meG76lRsnuKwfQqC2Jc6
	V4v/5cCVWIN3tDY3iH3+trVMUaihDVbc6GEVLoGRVK45n8/Rc9kqX1nt61QYlhPMl2nCKrnBof2
	y9mM=
X-Gm-Gg: ASbGncukZPMWKngMrSE3uP/VD5XMmEVz+KmL2Si7KK8Q0dVe1IwWFfu7O7nse2emhq0
	gGDBp99hS2lk+JMLH++Sm/KDGUr2TBuouj+/xqft9Eorqe8p/TBSP4DnE9lBLsbPnd3XZMutkJt
	bC3fNf/Xs5gJuDEviZouNZOyQw8jv05OXztykJ0UEis1jgOAiJAWymQ+JYHhF7naA6pFEky6xtt
	X1YRPqFPVSByzdkpos/xLvodT7KiMviinAWWuqaV/MN6XEwmDqm9Q03Q1gwM57hWNhpsApQszrF
	7xsJHGZDtuFGvkaikKfhhQ+7gTLZgetEwREkXEEHLHBPjn5PkKohK1Ubn4s5baiR9GB7y8ZdXYO
	ZrI31eQ4aUcxtrRpHut9LdHhQ4g==
X-Google-Smtp-Source: AGHT+IHAYYf/M2W+IzSU3a8Pgdq5Xxs+yMxUJA6uOJipLHoZLU9Ite0mUN4L6OxNyAekSN7p3ZRrcg==
X-Received: by 2002:a17:907:1c15:b0:ad4:deae:dd13 with SMTP id a640c23a62f3a-ad4deaeeceamr15872666b.45.1747082378335;
        Mon, 12 May 2025 13:39:38 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23338b4f2sm497402366b.117.2025.05.12.13.39.36
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 13:39:36 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fd0d383b32so3662187a12.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 13:39:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqEFM3IJX15RlOVCApT+2Nx30oh09XiUPduQyDzx7LN02nNcZDy/AuUtNWsywEcKp/oqSV3MdnxLA=@vger.kernel.org
X-Received: by 2002:a05:6402:2114:b0:5fd:178d:f867 with SMTP id
 4fb4d7f45d1cf-5fd178dfc01mr7955993a12.25.1747082375924; Mon, 12 May 2025
 13:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com> <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net> <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net> <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net> <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net>
In-Reply-To: <20250512185817.GA1808@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 May 2025 13:39:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
X-Gm-Features: AX0GCFucCgAEV3-emriKKBbjXcTa9Ydw5XnavTKwpk2LJuNulre0nPwWMN_luBk
Message-ID: <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
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

On Mon, 12 May 2025 at 11:58, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > GCC is 'stupid' and this generates atrocious code. I'll play with it.
>
> PRE:
>     bf9e:       48 85 db                test   %rbx,%rbx
>     bfa1:       74 1a                   je     bfbd <foo+0x5d>
>     bfa3:       48 81 fb 00 f0 ff ff    cmp    $0xfffffffffffff000,%rbx
>     bfaa:       77 11                   ja     bfbd <foo+0x5d>
>
> POST:
>     bf9e:       48 8d 43 ff             lea    -0x1(%rbx),%rax
>     bfa2:       48 3d ff ef ff ff       cmp    $0xffffffffffffefff,%rax
>     bfa8:       77 11                   ja     bfbb <foo+0x5b>

I'm not convinced that's actually an improvement.

Yes, it's one less instruction, and three bytes shorter. But it uses
an extra register, so now it might make surrounding code much worse by
making register allocation have a harder time.

If you *really* care about this, I think you should realize that the
non-error case is a valid kernel pointer.

And we could add some architecture-specific function to check for "is
this a valid non-NULL and non-error pointer" with a fallback to the
generic case.

Because then on a platform like x86, where kernel pointers are always
negative, but not *as* negative as the error pointers, you can check
for that with a single compare.

The logic is "add MAX_ERRNO, and if it's still negative, it wasn't
NULL and it wasn't ERR_PTR".

And while 'add' needs a destination register, 'sub' with the negated
value does not, and is called 'cmp'.

So I think you can do that with

        cmp $-MAX_ERRNO,...
        js ...

Sadly, I can't seem to get gcc to generate that code. But I didn't try
very hard.

              Linus
