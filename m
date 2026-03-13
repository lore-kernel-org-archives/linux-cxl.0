Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C062314D18
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371123; cv=none; b=FHcUoqNK+8sTWmpjJmHV1ne9eI42SEdifM5iyx9NS2Z/uslkUhYC/OW14WPKBB/P0TR1LLA7lMPEO66MMT4tX1Eo1xUVPljHT3SIAWRquYky7Z5BN5ynyJJlTmDLRXdl49VY0q2kguseICxgb0qVJQOz6JBSYK3a1hcd2KOpWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371123; c=relaxed/simple;
	bh=WLsJA/HFpoSz/qJAj3x6z062D0MMeQF1uUYpy271mic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iapYBtpdS01dg/1mEiubOL7Bc7l8BgMyHTIp1dfD9Yp46SMd1DCQ+vNdUDBmxWfvfuSDdoRkomR/6qB37deEu4e4CeWfkUwuKWBfPrbGKXrKwHHuP7VdFgeJlbPbUiV34WuF5g8SxLHMZszysbFd+15N+TyEUMJh/oYhZYPdeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdHxAQ7k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdHxAQ7k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae82df847bso13377215ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371121; x=1773975921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMiD7iuuQ6RwrA9DHEwvWHHs17Gv5D7sbQEPQSKpbdQ=;
        b=OdHxAQ7kby3qHb87qB4/Oh6wjqtxy1jsTxRI68sP11dL0LnDbIJvalwJ9jOgbdREp4
         WsCHBufVT5pfxFb39f4437VFp5zWWguJhBvF1nKP0zYUoW9YPe+1KeOel9aLRtmxmy0u
         J+FTc5EwT2LpOyLR8Ic7ja5nK27eldfH75P2u5i/qiN4Gh977q3855pGCO/tKEerhDx6
         /MDz3vVUNeLpqDGsSo5htsG6Kjn1uLHPDJFvlXVshz3kwaPKE7MjxYpzibO7z+vj7Mjo
         k2kIIcQp507PifJ4nt7P3XJ6fxyzWEBmrdXF374QdmfxxlpQlJ3+eQWBR3MDAWqaj6UY
         9xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371121; x=1773975921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMiD7iuuQ6RwrA9DHEwvWHHs17Gv5D7sbQEPQSKpbdQ=;
        b=LsC4kmiuXFqe9JByLWREo50vJnIFbxoPv85DaYQzey/ShN4dZlr4Cy1klaqoaRkP9L
         jWxd79DFfj0q0DxuiO2k7Ofzg+eycW4+6XFTujdiSD3nPfn2I8ZGaPPyZTyYZHHaFWkv
         LdkgsW8T0lrqaAHKsDbdDTDjo0u0P4rcUFKFWfUeet6vf7tZBJXuvXosVEPbhIX7RW+L
         ogvGB5jos2i5YGXeA6pjW8G9AdJ5op3M5YPqxQAhWMLhdsG98tBnsOdcnmN54Kem7rSX
         yG7GC+yOQMBpi6DyFrfBRcCEcHXQYHR9vYyD9MJodK+vVS96iBt34aXnWuw6bJFyt8rx
         VFDw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJf6KLtAa1bVFbotzA+PLaUK+DFNWN/+R/i6Nw1xvfEilYWb/q0PpztWKa5rfsKhe1nSkayEZ5po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgkA8aQzwYghx1+VjKtLBV9IuDP6wnObNIb5hcyJYoNCOl+18
	+oUG/2Z0M/phmTT4nDbM9H57kP7mcKJBkehVWN+vrndWXpNxDUTlSvRq
X-Gm-Gg: ATEYQzzmY1bay+P9zP3CJQYPsBDV0wkAyX7Jmg6TULLL0cir7fIYNoP8pe4grIUhy6W
	H4AO2X6JLPIvJP0wd/B4dgeoTsBUQTnf9udlNC4NfZLSUHjoa6NgBSPzo3tirrDaiGIEsjsu6IA
	LsRLLu03Q1l/gmfeb7OFU9k41w5fYFlewG/fJB5PxFiJJBTEe6vGtjEkna44SrLxMf6j2uLUNiW
	iIL1YFXKJ6dehZy7Sp2fTlSlg+Y8OUesNZVQbr2Ih1/vbZCeor9fewGQ3UuGyvQ5CZLhvkX+019
	1w4ES+3bcl0zsuLTHs2MONf0TjSBCLNlgHzQjD96tymCSCrjOmCz19SzrnDubB7fwRt1YDG80Ss
	LMiJ38805YJg5o3e8FVn2cZKmls+Ai+59NFGVkIVreGa/jgm5eGx46FrmQ8ifER2YgxEy/pRmeg
	0c77dR+7ML/+ReceJw0vBFku99oGaEnGxKPwkX8bFR15Z9LB49A5kEqs/gfEomArZpx0dAsubyP
	Q==
X-Received: by 2002:a17:903:1a2e:b0:2a0:de4f:c99 with SMTP id d9443c01a7336-2aeca96723cmr15904725ad.9.1773371121407;
        Thu, 12 Mar 2026 20:05:21 -0700 (PDT)
Received: from [192.168.123.240] (n11212047001.netvigator.com. [112.120.47.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c388sm5610335ad.11.2026.03.12.20.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 20:05:21 -0700 (PDT)
Message-ID: <8315168c-0557-445b-aa86-174d9902e2e1@gmail.com>
Date: Fri, 13 Mar 2026 11:05:15 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node
 bandwidth
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: akpm@linux-foundation.org, david@kernel.org, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, linux-mm@kvack.org, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, dave.jiang@intel.com
References: <20260312091207.2016518-1-seven.yi.lee@gmail.com>
 <20260312115825.000045af@huawei.com>
Content-Language: en-US
From: Yee Li <seven.yi.lee@gmail.com>
In-Reply-To: <20260312115825.000045af@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Thanks for the review.

> As I note below, I'm not convinced this is the best layer to be injecting
> data at if we want a debug interface that allows us to reflect real
> hardware.  Might be the sort of patch that is useful outside the tree though
> so thanks for sharing it!

Perhaps a small tool to compute weights from the desired bandwidth
would be a better approach.

> If it was an SRAT (for GPs) / HMAT issue I'd suggest table injection is
> an adequate way to do testing and debug.
> 
> CDAT is trickier, but maybe we should be thinking about a debug path to inject
> that as well - similar to what we do for ACPI tables.
> 
>  From my point of view I'd rather see debug / testing interfaces that test the
> whole flow rather than just this top layer control.
> 
> However, I can see this is a useful patch for developers. But if you
> are developing debugging bandwidth-aware memory policies, I'm going to assume
> you don't mind building a kernel and adding this patch to make your life
> easier!
> 
> So to me, useful tool but I'm not 'yet' convinced it should be upstream.

You are right, table injection is likely the better approach.
During early hardware development the platform is often unstable, and
firmware may not be able to report it accurately. Letting the OS handle
debugging and evaluate the results can make experimentation easier.

And, thank you for checking the code.
