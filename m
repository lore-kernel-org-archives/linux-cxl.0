Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB4EC48BE8
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D3611CE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhFROBX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:01:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3282 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhFROBX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 10:01:23 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G60hz5VPQz6H6lC;
        Fri, 18 Jun 2021 21:52:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:59:12 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 14:59:11 +0100
Date:   Fri, 18 Jun 2021 14:59:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 2/3] cxl/mem: Account for partitionable space in
 ram/pmem ranges
Message-ID: <20210618145902.00001dbe@Huawei.com>
In-Reply-To: <20210617221620.1904031-3-ira.weiny@intel.com>
References: <20210617221620.1904031-1-ira.weiny@intel.com>
        <20210617221620.1904031-3-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 15:16:19 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Memory devices may specify volatile only, persistent only, and
> partitionable space which when added together result in a total capacity.
> 
> If Identify Memory Device.Partition Alignment != 0 the device supports
> partitionable space.  This partitionable space can be split between
> volatile and persistent space.  The total volatile and persistent sizes
> are reported in Get Partition Info.  ie
> 
> 	active volatile memory = volatile only + partitionable volatile
> 	active persistent memory = persistent only + partitionable persistent
> 
> Define cxl_mem_get_partition(), check for partitionable support, and use
> cxl_mem_get_partition() if applicable.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Trivial editorial stuff inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for V2:
> 	Jonathan
> 		Account for Get Partition Info being optional
> 		Fix documentation
> 	Dan
> 		Store the active capacities in struct cxl_mem
> 		Make cxl_mem_get_partition() static until there is a
> 		need to export it.
> ---
>  drivers/cxl/mem.h |  5 +++
>  drivers/cxl/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 98 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 9dc34418db36..8d7bd966a298 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -79,5 +79,10 @@ struct cxl_mem {
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> +
> +	u64 active_volatile_bytes;
> +	u64 active_persistent_bytes;
> +	u64 next_volatile_bytes;
> +	u64 next_persistent_bytes;
>  };
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 94b7ee08ef67..341885345b53 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1455,6 +1455,55 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
>  	return ret;
>  }
>  
> +/**
> + * cxl_mem_get_partition_info - Get partition info
> + * @cxlm: The device to act on
> + * @active_volatile_bytes: returned active volatile capacity; in bytes

Perhaps over documented?  Would be very very odd if _bytes attribute wasn't
in bytes so maybe don't need to state it in the comment?

> + * @active_persistent_bytes: returned active persistent capacity; in bytes
> + * @next_volatile_bytes: return next volatile capacity; in bytes
> + * @next_persistent_bytes: return next persistent capacity; in bytes
> + *
> + * Retrieve the current partition info for the device specified.  The active
> + * values are the current capacity in bytes.  If not 0, the 'next' values are

Definitely don't need to say they are in bytes again.

> + * the pending values, in bytes, which take affect on next cold reset.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL @8.2.9.5.2.1 Get Partition Info
> + */
> +static int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> +				      u64 *active_volatile_bytes,
> +				      u64 *active_persistent_bytes,
> +				      u64 *next_volatile_bytes,
> +				      u64 *next_persistent_bytes)
> +{
> +	struct cxl_mbox_get_partition_info {
> +		u64 active_volatile_cap;
> +		u64 active_persistent_cap;
> +		u64 next_volatile_cap;
> +		u64 next_persistent_cap;
> +	} __packed pi;
> +	int rc;
> +
> +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
> +				   NULL, 0, &pi, sizeof(pi));
> +

In my view, slightly better to not have a blank line between statement
and error handling.

> +	if (rc)
> +		return rc;
> +
> +	*active_volatile_bytes = le64_to_cpu(pi.active_volatile_cap);
> +	*active_persistent_bytes = le64_to_cpu(pi.active_persistent_cap);
> +	*next_volatile_bytes = le64_to_cpu(pi.next_volatile_cap);
> +	*next_persistent_bytes = le64_to_cpu(pi.next_volatile_cap);
> +
> +	*active_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
> +	*active_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
> +	*next_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
> +	*next_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	return 0;
> +}
> +
>  /**
>   * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
>   * @cxlm: The device.
> @@ -1573,18 +1622,53 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
>  			cxlm->persistent_only_bytes,
>  			cxlm->partition_align_bytes);
>  
> +	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
> +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
> +{
> +	int rc;
> +
> +	if (cxlm->partition_align_bytes == 0) {
> +		cxlm->ram_range.start = 0;
> +		cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
> +		cxlm->pmem_range.start = 0;
> +		cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
> +		return 0;
> +	}
> +
> +	rc = cxl_mem_get_partition_info(cxlm,
> +					&cxlm->active_volatile_bytes,
> +					&cxlm->active_persistent_bytes,
> +					&cxlm->next_volatile_bytes,
> +					&cxlm->next_persistent_bytes);
> +	if (rc < 0) {
> +		dev_err(&cxlm->pdev->dev, "Failed to query partition information\n");
> +		return rc;
> +	}
> +
> +	dev_dbg(&cxlm->pdev->dev, "Get Partition Info\n"
> +		"     active_volatile_bytes = %#llx\n"
> +		"     active_persistent_bytes = %#llx\n"
> +		"     next_volatile_bytes = %#llx\n"
> +		"     next_persistent_bytes = %#llx\n",
> +			cxlm->active_volatile_bytes,
> +			cxlm->active_persistent_bytes,
> +			cxlm->next_volatile_bytes,
> +			cxlm->next_persistent_bytes);
> +
>  	/*
>  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
>  	 * For now, only the capacity is exported in sysfs
>  	 */
>  	cxlm->ram_range.start = 0;
> -	cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
> +	cxlm->ram_range.end = cxlm->active_volatile_bytes - 1;
>  
>  	cxlm->pmem_range.start = 0;
> -	cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
> -
> -	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
> -	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +	cxlm->pmem_range.end = cxlm->active_persistent_bytes - 1;
>  
>  	return 0;
>  }
> @@ -1618,6 +1702,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_mem_create_range_info(cxlm);
> +	if (rc)
> +		return rc;
> +
>  	return cxl_mem_add_memdev(cxlm);
>  }
>  

