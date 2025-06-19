Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548A125D6
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300521; cv=none; b=fuip7ax/O9FqrPWmj/AUXf1WpUFiaP79h6sHYiGzyDVDGjOjYrFKKsKixEhY46/UABNjyvBydRmCvN1k/oqMUvmeO047GYouVCHwS71vgeCsZFQtNAIn+XOxpifPU2TIezWnmWcSai/0HZhlvSTqrgemWyk7LvDBKyNe6ucIq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300521; c=relaxed/simple;
	bh=oI1NEh28305D0ayJRrlO+zIubPUuGt/MLPVps+N4jbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMqcHZCD1qvQ44x9SZ1eUQOsNM+V1aWJYtKnyXkKe5XxpKvuC6L/2F6nO3zIngtrKrlAs+Rgwp7DsL97fc+hxvbXbAr11iTo/vkhMgHSYEDtNLiW4g13ZT/NZXhJMVfic7RwqcE3agqHRYkA7ifQ4cJbD8MNkZeSu5kLT3L/Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwpvECJv; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwpvECJv"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea2fee5471so181604fac.0
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jun 2025 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750300519; x=1750905319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve9tIiVhsY8HsyGqSgZ9WHqrheC4NxF+RmsfnVlvf/Y=;
        b=LwpvECJv3H5DKOxZQFq/IvWd0rlSL2ZHSGP6lqcuHAe2ZDjuU7ftPEruVyi267LIrQ
         w6hVypbrX/3qiaq91mQCqQkfB3G7X+Y76jUEbbpWhFfxszZS7B7KlU3AkcvsCG+gxxic
         LzhudxuRpWVcGReZoRfQoqQalujz6Omn6yqWwN0IbsQPJyHOUt3wReqji2+zh3+mypi2
         8JguDE3XqwuMvzX5gBWs31O9IrxbxM8TWGwQZhGjbfZMikfQps6k8S1kUbU7rNGLZhle
         Sv5YiMRm+RMdmAZq8KluozfxNDpGCVI/lpjS95Wc2Q+4pOjBruYkAAyxV4IKjeu5/P9D
         DlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750300519; x=1750905319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve9tIiVhsY8HsyGqSgZ9WHqrheC4NxF+RmsfnVlvf/Y=;
        b=NTmEQ6GUthpJhXnr/v7rujNl2oP0O0U/xMznD2E2D0wzkH6O+o8t+WGZSq2qLEwx4h
         mEdhbUiR2IsGrRFDyPi4CpPIf6/UFPsJjeqH4BA7RcYnXIWMcbgmVAcDj8n5h7hOzTwV
         iO9YNb07WpTzr8fauXlIVrBenZA7AIoLeBMUfwPbJBhi848DGoEa0KoVXstM37OgbL6Z
         Lkj0mz91Ma2RHw+tVfWkVUiAX6b4gj3MAmhFwPefYFzQB/fNfCjyFbUrIgwaFoJl9/7F
         JcI47NT7PR+eu22oulbpOinT1xyeW+gJr7h3WFAu9bQqdtjAQmcu6ltnkq2umFmiHdA3
         oe0A==
X-Forwarded-Encrypted: i=1; AJvYcCW3JThmWh8MTJRW9M0Hn2COgwCrJ/nbsV3i3omxXYSMehwAuZmoUXs8hcKoamavNTssPRzuDiNB5Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH44R3NphGH8SiJ3ciRWv1uCBIBRhH3+8Gn2AwOimy9Z+jdv2r
	xVQvQ3Q1nIcw36CvV3V6SqYXyjDz1XSyM3GVpCSGLYkK2kf5e3N9wynJKDZhib3rls+aznF3FIJ
	QBVGb
X-Gm-Gg: ASbGncti6Hr6kZiWnUOlxQFW0B7JUSrSaemppJiBo7Y+vSyHYCmLkPc21MlJxq9SDsn
	AorzuE2b/ztcAoC3gnY/Lmwqh1fIGgqP2mXIMzd+wb+qmLXj0b0h1Q/k/bJ/Yk8OauhHRLch9bn
	B5+7Mhk6lyqGnP7Nmq6NfCQ8yLVb00lGYXD6ZvR8kwf6sjW4ueKssQVOSlIhgKeFvVRb4R+nNfF
	MADKYW+13o0rpOJr39gjZu5m8fVwb1WsgP1wIIBqIUFhXOPxq3DyO2WfajssLemhgfsHRHI6xU0
	iX/J4jPWmOiI5vnLqqhub9+SPPfzmg/j02a8zay0er+WZnFn85qul4xUFIDc8VI2L3kATw==
X-Google-Smtp-Source: AGHT+IEgO2jGNnbhfnKxYS9lSpLhkJ0gH4kFRnvQIBypkNPPYfFa7bQbcVijzfEL6AgPzJEpLeYU/g==
X-Received: by 2002:a05:6870:2e07:b0:2d4:dc79:b92 with SMTP id 586e51a60fabf-2eb9e89f262mr1258514fac.6.1750300519005;
        Wed, 18 Jun 2025 19:35:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:f083:6e52:f970:dc01])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eba6224f78sm129400fac.39.2025.06.18.19.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:35:17 -0700 (PDT)
Date: Thu, 19 Jun 2025 05:35:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Marc Herbert <marc.herbert@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Benjamin.Cheatham@amd.com,
	Jonathan.Cameron@huawei.com, dakr@kernel.org,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
	rafael@kernel.org, sudeep.holla@arm.com,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <b6e8a921-686c-46a6-b6b5-5e88e9b9c114@suswa.mountain>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
 <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
 <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jun 18, 2025 at 05:23:10PM -0700, Dan Williams wrote:
> Marc Herbert wrote:
> [..]
> > In other words, by turning this off unconditionally at the global level,
> > the kernel could actually lose (surprise!) some performance.
> 
> I expect the answer is that any compiler that does fail to convert this
> to defined behavior is not suitable for compiling the kernel.
> 
> The issue is not "oh hey, this fixup in this case is tiny", it is
> "changing this precedent implicates a large flag day audit". I am
> certain this is one of many optimizations that the kernel is willing to
> sacrifice.
> 
> Otherwise, the massive effort to remove undefined behavior from the
> kernel and allow for complier optimzations around that removal is called
> the "Rust for Linux" project.

We turned it off because of the tun.c bug.  CVE-2009-1897.  It was a fun
story:

https://lwn.net/Articles/342330/
https://lwn.net/Articles/342420/

I would say that if having the compiler automatically delete nonsensical
NULL checks leads to a performance improvement in your code then you're
doing something wrong.  Potentially there could be nonsense NULL checks
embedded inside macros, I guess.

But, again, this is a totally different thing from what the patch does.
The faux_device_destroy() code is not doing a dereference, it's doing
pointer math.

regards,
dan carpenter
