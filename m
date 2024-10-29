Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914351D79BB
	for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219886; cv=none; b=pj4WtHOFWP+LIqDasnNETxNo0z/+WRc0rZ9tpgmzwvmOTwaSVLTiGVhjVFQyuC+FyqWm0SmTGUuOnCOeTKwnFYqdBnPYPGPf/sq0eMnsRXvPG/Ns+Q9IKyzmRBGlGrk8tqXWG3CUt73hh6JIU9JOHnJ0kbmWDFNdFtJxHgomVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219886; c=relaxed/simple;
	bh=qkdJmMVHrXF/CV5lUCp0TIHxJkqkuYM9pcHCxkbzLb0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxOe2GDPPazG832ssrm4fasd1hkBRM5vNJnDDvxNI4+CqUeZuiEqW1fvS0mF965Oo7kXsURrH4Q5xLaw39wiKZpwxKsg/OqyOVLnhyEeBdNclzgRjTgnS1trbfLGGIr3mMp0W3k9PQAbtCwSK8Zu15qL3c2vOHibQygyNxqpL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d95lXTAJ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d95lXTAJ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so5759313276.2
        for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730219882; x=1730824682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODbIuKIbS3Koe9iJM7c0d89FHdP+CQz1EaZMkqKeLSk=;
        b=d95lXTAJdcGcYru1XWRNdsY6SUg+lz5sT1/HQBwRfYYFRy4Xb8uwX2B/4JSmvQBFxl
         xa3NywmVpuKbl9vjpBdmVfh4T/VigpCxZGn06Fk69ZjoeJ7GxlBrOOc8EYdjPwpLWSN5
         tyAgzccQX7XYVR3DGhXkY+SY7tK+qPzUhPtjlfDN5xJmY+nSnO4YTsQulMPDFRMxeBYq
         RF7RQFgUNpF47IQvZm6V5HI4aLsQ7kxikSXkmS84QDREwjf2rfyCDlydhtuIR8UXEn4t
         FkJXAUqjENf585vmKZ3e3I5JeZBDSJuOtho4zPsczbGmOzdt5M8t+n+0neCXQELzqebu
         gE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730219882; x=1730824682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODbIuKIbS3Koe9iJM7c0d89FHdP+CQz1EaZMkqKeLSk=;
        b=UIS8nYlzBsonurzENHWemEg6VMH+RommmS/L1kykQMmwceDkQc1+Le3n7dPkSy/Hn7
         7q+d6s34iZ2RS8sjd+AQIdnDiFp/uoPfnfFxdNeoVIQ3vmn8JzU+UGcFupLyKZscCg19
         MkqVbzALjOxjb9h8p0hLpX/GC4Tzn3HSi1qo2gmuVVqNqGVQSwYM4j9H5/lADktDAhYC
         OhOCukI/mFglHOxKN3MW5+r9WzplEDBbnrmSWe6287zoda1P5dS6tWJRAEoivTJqkqoU
         O/zjq3Schb3IHit9bEgVIT+0Rr+3M1SjO8mJZIRyLyKogrSC5JdOl1PI3hRTsq8smY0m
         y3bw==
X-Forwarded-Encrypted: i=1; AJvYcCV40l7NAUo3m6pluyMrqhIjw/8+I8jykmeSAnIN+5yEwOpwYqZ7Wem5Wx+otHED9cGd9jsKg4omMDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83OxgNEhagJ/hGD0HMfQYFFniMogCpLlOotbwECyEoeO/C36P
	h8uhs9nZ/PYKCBdCT+ykfP9joEBF0ItV/JVdtye/8rp8ZSg+OxB4dx4bQw==
X-Google-Smtp-Source: AGHT+IFnVZUsHRC+i95gktwWpb3xO12II0RNnDwtijDwQMaKuwGfCJwjoG3wajgf/4kSEjUmC+5ojw==
X-Received: by 2002:a05:6902:2482:b0:e28:e576:f712 with SMTP id 3f1490d57ef6-e3087a49591mr10540327276.1.1730219882507;
        Tue, 29 Oct 2024 09:38:02 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a01fae9sm1946377276.42.2024.10.29.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:38:02 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 29 Oct 2024 09:37:59 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mst@redhat.com, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, linuxarm@huawei.com,
	linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
	Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 2/6] hw/pci-bridge/cxl_upstream: Provide x-speed and
 x-width properties.
Message-ID: <ZyEPZyUMMo-Vlgpz@fan>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
 <20240916173518.1843023-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916173518.1843023-3-Jonathan.Cameron@huawei.com>

On Mon, Sep 16, 2024 at 06:35:14PM +0100, Jonathan Cameron wrote:
> Copied from gen_pcie_root_port.c
> Drop the previous code that ensured a valid value in s->width, s->speed
> as now a default is provided so this will always be set.
> 
> Note this changes the default settings but it is unlikely to have a negative
> effect on software as will only affect ports with now downstream device.
> All other ports will use the settings from that device.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/pci-bridge/cxl_downstream.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 4b42984360..c347ac06f3 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -13,6 +13,8 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/pcie.h"
>  #include "hw/pci/pcie_port.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/cxl/cxl.h"
>  #include "qapi/error.h"
>  
> @@ -210,24 +212,20 @@ static void cxl_dsp_exitfn(PCIDevice *d)
>      pci_bridge_exitfn(d);
>  }
>  
> -static void cxl_dsp_instance_post_init(Object *obj)
> -{
> -    PCIESlot *s = PCIE_SLOT(obj);
> -
> -    if (!s->speed) {
> -        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
> -    }
> -
> -    if (!s->width) {
> -        s->width = QEMU_PCI_EXP_LNK_X1;
> -    }
> -}
> +static Property cxl_dsp_props[] = {
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> +                                speed, PCIE_LINK_SPEED_64),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> +                                width, PCIE_LINK_WIDTH_16),

Not sure why. For the root port, we use PCIE_LINK_WIDTH_32, and here it is
PCIE_LINK_WIDTH_16?

Fan

> +    DEFINE_PROP_END_OF_LIST()
> +};
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
>  
> +    device_class_set_props(dc, cxl_dsp_props);
>      k->config_write = cxl_dsp_config_write;
>      k->realize = cxl_dsp_realize;
>      k->exit = cxl_dsp_exitfn;
> @@ -243,7 +241,6 @@ static const TypeInfo cxl_dsp_info = {
>      .name = TYPE_CXL_DSP,
>      .instance_size = sizeof(CXLDownstreamPort),
>      .parent = TYPE_PCIE_SLOT,
> -    .instance_post_init = cxl_dsp_instance_post_init,
>      .class_init = cxl_dsp_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
> -- 
> 2.43.0
> 

-- 
Fan Ni
