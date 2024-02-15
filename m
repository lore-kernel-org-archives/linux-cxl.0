Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9A1386AE
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025524; cv=none; b=F7ZBAVAZnoJ1zJk5pA/KABiyaIKsMN/TDeufDAbsonHAvBFNIQS553Bf5qar3XJCT7AwZrQrqiDx53Gnfpw5Xn8BWN3ztwR1FZy+lj12POMOImLP9AGp4WArtmXVa2a8EjPB87r5b/EL7f35QHW+gcONAZzidKYubD82t1mRc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025524; c=relaxed/simple;
	bh=mXxb8DS3o6Up5LwTuj+5zzUAJwedZeEjMZRRF9GsQzY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KVKILaVBOYt7In9tiGuzLoojfME9gYLVkCo0X7j5JqGvF+nWufQTlD4iUrJAllOLC7P6br5VTiB+t2kk+G85GW5CUOcGgt913gUiu+ILYlrMIglzPVTn2NbolxmmiR0UCmHAKqJTYrbVtm3MKrXPn+brlqoKBvavrBFU8b8+iBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bBF9XmJ7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBF9XmJ7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e0cc8d740cso1057924b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708025522; x=1708630322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J74btSBxazv6J2r+dLJAGzTw0cISGopBJUtERAZfl2s=;
        b=bBF9XmJ7NZcRo3lcVOUGEvu7Sz1cQrsXx+kF0WyF9K4LDRWGU+BuORUF2VIeF4NsR7
         qedHxKUhMV8yVfmmRCQLPprUvX3t+jTU6Mrm3R4q1YyVWpbeUgVOLNLJIXZCkzKpMTHS
         yqHIe+rU9myBkGdpt3vwVXrCq0PpcOi/ziknC9H1gAyPTMZ+NvKrgbYGqn+a1vXJNn4n
         BeA9Pv67L3zsqSSY+Z5PWGt80cZONL1d+NdWHGvH5jMrb0PM94HvitHiEmEdL2oUQXY7
         GJT3C9ZLLnXGNHBCPKXS8I7GAcLeH8wAWQ2uYobXwN4L4txj+LzeTJ+MtMaeUyG91zrp
         Sp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025522; x=1708630322;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J74btSBxazv6J2r+dLJAGzTw0cISGopBJUtERAZfl2s=;
        b=qPfTYjkdTSaez7mNRFqG50ydPXlHU+Cuh6/GE+dwio1qIj38nvasLEF3PLyZF9EJX2
         me3MBNuLIztXNqBaob0H1g2qAfF5Xbeq6qC4oTF3wn228lV3hzWyCXsEGitVh+h127mO
         aTOzT9W1yDt8+x84RlhEDuxc23SaE0LkulN0B3Cvld0h+swyDqw0iEx5XOZ5jJabARgK
         mgTRsizOoGuk6pKkC+JeR/7HthICgh+cUQUEemkdLXeBhaQwKcPU1wxJcWPQCJAVHAKt
         NvFLGk9244qkN0TsKzVPRGExLT6YEZM1gmtg2xfUO4mOQ3wiHx/4n2fdZbFhBft7AkYq
         wrnQ==
X-Gm-Message-State: AOJu0Yykv2xT2q8IA9e5BvkBnVkxgWjYgurHn8h4H012gknMVAFQraC7
	p15fDJ96lLqNWesJ+k5+s2x/mggq3UFUj/NkyELIdKhYuIqSCQHS+hGAkIV+BLs=
X-Google-Smtp-Source: AGHT+IFccsrWtc7EyQAUASxzlMRnbGMmXkZtPTQwZgipLpC3c7rV0pdb+m2i/RFsiyndMlD46m08ig==
X-Received: by 2002:a05:6a00:2344:b0:6e1:1144:b49d with SMTP id j4-20020a056a00234400b006e11144b49dmr3267868pfj.10.1708025521846;
        Thu, 15 Feb 2024 11:32:01 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id ka19-20020a056a00939300b006e050c8f22bsm1679320pfb.207.2024.02.15.11.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:32:01 -0800 (PST)
Message-ID: <8d7469f6-9858-41ba-8056-c6a2de15c422@linaro.org>
Date: Thu, 15 Feb 2024 09:31:58 -1000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
 <cde1076c-d4bc-4e2f-9319-9eb37d24eef5@linaro.org>
In-Reply-To: <cde1076c-d4bc-4e2f-9319-9eb37d24eef5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/24 09:21, Richard Henderson wrote:
> On 2/15/24 05:01, Jonathan Cameron wrote:
>> -static bool ptw_translate(PTETranslate *inout, hwaddr addr)
>> +static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
> 
> You do not need to pass in 'ra' here...
> 
>>       flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
>> -                              inout->ptw_idx, true, &inout->haddr, &full, 0);
>> +                              inout->ptw_idx, true, &inout->haddr, &full, ra);
> 
> ... because this                                 ^^^^
> indicates a non-fault probe.
> A return address is only required for a faulting probe to raise an exception.

Bah.  We can always recurse and hit the load case too.  So:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
>> -static inline uint32_t ptw_ldl(const PTETranslate *in)
>> +static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
>>  {
>>      if (likely(in->haddr)) {
>>          return ldl_p(in->haddr);
>>      }
>> -    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
>> +    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
>>  }
> 
> However the loads do require 'ra' for the io_recompile, as you saw from the backtrace.
> 
> 
> r~

