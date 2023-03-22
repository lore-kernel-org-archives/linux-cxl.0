Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF5C6FD1C
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 10:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCVKej (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCVKei (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Mar 2023 06:34:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668652F57
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 03:34:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso12697018wmb.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679481276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYkfG22HjGs03l4ehDPCyiQgubtep/FS2RbjbyPAMKU=;
        b=mw1Rk2Evr2Rb822D/JkRjVOtW4/ZadooypbQMLQakBrT5nsjjawNDD7DyVO5uve7py
         hhrmqoE4n6pN4wLLIlOjHkxhDV+ktp3DgIhuQSNxhjIxNhyc+UBzo16/WG7wGeX8cuqW
         QSHzNN3hWcabPdX6zUAbiEqR93zd8HzWAOTLZAy8ZiZ2GTOPfwHLbiKN3S1dCFZL9tIv
         hTbRdp998Y39uJs8ogrP3r5R214m8WyZPjmRcpNdPTqtadEBYNhNceNX5qK3vduVxq/b
         eJYNWmoharT0A8wHFgla7WTlEsreuZTeSe0j2KvQMyVL1LdvejbgubFdM1xn4bf7/O+r
         6mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYkfG22HjGs03l4ehDPCyiQgubtep/FS2RbjbyPAMKU=;
        b=wtggwxvUL+kMSwQEezp+aJF/kymfp1401xLlsHInNf5p5zOQa8FEG+wNbx/lCNYYdF
         lRf0/35bKY7GW7ZqV2qseLSntT4PoImxsBx5SKNjm8XZqHy/cEI3RTenNUUhKqNkPO3X
         qWwUtqoGXcEllAjhTrmUjnnw+owFrY56RCWTC0SbhlvLWH7iWYSzYAPriraZuHVXZJ8r
         /gDFOUo2XPT4vX0O30mXZHrpb58k80HFf7qopI7mizuDw8cIAYBgY1lcVHms3YX9wbCP
         ROce4fo6gX3iHsHkLDjghHYesQNpag0mpwDF5SzPhN+9xRGb5E1yqbyCthosSmkp2JPb
         eSmQ==
X-Gm-Message-State: AO0yUKV1aiBHwCxG4smBEYELqSn20h4Ta3E10Wmpyw+GxnnIooaPeoB1
        xDdpwHLAmTpq4UZ7VazXXfhpTg==
X-Google-Smtp-Source: AK7set/DZnvlMmeRk+0KDqjB7LCGWSlykJixPT378PklHt04EXgENQgDHwcOY8qGnUzaSXMFeyB9rQ==
X-Received: by 2002:a7b:c383:0:b0:3df:eecc:de2b with SMTP id s3-20020a7bc383000000b003dfeeccde2bmr4976466wmj.11.1679481275777;
        Wed, 22 Mar 2023 03:34:35 -0700 (PDT)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003ee6a91b596sm870914wms.29.2023.03.22.03.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:34:35 -0700 (PDT)
Message-ID: <366919e9-e7ca-28bf-f61a-813634c4a115@linaro.org>
Date:   Wed, 22 Mar 2023 11:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH 1/2] hw/cxl: Fix endian handling for decoder
 commit.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org
Cc:     linuxarm@huawei.com, Fan Ni <fan.ni@samsung.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
References: <20230322102731.4219-1-Jonathan.Cameron@huawei.com>
 <20230322102731.4219-2-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230322102731.4219-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22/3/23 11:27, Jonathan Cameron via wrote:
> Not a real problem yet as all supported architectures are
> little endian, but continue to tidy these up when touching
> code for other reasons.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/cxl/cxl-component-utils.c | 10 ++++------
>   hw/mem/cxl_type3.c           |  9 ++++++---
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index b665d4f565..a3e6cf75cf 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -47,14 +47,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
>           break;
>       }
>   
> -    memory_region_transaction_begin();
> -    stl_le_p((uint8_t *)cache_mem + offset, value);
>       if (should_commit) {
> -        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
> -        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
> -        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
> +        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
> +        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, ERR, 0);
> +        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>       }
> -    memory_region_transaction_commit();

Indeed the memory_region_transaction guard seems pointless here,
but it is a different change, so should go in a preliminary patch IMHO.

Conditional to this patch being split:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    stl_le_p((uint8_t *)cache_mem + offset, value);
>   }


