Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC3213EC1
	for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431463; cv=none; b=qpxNpxE1oWj5J3DAtNAms36u7Lfd0gXfR38dJh92XuBRt8Bq+OOE/SXl4fnsZAQOETlJxcECWMZpcG5+IK41NHvC4izECCOvGQ13a7l8oIfTfstL9PRTj+vOh8W3RZRRWwpKNnWzfbRn5XTuiERDINHsDpPONgRjr/Kmd0Xor3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431463; c=relaxed/simple;
	bh=GNTrVMRikj6cHWlVGWPrZEwP+h5BniWzUVnxxHOSCUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrGwCAW/z5N/kveTXEVhy9bCgrV0pyChOSu3gz81szvKjk5EJmZsUcOf5FsTcvTr+KZ+xkDHeWc/PeL6FJNjg4kmqNvPTq8kAmNRVNtf92HBb/dJ1zRLdNiREl058PiGATqyPqkSDY0OYIXdlADhZ0NKRetdhPRfDBlOIY3v+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJruT6to; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJruT6to"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so69180761fa.0
        for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731431459; x=1732036259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lTrFyt7xvaBjA0opqp0jNJBxCdnRTPvW3DdM/vMYjkQ=;
        b=lJruT6totKBnRFumYMShG72TgvxvRkb+6mUH9j+a3pnTFcApobO9hDrw0Xa+i19GFA
         9JIjsA9l3qNRp9ZxlvgCgUoF7FQtGsfdDPQ8wP+xMICkffwOgvat8Um2E7YEcCEIcjlw
         VT2KSzk1xMaq+CI4lZD7UIIgY27UJadxTk4MGPMxuHcTAFibxnLMla7B0jUVDfx5Yazb
         0xnLcSmpXEM1g3CjkLadgWFLamRJP6cnjjSbC3Mh5IAXkxzogUHGRQtFLNL8lOo68NDx
         vWQt9i/zW4vZB2OOL2V5FQPmAWkOQqLWsNhtpmheLv1kTn3o6egnuuJY1Z96H0LOt25M
         mDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431459; x=1732036259;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTrFyt7xvaBjA0opqp0jNJBxCdnRTPvW3DdM/vMYjkQ=;
        b=BZEciPCbD0nC8XU4WK26ghB83BoeJVP6YlyIqewB/h6Mv55R8QC3Msi/llHbebGmoA
         WJrRhvyBtw5/KoPbxQebZUHN03YU+xDzjNzEth/dJ21g3vpfOOgGT4QnhmnIu/tEut1A
         jS8n+4rtpOMPAuoaTj4AK2Lm6Pt9tMo6nVGlhJMtwhbq0Nn3+JoDB0XnEOCu1eSpem3G
         VIxvNjw2/5YXIilfAgodUIBMOCaoi6nFYJrBQ2X9ud2z/Nx0kawqJ4OpRUTyRXcOdymG
         r1XK9S5X2A3mWBsV+y2WZtxbs2OM4yxCLIoibo31NAqCUCyUCSojRYjVkMwBgcKgWjdp
         rl2g==
X-Forwarded-Encrypted: i=1; AJvYcCXCsPxQph9HCBfwPlwOn69ppIykodx7wAUxQZK2dc0BRK5h+GOBBvtqY7+bzIie+seniX6n3MsBta0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tu7wBWQTEp9DvgwMGn4fdzkgFkafyzG8EDJkgGaOISCZMPJa
	bRt9vpaSzdSgfUxyCohGxdwrg2k9kqJxR4XCYH4rPeCiE9JRvxSjhxU0LnKjwM8=
X-Google-Smtp-Source: AGHT+IEZJkkHnFzx7/g8tIsfc7KeUAIB+t5nT3U1cUtHe95euLU0cyf6R/UfJIu5a6PhAo9IOj1S6g==
X-Received: by 2002:a05:651c:1551:b0:2fb:2a96:37fd with SMTP id 38308e7fff4ca-2ff2028a91cmr133928431fa.29.1731431458917;
        Tue, 12 Nov 2024 09:10:58 -0800 (PST)
Received: from [192.168.210.26] (83.11.2.232.ipv4.supernova.orange.pl. [83.11.2.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def87bsm749844566b.143.2024.11.12.09.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:10:58 -0800 (PST)
Message-ID: <90513bfa-0888-44fe-8cd0-7b2e7518a41f@linaro.org>
Date: Tue, 12 Nov 2024 18:10:56 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH v2 1/1] hw/arm/sbsa-ref: Support CXL Host
 Bridge & CFMW
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: devel@edk2.groups.io, ardb+tianocore@kernel.org,
 quic_llindhol@quicinc.com, peter.maydell@linaro.org,
 chenbaozi@phytium.com.cn, linux-cxl@vger.kernel.org,
 asa-dev@op-lists.linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241105104346.417102-1-wangyuquan1236@phytium.com.cn>
 <20241105104346.417102-2-wangyuquan1236@phytium.com.cn>
 <20241107120457.00006024@Huawei.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241107120457.00006024@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 7.11.2024 o 13:04, Jonathan Cameron pisze:
> On Tue,  5 Nov 2024 18:43:46 +0800
> "Yuquan Wang"<wangyuquan1236@phytium.com.cn> wrote:
> 
>> This creates a default pxb-cxl (bus_nr=0xc0) bridge with two
>> cxl root ports on sbsa-ref. And the memory layout places 64K
>> space for the cxl host bridge register regions(CHBCR) in the
>> sbsa-ref memmap.
>>
>> In addition, this support indepentent mmio32(32M) & mmio64(1M)
>> space for cxl components.

> Those are too small.  Might work today but not sustainable.
> 
> I'm a bit surprised it was this simple to move the MMIO Space away
> from what is normally done for PXBs.
> I think it might work because the GPEX memory windows are effectively
> unlimited in size but I'd like some more eyes on this from people
> familiar with how all that works and whether there might be some
> corner cases that you haven't seen yet.

I see the same problem as with multiple PCIe buses (for NUMA systems):

pci 0000:c0:00.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0000:c0:00.0: bridge window [io  size 0x1000]: failed to assign
pci 0000:c0:01.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0000:c0:01.0: bridge window [io  size 0x1000]: failed to assign

I do not know how it looks on real hardware (all my systems have one
PCIe bus) but shouldn't each host bridge have own separate resource
windows for config space, buses, mmio etc.?

Now we squeeze all pcie buses as pcie-pxb devices and this patch adds
cxl to the combo.
