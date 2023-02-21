Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA02C61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 22:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBUWIK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBUWIJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 17:08:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DABBA1
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:08:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v3so5870460wrp.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hgvcP5je1zR/2MazVoMlLNzNse+MEVFrfGHS0cMg9o=;
        b=H/TWVav+m65Go5BjNw9/NyYGQIDKUfHYZGixppkd/RqEvocZpaHqVW9YMkMtdeTfRK
         zjrR7LFxvSEBaLnArmhoomYRLgtu5XheHFUHXAvs2x/ivfKUrEDr2K9z0DhGBikOsqhK
         XauQDKzMAew/KW8YJZsRoBHl+oayJ/a6GLq2lGm/CoXE7km+C8Omhy9Je5J5l6OEqKgO
         A8orPuglX0FnwIMntunzKBZCqXdgDf6VXXRhdWcCHbKsNU8FarcPESSAQ2dRSZu9cot+
         GnbQ2CjrRdDTqZdMT1oJwUcRywmetaUEo2dtQV5Uo3jMWySXpHYpFznIVvxcrv4qadSR
         ODMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hgvcP5je1zR/2MazVoMlLNzNse+MEVFrfGHS0cMg9o=;
        b=XWOrL5+N0UtDGH6TxsFYF9BShYQla4GJguqrjDkMtg8vAUhTqRYTxZfmehxab79o2u
         +8XikMpXF9PR3L493Wn1FlYqrNVz5qRJYk3pWEwwL5rHLGJi/tR6tEM6ojExTji31XHu
         Fz3kpv8cSJ9Z0q1btkeQN2CJCz8Vv6IlcF7yxTSuyE41bY8sNXkZWhr/AppnjzxTU7qG
         VlBdT2WmXM9unJVY1awLlpPnzzFWM1WHZmERaK/EjBwMClHeze0Aa+g5e/lAkYEATuTR
         QtVDFIWhFQOheL5SlzlqRqW0UQliZVpKvCENWBXurdmI+CPoO4s0+YrzeGKmvJHr6tb4
         4F+g==
X-Gm-Message-State: AO0yUKU2a1Ri23SY6zv4IiC8F9UGSBElNtPdDgnVFz+sLUIgnvOYoYMW
        uzFjUIrYZq+4UgLsZfpCnSiHfA==
X-Google-Smtp-Source: AK7set8lqxQLuA0qaQAKYxsByGrWM612GiDdZI79pIR4WGyoI6QqSgLFEpaY0ivQpvw7vaOHJ7GhjA==
X-Received: by 2002:a05:6000:1569:b0:2bf:d937:3589 with SMTP id 9-20020a056000156900b002bfd9373589mr6587242wrz.14.1677017286749;
        Tue, 21 Feb 2023 14:08:06 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b002c55b0e6ef1sm6244687wrs.4.2023.02.21.14.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:08:06 -0800 (PST)
Message-ID: <9ae252ae-db86-0e8d-c2e2-1939968121b4@linaro.org>
Date:   Tue, 21 Feb 2023 23:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 7/8] hw/pci/aer: Make PCIE AER error injection facility
 available for other emulation to use.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-8-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230221152145.9736-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21/2/23 16:21, Jonathan Cameron wrote:
> This infrastructure will be reused for CXL RAS error injection
> in patches that follow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   hw/pci/pci-internal.h     | 1 -
>   include/hw/pci/pcie_aer.h | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

