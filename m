Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E8C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516B661248
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhFRRAy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:00:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:52680 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhFRRAx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 18 Jun 2021 13:00:53 -0400
IronPort-SDR: 1VXIFNHiBsb7ybk6M2eJRVaOFwUPV7SYfIxQt8r4YYLem1MYgFgJt/8Hf3sjLfh3gGzjmQOiC7
 yfVc9Zew5ckw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="203564641"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="203564641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:58:37 -0700
IronPort-SDR: +LIj31sOxq8AneMpLOqILkUR0jH0JQ09sTbq4TIibEFSKdgj6KXXH/T62ETSowzMv5GAr6IgZb
 A1uW/fSTzVrw==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="451455596"
Received: from pbodapat-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:58:37 -0700
Date:   Fri, 18 Jun 2021 09:58:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH V3] cxl/mem: Account for partitionable space in ram/pmem
 ranges
Message-ID: <20210618165833.2jem3rshyy7szsm6@intel.com>
References: <20210617221620.1904031-3-ira.weiny@intel.com>
 <20210618163129.1912453-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618163129.1912453-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-18 09:31:29, ira.weiny@intel.com wrote:
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

This doesn't look right to me, but I'll happily stand corrected.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for V3:
> 	Johnathan
> 		Stop over documenting 'in bytes'...  :-D
> 
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
>  drivers/cxl/pci.c | 96 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 96 insertions(+), 5 deletions(-)
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
> index 94b7ee08ef67..3c8b7aa8c273 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1455,6 +1455,53 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
>  	return ret;
>  }
>  
> +/**
> + * cxl_mem_get_partition_info - Get partition info
> + * @cxlm: The device to act on
> + * @active_volatile_bytes: returned active volatile capacity
> + * @active_persistent_bytes: returned active persistent capacity
> + * @next_volatile_bytes: return next volatile capacity
> + * @next_persistent_bytes: return next persistent capacity
> + *
> + * Retrieve the current partition info for the device specified.  If not 0, the
> + * 'next' values are pending and take affect on next cold reset.
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
> @@ -1573,18 +1620,53 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
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

If the command is not supported, you're going to get back -ENXIO here and fail.
I think what you want to do also is use IDENTIFY if PARTITION_INFO doesn't
exist.

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
> @@ -1618,6 +1700,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_mem_create_range_info(cxlm);
> +	if (rc)
> +		return rc;
> +

Assuming my assessment is correct, I think it's time to make
cxl_mem_mbox_send_cmd grow a little bit better error handling. I'd recommend
something like this and then checking for -ENOTSUPP.

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b1a5a18dba92..3b7d8a905393 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -92,6 +92,7 @@ struct mbox_cmd {
        size_t size_out;
        u16 return_code;
 #define CXL_MBOX_SUCCESS 0
+#define CXL_MBOX_UNSUPPORTED 0x15
 };

 static int cxl_mem_major;
@@ -876,9 +877,15 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
        if (rc)
                return rc;

-       /* TODO: Map return code to proper kernel style errno */
-       if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
+       switch (mbox_cmd.return_code) {
+       case CXL_MBOX_SUCCESS:
+               break;
+       case CXL_MBOX_UNSUPPORTED:
+               return -ENOTSUPP;
+       default:
+               /* TODO: Map return code to proper kernel style errno */
                return -ENXIO;
+       }

        /*
         * Variable sized commands can't be validated and so it's up to the


>  	return cxl_mem_add_memdev(cxlm);
>  }

>  
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
