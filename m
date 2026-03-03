Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC288381AFB
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561261; cv=pass; b=azU5WkjpaLEFHzYDyMUm0SpEz9pgb5ORlXVz6gqE3Y5V5+4zqVnU1XpVIP1gqpIpQ5DYPCv+z2LRemyTqrQPATXYT/SJe3G70uVenrPkyCGVXRuqOdfyo4bZEKPt1eVT9c7FS4AUJ9thbsD6iPrmK8t3nWhgDitzpRjCtstPnT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561261; c=relaxed/simple;
	bh=HUHgj2ElBuPGmubcslyfUuFNZEOEJOjv22IyfxcfieI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlnwW0m1VmDeMnXpICtK7CihEMwFKTi/rFPBpWZqGa1KGXHLyer5VGicmdZ0MAO+eJXO6gMgYGR5jG5KJrSBRiKbxZtA8im1ljw6oKbQHh6PYdaqrp31t71hPRTF8xeBrpQadItOmxEvmPg/OOdOWuPgukMt8+1KcYU3xLIfrdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGapfEar; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGapfEar"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdff6c15a5so150221eec.3
        for <linux-cxl@vger.kernel.org>; Tue, 03 Mar 2026 10:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772561260; cv=none;
        d=google.com; s=arc-20240605;
        b=H/wMExxf4AVDLf+77uBvtbVZPxEN42P1cFnuW/ajLmO65ykSPkTGP6+wort4D1OJ0l
         WU9c1lwdDmSRpf1ZiBhRE69EG7v2rOcfKWYpBRSQwGyTo2PEyidLaJzKzcw+OuUolSqe
         B27mjn4FapIeVZB98TEepCI/uE2dV3hHWWU8Gl4KBln/5eFVOVBaodXM2nae5o0aXQHr
         x1M707ZcV18xUHeFhbU2iXACU+4JMqbN8x9nOOcyLpK2BoeKoDr9pOJXWJxaLxzR8fuW
         fR2KjYa1GbE2jXg0mKAm4U6AGJXQufCJhOA1hVOXqKrsxSwn1MaHo6vTNRuT0QOgfClb
         GMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R+q0jN+aH2U740XZAx90ODP1AU2BrSp5EsLhQpO8EjQ=;
        fh=cvO1iqyz4g2a4mJ18n62EFGLOX/UkAOSfBB4xxGo724=;
        b=U9AmdK4dgJEdZhDDzpOSs7kbQhuLr01oaODb+jv2iG+FG1/rxbqMMr8/4xkrRvF9Ly
         VuR3YZdWQBCF2m5XO8W+YNV3S6yzyjm9AQi+fwAtA9MSCH19N3lhsomhNaTyD9+9gp45
         ogE7MyjQcpVzKWuzRIhevHEksJa1hs1RtTMlSHvplkGVZLoF+HOKrMq7u8p+8fb2h5hf
         4S9XpsDZ23BImmXgh5/+zlTRLKWe0SUSaJlCTgq5mEEfjEmzZ6lm0oXxGsQyHKM4i04v
         xREeFKYDfeMBgOHFf9rudwY5ktNQSUBaFMp+nFJpsKC0cd9EQjDg9EFHfbMdxfsmbE8c
         mqyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561260; x=1773166060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+q0jN+aH2U740XZAx90ODP1AU2BrSp5EsLhQpO8EjQ=;
        b=XGapfEary2QvfkhT2A03zHWPyyNJ6Iao5dpwc6qoSW9t7U0bZEFgeqdUWFHiQx0oZt
         PMLO+YoBvftY2bV44jNW3TwFTtG4+y+HvpwCZzdquagngv7grRMS793RBb3gGOrxwQRh
         E+PmR57RDenuPd2sT4bp9qvEo7O0dtyqmqUziSLy77o3fNg0n4FGzzCCtazjecQmuc8l
         dZf2ZoDEqsp7iR5H+H2dKfgw6JlLEfrz5Ncya6As4PgHqhx+nA9oWgm8LS6SgA4Ko0AV
         JbiY+EHuU8qjRGYkzNbMAvD2NsVOQBJUH/75SaxLlqMriheKko1HccaKIHW3FGGn/Ig8
         WpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561260; x=1773166060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+q0jN+aH2U740XZAx90ODP1AU2BrSp5EsLhQpO8EjQ=;
        b=w7kdpN4KY+kODQsL36lEondqW9rNg7T2ZqYvztj3bjgUMzZ6c6Tr+6m246RZYDJk4f
         GFWdSpOL7vMeG4lrjgjqUBl/G6vrU/hG/mZQxgCa4M086OsB+C3yKYr0N/4a4jfTPXx1
         wmNNleEqrWsZP5adNN0Bv4o+Azz0KNE5099FmHU/n2mFMqqcaGCny+yZpj2VZYsa4vay
         cjVBekZrSYyWMcNZbqMf3kdI7XxJuy54MAp2L+unkku2llXkCtZT7iBxcPX9GIbwbono
         DP8V3z3l6DqiwK01E4/XYmTYxI98aZf0bk0htarC/KJYAOxEYFT+LhtrtBwAvvn+slbO
         S4/A==
X-Forwarded-Encrypted: i=1; AJvYcCUKDH/KBcNrCD/Xql/jezkJqq9BFo3eekoGIzD8OFzSGptuFHsDnFzioFOQep/7JP5ReHV4hwctEPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uiK8mgqTDtWEeuhnVxZbzuJLepCROHW/TG+CFd1fMbdP/HVC
	Fq2xNEcHXhhHQEFrNqIWxP7+GeSYb2DpPjR8bjhkD7uyBSc/NV9cegVqJXDY98Ih3ErvfA/NoLR
	ADtDv4hqr7fNhtfcIShL8zdWNwBTAqPKMh2p+bHM=
X-Gm-Gg: ATEYQzyi4aHgje4zXmPI13sP7uiTGWIhmWAbQ+MZaP2a3Wbu7RJ/DFg+ODNTE5bDXqi
	9yvqNXvDMVrXNOA/DIbF9nSZbtXzutieVN2xj8dpZoWeGbT8parNnhLCzHUOyInBBZO0MSEK+HD
	3o97NxFiBKOpf4aE620D6w0LL2I4TWf4ugiN8z3nHD9/IRMXQtqeN6jBqaqfLs/kNWj3OVruPyh
	b0wjEqThCDMS+kC+oXYApJQCymoB5BhqFDhKTBEVbwzp/9QHgnTH2gYP1KdSEmzgf2DgOtNHuDK
	KwzJ+Whnbx2VKe06JKQW5b+VluPqBy7cCbBnW5ykkDpMXXZeHuMTbqbps1UzgJlq0EKQvA6HYln
	5skdyRriiI2y5cd0kv5dTgOr7
X-Received: by 2002:a05:7301:128f:b0:2be:1946:8576 with SMTP id
 5a478bee46e88-2be19468a7cmr1189062eec.4.1772561259708; Tue, 03 Mar 2026
 10:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-14-alistair.francis@wdc.com> <20260303120901.00004f09@huawei.com>
In-Reply-To: <20260303120901.00004f09@huawei.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Mar 2026 19:07:25 +0100
X-Gm-Features: AaiRm50kQCG3rWYXRXgEs_41HrhB68jbew2wmRd5fS8L-moVcgSEic_0M728KX8
Message-ID: <CANiq72nU-0Da1R3K6eHeJU1jkhnu7arVP5NOykdvQEpoHSgHbg@mail.gmail.com>
Subject: Re: [RFC v3 13/27] lib: rspdm: Support SPDM get_capabilities
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: alistair23@gmail.com, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:09=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> Can we use bit_u32() or similar here?
> We've tried to move to BIT() for similar defines in the C code, so I'm
> looking for something along those lines. Provides a form of documentation
> that they are single bit fields.

We have these so far:

  https://rust.docs.kernel.org/kernel/bits/

Out-of-tree long ago we had also a `bit<T>` generic const function
(https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/types.rs#L31=
7-L349).
I think we also discussed a `bit!` macro at some point.

> This is why I was getting bit grumpy in previous about long lines.
> Fair enough if this is only option, but it's not nice for a review proces=
s
> that relies on patches!

This should be using the kernel imports style, which should make a
case like this more readable:

  https://docs.kernel.org/rust/coding-guidelines.html#imports

I hope that helps!

Cheers,
Miguel
