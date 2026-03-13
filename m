Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4C35AC35
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773373190; cv=none; b=ANKCTfa9LF4bfmKve/AALRZ7u0+7mRgzoxqnU6byYQJz9HftlR2BAnqQDyYfw9599HbK8yjg2Kw50z/Zd8P6yjjgcmBxqhuHGYbsJJ/Y1ZRE1+FDEqgPoOTXjsZyEYPQNlfe8YikFWpgMcYAhUXFb9VtNg9sF+2exeDhdYSKhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773373190; c=relaxed/simple;
	bh=wq5EHVNKbrIpJDbbH2uUvSo9o5rg2fy03S9KDJ4kNwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUwu+LPGgQf6PretcdN33lLsNov6k1tOR+GxUEVOrW3mBFug6q/KoNscFJVUD19nIKTccJ1sQy1w1YvWDIFgy1d8JuWd8l5LnD+PfbNtrDCQYeWIg9R/gwfz4+VRy/X5xR3hFR/JsjxzIjkFJtdZtcmdzKuZ745BVgCf+uj8YU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVX3xv4h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVX3xv4h"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so877701a91.0
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 20:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773373187; x=1773977987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+INjjQWlNJIxV6k0ZvQsdBiZDFnv72NM4m8hFvOy0+Y=;
        b=RVX3xv4ht0tHHVTXZGLjf+VTybREwGd2RWwG1wn9qdYZ5kGJ0bkoCzN8Prd/oZtXc1
         dY5s47G+md9/SW1Fd8rps+lyx31kjHfeRpYPmMC+Lku2H8oBrlLNx2wcQv3A/dNfRVhC
         S+KsIA/f7eZQ+9qZlwiP+yfS+d5TFnfFcvu1nphXiZdYVRGMutpeXAaxamvZ+wwYEU4D
         2G5aXgDgUD45wa5lGf8Gy9AqM+kl8qqPEo9hP3gwZYxtxSMEdNzP6NUHkwN+r274ZoPR
         DwGlts52ZFfAvMXRFdNdsprUG8WwiYc/i9M/GylRJ8+v5a7tUGjmpBIrOJALHa+HouwI
         WbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773373187; x=1773977987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+INjjQWlNJIxV6k0ZvQsdBiZDFnv72NM4m8hFvOy0+Y=;
        b=AqxFttP4dEPdR7MND/ka06zFQzgbjimU5QEe6Y9zkw1pwgbUrqqwUHvCYxGMUpV6yZ
         aQXO2UMOf4psoJKuB/7Rk23gGwVebLSDct0ShisJZXnIwnxXJ22Uozq7NjdwQSROZmQQ
         9TuKvAMK1gjp2V0PsTUJsEIpOj9EvJsH+Qh8gbq3ALXIEojCzQ6ZWfV1O9hRNe4ye/qi
         HueVXuW6mnr74ks76gjDJFjPTsgfAzpDUkV7M7ar4dKneeeHrH57X/iF+qtf0a6pStP6
         DpI3GEFDRScHN+qz8rP7hFXbtPFHK1oWknmCFFahIZZyycFhw2FLtdc+55ZceSw6Deim
         Vmww==
X-Forwarded-Encrypted: i=1; AJvYcCVVw0GrJDWq4M/yOXIsfin/SfcxkrVfkxJlQihz3UbQayP3yBBMu1i+Pi00fChXQmhmrd3SDDCbwhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FtSxGoPEtRzF2/wR7VbfCdMhH2ErmY51Qhd8oM9aGP40Kkgf
	0iEDstqZPK3qJmEFK/WmynV6FvW6TNETm/wP1c/+pKLMCG5BZx21Tupd
X-Gm-Gg: ATEYQzy0NkkXCWMVHtMPWbPCzv6vbgjl31+ElUCDvAdYtjLl4M5t5Qu9OaX0TD7wMMH
	HrQncGevPmrO7yO5JWc2g+YJXn2VT8D6zGAIEyWtJtr9BtJx+wrT3439fHREPk9Tn6cBFbYcdNG
	VKmEOynIxpcsvvsRrJXrtGEgmGg1t6GTy+eAqOxtx9YnnvWVr/giXbNT6OhDYWtiREXwAIFxfli
	WWXn742OY30sBxqEpAqC6/Tgz0clPYypCKZCLh9EfNnnQCnuEflr2k/VSbj69PX+TWkd34GgM38
	zICIE0EfxSmWTDqIpDtP4L+uKh/8mwdaZAiFPEAajNK7Y94FmtBZxFhLbK7nQw0MJKW4OVKLsdU
	IGxyV7fQtTYEfLVdnbsWUi4N82/Ju87CMJoKK+updmiqvbBNFlxVF7TveTi56Z2DoGNkaSEyfay
	uGkoQCLbsYw8xnFjlYGMB2CpdSyfR25cib1PY/OKqtvgC8UGfn+oM9+92tbT3xPvV7NSPRjrz6K
	mA=
X-Received: by 2002:a17:90b:2d83:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35a22053498mr1562896a91.28.1773373187283;
        Thu, 12 Mar 2026 20:39:47 -0700 (PDT)
Received: from [192.168.123.240] (n058152075021.netvigator.com. [58.152.75.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc9454sm7295623a91.12.2026.03.12.20.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 20:39:46 -0700 (PDT)
Message-ID: <06535c30-ce87-43b2-9670-53e56ca04c3c@gmail.com>
Date: Fri, 13 Mar 2026 11:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node
 bandwidth
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
 linux-cxl@vger.kernel.org, dave.jiang@intel.com, gourry@gourry.next
References: <20260312150022.1373486-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Yee Li <seven.yi.lee@gmail.com>
In-Reply-To: <20260312150022.1373486-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joshua,

Thanks for your feedback and kind wishes.

> I just wanted to touch on this. Is this true? Weighted interleave already
> exposes sysfs that lets the user set the weights they want. On one hand
> I think it would be helpful for there to be a tool to see what the
> effects of setting bandwidth information on a system could be, if it
> had other side effects. I'm not sure if there is a strong case to do this
> purely for weighted interleave auto-tuning, which already has a manual
> weight override and pretty simple calculations : -)

I agree — writing a small userspace tool to compute the weights based on
actual measured bandwidths (from mlc or stream) is a really good approach.

> Thank you for the helpful clarification. Just to be sure, are there
> other intended things that the user can test other than what weights
> weighted interleave would resolve to?

We can continue DRAM + CXL weighted interleave performance testing 
later, following Gregory Price's experiments [1].
[1] Link:
https://lore.kernel.org/linux-mm/20240103224209.2541-1-gregory.price@memverge.com/




