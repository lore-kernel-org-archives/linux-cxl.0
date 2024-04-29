Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2C3D64
	for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386636; cv=none; b=WJs5+hlMc3JySy9zTpKL8Br70CRJ4Nhp2AtOPMZPxhCBANQ6+n2Bzqp0ZsHHQ4ebLSaLvvecLhXs78ILYGx+ABp10SD4FDwKnryZdmIWtPY5astNNvd4UbQGkPtz/s1Um3bUoIO7X/21Y0ZrGPuaA2+uYFlwFixphUCCfmvw86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386636; c=relaxed/simple;
	bh=UbDQchwJ/5MpMWWetkzU6K8E2bg8wM9Cju7lJa1j2uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxyNHk12UYODaCpetcwg3vEkoV4CDXKycj4k4upUOpQ55ilVSL29RkaeYXxdZPjq954kU2eilCQkEN9AJKxmF2ja4mPIOy0up/k/5pIHbt9c2L6x+PzZm+WV+F2FURL4wwOuwpK4fYr48GX4uHQGh94EETR87jLFY8cGEIQyD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oh+QzXWO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oh+QzXWO"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5200afe39eso484072066b.1
        for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714386633; x=1714991433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HfdH1jIH2/B+b7aR8d7pkmFhac9pK2yLLIIWF+ZffE=;
        b=oh+QzXWO7GPG/rrPwOopWYzTXX2K94O0aR2QmPX5hnwa6PAiruuu1LwqbwxyBi2tDl
         c24hTVkZjHtL4x2t4LtP4zHrngUc1P4ZLGduv4q+ZvShcrxwEEJfJDPElZCOXUUFZDC6
         ysrnI/7hMwdig0LCluG1GAKmGXXzzIz8qC7mQbf7MtGtTDJ6qceFduCpbEOUrJANs1W/
         lR4j2xKX2nQITly/Kan9Ay2Y9V8f2n36PQYqaYyzBoF/U/HaimydTYnZa6p5hKGgDGvF
         2GtQEF7Ai9iEwjN/Aw4ER++eGSbs4f76lK2lqC/l6z57Ox2r3Vy32cGLdiazQFcINDme
         MvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714386633; x=1714991433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HfdH1jIH2/B+b7aR8d7pkmFhac9pK2yLLIIWF+ZffE=;
        b=kX6wUfr14U0j1E/g50IEBMAXGQeBLuQIFM0ongvMrmXE22erc3Un+9YnKzY3qCcryv
         rUaRhAK7NNoCmeom8FTz45BoMdnQExhDf5wcz4vz7dWSHfwsntrpFAyd6bpCVooCe7rx
         WqEQHNmtw5HsahbFElcmIyBfkVcqdEG+WcoerMVbUoMRyfOh1QyincA7EVC8UUwsWjZF
         wSlwmh7jaCnLQFjpSOrv0gdOYdlA9EaDWKZRlT1C8sna63hyA1Yn+pPnlAR0pB6VoZB8
         fTyZTCqH5MHpNE2pJVH76KfMlZXoU+yYCTLg0FdpNw/vWUTa48gtPgeJcjLbuWqiSi/q
         Jmtw==
X-Forwarded-Encrypted: i=1; AJvYcCWRJTw49F/6mojT2nrw7kitVXWSOyZUCAYTj1oAy3kX/mareli6aZRMCINLswQl9dXG5NsGqBDdO8lYNvSruhC4PaDP7fOUnm0h
X-Gm-Message-State: AOJu0YxFkIR7/X9YzmGg9+n/evC3J73kom2Rs2gyQH1wU6NkjXmuRXQW
	/WBHQVe5At36PqBY+wCc6XYsJSKfMy4BClUSSgIC118QPRJYRTVMmP7NE9bVekw=
X-Google-Smtp-Source: AGHT+IH20HweA0CE7+18VgLPAHNlNE07Gw2Y/AzjTIzrC+0NFUfK6LbhGiLvlju6wH/4YgzFQT7kww==
X-Received: by 2002:a17:906:eca5:b0:a52:699e:f2b6 with SMTP id qh5-20020a170906eca500b00a52699ef2b6mr7846394ejb.74.1714386632555;
        Mon, 29 Apr 2024 03:30:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bw13-20020a170906c1cd00b00a58de09fd92sm3080025ejb.27.2024.04.29.03.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:30:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:30:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Message-ID: <c6cab703-87df-4152-a5b0-a0ce31e7f057@moroto.mountain>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
 <576dccd9-1f8d-4c69-bc7f-497413b87b9d@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576dccd9-1f8d-4c69-bc7f-497413b87b9d@fujitsu.com>

On Mon, Apr 29, 2024 at 10:25:35AM +0000, Zhijian Li (Fujitsu) wrote:
> >    3084          mutex_lock(&cxlrd->range_lock);
> >    3085          region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> >    3086                                         match_region_by_range);
> >    3087          if (!region_dev) {
> >    3088                  cxlr = construct_region(cxlrd, cxled);
> >    3089                  region_dev = &cxlr->dev;
> >                                       ^^^^^^^^^^^
> > This is not a dereference, it's just pointer math.  In in this case it's
> > the same as saying:
> > 
> > 		region_dev = (void *)cxlr;
> 
> 
> You are right, a equivalent code could be:
> 		region_dev = ((char *)cxlr) + offsetof(struct cxl_region, dev);
> 
> 

Correct.  But offsetof() is zero.  It's the same math that to_cxl_region()
does.

regards,
dan carpenter

