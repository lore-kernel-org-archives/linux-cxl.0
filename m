Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931273148DD
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118234; cv=pass; b=R4gqV7WRnHizgAytE6JM1raw622k/GKiBHtiq20bYGYyFKODCcQ62n8TzrOwTUkECFM/yoz8lhKuwRqTV0LMSHL0Vc6kX1lQv3IlI7K64Mbt4/jQB2Qjo4nPtt9CCZ5TKT1gIHkbRw0v08IRVu+e3z6ovkAWmrMkmg7aCIdVEy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118234; c=relaxed/simple;
	bh=rMQgEeQaYEw35gJBRAPq9USscfGFXh1c3oZpopkcKNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmTuwEfewhEC5ckughth9UN1A2pGysyGuAbmIQnYv/OmuicopfWrSpacp6lIuF5F8kQ0F2rXzxDg9nF+10gC2fcjVZPev/N8O2OaS5qw5b0Wbdvz7q9M3VshUFCTLfJ8wpfG/9fK1ax7wSOlBf7ErN0a2xSc5p6rQf8Xap9n0e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=PO3MMMe6; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="PO3MMMe6"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so7602434e87.0
        for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 12:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118231; cv=none;
        d=google.com; s=arc-20240605;
        b=gQ6/cfVpd4BBSuEM854/MJB8Nt2Wrr07gcWpsMSZwZB2cyn6LQWpcCiGJct5u5OFod
         Lhv/4lnGZKx5zkXAlB7izr9QD2lvA9hM1FqcTNslVsL+G+X8zDpsJU3x7CFPoJR9rkgG
         Gzq3zn1aJqrcuBVoOEqDC4sIbKKtThtKTuYJMbVFPeYOiC4AV7K+qbI4XsOOGAGfO2nh
         vJWIIk9f5V+zBJC5xeEGUCPbNCKTQTcE7OUhujdjBCO4yP1uA2zILo1hNIlUynOgJFpf
         R/dM43ZdkN0Mh/fQFg+2YA7EqaNynQRwkhOYbMeMlwc3yjCV+2Dy+E+KXY7cEp7QVE1l
         AKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPogc90PNi+rFFaOSgYldDbwSyXKlFYavPrUR+tyDBQ=;
        fh=U/unuNwaE5oX0bcXyK4/fJiDwu9L4FcUm9hRnPZ0pSI=;
        b=ETSwXVFHywZPFyu9COshNhUDjuYUyKQiIRL2qRiylCqG+lUcUgaXv/Xz5XIKHo7hZx
         w9oim/gDH8/JxvxGCJnRODBHGlradMwPzHGqIx2M/bgUO6tfmuxPzEY2UDxzJLgpqLMy
         BE2BcHSHnW+NocVcMI4OPJrAfgRGuLN649ViMW840cbFJaw5mPyp84PVN4IGq6qfmt/g
         cXyClen5RXMHy3j2blSYA9PP3V7/z88PN1OqJUDFd4ruzHPnoAORvfPL2o9KR/9e+omp
         polJjnRS1kxpaLwnGdbxwI1tWsG2dQ4gzmW4Up4xdu2LYoq9zeZ+A1NcX1h7bssmeiQV
         s64Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118231; x=1781723031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPogc90PNi+rFFaOSgYldDbwSyXKlFYavPrUR+tyDBQ=;
        b=PO3MMMe6GuoOeOR76U8iYaltOsiPk4kVFUAgD96nkSYqFD0jr5s9Xwq6fQJIw+c0ln
         l/lPphBzAgLJTf6gbYk6juIkhNfl/LFtK8FfzXHwMKwA9cTMPK11IxrPrv0s+OKfMcz8
         wwdXm2jhwPEvwbplClK5xPYkA7G4p5rPiUMITcqYLlrVwuX0Ez4pKyGixCMrI9038btR
         YcVTaJnl7f7RqBQjESaCsmCjCpRNflHin86RIsTCStpzeE72kFiyJq3WklgfdSW46tnA
         MKDVbB0X91h/BUr5ORsuQe/fiHanRSppAYkZBQemYZD/+ZTKmT0SpsRnm+35TKVhYfAR
         tvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118231; x=1781723031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPogc90PNi+rFFaOSgYldDbwSyXKlFYavPrUR+tyDBQ=;
        b=mFqJMWUIlCt6G7MmdbpG4kpZdPAe28LUNTV/BRkPYM7YHsplgTFsPBZM9vxWbmys4P
         80RWIm4d8G9mejgyeFvs88Z2TtQK4aehD2WVFfcT9gzHRGc1QYXyEnyaj1/prhYuGG7r
         k/ofEqXFJeMcAp70qXZWXki5l/op42+lUe2gJC2JZ3eTJ2rrhTZb7V1XRHuuaXogyywA
         S0WGmyJteC4hqrUjSD0ozo5B0DrlBEY4TNapKwUqKKHkvCHAounPzJvEW5YaueF5N2he
         dHWI3pJ9DS78n/B7UhWzJ0UZBwNLRD2ZOZp31n30NBRz4fWqtP1T7oO4H53QOez02HGg
         kGEw==
X-Forwarded-Encrypted: i=1; AFNElJ90D5yrHR2T3gnvZQd808ucz98f9bUznenpfgc5jaQ6GC/RxATHUYa+XLUXU+89rk4siYVjzSdnA+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9VJ4smA4dgJURcIP+arw0yBYx9gd0yZvJ6qq/Uj/rPuinT+K
	xsFbThTm7/pd7HdBrxLIHfGK88G/+gG6DAdi4CnyYnOqIeo3oRpq2YbhG/VObIuZo0U7zThbPNc
	6L91PJHkghqXT4DYgZtChTjTAaDblN6FBMk3vQzUHzw==
X-Gm-Gg: Acq92OFsQ0xrHd0b7oyrTfdE0GjO4YBoquHQUEG1oTWmwi6Mp4Rw08SgydQBwbhgYDJ
	P3Pv8vEhlSlb6I/rEDLIPsDEq3WSyG7zyMbjUIr1Wogy4nS2I6kmL7o1ToxkjumDCcVUPba0nyO
	7FR0S64IxcLlygdcgJxv+P+bSGbU+pvxZlQQXOEc383jvJEr90UEnGr41kKh/Lh2j2CLntjCNlC
	rQ6XHyIGeg5p57s3dcgsOO1aEgF67z3j6tEU5eIMw0ir6FRL10GXoreMN1fLCH3x8FKcEyAPMHs
	ViWO2fXHIlaRgKee
X-Received: by 2002:a05:6512:131e:b0:5aa:6ca8:9119 with SMTP id
 2adb3069b0e04-5aa87b8a4f3mr8327296e87.1.1781118230719; Wed, 10 Jun 2026
 12:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605171238.3857744-1-dave.jiang@intel.com> <aimpGhLI-qCA5KM-@aschofie-mobl2.lan>
In-Reply-To: <aimpGhLI-qCA5KM-@aschofie-mobl2.lan>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:03:39 -0400
X-Gm-Features: AVVi8CdLj4M1n5UsSGRpywSzlQV3hD1KWkl9HorGQnM0-PDkZ2qwEl4tqNc5DTs
Message-ID: <CAE+C+Db57HpKxGd79ONZJHrzWbUtir_bPYgC07Jg9BNxM=UoVw@mail.gmail.com>
Subject: Re: [PATCH] cxl/test: Fix integer overflow in mock LSA bounds checks
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, dave@stgolabs.net, 
	jic23@kernel.org, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:12=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Fri, Jun 05, 2026 at 10:12:38AM -0700, Dave Jiang wrote:
> > Pre-existing issue discovered by sashiko-bot.
> >
> > mock_get_lsa() and mock_set_lsa() validate the requested LSA range with
> > "offset + length > LSA_SIZE". Both offset and length are u32 and, in
> > mock_get_lsa(), both are taken directly from the user-supplied payload.
> > The addition is evaluated modulo 2^32, so a large offset combined with =
a
> > small length wraps around and passes the check.
> >
> > Rewrite the checks to compare offset and length against LSA_SIZE withou=
t
> > overflowing by subtracting offset from LSA_SIZE after bounding offset.
>
> Above is a mouthful, is it more simply...
>         Rewrite the checks to first bound offset, then compare length
>         against the remaining LSA size.
>
>
> With a commit msg update upon merge...
>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.
