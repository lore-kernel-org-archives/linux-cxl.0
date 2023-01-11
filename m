Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FCC46467
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 15:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbjAKPta (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjAKPs4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 10:48:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B5B04
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 07:48:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so15477734wrv.7
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 07:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6QKQsMkd0tEzgfZl/1XKTPgvNm9zkksrUQSlImCLXg=;
        b=Fzac++Kx11k3sVfG3PP4A2YubERKKhD6cVA5T3EGQ4Me3m15e0PKO04TSjNYc/pOF3
         JjKHLgv8HScQ9pQXkRgkELifLjgNG4MwUCyUvIxIf3xoO/S3E8O9Kesi844Qodm7TkNm
         QCD1624Nts5b6F7nA5qyEe2hKIHvAaIJcxdmX9dPyFzCQYWiUmr9S4pSystuJdGg4G7n
         xRreZzvxqT37a3mdLgfYK/uw1cFB+o+3YKYRISaWxTFznKZID9sLIw9BHDsjNa5ICE4G
         PM4lHmM2OJHyqiPVootINMPHWsrlxXqksVVMt8jIKm1lVkchS87ScyZwTWiIuhDWRO9R
         lmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6QKQsMkd0tEzgfZl/1XKTPgvNm9zkksrUQSlImCLXg=;
        b=YWalkrOXVs2Vraw6zBCoFjIKVDdFDyzd9u9I7ULUSK9CqewuEKGxt7iKC7KsLWu45D
         jxQLCgS4g4Eis/2IIIEoTspRp4vmlHlBIxlbU+HQRz6d/kT7wctZfJXlaBFCWep0TtGb
         PQ9JPtnf3+36hGlZi6+m26FG9v+jYNhonbk0kwD+DYavqrEWm741bcOHLnkr83kVFUlT
         Xyv4Up/Qwc1O56BT0FabhD05w0twirXMLT+qcUDuv8mkZ0r/luKPvaYeaUfVCkHlEP2m
         YBW5DSUC34fstlMQ9o1jsuKO3Td1bNDwkP3Z8KtRc0qnM565pgSN1fpUMYjNX+bBUjlY
         fKTA==
X-Gm-Message-State: AFqh2kpwEv0PEtsGdhm9WHLTCWG7S9PB0sAuuOrh1EmNA7oRrnmDQbDE
        qqmVYdEygvxFFar6zYjYIyZ09Q==
X-Google-Smtp-Source: AMrXdXuUsrvPHS5p4nQEPjja3xK1fq5S69K0Uvyh4ERcaI7Ry2EfcujmHfoPGbmbj2NkhmB2FFbjZw==
X-Received: by 2002:adf:ee8f:0:b0:2bc:7f8e:40ba with SMTP id b15-20020adfee8f000000b002bc7f8e40bamr6930505wro.54.1673452134359;
        Wed, 11 Jan 2023 07:48:54 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id l1-20020adfe9c1000000b00289bdda07b7sm13731020wrn.92.2023.01.11.07.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:48:53 -0800 (PST)
Message-ID: <cde5dfbf-da7d-7a1b-94b4-bf4bac7ca8ba@linaro.org>
Date:   Wed, 11 Jan 2023 16:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-5-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230111142440.24771-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 15:24, Jonathan Cameron via wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> Remove usage of magic numbers when accessing capacity fields and replace
> with CXL_CAPACITY_MULTIPLIER, matching the kernel definition.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index bc1bb18844..942de73bbc 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -14,6 +14,8 @@
>   #include "qemu/log.h"
>   #include "qemu/uuid.h"
>   
> +#define CXL_CAPACITY_MULTIPLIER   0x10000000 /* SZ_256M */

Do you mind changing to the self-documenting (256 * MiB) ?
