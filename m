Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F9DC46467
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAKOpI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 09:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAKOpH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 09:45:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE02D1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 06:45:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l26so11247502wme.5
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 06:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hT0yCUFuOaktmsLkadVbzQZN/eHEXE/9G8TjF0C1TM=;
        b=j1eadlbl5tD/uJy5yKiJ7JPH5yraYt8R2qs8QEItEOvCZUVBMvV6dtqAHLq/X8D7SG
         AelZxX3wM8MfxEoUiS6cKiAmiQg+/5Y2zVJ1uQZmyUMM1W1OLDsAoOX4DyqWVEBqc+YU
         sJchtflIJs+wtl8TbYqXyc8pms0iTAiIL+BDeieA8u2GcEUGKiz8rXI8FGJVrjjryhmN
         mc16+rS7lFbr+lKn5I9oDP8X9rBjyBKDuQMpI6nKpGDpMEYQ+WBNVNWpnCFzqH7WBBCt
         fAQ+HwumABHL7AmfNZK5DWBTCfEeKIu6nZw/DztRJ0HlxLnMZQ1/RITRAa/nKdGHnQeG
         NZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hT0yCUFuOaktmsLkadVbzQZN/eHEXE/9G8TjF0C1TM=;
        b=TcLpJVxOxG5o9iJDdUtEG/dpG2RX1gj6P9zmor2GFXJQ2vLwxUDoN4bRHMll7gBcQf
         4l/itgwZ+Xvo+9N/DK/qsci8IGzedfNVGKb5+nZEp/7DVlVwbw26WjSQN7DRWg5/3PcC
         1v6Vo/utzknJZIeq6zDz1VE64kKd0RNXrLYj7er86AKtGX5C960nNCmbwpRCu6tVNR79
         HWVnJsCbWSovloAsorIbX2kvwpGQDqRa6xKgh+LmZ0+naYZkrereiWCNWFulzcJGmTb4
         PNZHFZazRs3jtYFZpBkVqomPIqE12Xg7cUK7pG0uuEx9bMQ15q3K3I7sTOG5d2016IrI
         w0Kw==
X-Gm-Message-State: AFqh2kp5Ov9UA15ZtWq9KHbBfJ/1Dz9VgHb+nLMvSW9ZFAyLwEit5pBM
        Xx/L4PKAK68BH/eUyOaPxbwvNg==
X-Google-Smtp-Source: AMrXdXuT1Bvxl0IOjCQJ2HhE2XnVrmFMhS/YISpxYe4t2a8mZkC8xfkv3a2fMFU18flgIHPLTpWOHA==
X-Received: by 2002:a05:600c:556f:b0:3d2:2a74:3a90 with SMTP id ja15-20020a05600c556f00b003d22a743a90mr55013398wmb.22.1673448305603;
        Wed, 11 Jan 2023 06:45:05 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d65c2000000b0027b35baf811sm13725966wrw.57.2023.01.11.06.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:45:04 -0800 (PST)
Message-ID: <517cfe71-8803-3fbf-265c-e13f32f3bd76@linaro.org>
Date:   Wed, 11 Jan 2023 15:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/8] hw/pci-bridge/cxl_downstream: Fix type naming
 mismatch
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-3-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230111142440.24771-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 15:24, Jonathan Cameron via wrote:
> Fix capitalization difference between struct name and typedef.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/pci-bridge/cxl_downstream.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 3d4e6b59cd..54f507318f 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -15,7 +15,7 @@
>   #include "hw/pci/pcie_port.h"
>   #include "qapi/error.h"
>   
> -typedef struct CXLDownStreamPort {
> +typedef struct CXLDownstreamPort {
>       /*< private >*/
>       PCIESlot parent_obj;
>   

I was going to post the same patch because when reworking some QOM
definitions I'm getting:

     ../../hw/pci-bridge/cxl_downstream.c:27:26: error: typedef 
redefinition with different types ('struct CXLDownstreamPort' vs 'struct 
CXLDownStreamPort')
     DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
                              ^
     ../../hw/pci-bridge/cxl_downstream.c:24:3: note: previous 
definition is here
     } CXLDownstreamPort;
       ^

So thanks!

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

