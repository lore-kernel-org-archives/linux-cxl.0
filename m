Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12526C49360
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08E6613E1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFKRUX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:20:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:9457 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhFKRUX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 13:20:23 -0400
IronPort-SDR: 0Z94GLD74szdDCw/+00VxlqD3bGwENuM2V/4jY3/MBPvg7fIlfpfpVeL7UJ+neX/e9yuCT8pZb
 e8jcWcAfh+1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291200370"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="291200370"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:18:06 -0700
IronPort-SDR: hm1JdrENE5GOhYnIvM95xV/7VT6U7QtI5Gs5NsFIiOouDeESp9wwMulL/ad7VOVDzGDs/T5GA+
 t+QzvvlGSeZg==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="403071733"
Received: from chtanaka-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.138.239])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:18:06 -0700
Date:   Fri, 11 Jun 2021 10:18:04 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/pci: Store memory capacity values
Message-ID: <20210611171804.br5eaur325drklo2@intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
 <20210611002224.1594913-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611002224.1594913-2-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-10 17:22:22, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The Identify Memory Device command returns information about the
> volatile and persistent memory capacities.  Store those values in the
> cxl_mem structure for later use.  While at it, reuse the calculation of
> the volatile and persistent memory byte values to calculate the ram and
> pmem ranges.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

One comment below that can be taken or left...

Acked-by: Ben Widawsky <ben.widawsky@intel.com>

> ---
>  drivers/cxl/mem.h |  4 ++++
>  drivers/cxl/pci.c | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 13868ff7cadf..8bd0d0506b97 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -75,5 +75,9 @@ struct cxl_mem {
>  
>  	struct range pmem_range;
>  	struct range ram_range;
> +	u64 total_cap_bytes;
> +	u64 volatile_cap_bytes;
> +	u64 persistent_cap_bytes;

I'd either drop 'cap' entirely or type it out. I don't think 'cap' is a
descriptive name.

> +	u64 partition_align_bytes;
>  };
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5a1705b52278..9995f97d3b28 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -57,6 +57,15 @@ enum opcode {
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> +/*
> + * CXL 2.0 - Memory capacity multiplier
> + * See Section 8.2.9.5
> + *
> + * Volatile, Persistent, and Partition capacities are specified to be in
> + * multiples of 256MB - define a multiplier to convert to/from bytes.
> + */
> +#define CXL_CAPACITY_MULTIPLIER SZ_256M
> +
>  /**
>   * struct mbox_cmd - A command to be submitted to hardware.
>   * @opcode: (input) The command set and command submitted to hardware.
> @@ -1542,16 +1551,37 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
>  	if (rc < 0)
>  		return rc;
>  
> +	cxlm->total_cap_bytes = le64_to_cpu(id.total_capacity);
> +	cxlm->total_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	cxlm->volatile_cap_bytes = le64_to_cpu(id.volatile_capacity);
> +	cxlm->volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	cxlm->persistent_cap_bytes = le64_to_cpu(id.persistent_capacity);
> +	cxlm->persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	cxlm->partition_align_bytes = le64_to_cpu(id.partition_align);
> +	cxlm->partition_align_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	dev_dbg(&cxlm->pdev->dev, "Identify Memory Device\n"
> +		"     total_cap_bytes = %#llx\n"
> +		"     volatile_cap_bytes = %#llx\n"
> +		"     persistent_cap_bytes = %#llx\n"
> +		"     partition_align_bytes = %#llx\n",
> +			cxlm->total_cap_bytes,
> +			cxlm->volatile_cap_bytes,
> +			cxlm->persistent_cap_bytes,
> +			cxlm->partition_align_bytes);
> +
>  	/*
>  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
>  	 * For now, only the capacity is exported in sysfs
>  	 */
>  	cxlm->ram_range.start = 0;
> -	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) * SZ_256M - 1;
> +	cxlm->ram_range.end = cxlm->volatile_cap_bytes - 1;
>  
>  	cxlm->pmem_range.start = 0;
> -	cxlm->pmem_range.end =
> -		le64_to_cpu(id.persistent_capacity) * SZ_256M - 1;
> +	cxlm->pmem_range.end = cxlm->persistent_cap_bytes - 1;
>  
>  	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
