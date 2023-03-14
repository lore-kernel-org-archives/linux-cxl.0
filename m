Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9530BC6FD1F
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 05:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCNF4M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNF4M (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 01:56:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF019129
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 22:56:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso6238307wms.3
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 22:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678773363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jq+BADjxNsd4bj9DaOcx9VC73aVjPdRd4pMpGOJg828=;
        b=iMMuCXyxUdDgwKfSNordIftUV7uSIAxdLRSrnCzC4/qSaR4pgIZMjXuAMU5i8FJlhO
         vVmsap1+UxudplHO/PQukWRVsa3uMQKpuj5xOvntS75D2l7rkFTBwgCsYWfs/FvFPivz
         cby7bg14hB/IYQPdNTCnLtWx5FboJC2nsqb2LaI+O8qeikwSHFH4+5kmNlLcgd9t3qPG
         6rIqGkePtdyip6IFHkHw3aWyk/LdXWNpPmevxICQQdc6c0TEfN5jM7/EBYe5sGOa/QHG
         Mzqh251CZrChY/R/QudZqWt1FHqhdAEshoL3RqUS2NVEJozqHd8A9gQR9pDGrboWXPRN
         xPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678773363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jq+BADjxNsd4bj9DaOcx9VC73aVjPdRd4pMpGOJg828=;
        b=J2bA6Ma+Xcya6gj+6tgDSMH6r4UDFEkito4/7zR9BJSI/K08Yy/NL65361G+v9Cqhm
         jrDLrJDS/KqQYhSmVtHup02/Af7PrH+GXZKwv2d+oj/S/9FBOgqeTvjLBAM4zRqwDgki
         VIsOM07YJzB7plKC5tKEvYWjU2BFp7zfjm2K3bmAChvFi3hTW5+7XEP1S8tZA2RSQToe
         hpqItucF6tsIDgIcjzkPwM7v2aoceEEsJPzou7Pk4fYI08d6HxlROSPGtaTAeEg3oNUz
         BVXceFT4kqkBF6J5iM5FLdaYnT+faKxct/0Ox5nECs/+6hgjfd9nluJ3CjLTPYYzbq3P
         ZBlA==
X-Gm-Message-State: AO0yUKWd2FSrxPhvawaQVymBi0JfPDIPcaPAWA4mvSPSpLEgWN9ekY5n
        r4ZpqRSPDMBiZmjcflCC2VyYYg==
X-Google-Smtp-Source: AK7set/BHS9bpASBAc9GSIjluC1ZyzkJlEch/DHA8tLf2Kw6ZB/HQ4Doc9vlfm32kqqWxGAhUW/5UQ==
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id o7-20020a05600c510700b003dfe1e9201dmr12587857wms.40.1678773362753;
        Mon, 13 Mar 2023 22:56:02 -0700 (PDT)
Received: from [192.168.150.175] (180.red-88-28-30.dynamicip.rima-tde.net. [88.28.30.180])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b003ebf9e36cd6sm1776566wmo.26.2023.03.13.22.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 22:56:02 -0700 (PDT)
Message-ID: <b90c1aff-c044-9dae-3b3a-a25a4cbd24ca@linaro.org>
Date:   Tue, 14 Mar 2023 06:55:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/6] hw/cxl: rename mailbox return code type from
 ret_code to CXLRetCode
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
        Thomas Huth <thuth@redhat.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-2-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230303150908.27889-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 3/3/23 16:09, Jonathan Cameron wrote:
> Given the increasing usage of this mailbox return code type, now
> is a good time to switch to QEMU style naming.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v8: Picked up tag from Fan Ni
> ---
>   hw/cxl/cxl-mailbox-utils.c | 64 +++++++++++++++++++-------------------
>   1 file changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

