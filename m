Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59519136E21
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699073; cv=none; b=mu2+BKCp+ye1leqMmZzUbhqRzeyCbloZg/pSm16V5d+/Bne7EZC5Hs2a4PyUq7C2MgSOU5JjLRWj+XhPqQiOmRycC6Rz8rhM5JiFUZoExGH7Jj7FBRltyJSh1ymj6j/O5U/aqC7Cbs2Y+cohJvxkRlv3eF1CFnbMsQMxmXxfxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699073; c=relaxed/simple;
	bh=/xxZs+EHskmEoopibWHF6zBSoqj6f7nqfqcBkjYLel0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjfmxArLpC2FJdTTJIl7x3ZIieTU+ABfkGLeoCr4kZ9OksG6SAnR6JQ2mFo2o1F+ZdQNp9D+wQvBL/8Ak/sQQZmRQTO0G0krfHS0THuegF4+DldarYc7l2Fyx6xBXyG/qFBbbF8W/3712cRe8mr7qMubxAtGNpP6VP5rgq27IJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rCecKGxn; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rCecKGxn"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc03951abso1656656eaf.2
        for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729699070; x=1730303870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/sooWPjU4O1hQpSOo+T+4AssgdRD517TbqfxHYaUx4=;
        b=rCecKGxnFbyhq4Vg0als9k/NB8/wxKZKNbBTBqZpCfGFQGbrss7+gNdafJwJjCcPX2
         FPQ2Xtz0LJReuEQxTNv0ExP6Tn/JX6trn2R5AV/eHEoEBc9lTqmVnjJ5ML0Gz3KM5u8V
         c1wNF1zBzeRWb99ugP4VttJYZ6cKunAU+D1gqd/97UE2c0tG65INlcFK7Tk2VEPN1Dwx
         wAiUgb9fiI6s9Wv7HTwgLZZlblCGYCHU8cg5WyDN75g8K0mMl86EkyDUUwBG8OGvA09J
         7GkN/rzLRj1aGtfdJneBaILIT74T8x5MMS1xkfEw3/2y2mY8TzkuEvOTFY9wG261HdJa
         SQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699070; x=1730303870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/sooWPjU4O1hQpSOo+T+4AssgdRD517TbqfxHYaUx4=;
        b=UBtL+gfhlQFNNLmYshfShYy83uq1kTiPCWzcyUc9yguKPELcNtdBg1psIZeEjA1BeD
         he+n2wLZAWv8ok+G05bbx8rns1/sWtOLAMXb4XMN++zLNIy42HqygWofCHLTRde0kfTr
         vKwyl3XYKu9qSTOjm6iorF/dFmcNqYoBDeWD2Bgj+mRmsDsNYJHtDjDd9qyWozdqAgF/
         qrA90FR1eUPANLoecd/dAsEG89fKDOUfqamsJjt2ZE7JBX6iknXzyHwL5oSayGWI5D+U
         IwFSxBMVinIXhDJwLJXLbiSokphoZhWndZ5rp31CE0dQQ8P6d2+2L93dPUs5+zBMegyP
         +vkA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3RYkPP9EDe8wuPQ0e969a/TNyP9zk5KwUsNUFJgAEuICOBmATUvzoHwmjIeVJHZ4khDC08XoZ/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQYhOW9aXUjjsBrBxMh5/9V6hYK1gdsBM4wqLeRKCFE91r55h
	7eVcSPOK5BmRxPORDTW5sB1h3hSTO6Fvo+6uFyL0pzTOWykDSyccDQM9lmVjK64=
X-Google-Smtp-Source: AGHT+IEmpCaUP5qM3+ueLmLiPjSBwDSYIxAdTvJrWh4zFWOHOvi5mtwabYje6lSr7M8fiSV7OVh/+w==
X-Received: by 2002:a05:6358:4883:b0:1c3:813d:47c6 with SMTP id e5c5f4694b2df-1c3d819cae8mr146485255d.19.1729699070252;
        Wed, 23 Oct 2024 08:57:50 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a71754sm398425485a.107.2024.10.23.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:57:49 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:57:52 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, dave.jiang@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/6] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <ZxkdAC2y8zHQGgUc@PC2K9PVX.TheFacebook.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Oct 22, 2024 at 06:43:32PM -0700, Dan Williams wrote:
> It turns out since its original introduction, pre-2.6.12,
> bus_rescan_devices() has skipped devices that might be in the process of
> attaching or detaching from their driver. For CXL this behavior is
> unwanted and expects that cxl_bus_rescan() is a probe barrier.
> 
> That behavior is simple enough to achieve with bus_for_each_dev() paired
> with call to device_attach(), and it is unclear why bus_rescan_devices()
> took the position of lockless consumption of dev->driver which is racy.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means.  However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/port.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e666ec6a9085..af92c67bc954 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2084,11 +2084,18 @@ static void cxl_bus_remove(struct device *dev)
>  
>  static struct workqueue_struct *cxl_bus_wq;
>  
> -static void cxl_bus_rescan_queue(struct work_struct *w)
> +static int cxl_rescan_attach(struct device *dev, void *data)
>  {
> -	int rc = bus_rescan_devices(&cxl_bus_type);
> +	int rc = device_attach(dev);
> +
> +	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
>  
> -	pr_debug("CXL bus rescan result: %d\n", rc);
> +	return 0;
> +}
> +
> +static void cxl_bus_rescan_queue(struct work_struct *w)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_rescan_attach);
>  }
>  
>  void cxl_bus_rescan(void)
> 
