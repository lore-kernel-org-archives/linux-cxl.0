Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125EC64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB1MAW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 07:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjB1MAK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 07:00:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6882E81D
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 04:00:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h14so9453016wru.4
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 04:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2tlH52WgVkP+yDnzx0qQIh/BKfDqkHSQjojXc809dk=;
        b=C3PPrETWuI/3AVBWzzVSeoEaDjNhYgdyoq2siNsCrmlNItnpib2EfiLLWAH6MTHpNy
         m3LlZ1wZmzLomlg3YV+D2W/5tB/G1QLRW0XlsfLG+4J8AourVJ3YCElHtkKi+QOoqITj
         gBp6E47iK5RGQ2feCxrOA4o5BQm89zq5cZsDQHnACA/L41NAnkwDZ0+ODSg8KGokLOE0
         VD+LvgtH5xjVdbpup34st4u979JMk6rttBHjdLjI08SF16nv4mLkdKeDbdzphQ8OdW6y
         vYQXozNmEuorRw/Mx/gAXFnl8vzLmPBhllwOsU8h2AdGQZQVOr9/p54I6IfquNBFHoae
         5oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2tlH52WgVkP+yDnzx0qQIh/BKfDqkHSQjojXc809dk=;
        b=oVV6CB57nOCzWLhsjjwoOwRR6QqCYH9yFJj8aGTVBv9BQ2+ZCTaeVG2rDOO/f/HwFI
         FqaxbBifGmW8tK/HWwoIpUfs+Y8nTnvkx4WBHAhy54CJ0aCLCX+KTSuyj1th/i8oza2D
         GfrmBTfOZyXwLtPdyOg2m0zkIhYvjrPYdHLkedDls4ucdf7y/idw+UCZFQl6fyqZCh6/
         69F70V4TMnQ7xAuWX4JoVq5w00sE49KjTd1mPw6WBpr2ZkGAxcnFvobUEoMjMAQHH7VG
         pKA0FH75spnla7zMWrzVwZBA2whBP4uewX9x4InJvK1pxHC6NQ6adGw9ZLXZ2A2ccfZl
         xFrw==
X-Gm-Message-State: AO0yUKXKEV5KQRVCF8Bhp1XsEsz/uTJUTmkVFjY2FNsURHX69KKXSW6F
        0kO4c3vxlvoHyUsGW3I3w8U/zw==
X-Google-Smtp-Source: AK7set+k9ud+EfRmHX1Z5Zw5V2mt3n1nEWhIv3e/afap7Wd+ilSWcNzFgeBer+285gWP5A0Yrb+P/Q==
X-Received: by 2002:adf:e790:0:b0:2c8:c440:cb05 with SMTP id n16-20020adfe790000000b002c8c440cb05mr1693729wrm.55.1677585607797;
        Tue, 28 Feb 2023 04:00:07 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d524b000000b002c573a6216fsm9364862wrc.37.2023.02.28.04.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 04:00:07 -0800 (PST)
Message-ID: <125689c6-a156-8df5-a47a-3f6c44449c9c@linaro.org>
Date:   Tue, 28 Feb 2023 13:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
 reviewer
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
Cc:     linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 28/2/23 12:39, Jonathan Cameron via wrote:
> Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> Add him as a designated reviewer.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> Thanks to Fan for stepping up after I requested help following Ben
> stepping down as co-maintainer. Fan base been active in testing
> and review recently so great to have Fan on board.
> 
> Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
> 
> Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

