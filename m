Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A5C6FD1C
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 06:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCNGNT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCNGNS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 02:13:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB2C3
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 23:13:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so13227917wrh.9
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678774389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUGWd2Fn/6JnOvamELR/2rfGI/Q0AO+PqIEnSloS4VU=;
        b=mR64jmsT9BCooYXoZNzxJQVAh4Cop2oNiL9DmJGqcQzftL30I0DWIW8F2AdJNQd+tJ
         8AEigZ9iDWqLB6SyPiPwR/l5VRsiifEMAFwuHJ2qvFOrdnatj6c774bnjzhAkum/h3ka
         4VmdYAUdGHU2D+JN2Cy1nluDEXn4L+L7mM3nsF91eG36svsKnp72yZNXXvBrCjfxfTuu
         eEPl694Xa9RaWy5NPetkBwW96OIDkdD3gd7O9dMi2qc+wYbWAMoTcBvfZffHhS+aCQbi
         SuJEyQScPBhy4umE17Rk/ISAGQMnh4GY4v+DEXiL7yFR6HooZEKFLb3mAwcbmGVtV1AC
         q6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678774389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUGWd2Fn/6JnOvamELR/2rfGI/Q0AO+PqIEnSloS4VU=;
        b=Ijb2fIgz7OBhGfjnj0eW+PwgveSw1YQV41dc4DUZGj+X0vJV2f01yzlZeZE8Efkfdx
         L7rvq/OtENL91dZA+KvoRXbpNapplMwXLnEDgKcsyE9V1opbwTCRKt0EOcCS6iOSiMeh
         8qkriaqfgCCaevgJ160lBPAgEoZ8QTbgY41pSfnnDUcUlthBD5XTu7FBwqGEtiB9Y283
         oMD5tZQxXE8N3OW5hucf+oNh9mZojOVmeJY9nB4Va3Skm7qLy1M7/gQXg8c3ViWGJrjf
         Rt/1rjIQc1ZXuJb4tiJfEhzl75JZJrW6UyNx07wbu8h0qrtXYvYxTI9ne7F7PrKyUtLL
         CAVQ==
X-Gm-Message-State: AO0yUKUkTR5Ii2vXTEJtGyPvkyL5sxn51pILBHtXdtgMmnRSS4fYc1qm
        YrYDHJcNZKyzK1cI8D2yWvOK2xVwk6fofMEt86Y=
X-Google-Smtp-Source: AK7set8cUlyR+Uy9g/Yq1SFhwW7a5U1WcEf6D/hDWBtoi35EvP1mRvBw/vWSYVMrX8uCDgu65H7hzQ==
X-Received: by 2002:a5d:4846:0:b0:2cf:d25a:635b with SMTP id n6-20020a5d4846000000b002cfd25a635bmr3967527wrs.62.1678774389028;
        Mon, 13 Mar 2023 23:13:09 -0700 (PDT)
Received: from [192.168.150.175] (180.red-88-28-30.dynamicip.rima-tde.net. [88.28.30.180])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b002be5bdbe40csm1184546wry.27.2023.03.13.23.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:13:08 -0700 (PDT)
Message-ID: <28a9d97a-b252-a33f-1ac0-cd36264b29ab@linaro.org>
Date:   Tue, 14 Mar 2023 07:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/6] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
Cc:     linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-4-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230303150908.27889-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 3/3/23 16:09, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
> 
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
> 
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v8:
>    - Picked up tag from Fan Ni.
> ---
>   include/qemu/bswap.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 15a78c0db5..ee71cbeaaa 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,11 +8,23 @@
>   #undef  bswap64
>   #define bswap64(_x) __builtin_bswap64(_x)
>   
> +static inline uint32_t bswap24(uint32_t x)
> +{

Could it be safer to add:

        assert(x & 0xff000000U == 0);

...

> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}
> +
>   static inline void bswap16s(uint16_t *s)
>   {
>       *s = __builtin_bswap16(*s);
>   }
>   
> +static inline void bswap24s(uint32_t *s)
> +{
> +    *s = bswap24(*s);

... and here use:

        *s = bswap24(*s & 0x00ffffffU);

?

> +}
> +
>   static inline void bswap32s(uint32_t *s)
>   {
>       *s = __builtin_bswap32(*s);
> @@ -176,6 +188,7 @@ CPU_CONVERT(le, 64, uint64_t)
>    * size is:
>    *   b: 8 bits
>    *   w: 16 bits
> + *   24: 24 bits

Following the pattern, shouldn't this be 's' for sēsquiword?

Regardless you need to update the doc in docs/devel/loads-stores.rst.

>    *   l: 32 bits
>    *   q: 64 bits
>    *
> @@ -248,6 +261,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>       __builtin_memcpy(ptr, &v, sizeof(v));
>   }
>   
> +static inline void st24_he_p(void *ptr, uint32_t v)
> +{
> +    __builtin_memcpy(ptr, &v, 3);
> +}
> +
>   static inline int ldl_he_p(const void *ptr)
>   {
>       int32_t r;
> @@ -297,6 +315,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>       stw_he_p(ptr, le_bswap(v, 16));
>   }
>   
> +static inline void st24_le_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, le_bswap(v, 24));
> +}
