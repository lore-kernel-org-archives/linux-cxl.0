Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8749FC48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678BD613F4
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 11:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFKLC7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:02:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3208 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFKLC7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 07:02:59 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1d506VW2z6G7NF;
        Fri, 11 Jun 2021 18:54:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 13:00:59 +0200
Received: from localhost (10.52.120.251) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 12:00:58 +0100
Date:   Fri, 11 Jun 2021 12:00:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mem: Report correct ram/pmem size in sysfs
Message-ID: <20210611120054.00007eb7@Huawei.com>
In-Reply-To: <20210611002224.1594913-3-ira.weiny@intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
        <20210611002224.1594913-3-ira.weiny@intel.com>
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

On Thu, 10 Jun 2021 17:22:23 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Memory devices may specify volatile only, persistent only, and
> partitionable space which when added together result in a total capacity.
> 
> The partitionable space is configurable between volatile and persistent
> space.  To account for the dynamic partitionable space the correct ram
> and pmem size information is reported in the Get Partition Info device
> command.
> 
> Define cxl_mem_get_partition() and call it to retrieve the correct
> ram and pmem ranges sizes.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/pci.c | 97 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9995f97d3b28..bcc2829e4475 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1455,6 +1455,62 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
>  	return ret;
>  }
>  
> +/**
> + * cxl_mem_get_partition_info - Set partition info

Having a function call _get_ that is documented as "Set" is somewhat unusual.

> + * @cxlm: The device to act on
> + * @active_volatile_cap_bytes: returned active volatile capacity; in bytes
> + * @active_persistent_cap_bytes: returned active persistent capacity; in bytes
> + * @next_volatile_cap_bytes: return next volatile capacity; in bytes
> + * @next_persistent_cap_bytes: return next persistent capacity; in bytes
> + *
> + * Retrieve the current partition info for the device specified.  The active
> + * values are the current capacity in bytes.  If not 0, the 'next' values are
> + * the pending values, in bytes, which take affect on next cold reset.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL @8.2.9.5.2.1 Get Partition Info
> + */
> +int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> +			       u64 *active_volatile_cap_bytes,
> +			       u64 *active_persistent_cap_bytes,
> +			       u64 *next_volatile_cap_bytes,
> +			       u64 *next_persistent_cap_bytes)
> +{
> +	struct cxl_mbox_get_partition_info {
> +		u64 active_volatile_cap;
> +		u64 active_persistent_cap;
> +		u64 next_volatile_cap;
> +		u64 next_persistent_cap;
> +	} __packed pi;
> +	int rc;
> +
> +	/* On error report 0 */

This command is optional... See below.

> +	*active_volatile_cap_bytes = 0;
> +	*active_persistent_cap_bytes = 0;
> +	*next_volatile_cap_bytes = 0;
> +	*next_persistent_cap_bytes = 0;
> +
> +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
> +				   NULL, 0, &pi, sizeof(pi));
> +
> +	if (rc)
> +		return rc;
> +
> +	*active_volatile_cap_bytes = le64_to_cpu(pi.active_volatile_cap);
> +	*active_persistent_cap_bytes = le64_to_cpu(pi.active_persistent_cap);
> +	*next_volatile_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
> +	*next_persistent_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
> +
> +	*active_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +	*active_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +	*next_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +	*next_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_mem_get_partition_info);
> +
>  /**
>   * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
>   * @cxlm: The device.
> @@ -1573,20 +1629,45 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
>  			cxlm->persistent_cap_bytes,
>  			cxlm->partition_align_bytes);
>  
> +	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
> +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +
> +	return 0;
> +}
> +
> +static void cxl_mem_create_range_info(struct cxl_mem *cxlm)
> +{
> +	u64 active_volatile_cap_bytes;
> +	u64 active_persistent_cap_bytes;
> +	u64 next_volatile_cap_bytes;
> +	u64 next_persistent_cap_bytes;
> +
> +	if (cxl_mem_get_partition_info(cxlm,
> +			       &active_volatile_cap_bytes,
> +			       &active_persistent_cap_bytes,
> +			       &next_volatile_cap_bytes,
> +			       &next_persistent_cap_bytes))
> +		dev_err(&cxlm->pdev->dev, "Failed to query partition information\n");
> +
> +	dev_dbg(&cxlm->pdev->dev, "Get Partition Info\n"
> +		"     active_volatile_cap_bytes = %#llx\n"
> +		"     active_persistent_cap_bytes = %#llx\n"
> +		"     next_volatile_cap_bytes = %#llx\n"
> +		"     next_persistent_cap_bytes = %#llx\n",
> +			active_volatile_cap_bytes,
> +			active_persistent_cap_bytes,
> +			next_volatile_cap_bytes,
> +			next_persistent_cap_bytes);
> +
>  	/*
>  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
>  	 * For now, only the capacity is exported in sysfs
>  	 */
>  	cxlm->ram_range.start = 0;
> -	cxlm->ram_range.end = cxlm->volatile_cap_bytes - 1;
> +	cxlm->ram_range.end = active_volatile_cap_bytes - 1;

This change looks to wipe out the valid settings on a device
that only does fixed allocations to pmem vs volatile.

>  
>  	cxlm->pmem_range.start = 0;
> -	cxlm->pmem_range.end = cxlm->persistent_cap_bytes - 1;
> -
> -	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
> -	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> -
> -	return 0;
> +	cxlm->pmem_range.end = active_persistent_cap_bytes - 1;
>  }
>  
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> @@ -1618,6 +1699,8 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	cxl_mem_create_range_info(cxlm);
> +
>  	return cxl_mem_add_memdev(cxlm);
>  }
>  

