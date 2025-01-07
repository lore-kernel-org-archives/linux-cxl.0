Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97A1E47A6
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291503; cv=none; b=ndVRP6dMAcP2JOfiVfUfxVf0BH6xOtjT5UTfhKw1CBp5qaneVD4cDaD6gXnL54bXFqjrEVua8Vjo+bsnSNDX3nzRZvWO3UuVmf7VRvkisYIE1u17wSkO6k8AnVE7OPIMOztZTZ6d8xe7OKUzwcj1JRQd6FlNEqCGtib5vz1OGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291503; c=relaxed/simple;
	bh=00ACdWSAWfIoDJD4HhgYq5Fv+ZbqeR8pjfbXt1Dkg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLDIv4sNQJwF5ddhTFf22K+ptTMJMiLxQc6N2ZkkIJytmV4zL2v3htzurz5LUkR5it1NkEQoZqneUQuerevX8hl+fEg8KmfMmIQKCqccakQVwiHHtdsmSU97yFpixewq+tLBLfmAd16gGzPP/0RwdZ4YO9TqpkJdEPmpA3tmmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YlZeB3PC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YlZeB3PC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ef047e9bso26927685a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 15:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736291500; x=1736896300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRfHwEhGh+uv5N1vGfQEk1M7/smo5R9vzYPolDrrP8A=;
        b=YlZeB3PCxFJuebNq3f227ohpFL4Lk8BXsmhv3naais9QXJ20mmCQ8sI+wiBDYkO+zp
         KKyDKPPd0Gx+cT/oiqxJCYPDyGOT+4lrwJkCq9rQr4tt/jZ70WIkrnbNYtwRNlDyvc6V
         qh7x6kR8GzG4YitGUWK8FK+y+/QKPrMUI7fP7tKcFa7jRkxfMfow2c4w4+ylzS3B2O5N
         0ejaYXKbqKxqs37oN/zI8ba+8mx3gN6gCbUki+BQsQwPvMz/1B3eMsGNmb2lGOYTa86r
         UQ3a5dzsO0MV3siU9FSeU/tBcLBBmRwrhMKqdEEPL+1e1HaN3w6RZoj+UaU8k4j2kyGe
         S1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291500; x=1736896300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRfHwEhGh+uv5N1vGfQEk1M7/smo5R9vzYPolDrrP8A=;
        b=F9vCFJo+FV0ClyBGnvrmrdvAWR9OAiqGMDUYVxuyjA4t5HOmRvvfLyvXZZuhqENqM2
         +oFWMBt/3B7HftRhjX/5ORtdgocmWXtic/hnqMrUp1PR4qCvVkq156wkTywP9sYJdyhw
         V+ZLFcg91ozWxdZ1OrHZW1rM+YxODcB05hWcrSCBMN3yBInYD9o/lmEE9MGmLXTgF/hX
         0ekmAxjfVjPatHpuiFX0v+HKEyirCyEMpqGtetpDiN0B3vZ9S4C8x7hqus7CffXaeIOj
         uuKCJbmyfglURYS3kbWk68573zQXhlo6NXTPZrzn3dS9wm7KOo9auZtWXO6exZRc2aQc
         tojw==
X-Forwarded-Encrypted: i=1; AJvYcCXL59SzrI3tu9L/vCaJNIvTlHAxUCgHgTqOutgABgnDu5LK2K5Cmsvf7tkozAMd8/ftKS7u9j4pjkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxgJce7eLkngLkMMOMbxd05+qi6UeYT5nJXseeghMFbQw7LSK
	vh6IcCDR2RpJxT5hzzPwxi0EjOHcqnhceFefoBcvQLRqthp1Edn9NUSLpOPDCxQ=
X-Gm-Gg: ASbGncvbkWB6ppEgaTZizXn+SYdlhe3zEEi31T1wVkZXCyRXqmz+/iH0fIMwa2g2Sm0
	uJcn61SzcdNuVGOH7pBxK4r5ny0hp7ucUTyy6dLk+GM3rdHoyptWgj9RbNdVthPpwpe4SapOVpC
	l0XH04S000/zKLLVmtJ/v77RhbScnz0IBYvm14mRXjxDfsi+xAXE0hgj6cMGscALqT9CDg7tOwh
	Wba5mgSWFbP4iTq+fi0CkrPHvAVkAlRTydrticJSDS0b63IzyvW2u9H72WJ56hwNMQlCTR/9a6Z
	WpkStppjjhG9RmvFoqrQ2LPBkHRxBfzLWIwpEd8=
X-Google-Smtp-Source: AGHT+IEVUJvTzflm/kX6K/z/f2lJ3/GIdOO3tryrrQft3fqQp3S0N1VCLoQxCSQqBetJUDiEErzFDg==
X-Received: by 2002:a05:620a:4513:b0:7b6:d5b2:e58 with SMTP id af79cd13be357-7bcd8cf0696mr188374685a.18.1736291500485;
        Tue, 07 Jan 2025 15:11:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc8cbsm1630280285a.11.2025.01.07.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:11:40 -0800 (PST)
Date: Tue, 7 Jan 2025 18:11:38 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 27/29] cxl/region: Show message on registration failure
Message-ID: <Z320qkSHzA40IqJT@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-28-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-28-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:13PM +0100, Robert Richter wrote:
> Esp. in complex system configurations with multiple endpoints and
> interleaving setups it is hard to detect region setup failures as its
> registration may silently fail. Add messages to show registration
> failures.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1dae7d36d37c..775450a1a887 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2240,6 +2240,12 @@ static int attach_target(struct cxl_region *cxlr,
>  	rc = cxl_region_attach(cxlr, cxled, pos);
>  	up_read(&cxl_dpa_rwsem);
>  	up_write(&cxl_region_rwsem);
> +
> +	if (rc)
> +		dev_warn(cxled->cxld.dev.parent,
> +			"failed to attach %s to %s: %d\n",
> +			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
> +
>  	return rc;
>  }
>  
> -- 
> 2.39.5
> 
