Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822023D81
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840381; cv=none; b=NVUR8JsBG3ZMbIRUcQv4KVf/Gd8+F3/M75nZO1goxXZs/VEAeQ9GizXKHT+9g4Sukf7tdHDJ+uXKKHg1p+YOSjUmVKPB21UmNqzdzxDgegC98eMYsYriRt3/s1Bm4ZDW1UOAYx6qOqWgSMu0sm0oWgLrYHy6Fqgln4FRMSYTIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840381; c=relaxed/simple;
	bh=Tc0Lshz5DTdlphPj1fOUaofkMKmgK9TbPSQ/vPSbYbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+c8jtrqqrI4PnUIJE3221rnn/CKP6Xcr7YeV8OtGvClNGBATiLMepNDoaU5KzL7Z6vHVv+CQrOtw70yVHjuLGkK9oTWqnYsWN7KoJNGo/WY0FotHpWskmxiDPhg7JC9+HhmWYlzx8+GNg+rrQYDVFG0sY38EGUEQUDnY8iIKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTDPOwAx; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTDPOwAx"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso5510469276.1
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 12:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730840377; x=1731445177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nP21VhhtAN4bMtCwZaYVPKl9ELon3gECWfWvivPbdhc=;
        b=jTDPOwAxAh5W3pimXLc3KlrUEYrv1sVm6weyimYfzm3GC1vmmnXvr47eo3iRY3sGFJ
         I/UI0HmbUozu3SsvVQadEj/PV6OpnSo349YbFaNEFl+741hGc2TG2QHpDH0bq9ahClMt
         g2W4b8ZrjR1+nlL3sdailpAuhb6ENAbnfDfbuYSkm5GOWaFxJFaMMmqjo7Rw75i759vB
         lQH2Ssi/NByvzJItk3MTkC6vlpX3TkZne5tceSTL3WVWtCrACiqQcJNN21UNTqgWDaRQ
         wq6X6Y/D2qcf9N+FryuVa/0hGJD3nReQTmccq/PsFADV6GvYEVky+zU3q2Ew40hNNCnr
         0T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840377; x=1731445177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP21VhhtAN4bMtCwZaYVPKl9ELon3gECWfWvivPbdhc=;
        b=hY+aj8Itkk7XSOFb2cCD6SKEg3sYqdkId2UXQyCJIaFpdld2p6w802eJ0P/d7H1LbJ
         8q+rADHBw24Kk1h75B0Df2i5uQ98/JhQ9Aw66lQpI7uM8rW68PavM6zBTsMqisoOq4qv
         eBXUx+VTir9YGYSU3KngyD7/Jm1cSidc2LrZQvWFQ4IveKZ8NHqIjt/Md9qvI7WoqJIF
         YmbGKPjLBtrPyK8+cYm5WiaPlCqrjKK4xelVqtJFYwC5eq1282cJ0KVbUQ2ZqR8ot0sh
         AVX85sqew0MjfFjMmC+DO3UjLtiww9IihWQj0Suwt2fpdunrkk0X7QAKsylREjZqHHsu
         a6HA==
X-Gm-Message-State: AOJu0Yw3OpYAUyzl4zMpykLjXAOGbbSkLsUqlr3dOWYxG0aUaH3Pktjk
	1CO9RIdG4/hiP11mRlMrtprWIFCZnDzS+BrhYL7gpuiO9R8B29Cc
X-Google-Smtp-Source: AGHT+IH6cu6bhcBmJTsqaVBEUTndllLxTwmnlDRoWST3Nr9aoAJUHpBX+kdr0XyR56Ec6zLatQmubw==
X-Received: by 2002:a05:690c:6289:b0:6ea:7afd:d8f2 with SMTP id 00721157ae682-6ea7afddd75mr128765917b3.15.1730840377364;
        Tue, 05 Nov 2024 12:59:37 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7c26d7dcsm17123617b3.54.2024.11.05.12.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:59:36 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 12:59:35 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 02/10] hw/cxl: Check input includes at least the
 header in cmd_features_set_feature()
Message-ID: <ZyqHN42zJeg6inGr@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-3-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:09PM +0000, Jonathan Cameron wrote:
> A buggy guest might write an insufficiently large message.
> Check the header is present. Whilst zero data after the header is very
> odd it will just result in failure to copy any data.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 17924410dd..e63140aefe 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1238,6 +1238,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>      CXLType3Dev *ct3d;
>      uint16_t count;
>  
> +    if (len_in < sizeof(*hdr)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>  
>      if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
>          return CXL_MBOX_UNSUPPORTED;
> -- 
> 2.43.0
> 

-- 
Fan Ni
