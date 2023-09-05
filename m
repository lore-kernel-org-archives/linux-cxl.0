Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE07CA0FF3
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjIEQXq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353961AbjIEIvK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 04:51:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC5BF
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 01:51:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500b66f8b27so3688678e87.3
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693903865; x=1694508665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v79Vp67t0wu7INzTM9V9wUXCXrocS2Y+HNPF9qPRgWk=;
        b=ziqZHIunAWU7p7K3xr9b8/3dg/MVVKQqoVki1FNfywZpUOZPGDqGVmGZZY950FQXjx
         pxRW9yauexc2MoZL6FgVxLW3Z9fSU7JvysxWv5/I75AfOhekTNeP8Y0sVzrjto8XNHla
         aR3//VJw864rswS6mpYTSMj9PGi4n/gBoLf5ZJSSE9+euS7cOa/Wb+WU3+FKVPmwi+uJ
         /wwpjqCDF/SUkud3Dz6hjPkxrjAOop0ZY6BWIETGJhKcPMEigK+NVwUhdnNuzdowBtZy
         NbEVMGlxYKshoGJwDm0RupnR22n22C7aUdvhjsDHnvDp7XxGpJj/Tsu1LntSSLbUGj2H
         LlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903865; x=1694508665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v79Vp67t0wu7INzTM9V9wUXCXrocS2Y+HNPF9qPRgWk=;
        b=mG0Q/PISNSjnJI9jFauy7OkFSW8szjCDUEOZXDJ2S3LC995OUQCJ9CdSDeeJMksUl3
         Ab5X8D1l2IcT7Njjpv//V+4rfqBdY5K6vmbUFFxLewiVdfn80yHFp8FVVv9vVnCwf97e
         PzTssSm239p7WGJThMyogcRyd1Q5fiB4U8MHFEp4fCgbUoq3+1160DYKTIJZLm2mrMnQ
         l+5b80LnWpykj+dM7+qkWlvTzzGBf2Zz8N7M2ti1oRy+owMrV/LmbKstQyaAkLnFSx8X
         x+YjVxWs6ht9i1M8qTgjqdqCOBH89iYGDL2uZeG7ccDCALMiCw9HncaxpqkJMkcbDknH
         Z7Yw==
X-Gm-Message-State: AOJu0Yw+k3zekGyUC5mWYnp+LacYN+i8yCjDKefk5/G/vLB6PymLEA7b
        fRfjCppEmoPhTzpcd06zY8ViiQ==
X-Google-Smtp-Source: AGHT+IE3+mJ69nsks5sMq/kErs7OpOTeV9r2todNYkVk8DOjR9SXuZgA/BQYX7CysP4wbODCajNPtw==
X-Received: by 2002:a05:6512:234a:b0:500:b872:7899 with SMTP id p10-20020a056512234a00b00500b8727899mr10427134lfu.62.1693903865146;
        Tue, 05 Sep 2023 01:51:05 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr. [176.184.47.79])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b00401dc20a070sm19330903wmc.43.2023.09.05.01.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 01:51:04 -0700 (PDT)
Message-ID: <0318a8c1-2c04-1a7b-ccbf-892946cf29b8@linaro.org>
Date:   Tue, 5 Sep 2023 10:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-3-gregory.price@memverge.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-3-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 1/9/23 03:29, Gregory Price wrote:
> Call CXL_TYPE3 once at top of function to avoid multiple invocations.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/mem/cxl_type3.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

