Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A355C54EBC
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 10:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjALKoL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbjALKms (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 05:42:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465F5130A
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 02:37:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso9745749wms.4
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNjH70h3YMyqRnnpci45rG2ziPjGcBrn9RpOXef1k7s=;
        b=bqQXyZHpvFU1niarM6Kz3HgOx7H1S8ULA6+pHUB9jxvaH6cWR+d9AuSnkEPjQ66VaB
         QpmjjjYub8HJLv8HiT4Hgj3E/UxxMNd1meXYA91O5z0CAwnlsEMvrYdaFNBgP7GxV6mO
         UDNz0S/89bMxZBRRhVFxKue6E02/cCGw9p/ysCvZfE6q6avLPRZJi0eoD8tKWVBgDFn6
         sd07liUFXaHjJsq0PRwTdxtlj6I2PfrYyM107sjfKvl9LQz3YkqxpVYNM2ObiaIKoZ/J
         m1U7KUiRc3tcQNeTMjcHpMccQLqN5GpkNWdAPPfamTYDWpdEtUvd7vzlebaT9B69Btk/
         kVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNjH70h3YMyqRnnpci45rG2ziPjGcBrn9RpOXef1k7s=;
        b=AwmFyAL3yvANGiosF5coCbm6aGdYeu2BKD7p8VSJiV2LOqQy2QbJTPRkz2vVoNvORx
         Db2bwFVDLWI+zRnlnXfvcLeOX1A3EtF7qZY3REyISk3sukEzG+wZcdWbuHY22CCZxdfB
         CK+yV1pBasQaeDXfQcYdAtwn3eZOlTWB/qaUNqjPVPaZxwj/1y+z/DKetcM1pyYvVSEr
         Hw1ii1VEkJVurfIet1tBi19bQoPHPzneODdfZbnnSLLJywqe2gGo8mXiQyTRAU+Pkj5w
         cTTzoquZDjf3FTEH5oqlxaISKmaOD5xtqo+41Awv/V5hN3BqYvEqViVfOUYcFjsioXbr
         09pA==
X-Gm-Message-State: AFqh2krq9G46UN8xWsPtuOhkjZdnLIi6FPA5NrF8C6aNZIOwnOpEPX7s
        /0Jyb3cciDpkXww5XnIdxVZof57oE4qdRS6D
X-Google-Smtp-Source: AMrXdXt46ViFFh113j3Tm/tOMx1XgaGCQHlPl84IqscgJtG0u7enSG9GrkkakymxVmMwzWrE+3IuOw==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr58684652wmb.30.1673519873137;
        Thu, 12 Jan 2023 02:37:53 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b003d9ed40a512sm17938494wmb.45.2023.01.12.02.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 02:37:52 -0800 (PST)
Message-ID: <9ef90fdb-1355-36f4-6308-9f19028f7706@linaro.org>
Date:   Thu, 12 Jan 2023 11:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/8] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
 <20230112102644.27830-5-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230112102644.27830-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 12/1/23 11:26, Jonathan Cameron wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> Remove usage of magic numbers when accessing capacity fields and replace
> with CXL_CAPACITY_MULTIPLIER, matching the kernel definition.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v2:
> Change to 256 * MiB and include qemu/units.h (Philippe Mathieu-Daudé)
> 
>   hw/cxl/cxl-mailbox-utils.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index bc1bb18844..3f67b665f5 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -12,8 +12,11 @@
>   #include "hw/pci/pci.h"
>   #include "qemu/cutils.h"
>   #include "qemu/log.h"
> +#include "qemu/units.h"
>   #include "qemu/uuid.h"
>   
> +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)

Thanks, appreciated.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

