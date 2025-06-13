Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CA1388
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818046; cv=none; b=MS0solGDPTntQ4jbaGnlwvJOTpJ34qnpnnlPQgCKYcImCX9bqzolEJ2owDAfRdzMWNm7wHPBq0saeyUOwtDqcZJ4NZRXXim2waPMeLlKGCQb+0+/uaqwkr5knGPwCznjLoxnQSeGqufKxxS9iYJd+NEOFF3U5NsSqbPaInrjvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818046; c=relaxed/simple;
	bh=2aO1xVqRNuFLVq5n9xbvMV4oOajc0pUhnL6zf+vW8WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcw6QRjI8ktFyzZU8y6f26HFM1wYP82Z3rjFNkxjARUWADdw/65dWMcIni5KcuseJevkAddO4vUpABIFQeoJ0rGU0sJYfEwXY3AB74xQ/m5/FqE1SDEIZ2TiSehPdP4LhQvYBzX6ciY84Gh8EbhZyXzLWdRPbzUDXh4ZYhX3Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzyvrFCh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzyvrFCh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e4043c5b7so18222787b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749818043; x=1750422843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71Ya53HdH2POf52rkfKFn+Nol6pKowztsbWwDe3T4og=;
        b=TzyvrFChRlGCGsTsUjnDCTfXu7oB3I1IS2bym+5DaBmzwTHaenXfG3rHBAeN9zxfnR
         HMAqM2/m4PvX7YZesrUGiOLS7WkYPOtpV5D7Eqaym2bUR4+Ao2J4fmeCCqUsPaGzjN9k
         lapSjqiGhGnuPNXwSNfHpJ5KrixEQDY+wOIAc6NFuV0+KCZhRUHlVD1bVXJ5ypixfwmJ
         s4tti5T29/e+4wai2snjExruf0h6ZcPCtOSBwbp/JUSwvp4BHKVwmAEIR3n9pPKBE2dS
         66KuvAqK9BijCPRLs+M+OI1j91CzcJH2GhvKSou/FsLsjkBG2XpedB/1Nh3TnRVOKUWM
         RCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749818043; x=1750422843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71Ya53HdH2POf52rkfKFn+Nol6pKowztsbWwDe3T4og=;
        b=kkmOicqCfvLweLy9uGwk2pUMCAwbs7iCBdENnF5kt1rwMoPiyvoTR6S/wWwVAI42ii
         WtP8N93G4iWu0fIoZiGyv0RFvZ62s5D10VJvxEGX74UY6GWfCDLTCmM0ERVnWVc1LV5q
         wRtC0Gk6TygS2PF3rwEzgiyEeCX/Ysd/FQnd6NZ+xIaAmuYDXAfS8Ls3R8RpJ/DemCKl
         B5Psb0K4K6+37dfwudPm2DUs/rFP1O6BV5MmNO2DToeu+xHtDIlZHx0K1w9dMhRWwf+Z
         jMIBPqJsGHwis/LRGlcVyIKk0fM35SrkrWnJbwivbfGocwksebvKZ8Yq/Ax8z+8CtGxk
         3f2w==
X-Forwarded-Encrypted: i=1; AJvYcCVNkKPuGNAHll/KLRBK01K2XMdev2Dkw8baHCUtiAdzyFU26OYCBYc0Y/rmrp5FfqOSwEmpSUiRzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4K/ECW7uwU/Tt9dlZ80QNcmIG2lgRnWrHSB5qzzEKzP4IOSF
	PG678rZOGLoDVIo1n9pqbP/AZ7vYP2DsIqJGz11SwaEZFY3rGNqXNUJ0F9nTeXrkox0LKqn8wSn
	j1cg4Paut8Zloz+iR73YjkmkcsT12InlJ2cZ9rf9oDQ==
X-Gm-Gg: ASbGncv7n9XfxGGtPa35BT1IeKfSVlVCO/sUVMYKWzCSCIXHXfMLLaYQX2YDfJIemSR
	CAuLMIBaKEtDCEkS6X868QX3hXAfXDYR3sgPNU/xll+231v5iPI6ybbVjtiHJYLBBy8ftJMhRV9
	ZhIZovScoVaQBWsRtU71kQswTAZfFFgMdrcUXkZYnoXwcWqawUlvz5YBI=
X-Google-Smtp-Source: AGHT+IEPb3qsJDLQBTC8O9rNw2LMABjdnqOth3sas+F6r3fDBdPhv+i9c4Uol0fLbXfZFpDJZmkdztNRwKzE2noXcvo=
X-Received: by 2002:a05:690c:6f08:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-7116374f3b7mr43623757b3.25.1749818043502; Fri, 13 Jun 2025
 05:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com> <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 13:33:51 +0100
X-Gm-Features: AX0GCFvpyAy_J3mza-WH8ODBb8J0cb17KuCFxq0_mXVNO-YpQTCeuWxKD6udl4Q
Message-ID: <CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows devices.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, 
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Alireza Sanaee <alireza.sanaee@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 14:44, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Previously these somewhat device like structures were tracked using a list
> in the CXLState in each machine. This is proving restrictive in a few
> cases where we need to iterate through these without being aware of the
> machine type. Just make them sysbus devices.


> +static void cxl_fmw_realize(DeviceState *dev, Error **errp)
> +{
> +    CXLFixedWindow *fw = CXL_FMW(dev);
> +
> +    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
> +                          "cxl-fixed-memory-region", fw->size);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
> +}
> +
> +static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "CXL Fixed Memory Window";
> +    dc->realize = cxl_fmw_realize;
> +    /* Reason - created by machines as tightly coupled to machine memory map */
> +    dc->user_creatable = false;
> +}

Do these things have any state that needs migrating or resetting?
If they do, they need a reset function and a vmstate. If not,
it's helpful to have a comment explaining that the device
has no state to be reset or migrated, so future readers of
the code know this wasn't just accidentally forgotten.

thanks
-- PMM
