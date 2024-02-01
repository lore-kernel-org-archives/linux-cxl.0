Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACB6217A
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807265; cv=none; b=ZcwWbMD/niCvkED4DW6jvDuYEkt970EG0LNbcgl+UrlGd0Xjbr5AbctJ8oBvY1dlnaM1GZ/VZqHKBoenXGkrlvwolJ1qD9Fq5VyfFjXS5o2AkHEVT/70NpEszy4XcN6oWrgPUg8R0JoLRUxoaR3c5MT2Yn/FFYk/tirCIG14Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807265; c=relaxed/simple;
	bh=9lcs9KY1YfoeYmOzyvbqbGjqiLppkJlXqLBWULoGILM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4Rx1wgwpSY3yJcGq3LQMoSwXSmP93pNct4VWBgpOXLaxiHINVGnmCCgVfltih3hwyfKgWyQggPUB8C2k+aKZVWKfflfCgrydrzBU8RH0nlYR88iAIC/y69D0S3OfJiQm8B6RDD3iSC+n10IJGv0rAEddrfmzQzd87X+stIeh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jErDthI1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jErDthI1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so2112332a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706807262; x=1707412062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lcs9KY1YfoeYmOzyvbqbGjqiLppkJlXqLBWULoGILM=;
        b=jErDthI1Tz4SF9tIjLezIk1BjLUTtg8lFoF5fz8Y8gWkclXzwIkC1Wq5S22QPPc5hv
         FE7hZj2Wyc0o/IRjUEPJ2zZf9cz06CIQR1kBOlXwEFKeyNBkGm3ja5pA9ztsl0wB02Ys
         GB8Z9SBL34e7oltZwgiB5BXsll4qJIK7mopdQiGVTr0b1NNb5Ns+TkQkZyJkd7hRSnRF
         /rKJJ6yYl7TyO1GUu2joW1FVgH/39kVrG1w2nBcp19r9LfiIiGAkFUGvgAHxhC4Rfdyl
         A4h+N9ta4sp7xSvm2ugEJZCmRX2CEYp1g+3nKbWr00M4I2n7OAJenvmheM+qMGd2OJtk
         S3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807262; x=1707412062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lcs9KY1YfoeYmOzyvbqbGjqiLppkJlXqLBWULoGILM=;
        b=RvOZWIAYbUdLp4sVKdmzM6puHovPK79j29cX2osuAnn/Nwe7/Nz9s+/w0YetY2raAB
         Pro1H1lY4ezWMsxb6/xcPmadIirTolODsYGCylpUGKtxYF06TwYjoyUd2X4nAbMSY4Fq
         JJ4ahjIa4uwBpztbWSJZO6HL1WG2n6hBoUVPFVHYI4Tkqk0xegS1G0lHHSgcoLHcpT0i
         6YBh8/6gn77RRwcmJhtrEk7Hy2fu1TlIJ8bBEUhc8J2T+RbAueZEe24AXiBeZBThDwHK
         kaCQGoOMpbVYOxx6gdjaiZI2AqSVu+0V3G/RH+ZAmzTk7rLQhKwd+y1hW3WN5gI+Earz
         0aGQ==
X-Gm-Message-State: AOJu0YxQVzgphgL72oSZfw+iIcO2v1NNuNeF4lmMIEJI9Y8irEp86ulg
	1Ln9c8kuXvoAjzxuxCXXGlh5+jnSu8bOdtMxj8oP7g0xmvumCth/d2cuxUY174jptkw/Gyyb+7m
	SLroh42Udw1tkbNvdUg9d9iKdScfwGrKD4Ux0Fw==
X-Google-Smtp-Source: AGHT+IHt06bMSqT1NVCIus7K30YakD+fbJJIPZUxSQFaEHhuVTqXkt4StlPgv7SxsER8mqJfyskIifU1aspbLYYtig4=
X-Received: by 2002:a50:8e43:0:b0:55f:5197:6314 with SMTP id
 3-20020a508e43000000b0055f51976314mr5076259edx.18.1706807262047; Thu, 01 Feb
 2024 09:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171233.00002a2e@Huawei.com> <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com> <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com> <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org> <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org> <ZbvPGV0a3xOMsAMG@memverge.com>
In-Reply-To: <ZbvPGV0a3xOMsAMG@memverge.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 17:07:31 +0000
Message-ID: <CAFEAcA8oLkpSsAabYNxXQTEuJvG93xJoP3yxv0JqJfH4udmNbw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Gregory Price <gregory.price@memverge.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sajjan Rao <sajjanr@gmail.com>, 
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Feb 2024 at 17:04, Gregory Price <gregory.price@memverge.com> wro=
te:
>
> On Thu, Feb 01, 2024 at 04:45:30PM +0000, Alex Benn=C3=A9e wrote:

> > No thats different - we are actually writing to the MMIO region here.
> > But the fact we hit cpu_abort because we can't find the TB we are
> > executing is a little problematic.
> >
> > Does ra properly point to the code buffer here?
> >
>
> What if the code block is ALSO in CXL (MMIO)? :D

In that case the TB is supposed to be a single insn,
so the insn will by definition be the last one in its
TB, and IO should be OK for it -- so can_do_io ought
to be true and we shouldn't get into the io_recompile.

-- PMM
