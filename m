Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B349198E6E
	for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219211; cv=none; b=GPiWRVYO+SHbCaKYLZK5tI7IdLeonfYWTUqh6ABbHepke/hMMgVG1LPjR3Db1srgBwT11EZxDYqQvIu7SwgJJrTKXUYHWyMaYK1lTwMJGZl2macrw5FIbgOKNMakjnK9KjmpjnEfBh1xPZVzSaY9C3yL0A309FCwKdsCVoRbmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219211; c=relaxed/simple;
	bh=2xnS5Y63VxToTjo460ljCGQ/0jO9jScJ+HudtmhL6b4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmn2JI/K/bqDZQ0Q2o4OpnFmfvG1jApv23KxUuDMFsvEhH/KiAH7nexGlZ53aLWOWZB4hz87NqZpla7gGDhHZgdcBTeEspG6zaeTBoWl5qiWZ2uq9omQE24WLnFSu+Lc8X4wPrwT/aJGsms2/pCF8yufV93ZhdUGqNIeWs6IdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBmDwh4B; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBmDwh4B"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3a97a6010so64059017b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730219208; x=1730824008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNz7zvIV8dkYQqm5r25/46W/cbbWVnUCIgSSCm4lcoc=;
        b=dBmDwh4B6f9+TVZQ4jLu2x3oerlL0nSCx0hSS6lDuSCT1ne4hj01Cs6fad0R6UPqrH
         0RqhqBRD2uZTtj+4AOizZxP2I9qOSZJ9F/6K30OjMSFaNZOjq90zPQGDuZsauGH6CKqk
         n5kos00g0FpbieenoF50dlxZXXaYOwhDPvum63KXJ1AsVh5yggSIg5eKAcFRxB9AU9Br
         NUHIDssJa385QefphuKOsko/o5qpeT2dw+KdYmrSyfG1PDTluXrU+Lzbg8hrCtjfpoK2
         Dd2xVWH6gnktxN6XRAa6zXQVI94ASPHTNLf1XxDdk2/E4n6+V1JOKP8VgZWNzzIu6YUp
         eyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730219208; x=1730824008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNz7zvIV8dkYQqm5r25/46W/cbbWVnUCIgSSCm4lcoc=;
        b=MSk2N7WRJd1vzrU5nW47OSGV8j2hOrVEGgg299gcN8ijp9OjUpJ6Ffb9cQ5j6OjLVk
         uZeBM0+Dk5jMvSiOvurpe9sCm03T7CqNJRtAEL9QLqQ4VwEGkf1wWWs6jsumWhvG0rhU
         RPRQHzax/RFPCsCNRx3tvGfCLe9qUkK3swVPLXy96RPdTNUDLDJzDBCdZXUDWuVS0Kmn
         fufYccnDJ/Q4qOkKB9qCnk2vF0O8Usiv8aP95bDGzreMZVUf+NsO+elVGwNd0YnDK6Xb
         s+xgB3Z7Nwl2c8kR9WahP70OpaUEb6DsUuKqskMyLLlS1hofEnLad4RZDjwFAgnveRgg
         CPHA==
X-Forwarded-Encrypted: i=1; AJvYcCXO3fbpEOrzczvrPA/5wHFQNekYkzDz6Cw2hV9+vC9LJ+rGgwH1enBImQDiGCZwWdu9+E2284+9UWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UDey1r0B1Q/s7lTxT/vOeM3qfhpKWaD1QJQSSrzfre9SrymA
	zwQE1Tn/jJo1ZHoy16LS/vHIkEmAdBg73gWixN9MJIjmVcMF8VkP
X-Google-Smtp-Source: AGHT+IEx5cx+H/vRnj3+XiSrvVcTyv5l1RSnPWY4t3VZwdC+aoAcizhYS0/Ff5Hx1OnoFRckiGxU1Q==
X-Received: by 2002:a05:690c:9c0f:b0:6de:a3:a7ca with SMTP id 00721157ae682-6e9d8acb4a9mr154068787b3.32.1730219208085;
        Tue, 29 Oct 2024 09:26:48 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bdd42esm20204777b3.47.2024.10.29.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:26:47 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 29 Oct 2024 09:26:41 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mst@redhat.com, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, linuxarm@huawei.com,
	linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
	Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/6] hw/pci-bridge/cxl_root_port: Provide x-speed and
 x-width properties.
Message-ID: <ZyEMwUnnufY0bbvU@fan>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
 <20240916173518.1843023-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916173518.1843023-2-Jonathan.Cameron@huawei.com>

On Mon, Sep 16, 2024 at 06:35:13PM +0100, Jonathan Cameron wrote:
> Approach copied from gen_pcie_root_port.c
> Previously the link defaulted to a maximum of 2.5GT/s and 1x.  Enable setting
> it's maximum values.  The actual value after 'training' will depend on the
> downstream device configuration.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/pci-bridge/cxl_root_port.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 2dd10239bd..5e2156d7ba 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -24,6 +24,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/pci/msi.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "qapi/error.h"
>  #include "hw/cxl/cxl.h"
> @@ -206,6 +207,10 @@ static Property gen_rp_props[] = {
>                       -1),
>      DEFINE_PROP_SIZE("pref64-reserve", CXLRootPort, res_reserve.mem_pref_64,
>                       -1),
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> +                                speed, PCIE_LINK_SPEED_64),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> +                                width, PCIE_LINK_WIDTH_32),
>      DEFINE_PROP_END_OF_LIST()
>  };
LGTM.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
>  
> -- 
> 2.43.0
> 

-- 
Fan Ni
