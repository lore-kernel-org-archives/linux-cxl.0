Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFF1A8F6D
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098124; cv=none; b=pkJJxFG9FDZz117//zJhYUf51NvQIJk+eyTH61o2TQOtyBzH30yF4GySDgFACkO0n2WgIuMljBMI7+sqZPQvgCpvPLsZV1/UgERO6+3uKQpwZHN+rY7C/X2BITMsxCGmMH00d3aFcJGT6MRIjFrualOVcRnv3LrVn6cGcN4I9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098124; c=relaxed/simple;
	bh=0EDMq5cSTxuCUaLadjW8Gyiwo1w0ECv/iUAH72LIgqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUseg4ZdQeXWAA3+yPiJ9K3HZfdwatgDwGn873e+N/N8FS/SHqbQ5LSBx23xg3/kI4hfFx5jPLHfEoS/8stxnx2AdxRSxKPatX6v4/qlwjbdtInJuJ59i3a+J0TaE7EkyGD8/5mygkONAN8rrosksZAnK8xU5RHuItzghgzNnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SU1jYOi1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SU1jYOi1"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1284482566b.3
        for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755098119; x=1755702919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2L57A8estrxMJoxB1LxgVIY26536p4EpnNTQos21VK0=;
        b=SU1jYOi1aamo4+C2nxzeUng+uYEMSsb6cCOuHW7hLxuil/C6HmQkqjvWkyGylLaf7o
         V+debXAuxVWWKDetcf+b6oFz3XXifO6WlPYQ78+OnWuWVHj7xLRufJhJw28qObpLbjkJ
         ZJHCU1UU/r6q3wj3IcDOrLqRqvyzsaFgtrbRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098119; x=1755702919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L57A8estrxMJoxB1LxgVIY26536p4EpnNTQos21VK0=;
        b=WF8XeXup7/cORumXbmXjPHFzBxjM9G6oCo4ZpV+jZ4P4qnKI3EuvWcQN98WHgdMJ2n
         zLcd+BXrlRoQGEOfH6GJ+iVsgSqaEgbtHJ6n6YQxSNb19JgExcPKirSv7E+P1EfHtEVy
         dodR/rK8UYBBJBmFWBaBDRJlAEcbMiX/2xDMdknJotDML6B1iWM07N7Dxdwo4jrutpg6
         T+/DtVNCIoMmz+ZPFEoRyl+Qu/kVzt2osTJS4XXEYfVEsTezBS0zC+2BoP8Zk4kZIpQV
         IySBAlBdxnHmPBAzVZL6cTiaQiQ4w2etwQoGZ8xyYXbavzoxkJZ/MxdjVuQFTkLFH9+5
         00GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWONXvqDvaSJt8Mg6UEH5xR7GXpgTHenph2YYf8vCimnwGocH3xHyFIIwu+cjQ/Ne7yOdFfg9tOFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRG3KrAHfZnSnjpEuDrQyJKld2+gu4MnPgfQvyRXxbWD5oVqk
	tYt7tPJ83xxTd9eG/sTvdflLq8TJjiZF0clbzTBqTHt6Rc93eqqNBaw09d6DkqSSwCh/toevAoQ
	nIe08K3Q=
X-Gm-Gg: ASbGncuKaPq340wsxXnqUkelEn1WFj54xvFm7SQ5kfBkFkZg1o5IEZx9KfXIQsiGD9X
	EQ72O0Sfr5jAL+7fROXmx/q3kfhtRAGpe+T8yMjAF/O4X9RUtD5qSjuoG86a5iAvMpBNr+0Z6E8
	Q+YLkyJlGIb5iWV4tn32/4yUuVh4CxS/RK37Oy22y9xkM1CKgMw44BCWWuqffIEJFiqIkzM5obK
	DO1l5cUbN5HSZzqIA/W5vLUbZMu2YqZjV6PR9yX3wmbikxDHmNml2lf5/OVq58xjoPJQhJDvxII
	FklKYHSGpgcHTfdA3u3GKXuOhh7/EZvogUtDmTG4ZpvTUy510w8HX2QCbD7pZSYFZO0tIgkoX9X
	euONGQ8aXn7B9m96ICXuNIoZ2XiVr+4ol8BOuuA8qioN4MSMOloWZkek+IglV/35HDk/hgHfpCS
	TeToAUYDI=
X-Google-Smtp-Source: AGHT+IHbkg654r9SEhXq8127GJuaFBTaN21KLaxZqnxw5fOL5kKbxnKJAecPvC8ANgs97aLIBRV4RQ==
X-Received: by 2002:a17:907:9406:b0:ae6:dd93:d7d1 with SMTP id a640c23a62f3a-afca4f06900mr345097266b.56.1755098118511;
        Wed, 13 Aug 2025 08:15:18 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078afbsm2404789466b.4.2025.08.13.08.15.16
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:15:16 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so12677316a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 08:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEZbt5H2CHz7cdgNyE7zAAqrC19v085Fz+1Xa8hdDAqdcFcla/cqGNIJszQVrmkYl3OAXtEShdgvo=@vger.kernel.org
X-Received: by 2002:a05:6402:849:b0:615:5563:548e with SMTP id
 4fb4d7f45d1cf-6186bf89e1amr3186956a12.7.1755098116142; Wed, 13 Aug 2025
 08:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804220955.1453135-1-dan.j.williams@intel.com> <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Aug 2025 08:14:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
X-Gm-Features: Ac12FXyf2H9rUW__r5AJukVyI2fsUB2Hnh8Hl0cQ4hvvDCB_hIfhAbGduc9KWBM
Message-ID: <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with DEFINE_CLASS_IS_COND_GUARD
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 07:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> >
> > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > find unused static inline functions for W=1 build").
>
> I so loathe that warning :/

So I entirely ignore W=1 issues, because I think so many of the extra
warnings are bogus.

But if this one in particular is causing more problems than most -
some teams do seem to use W=1 as part of their test builds - it's fine
to send me a patch that just moves bad warnings to W=2.

And if anybody uses W=2 for their test builds, that's THEIR problem..

          Linus
