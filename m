Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F376DC64EC4
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Feb 2023 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBJRaX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjBJRaW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Feb 2023 12:30:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F8735B1;
        Fri, 10 Feb 2023 09:30:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD11D39ltz6J9nd;
        Sat, 11 Feb 2023 01:28:48 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 17:30:17 +0000
Date:   Fri, 10 Feb 2023 17:30:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Fan Ni" <fan.ni@samsung.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 04/20] cxl/region: Support empty uuids for non-pmem
 regions
Message-ID: <20230210173016.000040d2@Huawei.com>
In-Reply-To: <167601994558.1924368.12612811533724694444.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601994558.1924368.12612811533724694444.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.211]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 10 Feb 2023 01:05:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Shipping versions of the cxl-cli utility expect all regions to have a
> 'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
> attribute to return an empty string which satisfies the current
> expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
> presence of regions with the 'uuid' attribute missing. Force the
> attribute to be read-only as there is no facility or expectation for a
> 'ram' region to recall its uuid from one boot to the next.
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
After your explanations in v1 thread, I'm fine with this.
Just another bit of slightly inelegant ABI that we are stuck with.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
>  drivers/cxl/core/region.c               |   11 +++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 058b0c45001f..4c4e1cbb1169 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -317,7 +317,8 @@ Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a unique identifier for the region. This field must
>  		be set for persistent regions and it must not conflict with the
> -		UUID of another region.
> +		UUID of another region. For volatile ram regions this
> +		attribute is a read-only empty string.
>  
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 17d2d0c12725..0fc80478ff6b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -45,7 +45,10 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> +	if (cxlr->mode != CXL_DECODER_PMEM)
> +		rc = sysfs_emit(buf, "\n");
> +	else
> +		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
>  	up_read(&cxl_region_rwsem);
>  
>  	return rc;
> @@ -300,8 +303,12 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  
> +	/*
> +	 * Support tooling that expects to find a 'uuid' attribute for all
> +	 * regions regardless of mode.
> +	 */
>  	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> -		return 0;
> +		return 0444;
>  	return a->mode;
>  }
>  
> 
> 

