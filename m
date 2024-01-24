Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD371350E7
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130282; cv=none; b=Dh79xIxO/hncdpWjf8fMSsW70kCHt9pZDkUMpHnsntpUqLNWafIKq1xAv751f/mK9RWFTDVxqooqzxyONHBurzkvOGJ7PlI7hfDdauYhtXmsLkPkTgGBhL1N+iYlHurySI02rpby8pIzQY1dy7cN/4FBxrQyvtHcJ7biOjKCmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130282; c=relaxed/simple;
	bh=QsQtVIzQ7U0oGlgxSwztfMCY686pR0jGw6BwOzFNCxg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw0ztw/vnXGArFekuGDu3ct84QiCABK5rr5wCLXC4tpW0Hrp1O2SUfhCcNODruQ/gKWt1K2NNzME93WnuMSwqUvbGv2481q6DSbzJHV12pX8ZL719r6froJGdRNQ1r/3Qe/1J4vWSXEbWQFSDNWYJ85oGzuJY1KxGU6yp09S0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0sU3fdx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0sU3fdx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2903cd158f8so3534489a91.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130280; x=1706735080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8JYoZcnluoDvCJc9xqAMy3/BcoaNF0u77JLKKb6+Ahg=;
        b=i0sU3fdxu+PSMVKlS05qXx2DO4mlj7X0ACnVgK5OQht75ZRXNOVSUJczB54Jdj66hV
         OR6nuMuG2yFQRFPIdR9KBcvYV42niUDwisRaqZmcxWUWxpN9PvlSOsiE83dw3B+cp/jP
         BgEFySty7nKpcrpEo7iFYqtXg+35DXrQJfG8eUIMoVWL5Q5Sazv+7S79v88XPh7YGHhl
         SDSWWox+Wl++Mot7RCotErtzsHr3E80usJsPKof7xMkIyT0u74sO4ODIIGirpHU/Q+is
         /cd/VVhNOvcEDvUUhS2bJmCcr//KrOQhOWDr/0C+Nx+hvKZMK4GhfwWtgkcDl/6MyXIs
         tajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130280; x=1706735080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JYoZcnluoDvCJc9xqAMy3/BcoaNF0u77JLKKb6+Ahg=;
        b=HAVvWOr+KGxTa7XlshIbPCP810IXo6fA/E7Ox22pNWzf/X0LGQwwPvTFEEqKwQ5G3C
         LtpIRlB9dzc4vcqHZNxJ4zTi3H82RzOZSVQ8NdXgYDurAmPLI5zVMZ3EcF+Vb5Ci96O2
         AekpQ0qtRtFJ3FXE7edGw5vLTzxkwQxfi0sVSRloVZEZ3P2Q0R7Ldm9Bn1xfE2+izw5A
         SL76j5dlYypDK6MFJusp7jjDs/ifGdthqqwNxwexoxXCUpJ2vbE+CIUQg0duLCqznZVJ
         i8m3zduT6JBKAHY7DN0ZKcLg0DLlwoShj34TwItPDHTGjzmu0mEDoPuD2YRAr9D1wsUG
         6/Dw==
X-Gm-Message-State: AOJu0YzCIRQU/e9jf/8EhTaurBdoxYalBIqNLOpMsdWtYAq7L8k2h0lE
	s4bfg9JiQCTTq+qBBKSQIx+DTpCJbvebwJrgFNnGB4bWe4HhdrKNlT56psN/
X-Google-Smtp-Source: AGHT+IEdc1zUvJpKwLv00KX1tKvpJYxkxJv/r8oxFFtNTpoU7K9eRW/RciWy/etjhzi2Tw5/6a3v+g==
X-Received: by 2002:a17:90b:440b:b0:28e:3daf:f6e0 with SMTP id hx11-20020a17090b440b00b0028e3daff6e0mr133045pjb.53.1706130280164;
        Wed, 24 Jan 2024 13:04:40 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id md2-20020a17090b23c200b0028adcc0f2c4sm90521pjb.18.2024.01.24.13.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:04:39 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 13:04:23 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
	Dave Jiang <dave.jiang@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 01/12] cxl/cdat: Handle cdat table build errors
Message-ID: <ZbF7V0lhCwZ2fey4@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-2-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:49PM +0000, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The callback for building CDAT tables may return negative error codes.
> This was previously unhandled and will result in potentially huge
> allocations later on in ct3_build_cdat()
> 
> Detect the negative error code and defer cdat building.
> 
> Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-cdat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 639a2db3e1..24829cf242 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
>                                                   cdat->private);
>  
> -    if (!cdat->built_buf_len) {
> +    if (cdat->built_buf_len <= 0) {
>          /* Build later as not all data available yet */
>          cdat->to_update = true;
>          return;
> -- 
> 2.39.2
> 
