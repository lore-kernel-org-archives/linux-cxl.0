Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD1C6FD1F
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 06:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCNGcd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 02:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCNGca (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 02:32:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEEC94A76
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 23:32:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r18so13290358wrx.1
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 23:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678775547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JydG0wflcCsIHIkmoinsPUsKF3AFLzMW2HdeCY//o8M=;
        b=loYLY6T1dJ6CpoGW34hij2R1zNxtOBLW4OerVwoYERh8JguApZgVFP/71dHYsguTaW
         UU3HGvB6xBZJ3+Hq7IRH1zXZDCah2S4DLDw+T8rWgTu86OiSJb2i4AdjYPK5AhSI3TbH
         7r9CUR7GBJb4X1jpFgnANnuVhWwlZATUe68sK8zIdiVoP32DGBfqgt7EwtXLCCExijcZ
         x4NAUkVjpuAKh6CKUH8EFwLtL25WNhSGBUKrAIDQIoFoWni5onA/pdi3GDwzdnqJDog7
         RjVUsN2i3QyEBHYV5h10Vg8hN+t+dzBgY7DKsOzZ3o99WvB5zV2p7hBy3VIiO7HJKGg9
         dZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678775547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JydG0wflcCsIHIkmoinsPUsKF3AFLzMW2HdeCY//o8M=;
        b=ttCxejPfgOUfC8bv4fiW7Yz6KVMg3KCZqIFXYlgXEjj6OkBlsL7xgWsf+OFbPZMXvz
         Ktw+4prn0LzsltC5rolVtMpJz6t4jw0ha+Vf76xFowfuaaqVeVzZn1dz7YgKrTUycD2Z
         poH2YFRYAcVvQRcfk8iBeWDgCY+f2dltY07hfq6U0QkbtAkWlbhNrMVVn6o7C4Zjn24s
         WXIQIt8ujZGSNP3yYzaaafUWH/5+Sy0mJ/WuBB+lvBZUCGpXwaICgV5UNDMgQZFVkbdh
         S0+kJaPCtBy4/Uc22ZDPHExMwsq73q5M0upwu2BoiSMEpop2GaNxCKhxuO/YJCX/SsnE
         WTzA==
X-Gm-Message-State: AO0yUKXuvEV2eCgOiiG0pUuHXkmK2IEmQPMsY4c7YqtaFbhkbT5+vPPk
        668yW5WwLx0kMh+UMOBehXSQ/w==
X-Google-Smtp-Source: AK7set9Dj0H1pvsudsgMYC3B58XlAkWu0jszc/ksz5225KocRiesrDL79qNrt1DibhPRf4pDj0B1pA==
X-Received: by 2002:a5d:4604:0:b0:2c3:be89:7c2b with SMTP id t4-20020a5d4604000000b002c3be897c2bmr8982224wrq.14.1678775547181;
        Mon, 13 Mar 2023 23:32:27 -0700 (PDT)
Received: from [192.168.150.175] (180.red-88-28-30.dynamicip.rima-tde.net. [88.28.30.180])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003e8dc7a03basm1766307wmd.41.2023.03.13.23.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:32:25 -0700 (PDT)
Message-ID: <ae5e2fa5-e641-f787-38e3-4de1defd0050@linaro.org>
Date:   Tue, 14 Mar 2023 07:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 0/6] hw/cxl: Poison get, inject, clear
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
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

On 3/3/23 16:09, Jonathan Cameron wrote:
> Note there are several series ahead of this one and in particular
> the RAS error injection series needs some QAPI review.
> The QAPI stuff in this patch is similar but in essence very similar
> to what we have in that series.
> 
> Whilst I'm an always an optimist, this may well end up as 8.1 material
> now.


> Ira Weiny (2):
>    hw/cxl: Introduce cxl_device_get_timestamp() utility function
>    bswap: Add the ability to store to an unaligned 24 bit field
> 
> Jonathan Cameron (4):
>    hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
>    hw/cxl: QMP based poison injection support
>    hw/cxl: Add poison injection via the mailbox.
>    hw/cxl: Add clear poison mailbox command support.
> 
>   hw/cxl/cxl-device-utils.c   |  15 ++
>   hw/cxl/cxl-mailbox-utils.c  | 283 ++++++++++++++++++++++++++++++------
>   hw/mem/cxl_type3.c          |  92 ++++++++++++
>   hw/mem/cxl_type3_stubs.c    |   6 +
>   include/hw/cxl/cxl_device.h |  23 +++

There is a '64' magic number used in various places, I haven't tried to
figure what is / where it comes from, but a CXL #definition for it could
make sense.
