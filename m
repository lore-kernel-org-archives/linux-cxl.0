Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223EC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9963613E2
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhFRNnT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:43:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3281 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhFRNnS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 09:43:18 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G60J76jmcz6H6kH;
        Fri, 18 Jun 2021 21:33:59 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:41:08 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 14:41:07 +0100
Date:   Fri, 18 Jun 2021 14:40:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] cxl/pci: Store memory capacity values
Message-ID: <20210618144058.0000742c@Huawei.com>
In-Reply-To: <20210617221620.1904031-2-ira.weiny@intel.com>
References: <20210617221620.1904031-1-ira.weiny@intel.com>
        <20210617221620.1904031-2-ira.weiny@intel.com>
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

On Thu, 17 Jun 2021 15:16:18 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The Identify Memory Device command returns information about the
> volatile only and persistent only memory capacities.  Store those values
> in the cxl_mem structure for later use.  While at it, reuse those
> calculations to calculate the ram and pmem ranges.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
New naming is indeed clearer.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes for V2:
> 	Ben
> 		Change names to be more clear
> 			total_bytes
> 			volatile_only_bytes
> 			persistent_only_bytes
> ---
>  drivers/cxl/mem.h |  4 ++++
>  drivers/cxl/pci.c | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 13868ff7cadf..9dc34418db36 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -75,5 +75,9 @@ struct cxl_mem {
>  
>  	struct range pmem_range;
>  	struct range ram_range;
> +	u64 total_bytes;
> +	u64 volatile_only_bytes;
> +	u64 persistent_only_bytes;
> +	u64 partition_align_bytes;
>  };
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5a1705b52278..94b7ee08ef67 100644
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
> +	cxlm->total_bytes = le64_to_cpu(id.total_capacity);
> +	cxlm->total_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	cxlm->volatile_only_bytes = le64_to_cpu(id.volatile_capacity);
> +	cxlm->volatile_only_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	cxlm->persistent_only_bytes = le64_to_cpu(id.persistent_capacity);
> +	cxlm->persistent_only_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	cxlm->partition_align_bytes = le64_to_cpu(id.partition_align);
> +	cxlm->partition_align_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +	dev_dbg(&cxlm->pdev->dev, "Identify Memory Device\n"
> +		"     total_bytes = %#llx\n"
> +		"     volatile_only_bytes = %#llx\n"
> +		"     persistent_only_bytes = %#llx\n"
> +		"     partition_align_bytes = %#llx\n",
> +			cxlm->total_bytes,
> +			cxlm->volatile_only_bytes,
> +			cxlm->persistent_only_bytes,
> +			cxlm->partition_align_bytes);
> +
>  	/*
>  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
>  	 * For now, only the capacity is exported in sysfs
>  	 */
>  	cxlm->ram_range.start = 0;
> -	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) * SZ_256M - 1;
> +	cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
>  
>  	cxlm->pmem_range.start = 0;
> -	cxlm->pmem_range.end =
> -		le64_to_cpu(id.persistent_capacity) * SZ_256M - 1;
> +	cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
>  
>  	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));

