Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB928E2C
	for <linux-cxl@vger.kernel.org>; Mon,  6 Nov 2023 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjgvQO2f"
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94194;
	Mon,  6 Nov 2023 10:28:01 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a81ab75f21so57574977b3.2;
        Mon, 06 Nov 2023 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295280; x=1699900080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiHuG/fT5g9xmDilldbrq0qWyx0Loz2x/M7JAocEXNM=;
        b=PjgvQO2fNvAC+9I2C85uC8622mxEY/X3T4J/UaR6zTlecrLYq5eFJ291QOS6I3bUMT
         sj+uT+iB/MkxiZDY0U/UHtj9igk+P759nOST7vc28p4YW+PHkSt8/bBAsS/yStWWXkpM
         +nY/K0VREOYSY8L4uWZ873y4vFFebk8Tc2kESkTaHgbBjczcZJ/16MI/AGu+UpwYP3bV
         47QPmQXXXz0Z8HzWdVtwAb3Q3rvOABP8MvwZTtZwBxhSmuWDlemUIQYGlm7Ibreb07py
         rWJM0CF4gBGM257vpJ5//VeYWW+AquRxeUHsC56n6ECjHd76+sA99pdmQTOkyz35grcZ
         U/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295280; x=1699900080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiHuG/fT5g9xmDilldbrq0qWyx0Loz2x/M7JAocEXNM=;
        b=xBEiJkudyfNYOrqxQRj6XE35B+d0CV/rSE+MCdrAF4JqnxfdPbYNqAQHGPWzWaYk3h
         Xo1Ar1i86Q24MQSOiWyIufnWrINNp82KoVHg00xlBOne3bck9XoNlLHlAn29sAbt6gJW
         kI7XcXHWk0hdMUoJXYR4WKVQSC57itI3UyBudhvkF1Neg0etr6h755sKSsy6GcoNr/XJ
         hoVcZhGPoM36Swjc9k9Mbh1jbhMYRnqzcTXW+La5eSwrL5hkbvIn/tI4Lp1ECv12RQpo
         jvFDYqGcwmylWS3ATE0pzKU0gVSCksSgnfKCR2foL14WgrZhluhJ8mqCvCejH76QYLAq
         uzOg==
X-Gm-Message-State: AOJu0YzFNNTCy3BHbKudn8xkTeG2aN85uNhdQr6hnUhTNO5qfQrT+du/
	ebK9638yd/VbUlENSpPuE9U=
X-Google-Smtp-Source: AGHT+IGLpyKFoZDbHCGPb7BuzxNKsicyASbBbioV81Opbu3cH8TozOUxOR+7VmIouo+kynqD8bJ/5Q==
X-Received: by 2002:a05:690c:95:b0:5a8:60ad:39a4 with SMTP id be21-20020a05690c009500b005a860ad39a4mr12508141ywb.3.1699295280544;
        Mon, 06 Nov 2023 10:28:00 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id w200-20020a0dd4d1000000b005a50575b1c8sm4576552ywd.26.2023.11.06.10.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:28:00 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 6 Nov 2023 10:27:32 -0800
To: Jim Harris <jim.harris@samsung.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: fix x9 interleave typo
Message-ID: <ZUkwFLIKCSLXTCmq@debian>
References: <CGME20231103201835uscas1p29ca7f76ed5e4c829bfb022a040202d73@uscas1p2.samsung.com>
 <169904271254.204936.8580772404462743630.stgit@ubuntu>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169904271254.204936.8580772404462743630.stgit@ubuntu>

On Fri, Nov 03, 2023 at 08:18:34PM +0000, Jim Harris wrote:
> CXL supports x3, x6 and x12 - not x9.
> 
> Fixes: 80d10a6cee050 ("cxl/region: Add interleave geometry attributes")
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..d295b3488e4a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -403,7 +403,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return rc;
>  
>  	/*
> -	 * Even for x3, x9, and x12 interleaves the region interleave must be a
> +	 * Even for x3, x6, and x12 interleaves the region interleave must be a
>  	 * power of 2 multiple of the host bridge interleave.
>  	 */
>  	if (!is_power_of_2(val / cxld->interleave_ways) ||
> 
