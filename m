Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAD5EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 00:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjFOAkw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFOAkq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 20:40:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4031137
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686789645; x=1718325645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNwQLbpx7NYRBoNN0z07sgUdN+nd9MWLC4o6by4bTW4=;
  b=lsxHkuY3KuSout4xnb8C5Fwx2B60r4IVCvHKG88FbBTAasaFQFxWY8xQ
   ZV9FADsKb9zhII4L7RhynjPRnEQeilWI/L/3fhUGgekAKQkO8kKcQ6OyR
   qW3GEBvPDhn/F1LlqjOGzy5LuD5FWpw9MTwxa3q+hEmKvp1aQ7pNhImFj
   cKpD0OGl/id8GG6Y9h2u2SnaBEcQuxghM/GUdvRiVTZyt/On+NDNAfcda
   hSC4OPqRzZTk0XFUdTxKaZ1qfi6Ylt/R0BFYyioiXNcifU+M37H35Z/iz
   U7NJcXs3pomrrD7JVKONpQluclICGPJf4SLsS0T+tXX2gMo9qYYSMvf/X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356265369"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="356265369"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712255257"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="712255257"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.191])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:40:44 -0700
Date:   Wed, 14 Jun 2023 17:40:42 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/5] cxl/mem : Expose dynamic capacity configuration to
 userspace
Message-ID: <ZIpeCsiJgLcD7eju@aschofie-mobl2>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jun 14, 2023 at 12:16:30PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Exposing driver cached dynamic capacity configuration through sysfs
> attributes.User will create one or more dynamic capacity
> cxl regions based on this information and map the dynamic capacity of
> the device into HDM ranges using one or more HDM decoders.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> ---
> [iweiny: fixups]
> [djbw: fixups, no sign-off: preview only]
> ---
>  drivers/cxl/core/memdev.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)

Add the documentation of these new attributes in this patch.
Documentation/ABI/testing/sysfs-bus-cxl

A bit of my ignorance here, but when I keep seeing the word
'regions' below, it makes me wonder whether these attributes
are in the right place?

> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5d1ba7a72567..beeb5fa3a0aa 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -99,6 +99,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t dc_regions_count_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	int len = 0;
> +
> +	len = sysfs_emit(buf, "0x%x\n", mds->nr_dc_region);

Prefer using this notation: %#llx
grep for the sysfs_emit's to see customary usage.

> +	return len;
> +}
> +
> +struct device_attribute dev_attr_dc_regions_count =
> +	__ATTR(dc_regions_count, 0444, dc_regions_count_show, NULL);
> +
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -362,6 +376,57 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "0x%llx\n", mds->dc_region[pos].decode_len);
> +}
> +
> +#define SIZE_ATTR_RO(n)                                              \
> +static ssize_t dc##n##_size_show(                                       \
> +	struct device *dev, struct device_attribute *attr, char *buf)  \
> +{                                                                      \
> +	return show_size_regionN(to_cxl_memdev(dev), buf, (n));             \
> +}                                                                      \
> +static DEVICE_ATTR_RO(dc##n##_size)
> +SIZE_ATTR_RO(0);
> +SIZE_ATTR_RO(1);
> +SIZE_ATTR_RO(2);
> +SIZE_ATTR_RO(3);
> +SIZE_ATTR_RO(4);
> +SIZE_ATTR_RO(5);
> +SIZE_ATTR_RO(6);
> +SIZE_ATTR_RO(7);
> +
> +static struct attribute *cxl_memdev_dc_attributes[] = {
> +	&dev_attr_dc0_size.attr,
> +	&dev_attr_dc1_size.attr,
> +	&dev_attr_dc2_size.attr,
> +	&dev_attr_dc3_size.attr,
> +	&dev_attr_dc4_size.attr,
> +	&dev_attr_dc5_size.attr,
> +	&dev_attr_dc6_size.attr,
> +	&dev_attr_dc7_size.attr,
> +	&dev_attr_dc_regions_count.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_dc_regions_count.attr)
> +		return a->mode;
> +
> +	if (n < mds->nr_dc_region)
> +		return a->mode;
> +
> +	return 0;
> +}
> +
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> @@ -385,10 +450,17 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  	.attrs = cxl_memdev_pmem_attributes,
>  };
>  
> +static struct attribute_group cxl_memdev_dc_attribute_group = {
> +	.name = "dc",
> +	.attrs = cxl_memdev_dc_attributes,
> +	.is_visible = cxl_dc_visible,
> +};
> +
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_dc_attribute_group,
>  	NULL,
>  };
>  
> 
> -- 
> 2.40.0
> 
