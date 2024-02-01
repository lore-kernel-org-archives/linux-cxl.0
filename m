Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EE84FA1
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810685; cv=none; b=e2/sDXqcoBBQ3EuEuLAybyx8c+oyBMSolngCoedgcA18cfrpMMi8Hgg/0fAjJ8+luDyC/RoLkqcC332kmFklCcgmnW8798UXNw9tymlpnkgJBJemG+m2CY7kgq9AWhx8NONKyh1xuOyKFN5Tmnxs8eotOzEqgkgFl0QbSpNjjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810685; c=relaxed/simple;
	bh=YqAoSinQEkGWAWiWBJ41QVfQJJjc7pEKu8/NgCy3XOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvsTvoTMu3cMR4fBtXBTSwL3kvvUvLrFl3PHcd1n20W/oqZgnKekq9XIGbxZa5KRKPJLGFQHbceJIkwSyl61fq4aCIF+T7VNSYpAsGSBRSMpQ+n8v21sM5rMRpuX+BmAazuybrjglnWLNpFx59HatS53ZVCu1xNU/YIrnWUa5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rddtb9/b; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rddtb9/b"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f03ede12cso1635684a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706810678; x=1707415478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP1wbre1TKg8XYIERNLlFsNP6c4mIeB0Ldh6ArJkWqA=;
        b=rddtb9/bAG9FCxEYG58LIa0Av3TiP6hQXw7secbbxigOC6l20G9Oz6urvnXXBF8URv
         wHlBVr4BXuqDobZ9Zjdqa3aqpy/+hEEH5u0/eNcgNGBTMa4fDYnDBhByAqKHheTxipTV
         3tN7D4Ck2BmF70MnawpIA+gAzV9DyLHdoWAzHU7mLTfhJJ2rtOqjpxoHpqUBQt5LC7BZ
         0OvD10rXBZnusfJ1wB5Mo+dezIh/RV+urjpNF040pBmFXsOXKtrYoj1GeBWnxPx1qhPh
         VrF9NFxO8R6tsvickDpw/w5/Jd7oKxE6pqliQ00cjhZLXyi++YN9lqlSeZHsJaDCfHQy
         bZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810678; x=1707415478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP1wbre1TKg8XYIERNLlFsNP6c4mIeB0Ldh6ArJkWqA=;
        b=LTvtdUx7Ua35PXD2MoUYzY0d0fCgXDqI2p43KVlQ8uBIdDch5CXSjtJueVWn9akOtM
         /EA8SGJkriAA64x++FnrCtgA70pa282G/uun72BWwEXgGOrau2v/GqsklAbrV4M7s9aX
         h4MyVNYzNdJGzBzrLaYlUY4gpfe0iIljtAlqBNOpzW9+VOo0RBcq4IV830jtZpcnDF8M
         cGWs/aiQUXhHUXvBwW9n19g3c8WlY2U0hDPEk0iL7oR+d8YrdR+P81y0po7qlA9zO416
         I5lqCRQUkJhePsYFs4UmZT9d/79kYUveyPj1UsF6li8nJ0Ssq0iLlA8JM74RX/G5v/zc
         IwnA==
X-Gm-Message-State: AOJu0YwnBTWNqHMTuOc2eLvfO87Ib/bWgHL4oOHfkeDSqpbmbBKQdj0d
	Q+tGUvbQ3TS1WKGx0Wm11Wb1aIAYF2r/paf2pCDBiYR1QDox2HkZnU+xalKEb7ApEWb1qZt5ghK
	ckEZwIYNbPgG9iIY1FtOVWm4LyIUXNwcUfC0zwT+7URTL5jHM
X-Google-Smtp-Source: AGHT+IGzy1N72I2rrCXG/4KcOL+tTuBhKhzU4Dn2aVeMwt1jgyd54zIHxLMa8oKrJV9epVOmokiWm0YaKX3KPZFh+DY=
X-Received: by 2002:a50:fe83:0:b0:55f:e35e:137c with SMTP id
 d3-20020a50fe83000000b0055fe35e137cmr173322edt.25.1706810677883; Thu, 01 Feb
 2024 10:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com> <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com> <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com> <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com> <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org> <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
In-Reply-To: <87r0hwjdvl.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 18:04:26 +0000
Message-ID: <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sajjan Rao <sajjanr@gmail.com>, 
	Gregory Price <gregory.price@memverge.com>, 
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Feb 2024 at 17:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> >> > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D2=
3937, val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../ac=
cel/tcg/cputlb.c:2853
> >> > #22 0x00007fffa9107c63 in code_gen_buffer ()
> >>
> >> No thats different - we are actually writing to the MMIO region here.
> >> But the fact we hit cpu_abort because we can't find the TB we are
> >> executing is a little problematic.
> >>
> >> Does ra properly point to the code buffer here?
> >
> > Err.  How would I tell?
>
> (gdb) p/x 140736029817822
> $1 =3D 0x7fffa9107bde
>
> seems off because code_gen_buffer starts at 0x00007fffa9107c63

The code_gen_buffer doesn't *start* at 0x00007fffa9107c63 --
that is our return address into it, which is to say it's just
after the call insn to the do_st8_mmu helper. The 'ra' argument
to the helper function is going to be a number slightly lower
than that, because it points within the main lump of generated
code for the TB, whereas the helper call is done as part of
an out-of-line lump of common code at the end of the TB.

The 'ra' here is fine -- the problem is that we don't
pass it all the way down the callstack and instead end
up using 0 as a 'ra' within the ptw code.

-- PMM
