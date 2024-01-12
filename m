Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996912E79
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgc6lk6P"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3f8af8297so40106675ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 11:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088839; x=1705693639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myXJyk4Lmo/137CbC+kqerk92DdanzsaeDAQJeA2hgw=;
        b=Mgc6lk6Pur4HaLqdQrH/Jgydxk89jdZpBx6HRsI/tC+ucKg0Xc35MEQGhyVYtK2de/
         rgdUefYO/kQ5ivWFwUAi+8J0GA3ZQZfCedPPTFJqljqAadXLZMWD192lB7xC58fBMQvk
         0YCqadBytWQYhzf3zMNhipPAMBxB+YDOtwt1R2iuE950SJGFQCTT55x4Z2xxOwDv3utD
         UGwy9n0N7rZFp4MfhPj2vX/IiFpe0Y1Povb4H+rkZUNzgXbKpTxjY4Fssi39YFub5SD1
         SApihE1+0hv/ZEM5D7AdJghtWO1Vgcd6ksoLlnqXgfCyKzX6yF6Vgfp8ZXSw9kcSx7GX
         YMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088839; x=1705693639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myXJyk4Lmo/137CbC+kqerk92DdanzsaeDAQJeA2hgw=;
        b=Ne03l4VQZ6mRSs2GQKAWJ3BM9Q0jwbrVKeJEdXMWpbhD/1ftsWmKdvmFP+meZ9h92x
         hRB4Nv58QsKvRSKsPiODy0NWN+sgRcE/gWAhcNa+NChYwAXgzK4fuXGjaMtietfV1iZJ
         kf1C6pHX2w23EV2FHNGDlGrYcBTskAupyNN261ii2JgezL4Jj2HzrlOml2sgKv+fAp7Q
         4j5aPtkp2JMlch3fjFhlKEnwWojeJJm/MDcIlrE2QTI6XJFmR9LE9cI8EVE2Gqu/pzw0
         yumZ8k2dsiMZELSFbW6aovv4fX81FHFy7X7M1Bo8CjYy6TRNbhLQBoOKJOsUPHhFZ8TB
         4XBQ==
X-Gm-Message-State: AOJu0YxZm9zcloFJoYkbEYZn2nQkZ5gKRP9N2uXtOMi9wOeXubx3Yhs0
	ByC+U5MRIG/B0j3fbJE5rr+/DkmdAOw=
X-Google-Smtp-Source: AGHT+IGqwJPkQ67ksFvNBmp5i5bTIhTsteYTPmPUdIpJDCxUHV0zOmNGjiEu8jnV5vKPXfUgp4QH7w==
X-Received: by 2002:a17:902:6e01:b0:1d5:394e:eb83 with SMTP id u1-20020a1709026e0100b001d5394eeb83mr1158230plk.100.1705088839613;
        Fri, 12 Jan 2024 11:47:19 -0800 (PST)
Received: from debian (c-71-202-83-215.hsd1.ca.comcast.net. [71.202.83.215])
        by smtp.gmail.com with ESMTPSA id mq3-20020a170902fd4300b001d564115807sm3555446plb.46.2024.01.12.11.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 11:47:19 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 12 Jan 2024 11:47:13 -0800
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave.jiang@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: use sysfs_emit() for attr's _show()
Message-ID: <ZaGXQeBOHdytu7wR@debian>
References: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>

On Fri, Jan 12, 2024 at 02:27:09PM +0800, Shiyang Ruan wrote:
> sprintf() is deprecated for sysfs, use preferred sysfs_emit() instead.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2f43d368ba07..dae8802ecdb0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -114,7 +114,7 @@ static DEVICE_ATTR_RO(serial);
>  static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_node(dev));
> +	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> -- 
> 2.34.1
> 
