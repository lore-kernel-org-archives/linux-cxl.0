Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF310C48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980DD6108D
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 11:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFKLHd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:07:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3209 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKLHd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 07:07:33 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1d3F2Z1Gz6J9YX;
        Fri, 11 Jun 2021 18:52:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 13:05:34 +0200
Received: from localhost (10.52.120.251) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 12:05:33 +0100
Date:   Fri, 11 Jun 2021 12:05:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/mem: Add partition information to sysfs
Message-ID: <20210611120529.000001fe@Huawei.com>
In-Reply-To: <20210611002224.1594913-4-ira.weiny@intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
        <20210611002224.1594913-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.251]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Jun 2021 17:22:24 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Partitionable space is added to the ram and pmem size sysfs attributes
> but this does not show the entire story.
> 
> Add full partition information about the device under <sysfs>/partition.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/pci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bcc2829e4475..7e4e9605e4ed 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1226,6 +1226,42 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t part_vo_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +
> +	return sysfs_emit(buf, "%#llx\n", cxlm->volatile_cap_bytes);
> +}
> +
> +static struct device_attribute dev_attr_part_vo =
> +	__ATTR(volatile_only, 0444, part_vo_show, NULL);

With a bit of tweaking could we use DEVICE_ATTR_RO for these and have even less
boilerplate? 


> +
> +static ssize_t part_po_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +
> +	return sysfs_emit(buf, "%#llx\n", cxlm->persistent_cap_bytes);
> +}
> +
> +static struct device_attribute dev_attr_part_po =
> +	__ATTR(persistent_only, 0444, part_po_show, NULL);
> +
> +static ssize_t part_total_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +
> +	return sysfs_emit(buf, "%#llx\n", cxlm->total_cap_bytes);
> +}
> +
> +static struct device_attribute dev_attr_part_total =
> +	__ATTR(total, 0444, part_total_show, NULL);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
> @@ -1243,6 +1279,13 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>  	NULL,
>  };
>  
> +static struct attribute *cxl_memdev_part_attributes[] = {
> +	&dev_attr_part_vo.attr,
> +	&dev_attr_part_po.attr,
> +	&dev_attr_part_total.attr,
> +	NULL,
> +};
> +
>  static struct attribute_group cxl_memdev_attribute_group = {
>  	.attrs = cxl_memdev_attributes,
>  };
> @@ -1257,10 +1300,16 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  	.attrs = cxl_memdev_pmem_attributes,
>  };
>  
> +static struct attribute_group cxl_memdev_part_attribute_group = {
> +	.name = "partition",
> +	.attrs = cxl_memdev_part_attributes,
> +};
> +
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_part_attribute_group,
>  	NULL,
>  };
>  

