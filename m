Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F5C5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 16:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjAKQmn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjAKQmJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 11:42:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29409175BF
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:40:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso8330446wms.4
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=al2lGChPUZ3u+04q/VuYIYJIGmw3V4aA55LXLCAGrNc=;
        b=c5Pg7OwpjWmcQzY+01UbkCzo0MWGwqixZuh29s+Wrbyq+zOm/anYVg4YLDlDwwVGkF
         51bOEuS9fdbjhyhzhVVtUpk0uf/GKfnPvwenG5UApg5K26OHqV0ppIlEhbQeCn2AVQ8a
         F6teOD6bvVvWfWZ8SfAvqubMdmMZQwMKJv/77uHEvQNJ6YKdtggP3fO7A1JQI5VhBm1a
         MBCz/EhkT19lBjNzQBIwSU1cPU8w/QEGnEMBMochBhHNxkPz3WOVMPszWDZT2s1le6TK
         DpHminddWeWz22Xl+ulIfxC1pYTMtu1dFrP4rqvIkEN9o99yizgZeRorE3K/tR6DiElZ
         wDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=al2lGChPUZ3u+04q/VuYIYJIGmw3V4aA55LXLCAGrNc=;
        b=vpVHZ6IgJ8E4EZ/4aY8VgTibnT/xTUhEQkMnI05cu8fkHWJP9VEtkK8jZhqTbP/JMA
         VwTr7+Mh/1AHh9H4RfBGBv3bG88odWP8xV9Sszmo0s70g7kMlfEDtOb+RWNau/d4MNon
         42YeKpN86RaD/af3/OePX8rvlf5StG2FUTyuIK/HWzlObeZXS0ZOgIdDp9w9Lfipcpsu
         MfzySAGtJkJrJDl69TnSAWXMPaV522Gb0QVqdsW3Aa6PQFAQIHwMsMw7Sk+HzNP7eTQD
         auxB2WK+Hois1becSEVK8ah+Nrmke8cbHRdQgZwS6bQtUFZpVYNH9ZxuhgLFkRczWT0x
         0TiQ==
X-Gm-Message-State: AFqh2kqXHx5z0NT093ad02TSMyl+yL5gg2Tehy1BQkwiQijqVm2p15T7
        jUghzppxJH0PfcCOzZJIv3oOdA==
X-Google-Smtp-Source: AMrXdXs2Khrvo3qBkzDDJlR3UNHhL18rQ/QKGKYO0vpabeNFRzD8PS/h83ffRkQwx1ju2t5qn36enA==
X-Received: by 2002:a05:600c:358a:b0:3cf:8d51:1622 with SMTP id p10-20020a05600c358a00b003cf8d511622mr53918847wmq.1.1673455247755;
        Wed, 11 Jan 2023 08:40:47 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c4e5200b003d9876aa04asm22563096wmq.41.2023.01.11.08.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:40:47 -0800 (PST)
Message-ID: <8cb2447b-a2e6-f137-5cb3-a5439a35bb7f@linaro.org>
Date:   Wed, 11 Jan 2023 17:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] qemu/bswap: Add const_le64()
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-7-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230111142440.24771-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 15:24, Jonathan Cameron via wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Gcc requires constant versions of cpu_to_le* calls.
> 
> Add a 64 bit version.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/qemu/bswap.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 346d05f2aa..e1eca22f25 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -187,6 +187,15 @@ CPU_CONVERT(le, 64, uint64_t)
>    * used to initialize static variables.
>    */
>   #if HOST_BIG_ENDIAN
> +# define const_le64(_x)                          \
> +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> +     (((_x) & 0x000000000000ff00U) << 40) |      \
> +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> +     (((_x) & 0xff00000000000000U) >> 56))

So looking back at 
https://lore.kernel.org/qemu-devel/20200917163106.49351-4-philmd@redhat.com/
this patch missed to update the function description:

  /*
- * Same as cpu_to_{be,le}{16,32} described below, except that gcc will
+ * Same as cpu_to_{be,le}{16,32,64} described below, except that gcc will
   * figure the result is a compile-time constant if you pass in a constant.
   * So this can be used to initialize static variables.
   */


