Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF868175A84
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368452; cv=pass; b=FjbWChlIYltpytvp63s5s6XmEgEijA+2PAoTq1HJGwd0m0vCz3YESWqT9k72mvlOmstesSOuGldV03NXuU8o0hC4Hxmyn6yEcZeTpP1fCmk1rM2+Fh/GguUxZeFeznGJCU+LnGR4+JoSV7xnHrTPeUt8POv+X89Wqn/egrn9KeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368452; c=relaxed/simple;
	bh=Nc3vSgPCiZyWTFw4ReuW9B3v4aeGpdG1apfFjxfTvD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwIMgs74oeAQiDtnLpxN4o02894nAQFNqDvJMciRWfzvoTQOQSnFFAky8smUbymUUyv+oykc39MZVNoBm/BrHD956BZHySeL+nN4oYnyEv5mH/D+KFncfIRMujAuwYk6t/xAmigNfmSf+lxqBaagzPJSsS7LXARX3Pymn3kssjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5m/2h4t; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5m/2h4t"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso2418209a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 19:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773368448; cv=none;
        d=google.com; s=arc-20240605;
        b=LWsroJc2AiAMT9mbHy3uUI9lx7SG5FvugmhrClNn0DmBVAN5B+Oi04Ff0ayTG+8hAV
         TDt/LnVLUpB4ipmfdaJ5++knhkBiqKvoOonb6u37cE02OME8VzxnwMWz7JzoZPy9f4qb
         sSrClcNxC9Ce9HoudvlwiKcClurnct6zogJgyJPJ7hOFrT5569Fo7SMelCcAer17zlI4
         TUdy++0Xy4/tMER7tvHQV0JzErLZUd6vKNNmL0Zz0kaGdsRh7RpSeofwKwwmGLncFOy1
         TdPClcfANiKqNo74QVQyDSAx0JpCcFD0V8/GlORvdjEiZ/EzOf6mli8sFisdPvJj7jEV
         MxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bF3o1la32fuvNbL6eogbD9OSVNGno1MaF2cdSSjD26g=;
        fh=lv0MiineoubZTFCLPr0eL+S14YzfK1X9UbINwIBZipY=;
        b=Zc8EBdjxH2nz0/LDfGBt0tc6pyanTCRceXcQDIT3LL0uuo09Kou4bJVje50wKEgPaf
         /V3UotrslnESGOo/+ALO5geSZo4fLCY9LrHz6C1W8XW/gbJ0eY4WW/VPaycNKY9JbgDX
         sZJJPdXWlaI2oLoN/i3n9TZExcShtsgdUIpaBd9XLMeM6zTktCXoD0zF720fkhtgmtMR
         44Pg5sHVy2C1H7qkjL7Dx2MzjgJKey+t8LXlomsY5Pogc27tS4AWYNcq72Jdn1Z7iJtz
         3dnYTSL/x/gZosLNWC1uqGfLsrP6mPxHgKoYMfXnFbb2fiMl8CrvvRjAVzxNozi4BMSm
         /ynQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773368448; x=1773973248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF3o1la32fuvNbL6eogbD9OSVNGno1MaF2cdSSjD26g=;
        b=h5m/2h4tZSYh97yKPQKNRK5SkPzjkbsLDTs3h2w4/4UGx2qb5nct95DPQcMPjEmLvu
         QLz8mY/x9UqfIykNYB5GPFSB93REPQaQbSvZH460waH4nC2nP9bvd5BKNsndUcwP6Zf7
         Cdnybwni30ur9x4zy1pa6qts7Ggg9yDm3C+Q53o2EHPja3PYguRU9Lea81P+xJnazHFa
         jVqpIZtYCWZHdKquQhNfwgzwJnHquxXF3Sa8Drgc1PamUK8jq8E/SaxzG1ax3UasmBLG
         5XGKXBm5wXnrZC+MXV1OO/UlVfGlu2poukrA8a8ksFCmByoGzNleCWEQ4gq7Mw+uCM2C
         +Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773368448; x=1773973248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bF3o1la32fuvNbL6eogbD9OSVNGno1MaF2cdSSjD26g=;
        b=qYmdM/qrn6tHdfoU0JQcEBgZDMkFE/yjTGOM1KVMCfjYyMOiOv3gtLDhauEW4MOvoB
         9B5H+5HSz6DyntmvK7NJpp+BwJfPUlW3IT0/vDLrA0/FWA2UbGcjuxPejwDYF1xu2kke
         cUQGBGByOWXlM2oFejRhSrSDE9CqKnc5q1jIELC3zs9gu20HZVjCF7lQK6o/j5q0aDtC
         efJ27TsMZYLM3xC+j3rES+nbTB+TTi7oYGEXEzwIbTjVl0OcqYQlb/iaKIs06+r7rjRj
         NPirkyGRoImcfmxIMc8w+lUKXW80YHXyrpbzlKy2Etcq1YTOSRtU0Bwszs7N+9v7ktDi
         Wukg==
X-Forwarded-Encrypted: i=1; AJvYcCUvqn5SfYE5K1e415gTiJ8xaH46QQPM34cymaQ9CMmQWHxXc7NAeTIU5/0G2Y8l1I9YlByuVXM/UxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNs1UXS/eul5yon9XQYU1m6TA40fCSWGPffPDQHLJHzkz0ZEI
	ANCHtLORK0zSmRPEg6+SrEXxQ5QrWnXLl+FRPlczMeW0yjRtbt9WX4NiuykWQRkjvXNhR1zW3IX
	/272M0nPlzCMuJP+JGEN1+X8hFCFpQmc=
X-Gm-Gg: ATEYQzw0DnEltWt+KN3dByVx8wzO+b+wbY9SKycvTAlvioeBwC8h1PIO/ciKaVned/I
	48Z00EcihPWylVhyLzSzeZDfUTvXQpsX51y4CN4ZLQqxFhKNiqMC7kOVFq9meN9o1zXAn4AF3fc
	uHKh8IE92K56LHh0ockmsGDKDZiNVeigKcZxrYvU6/zOGfD7geJxGMW1VWZnWscqMzSm+f525/B
	WnUFf3OFmDyFu6nzJuSj2EH5ka3M0LdIldhi8sjJpNMgG/R1aP21a23unj2uu6fmBVakk6ikDjo
	PHDEUP7hNyBnEZYcqd02cffgau2LsERFmmH+Ow==
X-Received: by 2002:a05:6402:35cd:b0:65b:edef:40b6 with SMTP id
 4fb4d7f45d1cf-663babb2796mr790403a12.6.1773368448051; Thu, 12 Mar 2026
 19:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-8-alistair.francis@wdc.com> <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
In-Reply-To: <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 12:20:21 +1000
X-Gm-Features: AaiRm52El5V2cLVcjV-Q8_ZosbewKKcX058abV65Lg9yJW4Ibt_OSl9fj2Npv2A
Message-ID: <CAKmqyKMXmn6=suyjhB3Kq12-UHuLbPLOHPd2JO2b3Nxn4jYHpw@mail.gmail.com>
Subject: Re: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for
 Kernel Error
To: Gary Guo <gary@garyguo.net>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 12:49=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On 2026-02-11 03:29, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Implement From<FromBytesWithNulError> for the Kernel Error type
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  rust/kernel/error.rs | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 258b12afdcba..569d9d032ab3 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -12,6 +12,7 @@
> >      str::CStr,
> >  };
> >
> > +use core::ffi::FromBytesWithNulError;
> >  use core::num::NonZeroI32;
> >  use core::num::TryFromIntError;
> >  use core::str::Utf8Error;
> > @@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
> >      }
> >  }
> >
> > +impl From<FromBytesWithNulError> for Error {
> > +    fn from(_: FromBytesWithNulError) -> Error {
> > +        code::EINVAL
> > +    }
> > +}
>
> Are we sure that `FromBytesWithNulError` maps cleanly to the `EINVAL`
> error code?

`FromBytesWithNulError` means "An error indicating that a nul byte was
not in the expected position." [1]

To me that maps with `EINVAL`

1: https://doc.rust-lang.org/std/ffi/enum.FromBytesWithNulError.html

>
> Anyhow, please add `#[inline]` for such simple functions.

I can, just noting that none of the others have `#[inline]`

Alistair

>
> Best,
> Gary
>
> > +
> >  /// A [`Result`] with an [`Error`] error type.
> >  ///
> >  /// To be used as the return type for functions that may fail.
