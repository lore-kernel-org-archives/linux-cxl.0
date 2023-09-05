Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D3C83F2C
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbjIEQYN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353949AbjIEItC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 04:49:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A240AA
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 01:48:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401187f8071so14571165e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693903736; x=1694508536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gvuu+n42szEBpyOL3PLFtjXB9ZXWCf1x5xn2iFhGvI=;
        b=i34Fj3yGWj8umZhT4GW9/irw8hbTNFFCaaj9KckAeDX6QmraNgRZJ8/PLqFVt+OLsG
         PzUkrr3qFfUu76Sk9+yRzFZDu+u93QGMtPSMMytYh7nsLNuQE3B1mElHGtwPTiMNx90B
         q3yHnjoiypTgGMuqH6SfvkmWB2eU2p5LARHU1TiCvmpZ72liWjqg5hgFYn5pLiD6GtNS
         EsqRc33YQ1AI3lwp6sMC+1Ydd11b5bhHpVh6Mb/H7sTZwp4w+hrNNCTskpx8KS0YRjjE
         Kfrx1UF7yGmKFcfmyajjMPsGtLS8TvUixRaRnvht4HGKC1uQWprjlJvDNIBk+lajZkid
         ZnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903736; x=1694508536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gvuu+n42szEBpyOL3PLFtjXB9ZXWCf1x5xn2iFhGvI=;
        b=SNSI7p8q3OzRMg5zQFZiCpSzFuX4SuVNKs4v+WcWB4fmO5NYVo8yPfFaQXkKp4yB/j
         hmiOc2fWvirbxjB5w7Fi6r+v8F2jkz6BXRsxquyKvpFUnYJmfGc6RJxQocOyp7ytHiz2
         t7/uZ1hHSyzLMPqpDLKX/jRaJnrcr6YX8X0PzO9yU5QdZv2IZ6bVhf3cjJAatK+bb3wQ
         09dExdrsVSjucZOzZrJcUaCuLod+pBI42xptU1tngs1zD0IJ+XVcTiA+ieX8Due2+vQI
         iNc8qvyWvANRoEAh3wXPEz7LijkKtD4l5aO01N2PgbzBqbf0ZZFSHUqPuvqOHnKRm3xU
         QtlA==
X-Gm-Message-State: AOJu0YyqBwmihxMqtPRazthyHNn2fRKZXcg9rdssYqmkvCqMKeDbLTkf
        iE/+Rv8WFk9zvysqjMBR/+iy0Q==
X-Google-Smtp-Source: AGHT+IG2H8+WGOu/SYUEp+7oYi2OkfupVCJKA01NZ7bYZIfOp6mpcNc8N/FmY44RFF2V27J17Wbk2g==
X-Received: by 2002:a05:600c:c6:b0:401:c717:ec6d with SMTP id u6-20020a05600c00c600b00401c717ec6dmr12114419wmm.15.1693903736677;
        Tue, 05 Sep 2023 01:48:56 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr. [176.184.47.79])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm16127067wms.39.2023.09.05.01.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 01:48:56 -0700 (PDT)
Message-ID: <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
Date:   Tue, 5 Sep 2023 10:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

On 4/9/23 19:57, Jonathan Cameron wrote:
> Will be needed so there is a defined serial number for
> information queries via the Switch CCI.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> No ordering dependencies wrt to other CXL patch sets.
> 
> Whilst we 'need' it for the Switch CCI set it is valid without
> it and aligns with existing EP serial number support. Seems sensible
> to upstream this first and reduce my out of tree backlog a little!
> 
>   hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 2b9cf0cc97..15c4d84a56 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -14,6 +14,11 @@
>   #include "hw/pci/msi.h"
>   #include "hw/pci/pcie.h"
>   #include "hw/pci/pcie_port.h"
> +/*
> + * Null value of all Fs suggested by IEEE RA guidelines for use of
> + * EU, OUI and CID
> + */
> +#define UI64_NULL (~0ULL)

Already defined in hw/mem/cxl_type3.c, can we move it to some common
CXL header? Or include/qemu/units.h?

>   #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
>   
> @@ -30,6 +35,7 @@ typedef struct CXLUpstreamPort {
>       /*< public >*/
>       CXLComponentState cxl_cstate;
>       DOECap doe_cdat;
> +    uint64_t sn;
>   } CXLUpstreamPort;
>   
>   CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
> @@ -326,8 +332,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
>       if (rc) {
>           goto err_cap;
>       }
> -
> -    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> +    if (usp->sn != UI64_NULL) {
> +        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_DVSEC_OFFSET, usp->sn);
> +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET + 0x0c;

Could it be clearer to have:

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
@@ -23,2 +23,2 @@
-#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
-    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define CXL_UPSTREAM_PORT_DVSEC_OFFSET(offset) \
+    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF + offset)

?

> +    } else {
> +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> +    }
>       cxl_cstate->pdev = d;
>       build_dvsecs(cxl_cstate);
>       cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
> @@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
>   }
>   
>   static Property cxl_upstream_props[] = {
> +    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
>       DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
>       DEFINE_PROP_END_OF_LIST()
>   };

