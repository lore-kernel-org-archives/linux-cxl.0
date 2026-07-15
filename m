Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414EC3C73D1
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144551; cv=none; b=KlntooEZOwpU2xgQIdeSe5cdrqeRh2u3TqI7ofrm+sNpcF9+JRFkQESlOkpFSoz87VVl83x7jfJst77gtjsjp4zfGesGc/qtM7bDyPngIeQGfTV1Q6VHyDl4x2or1f2TAjhrSeJFof2RPRo2PbkEmA9CPhOLQmvMUsAWkR450AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144551; c=relaxed/simple;
	bh=ivn+ns0/9HUTJGZP/TUu/nVUE4yfqrs0N8NAHnbEUnQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlvkIC3B/1PIidNs6FfDNbzFm9HcZQbJY2GBcKP/fmN49FnjiCvgWa22RAVdkNYTuFcFq2zolyKua/kkAfkyPsRW5ShlCYrl55zH2fCVRiX0tK4sgDLczibtyXuCWCSXVn1O/jXD/L7CEH/V8ea/3Iv+sL3npBA/d4/kWEKpAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ1a2dZ6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ1a2dZ6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2418008a91.2
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784144547; x=1784749347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xOT+iJ3ReQwbtNlxysq1AxWjZnmdfnRFxYkgt5mzAq4=;
        b=XQ1a2dZ6LvjXaVyCMQs5wTA5a+8rBzhnvZJxV6VH6NlY7OP/uavX02sC6nv0NpvOxr
         5V4CDxhBNeA4xlj77nFfh0ajtq4rtDLDzWtIwYg9t1xPCLXBCyH9/urK6Iy6rZkb5scg
         sLMyCqMOS5x+LcPnLDVdRmN5lq5rHKuJKTy916vl2a2FmgRKPkTdQxSFDkRQZRrtHTej
         9CfIu2dA0swYHHrf20bUa8/UXfmJSN+hnHJyw+mafBMX7apbobMLrGLAkdz98OP6eweP
         32+zsZ2EUM14hXAmgMLjpfJ3iXMXYDnoMSQRPwwcDS/e5UfqQHiwTokXJzQ8wzH9hDmr
         TVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784144547; x=1784749347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xOT+iJ3ReQwbtNlxysq1AxWjZnmdfnRFxYkgt5mzAq4=;
        b=nbrgEhOdlfydwmhdCkHxKd1ld/UoFD/hTV8OV7hV/7Qz9pKpgz0r9iF0FDtn9wUSEj
         HgsX1q5+q1yMuGcBEr8nFvYWwATtObtS6GKPYmGj0BnFQmGDUgLczxKWCFjga1HvlU1U
         XQoeFyNNtsh6g8WbUGtrECQgZxFicCux7uxSSb/nwdvblmrgKadII1kEaZRCP1q4g0v5
         xjhC5ycW7HGtnVeCaMiZCuvZL9PEMyYxyWJziQd025bFTBRYj6IHnHDr+KU3S+f2golx
         TDrpEfwSIKOOPFNIEHzQglo74tDYLb/zICykYtTsCs6QpP8AuAmSdcIN4IeeyfObpKq3
         47rw==
X-Forwarded-Encrypted: i=1; AHgh+RqIPxHIhZy6E9ppSxnYKl6tbIYggqDSha+LrfueQbPsx0o/BZEuNIAh6UTtGDhFf4OJ14ICRc5x8sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1wIe2vHaZIeqfZRl+mNu7RWmdrBIAdzHJfe2SdAvtJI+cXSx
	1JrX3yfXxXVI7SPyjrwjRdj9rl1E7RobcdZH498XSDFLxGqFgIZ1b04a
X-Gm-Gg: AfdE7cniIioBzQlj4w6IwKCV21rq1tBsWKaN6pj9GykkZP1qLCIptTxoRFXzWCwqHWi
	v21msQByrUquccIUO1OZlVB4FXlFILUWBLWCRExMo7AIZCcUd7De/9h85ywgiKH168eb8pLCoky
	pU6blfG3t5VeA987cGyI2aL3lBtJmLr4Az7vFMqpCVG7x0k+nWKDO8zxjalKjCe+dDsstMHjYkr
	fbYETKsQgqzUKl68rx30SvaJiJ/xqviEsB8UbxxoO5Xc8cjdQerpWcpSFFnaEDxV+Hwh4KCaxdy
	HnpFdhaUHDY+PHkqCFE3NAHnPCJjZNsDm4t1vIN4Jpn0UGBBwsWM1Yla1WFn2DMphweH/T3efk1
	y3gj/lkfUijWUJKpMzgMb0Nec5yLxOGqfnGNV8eHjYUhXIutdg+hboe+1NV+nFw3lYCttrTXO8z
	dUJczzTVoo20aPPyJfFm0/uoZhtKX0NkeNN28s8kkMvIvDYPez4oT5deMWvjdg2Corr/iD/9zfQ
	lXkqRg=
X-Received: by 2002:a05:6a21:7e0c:b0:3c3:7762:5d5f with SMTP id adf61e73a8af0-3c377626ec5mr2621801637.19.1784144546826;
        Wed, 15 Jul 2026 12:42:26 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4359166sm3647854c88.14.2026.07.15.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:42:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 15 Jul 2026 12:42:25 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 07/31] cxl/region: Add DC DAX region support
Message-ID: <alfiocEYiKmIoe1Q@AnisaLaptop.localdomain>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-8-anisa.su@samsung.com>
 <20260625181650.52E881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625181650.52E881F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 06:16:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Lockless access to `cxlmd->cxlds` via the newly introduced `cxled_to_mds()` helper in `store_targetN()` leads to a NULL pointer dereference during concurrent device teardown.

Fixed.

> --
> 
> commit 0243c2c435424873e37aafdcb17aee31b0ea07a1
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/region: Add DC DAX region support
> 
> This commit introduces dynamic DAX regions to support CXL DC capabilities.
> It adds a new sysfs attribute for creating dynamic RAM regions and updates
> target attachment logic to handle DCD support.
> 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 82ca3a4767080..9ed141fa13341 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> [ ... ]
> > @@ -18,6 +19,13 @@ enum cxl_detach_mode {
> >  	DETACH_INVALIDATE,
> >  };
> >  
> > +static inline struct cxl_memdev_state *
> > +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	return to_cxl_memdev_state(cxlmd->cxlds);
> > +}
> 
> [Severity: High]
> Can this result in a NULL pointer dereference during concurrent device
> teardown?
> 
> If a user writes to a CXL region's targetX sysfs file, store_targetN()
> calls cxled_to_mds() without holding locks that synchronize with device
> teardown.
> 
> Concurrently, if the CXL device is hot-removed or the driver is unbound,
> cxl_memdev_shutdown() nullifies cxlmd->cxlds under cxl_memdev_rwsem.
> 
> This would cause cxled_to_mds() to pass a NULL pointer to
> to_cxl_memdev_state(), which unconditionally dereferences it:
> 
> drivers/cxl/cxlmem.h:to_cxl_memdev_state() {
>     if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
>         return NULL;
>     ...
> }
> 
> Does this path need to hold cxl_memdev_rwsem or otherwise verify
> cxlmd->cxlds is not NULL before using it?
> 

Fixed:

Added new helper function cxled_dcd_check() in memdev.c instead of
called cxled_to_mds(). The new helper grabs the lock before reading
cxlmd->cxlds:

int cxled_dcd_check(struct cxl_endpoint_decoder *cxled)
{
	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
	struct cxl_dev_state *cxlds;

	guard(rwsem_read)(&cxl_memdev_rwsem);
	cxlds = cxlmd->cxlds;
	if (!cxlds || cxlds->type != CXL_DEVTYPE_CLASSMEM)
		return -ENODEV;
	if (!cxl_dcd_supported(to_cxl_memdev_state(cxlds)))
		return -EINVAL;
	return 0;
}
EXPORT_SYMBOL_NS_GPL(cxled_dcd_check, "CXL");

Exported to cxl/core/region.c so it can be called from store_targetN()
for dcd checks:

if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_1) {
	rc = cxled_dcd_check(cxled);
	if (rc == -ENODEV)
		dev_dbg(dev, "No memdev state\n");
	else if (rc == -EINVAL)
		dev_dbg(dev, "DCD unsupported\n");
	if (rc)
		goto out;
}

> > +
> >  #ifdef CONFIG_CXL_REGION
> >  
> >  struct cxl_region_context {
> [ ... ]
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e50dc716d4e82..ba03ec5e27c32 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> [ ... ]
> > @@ -2389,6 +2396,8 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> >  	if (sysfs_streq(buf, "\n"))
> >  		rc = detach_target(cxlr, pos);
> >  	else {
> > +		struct cxl_endpoint_decoder *cxled;
> > +		struct cxl_memdev_state *mds;
> >  		struct device *dev;
> >  
> >  		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> > @@ -2400,8 +2409,21 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> >  			goto out;
> >  		}
> >  
> > -		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
> > -				   TASK_INTERRUPTIBLE);
> > +		cxled = to_cxl_endpoint_decoder(dev);
> > +		if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_1) {
> > +			mds = cxled_to_mds(cxled);
> > +			if (!mds) {
> > +				dev_dbg(dev, "No memdev state\n");
> > +				rc = -ENODEV;
> > +				goto out;
> > +			}
> > +			if (!cxl_dcd_supported(mds)) {
> > +				dev_dbg(dev, "DCD unsupported\n");
> > +				rc = -EINVAL;
> > +				goto out;
> > +			}
> > +		}
> > +		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
> >  out:
> >  		put_device(dev);
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625112638.550691-1-anisa.su@samsung.com?part=7
