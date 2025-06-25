Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5526B0BC
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864888; cv=none; b=PsEqQr7qC8X8w8Dx3X/MNLX2kENH7I7CMX3jDu6qBwlpiwoXP426o38Vzgma8mm7zqP+dTADFkwRseioO6RdPxEFqVdKMXBmAfC93DrypV+NUR2VvXJRCxPLgpDCGevWjh6IQms4haIPxRWXMhZJYXx6nlc4yPKxDhb+bRvzGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864888; c=relaxed/simple;
	bh=KyGtK80to6KuEAYehb5mAJU+T+xcgGreIs/Qe+2xesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9FqWLSHLqHzU/J5n4oMpdR2AB5+mY0H6gyTZSmKX01kHguaxrdFJDEU+FTztohOYRxlP1wR2DA3J0QGvt/OTWkInB5uNcb6CTQ3er4SSSqWaxeBvd6UI8eo66TAJ35j4zJqKH+wVNastv6S0UHDYA1FW5z4Iq8kh0apzum21NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpzF0HvI; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpzF0HvI"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so17613fac.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864886; x=1751469686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaOBbGszEzWNvSbaKJDe5LeOUi5TUUgxvB4nzx65NaE=;
        b=dpzF0HvI50GVO8nmkHYCwMHqnAvt3wsTZZ02W2F2KsVWLuZ+gYHCjokYEAKqmsqNYX
         Rf/luAyTBXTFydtGS2O08FUWHe7+dtAR9lIOi3LZNrdRuaurVRvgttmNfpLnq5G8h78f
         ZSWPx6uKQHj8oCn2WJ6YuWMDVyCUR+l+T/2WPB9KDktcqdYtAilgsSxDxVPx93pC8HEM
         sHOyjNfRWsknhgPxKeG44rvZFHFGbYQ2zwe1xD5HJp9QZxnN5l2hMCbtCO8HsV5Zof3Y
         q8eNddk0Y5ymPa+rkFFsiLJb9vEhgrc9/IPUYfBZT8rqsRrTNILLnKWCpbdum8gyK3Mj
         KdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864886; x=1751469686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaOBbGszEzWNvSbaKJDe5LeOUi5TUUgxvB4nzx65NaE=;
        b=aOMj3bQDOAA+V4ZnJMfw85wTn5iJ+OjsLzTXqEukQa/fzuSvKJW7RKsei+2oD/LeLW
         XDZJ8DHL/1DkWaNSrYnmpLgJv7W69CjbGNu0iL56kLkc83nMNLW0JD0JgSfYwE44AAmd
         4ybOuh4pdM0hua9EzS6Pl1MqfRH2b0krO0P4xw48s2gKcG3jFp2C1OteMG8vmbIRsvil
         4A7LvJRsqje39P/fI5qC/G+I/2eV/Sv/pehTNV7nzN54Yc4JZ5BXWYwZVo6Hz8VTkReG
         YwRba4kPULCzuWqQH7VN+HeyAOgd3fHBbnLvOPOLNw9l6JJOcSRpNSi0kqY3ASUbbaWE
         SNHg==
X-Forwarded-Encrypted: i=1; AJvYcCUPTibZbTnbwlt1eqIdOGdfI7qnBRvKPVdR3X/esjulkCFvovNcMJ5ocjfe+OH5bKDEtBd5iWVcwmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ETp1Yaeb8Vf+6TbRW/FFJAoEzJYCVcBjRB6nQEnzxmwStuc6
	g7Zk1dKwQJ4wpn8/OAket7/t/t9Q/Fo4RUrsx7bc0L+vjrqDIEvcgEg1KhR/ZMhgxkQ=
X-Gm-Gg: ASbGncuMhICPcRx0DKjzXlDBDtljbj3PMHzx+jxB6/T/cG+1v+BUyhthik0MWTb8bid
	H8mufMuW2eCc4lQ4IK8kkgA64XDy5p00SVGwj2mARuGV/iOqJa9ViKow4flIQ04mResaphHoyit
	UdIFAo5KMTfthaXO8OlE8KT7xP94z9qdTCPD9N1g0TtK+jKy1G8C40BKEo2IyUm74O7Jz4zJQ89
	ecziCN+fSVimITRpuWg42rGdY9RWUrFCL1Ds0ngM3Oe8g0/RdhX9Rb+DDZI8Y/pGRVu4XW4QKGc
	9/E+9/sf/Le8foNpN6Wv04Wzf1O33NZU91zTkklK/9MRRylYeD/zFg60bE5nqclqXsVCjg==
X-Google-Smtp-Source: AGHT+IGk4J0jSMpXdWyxPvRR18hOuQQOIaOFP1Wr6EYSOJlLgXKdVD4YD5Z5m09gKSGJW9gCVJhNFw==
X-Received: by 2002:a05:6870:e96:b0:29d:c832:7ef6 with SMTP id 586e51a60fabf-2efb29472c7mr2491089fac.39.1750864885674;
        Wed, 25 Jun 2025 08:21:25 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ee665666d4sm2597761fac.16.2025.06.25.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:21:25 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:21:24 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: marc.herbert@linux.intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <4d54e4f6-0d98-4b42-9bea-169f3b8772bb@sabinyo.mountain>
References: <20250613191556.4184103-1-marc.herbert@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613191556.4184103-1-marc.herbert@linux.intel.com>

On Fri, Jun 13, 2025 at 07:15:56PM +0000, marc.herbert@linux.intel.com wrote:
> gcc -O0: Segmentation fault (core dumped)
> gcc -O1: ptr is zero
> gcc -O2: ptr is NOT zero!!!
> gcc -O3: ptr is NOT zero!!!
> gcc -Og: ptr is zero

Btw, this is testing dereferences where the kernel code is doing pointer
math.  No one disagrees about dereferences after a check.

regards,
dan carpenter

