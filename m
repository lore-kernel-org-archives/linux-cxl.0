Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA213956C
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025434; cv=none; b=YC49OvlRoovn/BQm06BDtZODT2g06CSurHCKZ9GKxSvbxZTcVt0ALaRtVsqDWaL4jpseuBQUeE6ow6RW6F1pFHfcQ2dlE2sDFKBvRVIev1agdaSfqupFGc0AnJHQKKkOb0XWJQwXElUneEQmBHEjl+KakeC106gYqKCNAuYZ9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025434; c=relaxed/simple;
	bh=cbhfuPCZ3q1FpfIfaW63RpfPa873fUweyl20XsQ7AsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NExe1SYMBQup5NV2gCj5KD0RcVB8al8SipCBgIvxzO13TvC7QeBpPnrkWESi/UNz43NFWDL/GFiv1avl5kTE+C+KbzUqgHAC6ZThoohXlUbTfoUH5p92T+fweLHVGzJpNWqlR4narJdxuWxilyO4Y25ZgZmVXkBjACZDWrF+eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xCWEons3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCWEons3"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1139507a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708025432; x=1708630232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3jH2JS8Icb9oqLzaU0hfXRD5zoULe7nghMNl44ps/I=;
        b=xCWEons3NF5BQu829IFB2I4dYumM7BOooLER+PJvKRVjFkcgHE9/aKgH/iQqx2k9Ly
         P7TgXMZqLmAmjOKhMkL6gfkwHJaN6o16Vklj/l/r7d3ZL5uO0ol5g7Jqi6neCuBBKOxZ
         Jl0yWdJChNd/TmjvOl88o4Bz7NMaKEHBuXl/NIPs2Nj+C6zGbjN24bhDmVTpEJ3u+g6Y
         vSgnKReUhbA0GdAdm3c2phiHFirIpVay98caKeRJ1XNIb1jp/ldSfCHK6dYdM91j2jFK
         oHAzk3GSkusRgXlks6OcpL/8cWssuwjH6/byFaI+YlZYBWxEH8Ty9+ws+mNzWtvrw3AR
         siuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025432; x=1708630232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3jH2JS8Icb9oqLzaU0hfXRD5zoULe7nghMNl44ps/I=;
        b=HcpHsmN3zvEuaDyZLwj1C2GAWoy6rZrKOahQs6P2sBQOCifF3xNAKrM5fvzwUStep/
         A7cdsHG+BoKW0nDq1XIoMjSHWKloEt7bxyun00w4YJLHrLZs/oKlAa7Okhx6RPMRL1eb
         y7ITCI/upIRb5IiOc68h/n1YOxN8p4XZLtkqE7xh3fdZ3fUrGXmpARWbeHgFSEMcHMPM
         q/+01ZLGg7mSG1JEp4HHTMBsgIIbF3R/P8GZ5QNTkbVHNA8onWNtpWjvFi+dkhkUbgrg
         KSLjgJUS0PPxn01z8drj/fYXBSeXqk8QgVFy5MZY6rZr9cTZwTFtgFQDYUzIMMFtBipS
         Z5qw==
X-Gm-Message-State: AOJu0YwUscJWKlA+1PRxTn7/kAdDrMOMQUllLDnmxSiiWLq4cxIn/aNd
	JB6NHJaqE+l6j7eGfgy96xOs6lDF86xNOfCk5DuWZXewop+wokbhBc2yw5ay4i4=
X-Google-Smtp-Source: AGHT+IEDsdRsj/u65YHtSoPM/wJajiqBSJQADzhJh3bY129+226WIkRAHHQKkL+Cl/akOsvHw4QzKA==
X-Received: by 2002:a05:6a21:164e:b0:19e:a1a2:4c53 with SMTP id no14-20020a056a21164e00b0019ea1a24c53mr2996223pzb.1.1708025432121;
        Thu, 15 Feb 2024 11:30:32 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id ka19-20020a056a00939300b006e050c8f22bsm1679320pfb.207.2024.02.15.11.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:30:31 -0800 (PST)
Message-ID: <4b00b67d-cb3c-4173-bb7f-1ae68cdfbada@linaro.org>
Date: Thu, 15 Feb 2024 09:30:27 -1000
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
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 05:01, Jonathan Cameron wrote:
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
>       MemoryRegion *mr;
>       hwaddr mr_offset;
>       MemTxAttrs attrs;
> @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
>       mr = section->mr;
>   
> -    bql_lock();
> +    if (!locked) {
> +        bql_lock();
> +    }
>       ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>                             type, ra, mr, mr_offset);
> -    bql_unlock();
> +    if (!locked) {
> +        bql_unlock();
> +    }

On top of other comments, I'm never keen on this type of test/lock/test/unlock.  When this 
kind of thing is encountered, it means we should have been using a recursive lock in the 
first place.


r~
