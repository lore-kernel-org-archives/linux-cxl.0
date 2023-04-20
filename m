Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E491C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 16:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjDTQoF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjDTQoF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Apr 2023 12:44:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03212721
        for <linux-cxl@vger.kernel.org>; Thu, 20 Apr 2023 09:44:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2NhR6wf8z6J73V;
        Fri, 21 Apr 2023 00:41:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 17:44:00 +0100
Date:   Thu, 20 Apr 2023 17:43:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] hw/pci-bridge/cxl_upstream: Fix bandwidth entry base
 unit for SSLBIS
Message-ID: <20230420174359.00005d65@Huawei.com>
In-Reply-To: <167950638058.386189.535068546966379964.stgit@djiang5-mobl3>
References: <167950638058.386189.535068546966379964.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 22 Mar 2023 10:33:00 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
> Information Structure, if the "Entry Base Unit" is 1024 for BW and the
> matrix entry has the value of 100, the BW is 100 GB/s. So the
> entry_base_unit should be changed from 1000 to 1024 given the comment notes
> it's 16GB/s for .latency_bandwidth.
> 
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

As a side note, I don't think the CDAT spec doesn't say which version of ACPI we
should refer to for meaning of HMAT entries.  It should set a minimum given there were breaking
changes in the HMAT spec from versions 1 to 2.

Perhaps worth poking the author of that doc?  Posting here in the hope that
someone (maybe me) remembers to do so.

I'll pick this up for my qemu tree and roll into a misc fixes series once I get
/ make time to pull one together.

Thanks,

Jonathan




> ---
>  hw/pci-bridge/cxl_upstream.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 2a00b708e560..d6f19c859a3d 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -297,7 +297,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>                  .length = sslbis_size,
>              },
>              .data_type = HMATLB_DATA_TYPE_ACCESS_BANDWIDTH,
> -            .entry_base_unit = 1000,
> +            .entry_base_unit = 1024,
>          },
>      };
>  
> 
> 
> 

