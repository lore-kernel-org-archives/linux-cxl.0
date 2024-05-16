Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34E6FD5
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879185; cv=none; b=oTm9L5gFigItQRAFNiLNL5e2JNqTr5a7WHEHiAmPWbIHHFmvkJWGaK4JA1RmBQK/b60eNxPAUJeUbET1tx8U513EeHLps4sqS+2GPhRj2WZJ107XkyV2F4LPP+W8CtApCwf19aFozLo0bWUbx7+Fib5SMmz0diuMYOW/Mipcev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879185; c=relaxed/simple;
	bh=Uhvo9E/KyIM9BG20QowO7mAfwhrYYleJlQwPcqmSyZU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzjCKu5bnfTpq8Mf2Rb14DmGfV0rnjDzygtCMc2Yw31KCbw0JpKnRqGuyXCAKIBLvQkIikGvARCXf9yKxc9zEPi5NeaeUZoBg6p5PeM3DLYXCxxaJw47wCX7sHW5udtDfCpNxCEPRXCsyNX50TgOIz8nVALB/FuZJnrD76WyfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcL1+zKB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcL1+zKB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61be4b986aaso94021227b3.3
        for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715879183; x=1716483983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOW2XSX5ui5IvG2zdHYpUVdATFaq4d1s0kZscFLQGqc=;
        b=OcL1+zKBzX1YKhBiTmxGsCPZJSxG/SwgBS0VouX6bmzD/YZkEh+t/M9XCwo99fFikU
         phzPY5YCruY73x18TqzxOOdVgXq89gj8vQFP7pBsiTrBq3LrjnxOr/Zyufl1AY72F+wV
         Cgru9qZI3WdUcF2tSUFhQliCUjnThDn2U6+hZS3xDC5OZtHBTrceuCOSniUOKMWUuEF0
         zRuroA50E/ZkB7SiqaYWn+TaEl5brv5X0PeVtC8QiHwWx4DytUmrOnCeXYWrGBaGikW7
         OqrF2NwiXOCOcW54/RJnYrrmH5z/s+jBL1jRYeQGL6/KkLylt2c/2z+tpeWVEp1gcCda
         x87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879183; x=1716483983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOW2XSX5ui5IvG2zdHYpUVdATFaq4d1s0kZscFLQGqc=;
        b=XjpJ/df99Emz8ZsrxciFI/vLhPlGiqpPwYBPrYxXTik2M2J2hdl7FEL8q9+ZNnNLBe
         u9o5BfwnNsTx9G9mqWLIYHw8uq1lM7JgS9M+FeZmkzJZ66siAoj/AGKkqdACz+QnOf/W
         r0E/fgfwYJhQIDrMVtJBCskkcHCIH8LW4zGaysWrqUdN2P2L54pbgevi/gwGL1vgNynW
         Xl739zR4QrfjjrzTp7lmIoIy1IGsW6u9zUlzIq0AqKXdzTtuoiJzOYnDwg5j+d0DHnK6
         4DIYg60Okx03rGlKgP6k/uH9jpHkxDtUXKhnIi9Y5BYFxu0etmtgtmrlI4VlvUhod+dq
         tM6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/VmodwRd4oalOhykuWAjbyl0JxUoESghX3RaSS4U2AUa8Vt5/VnvItkLEifdJ2SD6bn343TNupJ6704dEBzaKnkn3B41qA7d9
X-Gm-Message-State: AOJu0YyO1RpjKzNjH213s8fw3grFVQlQRPMA9P1hWuy6IMBh7qAUI+Gk
	/PRc50dKrSWgFgHIxoFO4nAA2qx+I0XfejuYGZRNqx9FqRF+Qh0U
X-Google-Smtp-Source: AGHT+IGwwbWpWFAk0GkKFHBxHOTMWinDKyQxOVq+10qbXzio2qwuTjuYgjPhmPTiMTQaUc5oMx9zqQ==
X-Received: by 2002:a05:690c:7506:b0:61a:e11b:4305 with SMTP id 00721157ae682-62560f13b08mr87315827b3.1.1715879183566;
        Thu, 16 May 2024 10:06:23 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e250aa0sm35637397b3.33.2024.05.16.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:06:23 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:06:20 -0700
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <ZkY9DE3v4RGvBqdK@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-5-fan.ni@samsung.com>
 <c91272cb-f42a-4ead-8d5c-e3ab0544d952@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91272cb-f42a-4ead-8d5c-e3ab0544d952@fujitsu.com>

On Tue, May 14, 2024 at 08:14:59AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/04/2024 07:10, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> 
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -635,6 +676,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >           g_free(p_name);
> >       }
> >   
> > +    if (ct3d->dc.num_regions > 0) {
> > +        if (!cxl_create_dc_regions(ct3d, errp)) {
> > +            error_setg(errp, "setup DC regions failed");
> 
> This error_set() would cause an assertion if the errp was assigned inside cxl_create_dc_regions();
> Try error_append_hint() instead
Thanks, Let me check and fix.

Fan
> 
> #3  0x00007f1fdc4fafc6 in annobin_assert.c_end () at /lib64/libc.so.6
> #4  0x0000555fd3edbea8 in error_setv
>      (errp=0x7ffe6d1a3de0, src=0x555fd3fe262b "../hw/mem/cxl_type3.c", line=807, func=0x555fd3fe2fe0 <__func__.21> "cxl_setup_memory", err_class=ERROR_CLASS_GENERIC_ERROR, fmt=0x555fd3fe2939 "setup DC regions failed", ap=0x7ffe6d1a3
> c00, suffix=0x0) at ../util/error.c:68
> #5  0x0000555fd3edc126 in error_setg_internal
>      (errp=0x7ffe6d1a3de0, src=0x555fd3fe262b "../hw/mem/cxl_type3.c", line=807, func=0x555fd3fe2fe0 <__func__.21> "cxl_setup_memory", fmt=0x555fd3fe2939 "setup DC regions failed") at ../util/error.c:105
> #6  0x0000555fd3819c9f in cxl_setup_memory (ct3d=0x555fd8b2f3e0, errp=0x7ffe6d1a3de0) at ../hw/mem/cxl_type3.c:807
> #7  0x0000555fd3819d7b in ct3_realize (pci_dev=0x555fd8b2f3e0, errp=0x7ffe6d1a3de0) at ../hw/mem/cxl_type3.c:833
> #8  0x0000555fd38b575f in pci_qdev_realize (qdev=0x555fd8b2f3e0, errp=0x7ffe6d1a3e60) at ../hw/pci/pci.c:2093
> #9  0x0000555fd3ccca9b in device_set_realized (obj=0x555fd8b2f3e0, value=true, errp=0x7ffe6d1a40d0)
