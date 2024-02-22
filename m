Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36473F23
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636879; cv=none; b=NmDCBfVt8uqVTNM35e50eSl4O9FSFj9sWIxUx2MYP8cXk1QuAeGuBgd2tLkJssoFwmHrp0rB2Gz7KOEpY8O8oErD51uBh3xcuvDDpmBNfDr9jprRRSW/BxEsmuFcVm1uWPxWjypLmJIFjgo6jTaAg2CHtvWdNq9ydf8k+IXtaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636879; c=relaxed/simple;
	bh=kxeWsdX/bPTqQV2DoeWkgnE7s6IRxbwXFo8x66l7+kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGQndDTqa+DFgEpD2MOqNqrZr6IGSU680tZFOu/S/S7i5SdPa8r7v87BZRgCau8yGVq9e+TmpsTRetsAmdvGCDrzEaHQvcndh2yz91Jwjlksq7DCeLoQrn5pbgqSvantLVibDzV1D+AWHL7TeHliV5Tus8NdcOCZE6r0AlCIZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aV4hbrZ8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aV4hbrZ8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e435542d41so98818b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 13:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708636877; x=1709241677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCCh/F1oQ842Tcqwks1U7mp9nWMsI9vl+KYbrNtyEo0=;
        b=aV4hbrZ8nRds0eam0dIMVV2WWzsofmtFk09n9BPzhR9chpbknje5VdYMOisbmwqcJR
         7YeJGw9lQwzVRcDYQrVSFsDo4/WmCQSblWieJcLIgOY7/SNNa3g/i5lyOkDGuDDWWw11
         4+KiRvjgRP6a8EMcretq1B4YQy2Tn3O+r3eQvchPs5v0+pGOzcw8dALdnarkcd7dnobd
         BvzRWDO5DWqYiACaV6WD9HV1+j0wAt+RcMRKpSws8ElK465ZklpmSt2M7XLN7/Si88s7
         N/fQaDklB4m0wkPfTjEC77mNENd44pORNi/vFdexbpUT66jHXJqW7Yeup+OexsIIhUFz
         Cj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636877; x=1709241677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCCh/F1oQ842Tcqwks1U7mp9nWMsI9vl+KYbrNtyEo0=;
        b=hV5q/QtSooksAZv9rbHL0Ef8XClUsrKWltXF1aTY1J8fhFL6PaEGRhh293cywmtIpP
         jXmL4oJQo2x2ZRaOPh8o6SOyjhsRYgjniWHFbBQeMJ9rsnYNtJnivWInlLnV0DCm91Ty
         ft54llCOGhYRv9821dHXWMCoD8Dvy/4tpSSqumoifqcbAgbt63iU9q5X45uSlS0tmL1t
         nof9k/dUlY15jFqHqiw7yOuuk+QVO4SwFXpm1h3P6Eg/2Llw/pw9kGAJXE1AHjFLdcxx
         o9+E7IcW/N5bhhnAeJiCcBu1gHGz7xk7Dlgm/hgD/KAMDrMLWZoxT2vVWOLZNYxCxuaD
         VzBA==
X-Gm-Message-State: AOJu0YxUwo/j9iSAM2sKUBbJrcIwR/37ddo4fsTdCWakStMhcbfmQHd/
	WgvYNl+K9nKZG4Sm3DQo8aTMuY0/I07QcfRxue6DspvOH7FGKP7/YVe4FCdOBgM=
X-Google-Smtp-Source: AGHT+IGLGtlbicdXcwsgdLRpXtbOJ76WaGeiX1GM253/BpXCfZ9BUDz8+Z+ZarV1GpK9ZgWnuZfLAw==
X-Received: by 2002:a05:6a00:2d96:b0:6e4:8ea7:231d with SMTP id fb22-20020a056a002d9600b006e48ea7231dmr126338pfb.5.1708636877128;
        Thu, 22 Feb 2024 13:21:17 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm8206831pfb.74.2024.02.22.13.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 13:21:16 -0800 (PST)
Message-ID: <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
Date: Thu, 22 Feb 2024 11:21:12 -1000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 06:12, Jonathan Cameron wrote:
> I'm far from confident this handling here is correct. Hence
> RFC.  In particular not sure on what locks I should hold for this
> to be even moderately safe.
> 
> The function already appears to be inconsistent in what it returns
> as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> the previous value.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Thanks Peter for reviewing.
>   - Handle the address space as in arm_ldq_ptw() - I should have looked
>     at the code immediately above :(
>     The result ends up a little more convoluted than I'd like. Could factor
>     this block of code out perhaps. I'm also not sure on the fault type
>     that is appropriate here.
>   - Switch to 'need_lock' as per Philippe's feedback on the x86 fixes.
>     likely() doesn't seem appropriate here though.
>   
> target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 5eb3577bcd..ba1a27ca2b 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>       void *host = ptw->out_host;
>   
>       if (unlikely(!host)) {
> -        fi->type = ARMFault_UnsuppAtomicUpdate;
> -        return 0;
> +        /* Page table in MMIO Memory Region */
> +        CPUState *cs = env_cpu(env);
> +        MemTxAttrs attrs = {
> +            .space = ptw->out_space,
> +            .secure = arm_space_is_secure(ptw->out_space),
> +        };
> +        AddressSpace *as = arm_addressspace(cs, attrs);
> +        MemTxResult result = MEMTX_OK;
> +        bool need_lock = !bql_locked();
> +
> +        if (need_lock) {
> +            bql_lock();
> +        }
> +        if (ptw->out_be) {
> +            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
> +            if (unlikely(result != MEMTX_OK)) {
> +                fi->type = ARMFault_SyncExternalOnWalk;
> +                fi->ea = arm_extabort_type(result);
> +                if (need_lock) {
> +                    bql_unlock();
> +                }
> +                return old_val;
> +            }

Use BQL_LOCK_GUARD() and avoid all of the repeated unlocks at each return point.

You can merge all of the error paths, e.g.

     cur_val = (ptw->out_be
                ? address_space_ldq_be(as, ptw->out_phys, attrs, &result)
                : address_space_ldq_le(as, ptw->out_phys, attrs, &result));
     if (result == MEMTX_OK && cur_val == old_val) {
         if (ptw->out_be) {
             address_space_stq_be(as, ptw->out_phys, new_val, attrs, &result);
         } else {
             address_space_stq_le(as, ptw->out_phys, new_val, attrs, &result);
         }
     }
     if (unlikely(result != MEMTX_OK)) {
         fi->type = ...
         return old_val;
     }
     return cur_val;



r~
