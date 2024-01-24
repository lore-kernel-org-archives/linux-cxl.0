Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18721350F0
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130722; cv=none; b=EoP11Wnzw+fJAbBq/cX6hjGisb9qx4bFX1pIF4uxx4ubDSSVFhUR8CIqIKQ0Lr52Sq7yrWkJEUf+tZO83kc5wK0g9SUkKNTNypOd6DJv2VJGQb4lmwZOHwlI51cgRu88V7AGIcS9puff4XtbeHZcuJo4z0QJCr7QEnIShMYk4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130722; c=relaxed/simple;
	bh=crYMjGjDD/ETFS+VW6BU0hOMQRMW5y0znJAM+fLErEg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzwF2zNettKNDtuF1VORmGG6KTLV8+iEIyfbX4Xvi9eREEfAOtK3E2/2uW0i4ESMUNhoWCbCw2g6KPR7BEJWb6Q2kkjs6kpJX8T8WaITYX8+ECkYNxXpu8l4DMtv7l1BvKuC9tjEOs/Ey8QLOzQWxF6sXJP/eZpNNUdnJoQ+aPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0tDlzm+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0tDlzm+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso3142853a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130720; x=1706735520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=en9elrlzH5ROGIslaMPqVVimkyWbMWGsUFGcvQEX4OE=;
        b=N0tDlzm+jMkmGKPG0LPXc3ibqPN+oTQQhncf0xSaG72n/MC4aQByb3y20jiBfKAvad
         dlKFp+nQ3O2oCNZmuqveH/2W4giX/0llnfZcbVDrEa+toE9ZjBSD8hW5OktqUBcOC45B
         QZgf7Rmx2/jlkVX4wWvgJGW6BE5sigQbMwlrc7b1goS5ncJxXjZbW3PN90vNsBltvBxt
         9sIrpQ5hho6rYrK8J2xByS2emwJcq0kQNc7HHqCT7RELETVBYfR7vs8KFdBw8GWJPMvE
         fqRqOPDh5R0LGdSN0yrZ3P5Hs8zG1YjR+5Z6NSFgQ6Vnj/mXgLiwAyNDqMmERwLOrl99
         R9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130720; x=1706735520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en9elrlzH5ROGIslaMPqVVimkyWbMWGsUFGcvQEX4OE=;
        b=wJ7b7rtU6G+Xowg1GvDeo/w3bIbrJOaCSKIf1lWITuMUkdtrrhIGytegpiOtnNBoj9
         t66wnDTR+QhBke2KIk7uIxuaTpdZcBQnppPFhIJMmAgw4yt00FT/YAglSpUpt3ztlwKX
         zrhAzQU/Hg0DuDvWgoCkQtN5RUhmlISJ7LEN6KEYLspImJl9PCdkepEX/K/LkcYuoH1b
         OpWEwnqSryPX4x2yzZ5U6YRpNnemuID7oGiooiWcRd7gEpeNYwsL8a72NE6MOaAWyrvK
         UX1q9xZBdIvlyI5BDdB2UrKcdHfe1owIh6FaR3Wend0GIgEe/7lJbUkMQLFgJJMqyFGa
         0/PQ==
X-Gm-Message-State: AOJu0YyhflQoCoHHc49nrqXdRZef+M9RY0E9/Ko8L9U2qJdoFcLdWLTQ
	BhOkUizVHKvTahXpq5q+SWz8lc4m0+x6JXco4QBtiDdP9DvI5xyWKyvR9Dy5
X-Google-Smtp-Source: AGHT+IEk5Kj8Zs9IkifoB3g21OSw1ffdiYqnVXgWmdl/J8qaASYgziaGsv8xwvbkOOT2F+qre3g5sg==
X-Received: by 2002:a17:90a:a410:b0:28e:8012:1329 with SMTP id y16-20020a17090aa41000b0028e80121329mr139000pjp.23.1706130720053;
        Wed, 24 Jan 2024 13:12:00 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090add8500b0028dfdfc9a8esm94448pjv.37.2024.01.24.13.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:11:59 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 13:11:56 -0800
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
Subject: Re: [PATCH 03/12] hw/pci-bridge/cxl_upstream: Drop g_malloc0()
 failure handling
Message-ID: <ZbF9HMx_XJCKTcIH@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-4-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:51PM +0000, Jonathan Cameron wrote:
> As a failure of g_malloc0() will result in QEMU exiting, it

s/g_malloc0/g_malloc/


Fan

> won't return a NULL to check.  As such, drop the incorrect handling
> of such NULL returns in the cdat table building code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/pci-bridge/cxl_upstream.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 36737189c6..d5341b530f 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -228,9 +228,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  
>      sslbis_size = sizeof(CDATSslbis) + sizeof(*sslbis_latency->sslbe) * count;
>      sslbis_latency = g_malloc(sslbis_size);
> -    if (!sslbis_latency) {
> -        return -ENOMEM;
> -    }
>      *sslbis_latency = (CDATSslbis) {
>          .sslbis_header = {
>              .header = {
> @@ -251,9 +248,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      sslbis_bandwidth = g_malloc(sslbis_size);
> -    if (!sslbis_bandwidth) {
> -        return 0;
> -    }
>      *sslbis_bandwidth = (CDATSslbis) {
>          .sslbis_header = {
>              .header = {
> -- 
> 2.39.2
> 
