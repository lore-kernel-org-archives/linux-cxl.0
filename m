Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AC67C45
	for <linux-cxl@vger.kernel.org>; Tue, 20 Feb 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430187; cv=none; b=o02dAklh8xJnjy6VvIyk6yFg/1+7hdTToVDTVlEB5zRfBYkaw/2meznzIJKJG41uyBFnNU6GzBGo1QCaQg68vPdn1YQp8uunYJtJTF/fhk/4h71UAVKDDBmS6UOlcda4RkEKXjmhzvO8uDES+dAnvs1V9aHkRDFbr7227l91/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430187; c=relaxed/simple;
	bh=wUPrVkP3HKE7jUQLKcqx8MVvYIspz2oWeSvgBTNjXNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m6zJOoZNJb/vLp8GsgixMMU60GrZl0xITx9dWN0wXsCFy7tbxVGs/2r6+xsec8xUgXrFmL4LdimOJekQYChAAJs9s+nG5LT+SJUfS+H3SIGqOPHbIsJbXNGAGQyHykqGlcuRfytK/6s4nwW1IlbDFDg+7i1uqY1lvoWMDQ3gP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OGH8BdQt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGH8BdQt"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d208be133bso54607191fa.2
        for <linux-cxl@vger.kernel.org>; Tue, 20 Feb 2024 03:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708430182; x=1709034982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bymRY9Qqw4BdFm18zaS03JMajlZ6OPZF8f+G7bQq/zk=;
        b=OGH8BdQtIyF5Uaz+7DcH3Qx9dpGfZhMfHRWKzikmSI/uTnTi+GuQqRFpnz2fQ8ql34
         +NFACzNqoErmkWj8ogXARWNddNLWbCt9yRcPaXaifQs4YtvM9D2Gbq71v8N1WZ6VY1yk
         9CNLPv/cP4yop9+zOBuwAp3QfChBZSqNQqK3i48PFhxaiyB53NRFStP7dC87WAGg0p9m
         8YNT4WTx2MDxa7J72OwoUrj9CPzePdwNbkTpZhTLXamKP3ECoTqBBCKWn57eMc5CO9eq
         FXOWRjzI1VxSKcDiMbCWv9Kj7qnezwSHC16vVdPeliEPAn0cf0M1XqsLCzJ7Jh/1/zOO
         gnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430182; x=1709034982;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bymRY9Qqw4BdFm18zaS03JMajlZ6OPZF8f+G7bQq/zk=;
        b=PwTABw7u3lfhElD75AFTz0Z07oPJlyTkNzJrhEpTEgPV8n9OSVXo2rkEOrYrK2GRhD
         licrMSIaG86a7dp3qQUTAZd5oK60edu5Hda4bPbGtRBqP6+0aU5iJuD1b52m6SeMe01J
         v9xMwxle5HV3uDQfiaCjULLH6Sw6gmH9bIQGAtXWUD4BzEndhaKm8m1WcwxMiRp3z71H
         5LqoGtQrKNovkHWEL6svWcomBrZrCLnGIsIcLOAhQ4DLUjLe+RSQa4+y7cqYQR45GqFA
         12rDZK6tBG8eOF4sU3zxdaLnMYLebbsjliFZyB6Oy1HOZSRkAGRdyqYgECGT/2aFVPSI
         YdHA==
X-Forwarded-Encrypted: i=1; AJvYcCXDyvkF+hu7cG+QxmPlCYt+LmQ1R50zul+et3puZItTT6dNt1jhyi7hkS0/463Q0zhSXKGf5/Aa7vQ3kZmytlqZCvVXrc+7Xuie
X-Gm-Message-State: AOJu0Yza5ej0HajubcsslGhqj0PVpXgMv1D3gcgSe5lcF0l5FWyB+KBm
	Nw1DFCMJeSKWIHkm3r9uv0SYPyFXOvCidYBiMDXOtrsXn6wmSaAv6EOpCLjNkRc=
X-Google-Smtp-Source: AGHT+IHXWmYpALArkBYNG3H/2+0kXGPOOYUdkituEaM6R+uqompHK0Khl1c+DTIZlz+FSVDdiwv91Q==
X-Received: by 2002:a2e:9c8d:0:b0:2d2:42ff:484c with SMTP id x13-20020a2e9c8d000000b002d242ff484cmr2824105lji.37.1708430182216;
        Tue, 20 Feb 2024 03:56:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id e4-20020adfe384000000b0033cfa00e497sm13147105wrm.64.2024.02.20.03.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:56:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 869805F8B9;
	Tue, 20 Feb 2024 11:56:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
  <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
  "Gregory Price" <gregory.price@memverge.com>,  Sajjan Rao
 <sajjanr@gmail.com>,  Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
In-Reply-To: <20240219121455.0000387d@Huawei.com> (Jonathan Cameron's message
	of "Mon, 19 Feb 2024 12:14:55 +0000")
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
	<20240215150133.2088-4-Jonathan.Cameron@huawei.com>
	<4b00b67d-cb3c-4173-bb7f-1ae68cdfbada@linaro.org>
	<20240219121455.0000387d@Huawei.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 11:56:21 +0000
Message-ID: <87zfvvcpsq.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Thu, 15 Feb 2024 09:30:27 -1000
> Richard Henderson <richard.henderson@linaro.org> wrote:
>
>> On 2/15/24 05:01, Jonathan Cameron wrote:
>> > On i386, after fixing the page walking code to work with pages in
>> > MMIO memory (specifically CXL emulated interleaved memory),
>> > a crash was seen in an interrupt handling path.
>> >=20
>> > Useful part of bt
>> >=20
>> > Peter identified this as being due to the BQL already being
>> > held when the page table walker encounters MMIO memory and attempts
>> > to take the lock again.  There are other examples of similar paths
>> > TCG, so this follows the approach taken in those of simply checking
>> > if the lock is already held and if it is, don't take it again.
>> >=20
>> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > ---
>> >   accel/tcg/cputlb.c | 9 +++++++--
>> >   1 file changed, 7 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> > index 047cd2cc0a..3b8d178707 100644
>> > --- a/accel/tcg/cputlb.c
>> > +++ b/accel/tcg/cputlb.c
>> > @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CP=
UTLBEntryFull *full,
>> >                                  int mmu_idx, MMUAccessType type, uint=
ptr_t ra)
>> >   {
>> >       MemoryRegionSection *section;
>> > +    bool locked =3D bql_locked();
>> >       MemoryRegion *mr;
>> >       hwaddr mr_offset;
>> >       MemTxAttrs attrs;
>> > @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, =
CPUTLBEntryFull *full,
>> >       section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attr=
s, addr, ra);
>> >       mr =3D section->mr;
>> >=20=20=20
>> > -    bql_lock();
>> > +    if (!locked) {
>> > +        bql_lock();
>> > +    }
>> >       ret =3D int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>> >                             type, ra, mr, mr_offset);
>> > -    bql_unlock();
>> > +    if (!locked) {
>> > +        bql_unlock();
>> > +    }=20=20
>>=20
>> On top of other comments, I'm never keen on this type of test/lock/test/=
unlock.  When this=20
>> kind of thing is encountered, it means we should have been using a recur=
sive lock in the=20
>> first place.
>
> Hi Richard,
>
> Whilst I agree this stuff is really ugly, is it practical to fix it
> for this case?

You can use:

  BQL_LOCK_GUARD();

which does all the recursive checking and clean-up and for free also
ensures you don't miss an unlock leg.

> Or was intent here to make a general comment on QEMU locking?
>
> Jonathan
>
>
>>=20
>>=20
>> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
