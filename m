Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEA288BA
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565814; cv=none; b=p/Oe2ImFNkH9uChrlcTGT5eiSp5QJ/IAHp7uauqUNMV7jNN+vyu6l0nCvOIj6nohVAkcGtIVqVwECdbPPWHRfMGohblG6nYNf013JCvpteP0w2RUwqe07OexhPOaAPEn9y4XIrrqZlqmgnYEu2uvjpsS85Qfp9Hp8JqZTgqHu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565814; c=relaxed/simple;
	bh=dmQtTS/HM5impIz+F6T6ur8Go17p7rMrlpLMnE5hxNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDKZ6mj5gX5MVEPL0KjunmRhnHMep23OPsBOOmHPGZ7Gvs6WmohjJbEwvqsNzVXGcNk6nXpU+0LAaAtQXgOHzQ1vJi8ag/npaJ6p7tGiLn1PH2NEuzweZsfq8WAiSg5IUQefTFiSxLCbrZMQgY2Z0PZD3zuB4RadEidZ+HCw2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GyCZ7mdQ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GyCZ7mdQ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fc176825so16639386d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742565811; x=1743170611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh0IrT1w8SpjDCYcv9mtaMhDrGwZvUvL6QFs1cEwHMU=;
        b=GyCZ7mdQRxRwPbuQfvVlFj6b3BNM2f3j6LLTIgdu4DetZOUor9yfYRjZWweiWBNkF3
         /WYZkgoOua5v8Yuk5BIKoRbh2HHdKHrM97eMf8+NDgt530yvksUcwVZCLtAeZHbOLwQa
         EaZwKyzsz4swiJclXXGEPPN0BknkIFerXr0abpuJMCrr2LzguKq2hS2F07YaWPqbrTDk
         FDms3nog+WoDmaNaHBLs8fZdS1Ubqx0sCBG6JJ7+Iv5SfVinvCH5Iu5RjlnDktizn5uJ
         Tee4ZijZiShbzvMDvhrRGGvZWr/6Tyqdt692hYbUCxIsgS386H7JaaKdcDoOmA6WxEih
         GZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742565811; x=1743170611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh0IrT1w8SpjDCYcv9mtaMhDrGwZvUvL6QFs1cEwHMU=;
        b=G+kBYHR8A/M1AHxKFNDh+h3NrhWLM1gdq5JJQNdrDbOvSUDxqwC6uNGFiHfw2jd2YL
         qxoeeDbqPd4lwjVWdBQOatVJQ9bU5OMaNCG5rzaniT6AZA6ObnfM9bFx5QEWWXKhYNKF
         Ghh0+AIxh4xCJovb9UGcIz/IKSZeN9oPWMvzqgK/Z3HNA0BW/39hT3PqvJoc921txGzL
         n19AVp4qbyMwoUiOGkG7Ftp79KTNGqWlgqZTq0UJ/pi+N18zoXaceRb/Nd3PCpdNWqBA
         hw524LdQuxBCnx2GFLFduqIk1+T/HfU0m5qx287A354T5MRiXwW63+1bDH0p795rsIyY
         +/tw==
X-Forwarded-Encrypted: i=1; AJvYcCXN8jTUKbsKQKoPOeeAUe08CvNnCXejgelNsZbycGZyxJzqTLGN3kVijCeB6mKLuowk6/3fBxBT0Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz743jIrqgJI5nuvD3tDgc2hUf+rqDDpJygs58niTTlHnQ74aDH
	PBT0epCMbre5TW8vmHEE9uygY7uZeueEDqHUi0DocKFHcaPG5O+u9W76qSwMt5Q=
X-Gm-Gg: ASbGncv5BwIrnBelTMnUbmrIEotkREIalRhi5mtys2omfFk6cpJkIgU6eIdiHt+bZf4
	kqQIzKWMiYbkwPn2Dum9QYvhZDHBdFWYE2K3YSKlwCq95q2mi3fVFGziGqT+LRLL8ALmJU7w1Wc
	lIrm7LMDAtAUPRJQU9D8puhGibs8P95Fp7RskMWcULfyKggpDimlS65umoHxNZBSgALog3YnLFN
	eEuQYPRgTw9yUBY07DJHx3KD0El3Mcbk/02wnVb0taMcjodhG0KygFvf1TvmmLsN9qU3qTknzY7
	tXUB3zdXsaQG08/HeSpdja8AAfZn+u6+kdLYIltW4FkxJ1pePdTImUkigjGWSQ6qEYYMFvxzJVw
	stPLxxz/FVcEs0GNaysZ4xAiCLno=
X-Google-Smtp-Source: AGHT+IEsR9SqinX2KEraGDeefNZOjnaeKRUcenWDJRbEfEjhwa6N5Cjx0RY1yuslTrclVtYFfhgnzA==
X-Received: by 2002:a05:6214:b6d:b0:6e4:4164:8baa with SMTP id 6a1803df08f44-6eb3f27f5f3mr39953556d6.6.1742565811373;
        Fri, 21 Mar 2025 07:03:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f51esm11628666d6.26.2025.03.21.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:03:30 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:03:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z91xsVv98wp7TVrq@gourry-fedora-PF4VCD3F>
References: <20250320164532.1313581-1-joshua.hahnjy@gmail.com>
 <20250321043729.939-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321043729.939-1-rakie.kim@sk.com>

On Fri, Mar 21, 2025 at 01:37:22PM +0900, Rakie Kim wrote:
> As you mentioned, I agree that Patch 1 may be a bit unclear.
> In fact, Patch 1 and Patch 2 share similar goals, and in my view,
> they only provide complete functionality when applied together.
> 
> Initially, I thought that Patch 1 was the fix for the original issue and
> considered it the candidate for a backport.
> However, upon further reflection, I believe that all changes in Patch 1
> through Patch 3 are necessary to fully address the underlying problem.
> 

Patch 1 does address the immediate issue of calling kfree instead of the
appropriate put() routine, so it is fine to keep this separate.

> Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
> into a single patch, then renumber the current Patch 3 as Patch 2,
> and treat the entire set as a proper -stable backport candidate.
>

The set adds functionality and changes the original behavior of the
interface - I'm not clear on the rules on backports in this way.

Would need input from another maintainer on that.

Either way, I would keep it separate for now in case just the first
patch is desired for backport.  Maintainers can always pick up the set
if that's desired.

(It also makes these changes easier to review)
~Gregory
