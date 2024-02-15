Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6BB137C22
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011095; cv=none; b=dBkINbtMx+b8t/lXNMcSfTZyDd2qSpE2dbOUyg7lyUrQ6DTmwdXbtwalc7JQ07U6p8SS0N5WIprZlhPxMZA+IJes2vcggLqRAqsirMR/+QnN4hzc4IYJ+jFEyS7SDxfKkv3WLtRnjJeG+viDdSKHO1g5HKbx1981I9MI5K1GPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011095; c=relaxed/simple;
	bh=39YyAmLVSrEuyPDYBzSQeogrtcd6ybU2iIc3SqBtvfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q53mlmo7zB8fwXiSeFvr0YOVvYP66TxC5+0NJrQrV+9kk5EXrGwAgG+LGLJJ3kAt1CNMgMKj7DsJY5vPgsSaGPbRjl2abGCJiaY8g39hmB7wQEiBqetLMDNA5cknU8lV+w5Bo6jo1ei63qYi33uD8nq88blEpqrQn88h4Mbu50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uwbOb9hy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwbOb9hy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d07ee22eeso395306f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708011092; x=1708615892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcwqVsCa+Ohf5b0UP6zNfJGfZs35k/9ldYEB3aIfx3o=;
        b=uwbOb9hyeZigi8/wMUsX78vo4NdH9jH6IW/MTbNQAlgBCWqjtrQXb0upvib21PTqMO
         npXVuVmYHPHw3cfxul1jS5eFyHa0T5F9GiOjjgiREhixVOrLAhg+6IZQ2+/F8MPVRysU
         znxkFAqvVQn2bK5uE+6CB8wSh7VVeTFh12e9T66cmLlFGhjqO/0qwrhHEJ/vBFg4E6YO
         5saMjriSNuQNVEj8n7Xl6gHPTOlMFJ65VnfVABTm5B1ZI86adtNbh16r2gn23ae8pHaK
         Td2YP2ONGCMf5U0ZkqQa6zh7t/gEBAM+eMc++4XY6Acdh4b7/ju/6qzseHzZ62VEOp2f
         1gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011092; x=1708615892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcwqVsCa+Ohf5b0UP6zNfJGfZs35k/9ldYEB3aIfx3o=;
        b=StQJ2vXZKL4Ta0E5w+mG1ZRYD1AGh37PWXq51eIOxHccJZSE6NT2Uy9LYwrMWq3zJ7
         dQlxk4+s/bCA9/R42zUKHF3vi3zLgLVm361/R0mlQYD5oq4140npLmjnRZDrrMoUkz8K
         Bz8xXnlZ8v4qq0f4WMcLOWrmh0JbMcK/6S3FCunq0N7B/kVm5g0DPfQDoZIOywt0Bnx2
         MXiqksdeICNqOMhIRYTGnWzg8MxiKwvgRbbporsKfuQ88O6KFQlaBqgoHVCiN+qnwn3W
         N5qksIgLJ0LDNMfoaGHAWhWezYNdkT3Q7NXgMZOfbn7DPLy4wOHFUG7hkGn3zz8GjOkU
         KMug==
X-Gm-Message-State: AOJu0YwWZ2XA5CcF27AWXnx7OCMkUhV/HE0kQhki475X8pC17fprWIaW
	BXaTGxYY8Sgnpye14F5HCGcr1TrBbtAr2yWb1I9JdPzibNQT8jXRqHfmpyKS3Cw+POIL88N4MMO
	4Ot0=
X-Google-Smtp-Source: AGHT+IGlI9tJMw+FXdsS6jyMwLgXirQaxJhBNIvJwkdDzDeSqiypXYg/w+5dR4cwMq85ZbeOAzYL9g==
X-Received: by 2002:adf:f9c5:0:b0:33d:14e8:70e2 with SMTP id w5-20020adff9c5000000b0033d14e870e2mr173303wrr.53.1708011091655;
        Thu, 15 Feb 2024 07:31:31 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b0033d14455c99sm408546wrb.101.2024.02.15.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:31:30 -0800 (PST)
Message-ID: <5b53790b-8f94-4b21-b1da-e7f278af0dd7@linaro.org>
Date: Thu, 15 Feb 2024 16:31:26 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
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
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/2/24 16:01, Jonathan Cameron via wrote:
> From: Gregory Price <gregory.price@memverge.com>
> 
> CXL emulation of interleave requires read and write hooks due to
> requirement for subpage granularity. The Linux kernel stack now enables
> using this memory as conventional memory in a separate NUMA node. If a
> process is deliberately forced to run from that node
> $ numactl --membind=1 ls
> the page table walk on i386 fails.
> 
> Useful part of backtrace:
> 
>      (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
>      at ../../cpu-target.c:359
>      (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
>      at ../../accel/tcg/cputlb.c:1339
>      (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
>      (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
>      (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
>      at ../../accel/tcg/ldst_common.c.inc:301
>      at ../../target/i386/tcg/sysemu/excp_helper.c:173
>      (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
>      at ../../target/i386/tcg/sysemu/excp_helper.c:578
>      (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> 
> Avoid this by plumbing the address all the way down from
> x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
> which provide it to probe_access_full() which already handles MMIO accesses.
> 

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> ---
> Patch posted in reply to thread:
> https://lore.kernel.org/qemu-devel/ZbvpSaOXzZkqDd6c@memverge.com/
> 
> I checked Gregory was fine with me adding Sign-off / author via the CXL discord.
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
>   1 file changed, 30 insertions(+), 27 deletions(-)

