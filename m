Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D67134733
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011232; cv=none; b=X7TGZvZoGR0zz645QxybvdVOKkZMtzBOHY8OU7Srp7OR7zryKainFGObsM2F4ZFrNzG9z7riD9TFMCi3SIeoFRjo/YthIiVsjGtzW7eaGoYS624qmTqz0ifV0TKgSgNkUJLqQxzihntWFjVJ2Olra6M7rNs8zDdNK2d8xWog2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011232; c=relaxed/simple;
	bh=ucGt+8YK/F0QDJjNOL0xS78N5T6FMEx7h1hVi/kOjYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3/iMwlzlGfehw7eDGRkTQRKdn5yCpqn650f/aRd5DED4v61iOU3XN8CGZTbGCBaInGtIiYfnCdnOWtXmVtKWgPXrzDsBvNUojUXVq3YWMBA2WUzmpDg5d/LEkeOXTEaByH8aGL4AmsyzY3KnmKvEFaox8/cup2mXvhw9/f1vfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtIOCXmq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtIOCXmq"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3cf64f33b3so136119666b.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708011228; x=1708616028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiA5fxKEHs1HuarSxxPG+s1cSmN1+KDdrLBBwz4U2Tk=;
        b=VtIOCXmqaMDPGOQosH2vllw7nGifqmUFiWqHWw3un8ZiN3PGYkL3PX7Ctfp5fvcDkt
         0DWwQOvcwECt1oMqgjxlTlD3eZAu6UMRxbbeJ8A+71ryioqOUxxerYwyGNde0eI6YzKg
         l5lG0nmk23m+TsliMBlur+SmNN1fb46ihNjhIx27L0V3BiVkNtN6NCMBZSjUiuc/mDQM
         n+r+ifK95Mppvr1XVuYY3IYieHYVzZ1tTVgS1oVWpqg09y/pCir9oto/PnL3v9M92hm4
         hIm6riNr84RxyeMHuG1GxtGolMGQJkjkJxfdeoqenf2bA7IZCMOWSIlmG59RPKOTp2OV
         pVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011228; x=1708616028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiA5fxKEHs1HuarSxxPG+s1cSmN1+KDdrLBBwz4U2Tk=;
        b=V30zIxsRzUvU81BWWgkllhrCvlvaKL6qRP3lgcJYTStz0AGp5SEdlY7uDZgnFBSi4D
         HfSx+2OgcAZF/KNxdFUJD3ClM10t9hjKlShwArAU5BvjeQQNL//J0Dulh6eNW5jYqqbz
         PQpFUheV1d/Ln/qIgLlkY+N4KazGG+wJQUYL507AL9fll1xU8So/QHxDfxKYi43gvrUM
         lV2Q+H+1slSiCS9slo6nGnQnJ12M31X2JEVYVEMKi/M51CAZ66IAHA6uj3bJjPdAQvMB
         KkBYm46h+u3L8fD495MPcZlg8ANYjtjRQG6najeAoDojNvZJgS+mr7zfyqxSSf5MqM7K
         xpZQ==
X-Gm-Message-State: AOJu0YzlXcYEB31283oTFRJMR8yXyyWhfqF9jbYGWOGy1WkXu6hP1trk
	q8l8HwNfJYlZIKKI7huqI1XjUrLJDKr29eVeq7013GCdg14MDwoleKdzzM3qpc4=
X-Google-Smtp-Source: AGHT+IFeXaq29rbgD+Vi1PkfsSNtK04QWm6IerTb9I96DgkHoeOSMnsdizDAnrvYykJRDKZt1gtkYw==
X-Received: by 2002:a17:906:a88c:b0:a3d:b130:560f with SMTP id ha12-20020a170906a88c00b00a3db130560fmr688584ejb.13.1708011228659;
        Thu, 15 Feb 2024 07:33:48 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b00a3d81b90ffcsm661462ejb.218.2024.02.15.07.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:33:47 -0800 (PST)
Message-ID: <bdeb194e-28f6-4dda-bf85-bd1a0b983ecd@linaro.org>
Date: Thu, 15 Feb 2024 16:33:45 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be in
 mmio memory.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/2/24 16:01, Jonathan Cameron via wrote:
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
> 
> Useful part of bt
> 
> Peter identified this as being due to the BQL already being
> held when the page table walker encounters MMIO memory and attempts
> to take the lock again.  There are other examples of similar paths
> TCG, so this follows the approach taken in those of simply checking
> if the lock is already held and if it is, don't take it again.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   accel/tcg/cputlb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 047cd2cc0a..3b8d178707 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>                                  int mmu_idx, MMUAccessType type, uintptr_t ra)
>   {
>       MemoryRegionSection *section;
> +    bool locked = bql_locked();

Maybe clearer as:

        bool need_lock = !bql_locked();

>       MemoryRegion *mr;
>       hwaddr mr_offset;
>       MemTxAttrs attrs;
> @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
>       mr = section->mr;
>   
> -    bql_lock();
> +    if (!locked) {

if (unlikely(need_lock)) {

> +        bql_lock();
> +    }
>       ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>                             type, ra, mr, mr_offset);
> -    bql_unlock();
> +    if (!locked) {

Ditto.

> +        bql_unlock();
> +    }
>   
>       return ret;
>   }

