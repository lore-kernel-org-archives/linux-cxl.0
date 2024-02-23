Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FD14263A
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712405; cv=none; b=gzt/C43PTQNCMy0NMpM8qpcn8MaxLDH2GeVpngktiuAS40sI68d17GnDN6F0BWyITZH2Zm0et99BsSXTGFA8JLERw7W1WhFRCYKL6ujlM8Ok+LPsq7uuw5/ROmqK0RmZoWY1PznDiPtGk77XftWzOTOghI2JWNyD9Q/lKOGkG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712405; c=relaxed/simple;
	bh=jCwnUbFwT+l8ckUMK2m0mQCVbWAKZdK09GXLEpsnI8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lT6ccVBOqVvouxyljC7jNYXJqL23rgF4e14SCDvbFSGZgJnNRq4BhRhgwi6dCG/nLB0C5fYzmXdCaHcQDjMbZQ8R0IA+3g0tW01eqjCrpOz9ym8V+EJ79Dw4WNRmdf4vaNmBr9CfVQCeCIqXjaL4ihW3xUPsry0BAmdl3CusRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EzcyQTUa; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzcyQTUa"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-218642337c9so326199fac.3
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708712400; x=1709317200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LklWzCbZx7Ck0JRACSyFYvfkFz2hYYkazCbjgi1SDKE=;
        b=EzcyQTUai/SR/GzeUEj4u7i5KOET2BTP8LWmmxyq2PND+SgkaSrmzsSoQh+vrT8vYe
         WClorYyR+jnwh5AotJaSj9/zY2m7/NenicHeAJOt0otwrN9U5ZCWeYaa2VDuy1mN+ULj
         wuR5/rePuy+CCvQb2yx3TIwq7eGJ5dZfB6ofJDy+sZH0Z3ygJRu7+pzt9FMzfHcT+5tw
         sWzw2Dw6zBuEbuXmGvWmwiCMw7q2ctQqU7yAjBBwO5pNUPoO6bVdLK1rlbC6IDox76ID
         GIs0CSFkBPLqOsRYzeyyjSKq6DJQuWz5r/J6cA9po+OGNDzCcBzprwhE+WSKb9x5i429
         /tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712400; x=1709317200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LklWzCbZx7Ck0JRACSyFYvfkFz2hYYkazCbjgi1SDKE=;
        b=uLIvAf68Xpzzz9TuIBWuNd/f6RUXDXW8i+Bj6WaTujWlTZ2NNTrUymHOXEF+WU0d1N
         y59BWeEnAVELWu98EKi+s5/KUHqdptpuVtahUi4vZtPMraCUUtztSuKe0Jd5D2ywYfgG
         w4d5wnj1+MuHGx3p3hPqyaVF6luIB/UlhUkwg1FBPe7ZrOyBL3uaG+/7tEiR8kGK4AKx
         9dw+7XFaq4EREdL8HTWstq4k8UkzhUJnqX66l3uQptPsZhrjgCGPlrIpS+M+326fdPnm
         YxskveJR0kk04GAu2/z7i3n4ghe5tE+E0/b5LGmyu/sNDVuyije1HPyRWS67jFt1tDwC
         EmgQ==
X-Gm-Message-State: AOJu0YxbtzSi+Z7XG6jkTtlhGEZ6mONDfDm2FqkwlLtF874j5i1wyWsH
	6zAvYiafWbu9i1D+NLhAGnAWdp79oZAHR91WZ9/1zaMLejpJQpWxqT39TC2k/70=
X-Google-Smtp-Source: AGHT+IHLome3EF/8wSzFbHPRxEopmaWUd7kVWnhOMJyUCshJRInWlfI5JqADDBK+g5fkQ6ZST6xm4w==
X-Received: by 2002:a05:6870:c992:b0:21f:c7fa:753b with SMTP id hi18-20020a056870c99200b0021fc7fa753bmr312202oab.16.1708712400045;
        Fri, 23 Feb 2024 10:20:00 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id b13-20020a63eb4d000000b005dc9439c56bsm12397324pgk.13.2024.02.23.10.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 10:19:59 -0800 (PST)
Message-ID: <47974032-2c22-481c-a9e1-1fc5990340d6@linaro.org>
Date: Fri, 23 Feb 2024 08:19:55 -1000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm/ptw: Handle atomic updates of page tables entries
 in MMIO during PTW.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 08:01, Jonathan Cameron wrote:
> Seen testing of CXL emulation on arm64 (currently out of tree).
> 
> CXL interleave occurs at subpage granularity so is emulated using an IO
> Memory Region. The memory is general purpose and as such may contain page
> tables. FEAT_HADFS using atomic accesses from the page table walkers to
> update accessed and dirty bits.
> 
> Note that disabling kernel support this ARM 8.1 feature avoids this issue
> as the PTW no longer does an atomic update of the page table entries, but
> that is a nasty workaround beyond its use in root causing this issue.
> 
> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
