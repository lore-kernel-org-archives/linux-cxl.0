Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A33D6D
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024287; cv=none; b=BL11GTP/6kRlLcO8Ik4Ym5jKhzmirLIFFtg2oBs9AZBJu3daSjtNtEAb+CPJAlP/VW4omvbobdxQEDocw1r6RouInqrxdmOpGyfxuy+4falTZjVbMKkVFUTQ9JVYlzc8QjSUf/EOLtqdzkR69J8n8Zo9LT5bDb/lTyqJxYRoX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024287; c=relaxed/simple;
	bh=Kd2MPzvQ6eRT1TRiBSrDPcYmCxMTPpugMdgFcD9BlwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObhDf9NNZofs5P3CtrwW5Uo66zxWq2Sx0RnloneR6HcMjlqbjZLp+v0ocYqi+NovtWc8lw+UPvXUplB4okpDIRhdoZ6o9ZfGmDdTj30q+4yk0bX9+s6z710s8f3/3yCowqdMnqpjRjaR4N3Nh6MSZthPqQZ+E5c1XdI1xErccWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBKsIqzY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBKsIqzY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-298fe09f851so660537a91.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708024285; x=1708629085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFlCBzvtwCOVRNl3twRHbZHmzPTvnU4xWu2ISNExgbI=;
        b=DBKsIqzYxAGfrsfO0jDss7UPaS+zN/dKR7Q/UT8jgkiZvnIXnDggJIfGvBNPCGHJyZ
         lUqr3YQhqYFpvqa8N83rNnnPbomUBEYku/y2ve/ezY2ZGm7cuYbk19lBP9Qva6IliRI0
         429Ju4uDK0rJcanF5TNgpxeUNPholFe5JlUc15bJVV6JN9oZ/UYPYnJ3K2F2SY7paNN+
         VRkb9frZC5anl6o2pfzZ6YM1omEbMCC9NvddekQ/YKyrmJsD5tMLqfaD7an023bSrsvW
         2djU7qFX2EDTxlKu4AtcXGPx7NELwdN/12Ak4ukS1T/6OrsfFRKRIvxGUgR7hEbawEEk
         FSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024285; x=1708629085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFlCBzvtwCOVRNl3twRHbZHmzPTvnU4xWu2ISNExgbI=;
        b=n6XUCKjiaCdw2lcBiaDjdXcKgkS6ooPg4TPHgBQt2dyGWmYH5ISA35l4WKv629UAJ+
         rsg4s5XfJKEjAgpsDcDKoleKD8x9yETbz6fqSeYiVTUaM5FCptuaZxyg/ClYqBdVeWQp
         FVCCHGeVccqAn+T5LDXl08uGndxzWMTN+MTHdNhkMg600DPN/zXDYZ6jcqxr39YWjedh
         +PFT38phf1erhNm0Js3yuDEi72f2EGfdL6fY2w9653oksjXfQ1eBqqgsWmt6uhTC1CW2
         CvztpusROjCL6COZOYS0j66jFJG2XPFDqVGoxYl5P/H71KmqF5if1RmUtRnTN/h7PRPz
         an1Q==
X-Gm-Message-State: AOJu0YwzUUycHTinZEbam3TItv2RrVmOUgbbsktd9DJXLjLaYKc68oS6
	y48OukICcK0ezlOslUm866o2f8Wi3wAP4UvzCOOOytKJ8eVRbRxhJtYPsnxq/jk=
X-Google-Smtp-Source: AGHT+IFosHLOzk4ViGv8QCWH+Bff4Yl9/gs4yDNGIeyREt8jgtSy+1qwAXmMbaMwcgP0IxmxKFvbJA==
X-Received: by 2002:a17:90a:e617:b0:298:a03f:ecf7 with SMTP id j23-20020a17090ae61700b00298a03fecf7mr2987448pjy.38.1708024285145;
        Thu, 15 Feb 2024 11:11:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id se14-20020a17090b518e00b002967bc2c852sm3769428pjb.43.2024.02.15.11.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:11:24 -0800 (PST)
Message-ID: <11c4cd99-67e1-4a50-94e6-aee3f0b55230@linaro.org>
Date: Thu, 15 Feb 2024 09:11:21 -1000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/tcg: Set can_do_io at at start of lookup_tb_ptr
 helper
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 05:01, Jonathan Cameron wrote:
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
>   accel/tcg/cpu-exec.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 977576ca14..52239a441f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>       uint64_t cs_base;
>       uint32_t flags, cflags;
>   
> +    /*
> +     * By definition we've just finished a TB, so I/O is OK.
> +     * Avoid the possibility of calling cpu_io_recompile() if
> +     * a page table walk triggered by tb_lookup() calling
> +     * probe_access_internal() happens to touch an MMIO device.
> +     * The next TB, if we chain to it, will clear the flag again.
> +     */
> +    cpu->neg.can_do_io = true;

Yes, this mirrors what is done in cpu_loop_exit(), and I can see how get_page_addr_code() 
and the ptw within would require can_do_io set properly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
