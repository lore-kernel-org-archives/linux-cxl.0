Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3489136983
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024917; cv=none; b=KBOLgNxn9W6Dq4tkdXhvMaysXCrIijXulTFtQ32xSz+Dp+klS9UyuJdRuiRkupLfvbKqimXgcCJ4qTCKXqCralig3ERjA3Ua0hpbQzh/lvOwImvb60ZTJNTFkd7gFLbhRWMbubSEsNrYxOQnO85TTpTiELr7lK8CnSXUujWwqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024917; c=relaxed/simple;
	bh=o3xDCbZLloqxGK5FQFWafvQmMFLzw63Dr7vqdYq3r4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCwoboL6o+ItordpY/YM8GmFUvtkgJIWkAtsnGiJOtLB7lVmS/rZWlp01sFIsfEfCrPnLppTbIlWspPIMLRgCVvUw2TFUzGRzXkczyfJ35pmnnT8Ofm4FSd57FQyhAr33IQC/YUj4jxvg8bO42ydKlv2BQx7tNwTapk3XaJiiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=leODmwcJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leODmwcJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db5212e2f6so9202955ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708024915; x=1708629715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UY7ZIf0XDjrnf+8+6JSkNWrbZN8oo6G4+Ro1fQYUmfA=;
        b=leODmwcJ0kYGEtgBzUzQ/uQ9W2BHJuyXXnI/JaBdMfNMVj6Ml3bGT7v67n3fXkEu6J
         65RRqhYkJzzJ4P3a4g4gh0FofCotZSdBeptp2ITlOkynGIe9beYg6hKUgAAaxnsosyF6
         NXGS2+NMD1zgoC5pEQmsfwe9i3EEptf4fGOVUckbcXM1qMID7l6PQGireFHcGuT3KlK9
         e38zwHGmsTrU8FeF5LG0j+XvpXxk3EKcKTPuHjUOkpX7Qwg/WlM6Dj2l8oiq5oxuDjWK
         YuWtf6AuqVmOXEsxqIQK4YvXGMREkpmXmNNkMEXfpd4DgB45akxkO4IDFwhXumjjJxtB
         NF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024915; x=1708629715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UY7ZIf0XDjrnf+8+6JSkNWrbZN8oo6G4+Ro1fQYUmfA=;
        b=FJIYORwd+24XjcNy0T1VNtjNcVg6F3kRcZyp1VvJAQnpa1gNlLRS0gaUJNBUloEqRN
         vCfXPxcohIyaAkLosIo8q4sKt3IyxI58DiPZ2X007vug7cuooCKJQppLAS1ozDO34Dzf
         YumXScYXlUvcVtUdK+S5P0FT9EMehqYRbFoPqPSpGHMm6gQjJ3co/7Z/jMoE3s0wmmDa
         vgHM1YizKC/jmvQMz2kxdmiU6oQCCIBflztR3lJ3kSvZZ6FXtayS21GkOqMa23iLgJdI
         t4i4LFXtKthbwkVJ6Vfh9neb1IPend3lkeRo549OJKna0nT+GHsg+HqWwcLao+8IA4zZ
         qKrg==
X-Gm-Message-State: AOJu0YxviC0LrCQT1hjQphVEAWG2uEskvesHy6e3xXonVUJ74v/h8Wl+
	rBRY3dmcDkpwmetBevcXFnaFvih+seH6deQ9tAsPua9g/FHCvaGQOUP8hH7iCJk=
X-Google-Smtp-Source: AGHT+IFw54TZjgPqy+YK1TuVeDyWvVczSr1maCRfAB1E7aSihqnEwQcuPRhVPo72Li7BLP2bY6iHuA==
X-Received: by 2002:a17:902:780e:b0:1db:2caa:6c5e with SMTP id p14-20020a170902780e00b001db2caa6c5emr6968338pll.3.1708024914987;
        Thu, 15 Feb 2024 11:21:54 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b001d92a2b258esm1613209pls.118.2024.02.15.11.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:21:54 -0800 (PST)
Message-ID: <cde1076c-d4bc-4e2f-9319-9eb37d24eef5@linaro.org>
Date: Thu, 15 Feb 2024 09:21:50 -1000
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
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 05:01, Jonathan Cameron wrote:
> -static bool ptw_translate(PTETranslate *inout, hwaddr addr)
> +static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)

You do not need to pass in 'ra' here...

>       flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
> -                              inout->ptw_idx, true, &inout->haddr, &full, 0);
> +                              inout->ptw_idx, true, &inout->haddr, &full, ra);

... because this                                 ^^^^
indicates a non-fault probe.
A return address is only required for a faulting probe to raise an exception.

> -static inline uint32_t ptw_ldl(const PTETranslate *in)
> +static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
>  {
>      if (likely(in->haddr)) {
>          return ldl_p(in->haddr);
>      }
> -    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
> +    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
>  }

However the loads do require 'ra' for the io_recompile, as you saw from the backtrace.


r~
