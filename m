Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0B13248C
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009894; cv=none; b=drWuGIUQ2ctJWRVM2wGxGsE5QCcCP1TKM+txilA2f717n5z9Sz0fwmrn9ksDUp5BUQ8k4NJBui/FRELU6DQFOGMMQmd9s9NzuRCnGlQWp5IFrXckt/cRunQpmJL5zEsJUgigq3uiNNZyNDTdRK96AVC9y3fqMlCfbbsUqKKB7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009894; c=relaxed/simple;
	bh=oKqbNPhdGYvbgO12Q2lmhwpyNc8Jy3i/w6dQIIuhzNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6qA0hkdgxNSNq9wgKdOq8CfJvCGfqM2m0JlwwmUlry31QYy+1zGI65umLdKsJtzYn/km8S5mZIGs30jBugeSPZPu0vNRJD0hicPsbjxEXvQevZl7QvXunB0Rc+WxpZku8L1plKbEDsClsX5pKpF/HahjlV0scRMjiSGtVAeR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXCNrqK1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXCNrqK1"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d10f52e7d8so10529661fa.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708009889; x=1708614689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pNghoLPXthAQrjQvMbiLtG5ZZFo5ifcr0c5D+WQ9IrY=;
        b=mXCNrqK1cBbcTUfmYpr2I/jHug+iHERpXtaRkaEJ4Mb6veU5g0Gl7IvIZFp84rBxIA
         Yunltpi01yNm0t61t4j2P1xYpBTvmlwG5/jtU28BJ8lBL2jtawKpOLT8NyrOdcfvYMBZ
         hOP+XawqkXW7RSY+yzaScxIO94lvQ6tT2zIn+++ICA/TuhTf/1CQzHb+nHA9Xsim4rDT
         EV9Y24rhW/FNsh8IQcnsfwaODwVNAAFrkHKP4WfelLQrNbAgaEK1nv4lIG6AWKNscTeh
         mtE9FmFc54PHUbtPSiT9NWw2dF14IgMcbT4mC2Nd4rwoL4uqzuqX6VT1wrdwk0vSYp08
         tzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009889; x=1708614689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNghoLPXthAQrjQvMbiLtG5ZZFo5ifcr0c5D+WQ9IrY=;
        b=CUzIb5OJ7zlE89BGV4MaKgOW3CmfOiBUeziky1Zxzjk7xXoSDa+vjN47nhyVKBw2sX
         3AO1wpqIEsdKdAmFpHNRnD2B4WpMg4lZqz6LUGUneWY2i0EYBs2iDKqBG5LBB0/vKcSA
         b1jVhb6gTPIgkb2m/dOTbKjyOLBfEcTOLrlKvodwWe/wd9HSVnwpztHB604z8CU62elc
         ffK4ADhadXevV2556wY1KWSZSl+t0Nw/gAMA644Hfvjaf//JbBV771iTFKUhCMiuGmka
         yMxnlzOMQJD2eHLxx6nVdRSfdPFp7Q33NK3Xt71jqDDN0ECu27J2U2mpHBrX7sF6AmoE
         3UBg==
X-Forwarded-Encrypted: i=1; AJvYcCVEBejwR7RSsG5vLVB8ulpAuQETIUMmT09rtkvp/RaxWryRn/t/iD0r+eO9/GwHfAtmxmDplPyscQWUyZ7nbbCHfcHKqGduEZgW
X-Gm-Message-State: AOJu0YwGeJ1kZz0wKqxvj8TIVfoWhY+daGCsK2TazOxuVHxMbh9NTVuC
	OOoDOpr1H9uDELkjXkTs3kQhAqF4QnQXu7Sc+o78G3k7RgnRFNyZRwaBF3wSh37RYNEy0FSD0wY
	xWM/bOceUKt1B8JZhOdpFtWiEc3Am594mlVSNqg==
X-Google-Smtp-Source: AGHT+IHy5JjuzhTnefD6NdS9AlGh/MuVdt6RKKZLJbVCqOvz+9XRFMxLPEPH9KEAd9J83uMFjcO5Q6wcrJO/OW8gGMA=
X-Received: by 2002:a2e:a98e:0:b0:2d0:de71:935c with SMTP id
 x14-20020a2ea98e000000b002d0de71935cmr2182793ljq.0.1708009889242; Thu, 15 Feb
 2024 07:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com> <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 15:11:17 +0000
Message-ID: <CAFEAcA-_z8FWxXRdGVdk7u5rgOMOEnfSLokdx6_ocyObzPF8bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
	richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:02, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> From: Peter Maydell <peter.maydell@linaro.org>
>
> Peter posted this in the thread trying to fix x86 TCG handling
> of page tables in MMIO space (specifically emulated CXL interleaved memory)
> https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t
>
> Peter, are you happy to give your SoB on this one?
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  accel/tcg/cpu-exec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 977576ca14..52239a441f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      uint64_t cs_base;
>      uint32_t flags, cflags;
>
> +    /*
> +     * By definition we've just finished a TB, so I/O is OK.
> +     * Avoid the possibility of calling cpu_io_recompile() if
> +     * a page table walk triggered by tb_lookup() calling
> +     * probe_access_internal() happens to touch an MMIO device.
> +     * The next TB, if we chain to it, will clear the flag again.
> +     */
> +    cpu->neg.can_do_io = true;
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>
>      cflags = curr_cflags(cpu);
> --

Happy to provide a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

but I'd appreciate RTH's review to confirm this is the right
way to deal with the problem.

thanks
-- PMM
