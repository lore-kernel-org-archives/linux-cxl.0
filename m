Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB857CE7A81
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 20:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIVUJH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjIVUJG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 16:09:06 -0400
Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83AF1A1
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 13:08:57 -0700 (PDT)
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
        by isrv.corpit.ru (Postfix) with ESMTP id 8F0A72463F;
        Fri, 22 Sep 2023 23:09:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
        by tsrv.corpit.ru (Postfix) with ESMTP id 5F0132A220;
        Fri, 22 Sep 2023 23:08:53 +0300 (MSK)
Message-ID: <f92187e6-c7a3-3826-f980-b95533e18643@tls.msk.ru>
Date:   Fri, 22 Sep 2023 23:08:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] hw/pci-bridge/cxl_upstream: Fix bandwidth entry base
 unit for SSLBIS
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
From:   Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

04.09.2023 16:28, Jonathan Cameron:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
> Information Structure, if the "Entry Base Unit" is 1024 for BW and the
> matrix entry has the value of 100, the BW is 100 GB/s. So the
> entry_base_unit should be changed from 1000 to 1024 given the comment notes
> it's 16GB/s for .latency_bandwidth.
> 
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/pci-bridge/cxl_upstream.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 9159f48a8c..2b9cf0cc97 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -262,7 +262,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>                   .length = sslbis_size,
>               },
>               .data_type = HMATLB_DATA_TYPE_ACCESS_BANDWIDTH,
> -            .entry_base_unit = 1000,
> +            .entry_base_unit = 1024,
>           },
>       };

BTW, is this one stable-worthly?  How it's been found, - due to some real
issue or just by code review?

Thanks,

/mjt


