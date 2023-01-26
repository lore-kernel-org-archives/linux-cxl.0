Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD91C54E94
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 10:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjAZKCr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjAZKCp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 05:02:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497A6FD17
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 02:02:38 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2bpQ6pVXz67D4J;
        Thu, 26 Jan 2023 18:01:50 +0800 (CST)
Received: from localhost (10.81.202.191) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 10:02:36 +0000
Date:   Thu, 26 Jan 2023 10:02:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
Subject: Re: [PATCH v2 1/3] cxl/mem: Quiet port walking warnings
Message-ID: <20230126100235.00000d6c@Huawei.com>
In-Reply-To: <167468465444.586774.9409731200278259584.stgit@dwillia2-xfh.jf.intel.com>
References: <20230113110441.0000657e@Huawei.com>
        <167468465444.586774.9409731200278259584.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.191]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 25 Jan 2023 14:11:17 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The cxl_mem driver attempts to establish, or revalidate, the cxl_port
> hierarcy to attach a cxl_memdev to a CXL platform topology. There is a
> natural race (on ACPI platforms) between when the cxl_mem driver
> attempts to attach and when the cxl_acpi driver establishes the root of
> the topology.
> 
> If cxl_mem_probe() runs first it will iterate to the top of the device
> topology without finding the CXL platform root. That situation is benign
> / expected, so stop warning about it. The cxl_acpi driver will poke
> cxl_mem_probe() to try again once the CXL platform root is established.
> 
> Suppress any upper level errors by making it clear that this is merely a
> probe deferral event, not a hard error.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes since v1:
> * Use dev_err_probe() (Jonathan)
> 
>  drivers/cxl/core/port.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b631a0520456..feb8f84a9281 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1397,9 +1397,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  
>  		uport_dev = dport_dev->parent;
>  		if (!uport_dev) {
> -			dev_warn(dev, "at %s no parent for dport: %s\n",
> -				 dev_name(iter), dev_name(dport_dev));
> -			return -ENXIO;
> +			dev_err_probe(dev, -EPROBE_DEFER,
> +				      "at %s no parent for dport: %s\n",
> +				      dev_name(iter), dev_name(dport_dev));
> +			return -EPROBE_DEFER;
>  		}
>  
>  		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
> 

