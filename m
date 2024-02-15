Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7889134CD3
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011973; cv=none; b=fM1pRIsnCHbCxV6I4sidFSbhBheRO2x0qOfgi9b9dcLMYywAjeeA7jqfxkZaVFbLqbmZaynEk8yiw0r/GOC1+WvguWMonpBWI/6WiZLSlV4rvoN3WHCX68qFptg20Inf3zQRcuQ1pt6OoSMeVvB3NHNU/ipD5G+9qWU3/QlCvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011973; c=relaxed/simple;
	bh=7wDLayBc65DhnVOEsLe/6UoDzv0OIt8elWGjCu+HNh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjI5++qSHwoXYXWbaYr0yiaGmWIdLweXzj5R7sat8LFkznfYYWCHhNQh2/UpSDBL+lXPshLTA0uhR6UGO/HSSdh17DxR+MZ+Uuq9x06GfyHb++WS+h5Z/Q+Hb6ne4eAGIPaFutUSBUlZHUJszUNOISQGNvuZOAoAvvn42kQgHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wbWdxh6s; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbWdxh6s"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51147d0abd1so1160038e87.1
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708011970; x=1708616770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4rBSgrX5YVivbEpiuFCj+73HjrmHSxalYOXOHIQ6N48=;
        b=wbWdxh6syK1lR+Z90UHZhpIEKzf7AiHaG4wxtJCjuMrzJ7e1XHAmWChpWF/INeDaVF
         UJgsWiGxAF2raNX5HN6GVdttYwvwgaeQ+mlaWp2TM8USZjAzSmCXcJOxyKkoijZRmBsV
         FISkw51C1Cz9n7CP8QsTCP7a2sWRPkN/jci1pUfJUzFM8wqzG6UrRW//BDdRajtY4Dr8
         U2wx0MFmspubUHYoeEoYUI4hoejnSpUk/Jd9i3YVqyZumqK2PFxeafcl7go5CyrldbP1
         sUnjaPpYY5JRWwzUEYhfTGq+e9wa4x/FItpB4TlMz1H0OcHYK0zVoXYfmxRJ2CfUSpOr
         LZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011970; x=1708616770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rBSgrX5YVivbEpiuFCj+73HjrmHSxalYOXOHIQ6N48=;
        b=vNf6NxoaaeVkfD49lbrf0Zitedi7M8VGO0dkFsLTBb5gqWOnwuhj5lNz8GKxjG/46o
         80kl5+sKmHIM4JWtKjt+IRyveEzEBK/iUdXm5nDQWONtAAA+TeXNNtmjCxPQ6u3f0zaH
         Ob8XGszq+BOHyr+1rKCVr1UxxUUilzsbchW9z8bqngs7NrIG0O/quFeAp9ChydPRbcF4
         RXtwKqGeMeZkmHQYcxyRFfmv1q+9epodFTnprZUrq84JSoHpZ/WCbeRjTHVsFta1rL4B
         JsrSy1ZzIEVIfo6RtZnxrnSjfops5BeEgYCFwA5e6mBk6diEfIvhzEdIEfGW9vS+A3gB
         airA==
X-Forwarded-Encrypted: i=1; AJvYcCX9U1zMd62OMLNPESEQ0tRiOpazmzscCE68POl63ITwo5GmkuWidoscUWsR1gQcuO2pypRNrP7Wzr6TQAN/HFCh7Y3nc5KjRCJa
X-Gm-Message-State: AOJu0YzAA1Wzztpjex8xAmqEQtL7CYLZ8ChSTG9mfVr3UhbEtlM7oWNI
	K/Y0X9J7wyQOpITpqj1hchokpd/Er8d5t2F2lGsEYyRvuSsMZoL9nBrBfbQC7jlONoOI9HXlrsf
	C1Ig6Xg6SB/L2rGvPt2JnZ5aaD1eyMt231Ixtrg==
X-Google-Smtp-Source: AGHT+IERVKkfp9+r3RR8EamMBaAVeDZmMBnIM3VV1wDnqIAEzDXRbv0S+MnmCkslT/Ub4r1yMGquQcLzMR7LQ3JKSSc=
X-Received: by 2002:ac2:5333:0:b0:511:4e6a:12e7 with SMTP id
 f19-20020ac25333000000b005114e6a12e7mr1675056lfh.58.1708011969851; Thu, 15
 Feb 2024 07:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215151804.2426-1-Jonathan.Cameron@huawei.com> <20240215151804.2426-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240215151804.2426-2-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 15:45:58 +0000
Message-ID: <CAFEAcA8YgJ-m6D6QZFsGCw9H0orF=DHKgs8t8Vaz=502+eXdcw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	richard.henderson@linaro.org, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:18, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> I'm far from confident this handling here is correct. Hence
> RFC.  In particular not sure on what locks I should hold for this
> to be even moderately safe.

> The function already appears to be inconsistent in what it returns
> as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> the previous value.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  target/arm/ptw.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 5eb3577bcd..37ddb4a4db 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -711,8 +711,38 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>      void *host = ptw->out_host;
>
>      if (unlikely(!host)) {
> -        fi->type = ARMFault_UnsuppAtomicUpdate;
> -        return 0;
> +        /* Can I do a load and store via the physical address */
> +
> +        bool locked = bql_locked();
> +        if (!locked) {
> +            bql_lock();
> +        }
> +        /* Page table in MMIO Memory Region */
> +        if (ptw->out_be) {
> +            old_val = cpu_to_be64(old_val);
> +            new_val = cpu_to_be64(new_val);
> +            cpu_physical_memory_read(ptw->out_phys, &cur_val, 8);

This is definitely wrong because it takes no account of
address spaces. You need to also account for ptw->out_space.
Compare what arm_ldq_ptw() does.

> +            if (cur_val == old_val) {
> +                cpu_physical_memory_write(ptw->out_phys, &new_val, 8);
> +                cur_val = be64_to_cpu(new_val);
> +            } else {
> +                cur_val = be64_to_cpu(cur_val);
> +            }
> +        } else {
> +            old_val = cpu_to_le64(old_val);
> +            new_val = cpu_to_le64(new_val);
> +            cpu_physical_memory_read(ptw->out_phys, &cur_val, 8);
> +            if (cur_val == old_val) {
> +                cpu_physical_memory_write(ptw->out_phys, &new_val, 8);
> +                cur_val = le64_to_cpu(new_val);
> +            } else {
> +                cur_val = le64_to_cpu(cur_val);
> +            }
> +        }
> +        if (!locked) {
> +            bql_unlock();
> +        }
> +        return cur_val;
>      }


thanks
-- PMM
