Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44EC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 10:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiKKKl5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 05:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKKKlw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 05:41:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80449657D6
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 02:41:51 -0800 (PST)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N7wF82GRhz67PwL;
        Fri, 11 Nov 2022 18:39:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 11:41:49 +0100
Received: from localhost (10.45.151.252) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 10:41:48 +0000
Date:   Fri, 11 Nov 2022 10:41:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave@stgolabs.net>
Subject: Re: [PATCH v3 16/18] cxl/pmem: add provider name to cxl pmem dimm
 attribute group
Message-ID: <20221111104147.00007300@Huawei.com>
In-Reply-To: <166792841412.3767969.837651453603473607.stgit@djiang5-desk3.ch.intel.com>
References: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
        <166792841412.3767969.837651453603473607.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.151.252]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 08 Nov 2022 10:26:54 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add provider name in order to associate cxl test dimm from cxl_test to the
> cxl pmem device when going through sysfs for security testing.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm |    6 ++++++
>  drivers/cxl/pmem.c                         |   10 ++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> index 91945211e53b..d78e4553d9af 100644
> --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -47,3 +47,9 @@ Date:		November 2022
>  KernelVersion:	6.2
>  Contact:	Dave Jiang <dave.jiang@intel.com>
>  Description:	(RO) Show the id (serial) of the device.
> +
> +What:		/sys/bus/nd/devices/nmemX/provider
> +Date:		November 2022
> +KernelVersion:	6.2
> +Contact:	Dave Jiang <dave.jiang@intel.com>
> +Description:	(RO) Shows the provider for the device. (i.e. ACPI.NFIT, ACPI.CXL)
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 9209c7dd72d0..322f834cc27d 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -48,6 +48,15 @@ static void unregister_nvdimm(void *nvdimm)
>  	cxl_nvd->bridge = NULL;
>  }
>  
> +static ssize_t provider_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +	return sysfs_emit(buf, "%s\n", dev_name(&cxl_nvd->dev));
> +}
> +static DEVICE_ATTR_RO(provider);
> +
>  static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
> @@ -60,6 +69,7 @@ static DEVICE_ATTR_RO(id);
>  
>  static struct attribute *cxl_dimm_attributes[] = {
>  	&dev_attr_id.attr,
> +	&dev_attr_provider.attr,
>  	NULL
>  };
>  
> 
> 

