Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDC450F2;
	Mon,  5 May 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479099; cv=none; b=MG+8RyooDlj85KfV7Ps4OJvt6GSkFCK/AL9rqv8Z8tcjQoA1xM5cK2Hqdd5+fyDEsWiBry/f8UhKgczjKpERmtRIh2QCmYtZtklej4Vg4pZTDhrsKw8cHciW0caAlTG4mitZ6t6V/0hlkevlB5gO0+xNxP4aL3UrJiD4VPg0QcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479099; c=relaxed/simple;
	bh=FGiWGc+82PiPbIk6BF5/UnObbgn45qQJgVgN4UIx1T4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbyXBv0QOZJzEzDhRSyBHFInlgY9gylHMsajPeK3t+8SN0dyI1ewX+PT/yFRp4fXfyN4pGg1hNiBao82c2C84rQ0bvP3sJo/mpPI18BOg2sPepjx4/0H15foadO33xMJZBftG4f425aUugT5T/aXfO1nelARDCLwCSySofn3zlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/ha/J05; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/ha/J05"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2260c91576aso44187605ad.3;
        Mon, 05 May 2025 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746479097; x=1747083897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f203cTbIpPkVhyyjjbKF+s15CLqMptv+0eTp+x4sYXs=;
        b=a/ha/J05zHhQdOwzCQrpJlPm3Z1qrwPEpYCK0f+YSxQqOw/G0OOPHhenWsp3mh0a/2
         wDp90JNYiVasRFfmvw1o61QmrM3arQm9wfWHH6N3r3sr5yX/8KgSrDfqj5kUd2z54b7R
         57L9PZNEdo2mOi26wzGuvL4STxQj1yDHgQmpkDRU2Jh+8UvVBoW4jFOkUNHWLh5CyVzH
         rUrAkgqSA9WKRPhsT+6XpIaBthzKuOOGvgLT5DxGo5CHRQuwsu3Y8aNKIFzTO/c4BenB
         FfyX03q6QlRksVlh9/utcTfNePjI3+WdC9WVWXcWBr643ET1dRNLfiEDXgxQMUqRAp8o
         csQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746479097; x=1747083897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f203cTbIpPkVhyyjjbKF+s15CLqMptv+0eTp+x4sYXs=;
        b=c2/6mA8aIr5JyBojq47qWpNIL9Fxp3cDScBCpUIv5yefSddjFBKKk2H7CXVOt3zQ4V
         c2zWRplHP0poQrsyw0EjTTPWX5GU3rqLkjPDwlbKebQv9DxpnsWGjjgOVuVpVDbTJeQa
         exbXxIukws/HSu0szZBYN+WL//gSlleUR3tGli4kqwLZiuoc+ASios1QQACOMV0KjpVn
         Lf6DN00O6Fj3YsLGVgRU8vq1NKD/CmfVpjmJX6EOQrLBgtk8yWAL31gLX6RUpifu3a8N
         //TYWyI4sV+KaKV6fKvAtyAeeFnEWzeEQXEJ7/y+MR2zDTJ5fNbXQPEODvAeZCv6KQUD
         BOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCK8hItTB9+E/ZpTuAUIATvH0BMtPMncU4E0t9l8HAZlzJ5OF3CPBMRTe6hNIvvP5/1Xnha8/Erh0=@vger.kernel.org, AJvYcCWtwHA/DqoaL4lNYO5k+wW2P9WTRUlUES6ZZxcTmnCUfFZ/Z3x5j/X5Lzd1n68fNqFNlQZd7PZ8rar+jEiS@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPIwwGr2FgWF7zE8ZlYZf4SrLPRvo0bPH2H/FnDqX7gw8zhQJ
	Z56TOHW7NLf5m9IZgRW7jhb4XX1sEgMEjwAjXIBFR+OXbrNSA5n4AiysCQ==
X-Gm-Gg: ASbGncvhcA4Qo8L1QSBw1Dy2nHwqBbn+TwnrZVnzhNUR4A+Zcjn8yxRLLshiQXx+2FJ
	r2mE/jac7dar5EuiIXMgKN0qb0mRqx0q/opvd8hv4afQYtTaMRsc7ZZznBK0noA2x2c6EvQvN/C
	ZJp8Ct/MKZQK/vfSCHKZzdFBLK9VVPwayxIyLYgKsblWsIJow+okO07cKuui/aKkJHLj7ekyFBD
	1VjD3wsnu3hnJCbj1bctQFv9mJYT1hgcDbJcOvw1Gof7MsEYej8RPSEc0h7RMGWuSJVcsyVbuz1
	tOQ4gBNtrnLf8EG+F8qso6hW7ZMPrPM=
X-Google-Smtp-Source: AGHT+IEpMlyP16CP04/9tmk3lHcgVxz6nJ39N1Oa0bFBCxZGfdK56DSPwOXRU3TsqUpZZQ+683qOAQ==
X-Received: by 2002:a17:902:d482:b0:223:67ac:8929 with SMTP id d9443c01a7336-22e1e6ec76amr132240305ad.0.1746479096883;
        Mon, 05 May 2025 14:04:56 -0700 (PDT)
Received: from lg ([2607:fb90:87e0:9bc2:145c:221c:4526:62fe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151eb3b0sm59890325ad.103.2025.05.05.14.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 14:04:56 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 5 May 2025 14:04:51 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/19] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <aBkn813skYvTv7QC@lg>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <20250413-dcd-type2-upstream-v9-1-1d4911a0b365@intel.com>
 <20250414151950.00001823@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414151950.00001823@huawei.com>

On Mon, Apr 14, 2025 at 03:19:50PM +0100, Jonathan Cameron wrote:
> On Sun, 13 Apr 2025 17:52:09 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Per the CXL 3.1 specification software must check the Command Effects
> > Log (CEL) for dynamic capacity command support.
> > 
> > Detect support for the DCD commands while reading the CEL, including:
> > 
> > 	Get DC Config
> > 	Get DC Extent List
> > 	Add DC Response
> > 	Release DC
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> 
> > +
> > +static bool cxl_verify_dcd_cmds(struct cxl_memdev_state *mds, unsigned long *cmds_seen)
> 
> It's not immediately obvious to me what the right behavior
> from something called cxl_verify_dcd_cmds() is.  A comment might help with that.
> 
> I think all it does right now is check if any bits are set. In my head
> it was going to check that all bits needed for a useful implementation were
> set. I did have to go check what a 'logical and' of a bitmap was defined as
> because that bit of the bitmap_and() return value wasn't obvious to me either!

The code only checks if any DCD command (48xx) is supported, if any is
set, it will set "dcd_supported".
As you mentioned, it seems we should check all the related commands are
supported, otherwise it is not valid implementation.

Fan
> 
> 
> > +{
> > +	DECLARE_BITMAP(all_cmds, CXL_DCD_ENABLED_MAX);
> > +	DECLARE_BITMAP(dst, CXL_DCD_ENABLED_MAX);
> > +
> > +	bitmap_fill(all_cmds, CXL_DCD_ENABLED_MAX);
> > +	return bitmap_and(dst, cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX);
> > +}
> > +
> 
> 

-- 
Fan Ni
