Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B50EC77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbjELPGJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241722AbjELPGE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:06:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D65FFF
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:05:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHsVJ091Pz67jdn;
        Fri, 12 May 2023 23:04:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:05:49 +0100
Date:   Fri, 12 May 2023 16:05:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 07/14] cxl: Add helper function that calculate
 performance data for downstream ports
Message-ID: <20230512160548.00005805@Huawei.com>
In-Reply-To: <168357885604.2756219.14660517574518073528.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357885604.2756219.14660517574518073528.stgit@djiang5-mobl3>
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

On Mon, 08 May 2023 13:47:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The CDAT information from the switch, Switch Scoped Latency and Bandwidth
> Information Strucutre (SSLBIS), is parsed and stored under a cxl_dport
> based on the correlated downstream port id from the SSLBIS entry. Walk
> the entire CXL port paths and collect all the performance data. Also
> pick up the link latency number that's stored under the dports. The
> entire path PCIe bandwidth can be retrieved using the
> pcie_bandwidth_available() call.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial comment inline. Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    3 ++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e4f75847b851..1111a3cebc8e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -9,6 +9,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> +#include <linux/node.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <cxl.h>
> @@ -1950,6 +1951,74 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
> +static void combine_coordinates(struct access_coordinate *c1,
> +				struct access_coordinate *c2)
> +{
> +		if (c2->write_bandwidth)
> +			c1->write_bandwidth = min_t(unsigned int,
> +						    c1->write_bandwidth,
> +						    c2->write_bandwidth);

min() fine here I think. All unsigned int already unless I'm missing something.

> +		c1->write_latency += c2->write_latency;
> +
> +		if (c2->read_bandwidth)
> +			c1->read_bandwidth = min_t(unsigned int,
> +						   c1->read_bandwidth,
> +						   c2->read_bandwidth);
same here.

> +		c1->read_latency += c2->read_latency;
> +}


