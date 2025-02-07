Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878FB1A23A9
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925220; cv=none; b=LqkkW/IrQpLG94gSEq8IQsQsz6m3NKmyTUICM3PDFn/5bulZKul+IR9xx/UiLxSTnL6umLAf/fG2RN4gm7OpMRknGshonJdMXxEEfxGmPGjzkmucX+NGA2FWmoKkj06mAsXhPcZUp6EQRzHYZodrLgKnGBlF+gp9z2pTVta23n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925220; c=relaxed/simple;
	bh=Al82twb3ZORnkFpPKGWaa+dGonLUQqELTg90LuZe754=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBwPSig+NYRckUDeOocw7bHg+5+G/jd/61dQDJDdZaoV2NbWpcui9ZQEn8yDi54RO04JHdmsXSOZb/CwTuP9go0LLxGGOLlGA1GrlP1wJ7MoX/suUGV8TdkdKbhxmnkyB49vYM1cRV9MDkh4TLyUfhZyfc2LSCQAdE7fkRpdOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU//l8MD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU//l8MD"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5b1c4b952dso1625345276.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738925217; x=1739530017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ELHCCsWgc5ETP5HPI0Vfzd1JQz/muXIEmMEw0zlWiV4=;
        b=OU//l8MDT+sEMW0uUdsIRvwP5nJmTdKnPNX/IGy25g6w42OZrboAiuh7ClW3wsbzzV
         Bs9uy+bm10G8Y1TzG5TXvAp1ixFcp3SKGEeAltgh6GHkr03sAo7CNQHLt/6b9RBtTgkp
         uDTVFIf+3UWl2xg6tP6Ee4IgEceddd3pr8lSogbOZAZshVXC15+kU53mo5rfzZOFFLJD
         /MFpbHEGL4haKALxcLDxxgMftFawuoX8VGDhp16en5akquKcqwbtlceQRFYRT/0VD8kU
         u5pjBvvTPPRHG9VzSQnGi18MuFLR1q1LuvDgv22FJKkE3cCsGD+Mh0F7xjaJdh2nj5Ek
         6C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925217; x=1739530017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELHCCsWgc5ETP5HPI0Vfzd1JQz/muXIEmMEw0zlWiV4=;
        b=Ccjg0B6DN5pZW3+ceJVszGv60n2AT6AuOUwBxvWI/2yYab1LND4JLlQ7u2eBg4q63h
         o1R/ZMT8iezc6TXlSJN0e2aSKgBWP2FQKo0PVg8nKpWgk9RQ8i28OPznUU6e3ov0gzfd
         VL7a3GX50lXi2o513buwQ7j3bpgkBIk5gvr7W6NVj2SzNNb5uOneLupOuIvf4kYNts/s
         0EmpxvoIVjYxsRr7bn2/ez4oBf59ukA/ZSSnmeVqA5ZeKd+NQ5h9g9nzj5hnV3Q5Kuzs
         XJ2fObIzOyQ9DbK8w/xoIBZvoAdHoIAOnr5Qo9JO4MOfNvPzUNq1eDA+97zeCtTngD1r
         +0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzBtuzCx+i7N9Vk11RF2mOO6eVWaB69G6cvnzwehn6JAWICgLKWyyBfemFctyID0eKmIYQIH7tbdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6I1UjxulWKuIFKF4iu5VFNfFOvQVqUhyBQ4MP+ijeRFmeQ9K
	6anDKfID5l3oRUBDDa5ypN2DCInlVQ/wcDTkzI2Z9yWzG1ay2KSIc4P5ef35cT1Zqmw/Bc9kuHs
	7JjfB71njJFTOQaZeKhSNaave0ovl9SvihD4njYHI
X-Gm-Gg: ASbGncvlVsZ0zzlLshcf6mvrI4tv9GhKjXyJoIGlmvUadV5BYASjWgwlu8YrAHqCcHG
	+NrdSIuTzOImUXZ1nLU+YK44pcwaCUkvIdzer7s3Z5qwDPhg5RdqVX2Cjse8t7DERbpFXmwfMew
	==
X-Google-Smtp-Source: AGHT+IEgcCQQICaOTy5gqNVXRGpv9GRs+ijB2WHBN2P3UBkZlfZ+yDK6vEcPWA2hR8HOw82quOstRHxPnC/ECXmCrrY=
X-Received: by 2002:a05:6902:2581:b0:e5b:19a0:afe2 with SMTP id
 3f1490d57ef6-e5b461e105emr2270733276.24.1738925217458; Fri, 07 Feb 2025
 02:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205040842.1253616-1-dave@stgolabs.net> <20250205040842.1253616-2-dave@stgolabs.net>
In-Reply-To: <20250205040842.1253616-2-dave@stgolabs.net>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Fri, 7 Feb 2025 18:46:21 +0800
X-Gm-Features: AWEUYZmWY_l0vX8ILy8cFXiRWsmElLKYT2kB7nZc-bpoHjA53Bin39yUUGKZsnw
Message-ID: <CALX8JfQzofLZwUj4sNN_3A4aL-LMe3mUX1-PE35=rvR0pzEfHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cxl/pmem: Export dirty shutdown count via sysfs
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com, 
	jonathan.cameron@huawei.com, alison.schofield@intel.com, ira.weiny@intel.com, 
	vishal.l.verma@intel.com, a.manzanares@samsung.com, fan.ni@samsung.com, 
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Davidlohr,

I tried the patch in linux-cxl next branch,
ERROR: modpost: "cxl_gpf_device" [drivers/cxl/cxl_pmem.ko] undefined

A few comments inline.

Thanks,
Yee
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..bcf05d010a77 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1141,3 +1141,26 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>
>         return 0;
>  }
> +
> +int cxl_gpf_device(struct cxl_dev_state *cxlds)
> +{
> +       int dvsec;
> +       struct device *dev = cxlds->dev;
> +       struct pci_dev *pdev;
> +
> +       if (!dev_is_pci(dev))
> +               return 0;
> +
> +       pdev = to_pci_dev(dev);
> +       if (!pdev)
> +               return -EINVAL;
> +
> +       dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +                                         CXL_DVSEC_DEVICE_GPF);
> +       if (!dvsec) {
> +               pci_warn(pdev, "Device GPF DVSEC not present\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
Maybe cxl_gpf_device needs EXPORT_SYMBOL.

cxl_gpf_device
defined in drivers/cxl/cxlmem.h as a prototype
defined in drivers/cxl/core/pci.c as a function -- #include <cxlmem.h>
referenced in drivers/cxl/pmem.c -- #include "cxlmem.h"

Refers to other functions (external call) in the drivers/cxl/core/pci.c,
EXPORT_SYMBOL_NS_GPL(cxl_gpf_device, "CXL");

>  struct cxl_pmem_region_mapping {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 536cbe521d16..ee0c93fde50c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> +int cxl_gpf_device(struct cxl_dev_state *cxlds);
>  #endif /* __CXL_MEM_H__ */
