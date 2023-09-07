Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36070EC873A
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Sep 2023 15:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjIGPmb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbjIGPX5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Sep 2023 11:23:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5A184
        for <linux-cxl@vger.kernel.org>; Thu,  7 Sep 2023 08:23:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4bdso1437057a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 07 Sep 2023 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100232; x=1694705032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8vikMzN1ZOFRuwLydXCyr5zoPLYWoyrQdvkTeY97zE=;
        b=mavkA8XWCvyNm1utaUWhYLVhayb7Ah9vEN/baqN/8Q3R5Sdx8uYtSAdd2kc37sIgSd
         35n5IZ5g+f8HnJmmi9ErDTWwbW8nOHauXBWKh8jZDkJoe8uVhUZ6IPzWVfEtxS9bnQ4s
         5iMvok4/uNuOnU4VMICMyKJWIZRHwyehXfckd58z2doZLDiFuodEilZ1jG0mCipSvMsW
         yxHnHUjR+qu1UzXB0Y9FersbbFZXy3m/uA8mzO6x2o63iFG6wIycISCWCVLnHduAejF6
         5z0Ksay/z7/8wC/KtleE37onyviEvLy/zwRZ0aODcjelTs1pi1lVTVhBZEuKaEUPWRB0
         yqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100232; x=1694705032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8vikMzN1ZOFRuwLydXCyr5zoPLYWoyrQdvkTeY97zE=;
        b=bElMqFs8Z/2bGa72ErMKfQCR0m/HU5Hs0QXwDUTszoIlYaaM3WpItnZTXd4ENpKni+
         08ZWnEsi/3UsuPCl71oyAAbyaFx8kIq8wHQh7OxHGABYGZHVH8DxFlL7JmtDQHznZUNP
         Tj7qkU8AghFaXNWMkpaYvcsAP5sfNOxfIU2wNsl9OxnBGKBvPtsMKOUocUnLRewIRkiy
         aQmf/NDiCUohC2z8oiY81YjQDYyIv3QA5fYsGZwgtwyinjNfx9EDLg3h0NxDQyQ9jh+X
         Gm5qTIyfE5NiSpQ/lucUYIGpjrvoPB3SrRrortyjy70Q8H8J4MUyconbqaNDy3+QgXQ3
         3xtg==
X-Gm-Message-State: AOJu0YyHZZeRZ62va8yEQVdOVr4pAsuM3/yJem2wfC2WBKLWMttcgTPn
        V5/JlnNO/cag6sH/IZn/jxU3v18HUrb0MW/rWbI=
X-Google-Smtp-Source: AGHT+IHzDXtRiIEfeIaPNV+9ZTWkp3nFn3ZyrICqte9OR/wa4BrHv8nzKaKazub5LYTl/1tFLcKqtA==
X-Received: by 2002:a17:906:30cd:b0:99d:ec81:df58 with SMTP id b13-20020a17090630cd00b0099dec81df58mr4257759ejb.19.1694090478309;
        Thu, 07 Sep 2023 05:41:18 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr. [176.131.222.226])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009a5f7fb51d1sm10236509ejw.40.2023.09.07.05.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:41:17 -0700 (PDT)
Message-ID: <b7b7ca18-ec98-d402-9ebd-6ebaf49f7243@linaro.org>
Date:   Thu, 7 Sep 2023 14:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/9/23 13:35, Jonathan Cameron wrote:
> Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> and CXL Type 3 end points.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_component.h |  10 ++++
>   hw/cxl/cxl-component-utils.c   |  27 +++++----
>   hw/cxl/cxl-host.c              |  65 ++++++++++++++-------
>   hw/mem/cxl_type3.c             | 100 +++++++++++++++++++++++----------
>   4 files changed, 140 insertions(+), 62 deletions(-)

If you ever have to respin, please split the 'hdm_inc' introduction
in a preliminary patch, to reduce the number of changes and the
probability of missing a bug.
