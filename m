Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A715AF6
	for <linux-cxl@vger.kernel.org>; Thu, 26 Dec 2024 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735188600; cv=pass; b=bvYri/EfwguDNHLcazMu+6+HMUdActWF+zVB5wQSoyHtFfSTKWfvPw2mBoCFwzWabe+G8j0bFtHgQpfDpEQtbYi2FQFcbD+odR+yylKCRURfz9qpQsvF8dTrITCpmXPnfIi8cRoSZVJqQCDXkO68g3hlBQu+FLbCBRBYdzYU6d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735188600; c=relaxed/simple;
	bh=RWIJSGAlDElkFY1UjcWuKjrFtqmCP/YQAY0gzfk+jdg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FTEQUoLxX/zPCcXixBSl+SstOcTBU6s6YdQ3gYGPsWRZp4sycZVmQ2Ob/GTWbZS+79ki2CDRE9d3BBWGKzwvwWwSMEqI9fB1k2CG90RlFILY/E/0XeuG8pR9mM+4dvlL7haDWXFWdDdrLQkAD9yQAvIOy6vLAagXYr+SbQg6zn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WcjTXOR1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WcjTXOR1"
ARC-Seal: i=1; a=rsa-sha256; t=1735188586; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E6tEGLDIbNtrRFAI0MrdJDlrRLe+Iwa1cr4JRHRlkrJ6w07SReveT3KW+53b5dKcDj/G626RIa5OSjM4IROw0rk0Mu0SvH/zUYaNC2d7/q53Kc1WkUcO6NZpwABwjJ8VlmNso2EOTPXy730+h/UMevw38O853TpYU64NtEXcjtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735188586; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qA6jS06IiT0OgZ4Bv6jlcbfkSHP0nGY2ojRxEUeMO4Q=; 
	b=R9ZYcfXvi+Lxq1AyUSlUtLGI/kdZkCjR52AQqMxt6yxP890BmU4oseiwi74pXaxjyYuQv6oHrEJsX1SIsHUP8E/gxUyX/xz1D5oF9dNg6HBKo9calWItf0cy+kgcLGqhU1NJ9zQ29UQf60t9z8fslk669Bf/tFJh5W/RYLldtN0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735188586;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=qA6jS06IiT0OgZ4Bv6jlcbfkSHP0nGY2ojRxEUeMO4Q=;
	b=WcjTXOR1c0TiAMzVT3X/sPDGWTB5EiSB4mDqpjn67X7sSelvIdIyZIuLc0+/ZZe0
	dVuPJPVbQW/JOyAHeJDhdl3RbFW+hRl6hjUa6PgnMvP446DZIkFVIykMGvPnVuB9PRz
	NSAIolg2W6UHM35fzQ47v+rJHlzrc6D1N7nFQJOQ=
Received: by mx.zohomail.com with SMTPS id 1735188583528215.2749892275989;
	Wed, 25 Dec 2024 20:49:43 -0800 (PST)
Message-ID: <2d7a78c5-8544-4dfc-822c-bae8677c1703@zohomail.com>
Date: Thu, 26 Dec 2024 10:11:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH] [RFC] cxl/core/regs: Refactor out functions to count
 regblocks of given type
To: Huaisheng Ye <huaisheng.ye@intel.com>, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, dave.jiang@intel.com
Cc: pei.p.jia@intel.com, linux-cxl@vger.kernel.org
References: <20241225083539.2230150-1-huaisheng.ye@intel.com>
In-Reply-To: <20241225083539.2230150-1-huaisheng.ye@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122799fad64c88aa22d70746b74700005812f985b8f8c3c3b4b5c4461dee4eafc1a429d025669ab14b:zu080112273977cc70d4da53e66d207cb600001b425de431d2e709452e9a78470872c0a8141e89f6df982f6e:rf0801122dadb4d3a57b1366b7c6e4858b000073f9dd50b8b376c5eb39016836057ce2f26fa38fec963c4be982e31d8bef09:ZohoMail
X-ZohoMailClient: External

On 12/25/2024 4:35 PM, Huaisheng Ye wrote:
> In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
> added for counting regblocks of a given RBI (Register Block Identifier).
> It is workable, but has two drawbacks that can be improved.
>
> 1. In order to get the count of instances, cxl_count_regblock has to tentatively
> repeat the call of cxl_find_regblock_instance by increasing index from 0. It
> will not stop until an error value is returned. Actually, It needs to search for
> Register Blocks in dvsec again every time by taking a start from the head. This
> is a bit inefficient.
>
> For example, to determine if PMU1 exists, cxl_find_regblock_instance must check
> all Register Blocks by the type and index from RB1 to RB4. If there are more RBs
> of the same type in the future, the situation will be even worse.
>
> 16 81 00 23		PCIe extended Capability Header
> 02 c0 1e 98		Header 1
> 00 00 00 08		Header 2
> --------------------------------------
> 00 00 01 00		RB 1 - Offset Low	Component
> 00 00 00 00		RB 1 - Offset High
> --------------------------------------
> 00 00 03 02		RB 2 - Offset Low	Device Register
> 00 00 00 00		RB 2 - Offset High
> --------------------------------------
> 00 01 04 02		RB 3 - Offset Low	PMU0
> 00 00 00 00		RB 3 - Offset High
> --------------------------------------
> 00 02 04 02		RB 4 - Offset Low	PMU1
> 00 00 00 00		RB 4 - Offset High
>
> RB: Register Block
>
> 2. cxl_count_regblock blocks the opportunity to get error codes from
> cxl_find_regblock_instance. cxl_pci_probe has error code checking for almost
> all function calls. This is a good behavior, but cxl_count_regblock couldn't.
>
> With this patch, only need to add two lines of code in cxl_find_regblock_instance,
> which can return the count of regblocks by given RBI in just one call. It is
> more effective than before. Besides, the error code could be obtained by the
> called function, here is cxl_pci_probe.
>
> Based on the above reasons, cxl_count_regblock could be considered to remove.
>
> This patch is tested by ndctl cxl_test and physical CXL expander card
> with v6.12.

I think the description about how you tested the patch should be included in cover-letter rather than patch's changelog.


>
> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
> ---
>  drivers/cxl/core/regs.c | 32 +++++++-------------------------
>  drivers/cxl/cxl.h       |  2 +-
>  drivers/cxl/pci.c       |  7 ++++++-
>  3 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..d6b882a334d5 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -290,17 +290,19 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  }
>  
>  /**
> - * cxl_find_regblock_instance() - Locate a register block by type / index
> + * cxl_find_regblock_instance() - Locate a register block or count instances by type / index
>   * @pdev: The CXL PCI device to enumerate.
>   * @type: Register Block Indicator id
>   * @map: Enumeration output, clobbered on error
>   * @index: Index into which particular instance of a regblock wanted in the
>   *	   order found in register locator DVSEC.
>   *
> - * Return: 0 if register block enumerated, negative error code otherwise
> + * Return: 0 if register block enumerated, non-negative if counting instances,
> + * negative error code otherwise
>   *
>   * A CXL DVSEC may point to one or more register blocks, search for them
>   * by @type and @index.
> + * Use CXL_INSTANCES_COUNT for @index if counting instances by @type.
>   */
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index)
> @@ -341,6 +343,9 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		}
>  	}
>  
> +	if (index == CXL_INSTANCES_COUNT)
> +		return instance;
> +

Above return will skip below 'map->resource = CXL_RESOURCE_NONE'. is it expected?


>  	map->resource = CXL_RESOURCE_NONE;
>  	return -ENODEV;
>  }
> @@ -364,29 +369,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>  
> -/**
> - * cxl_count_regblock() - Count instances of a given regblock type.
> - * @pdev: The CXL PCI device to enumerate.
> - * @type: Register Block Indicator id
> - *
> - * Some regblocks may be repeated. Count how many instances.
> - *
> - * Return: count of matching regblocks.
> - */
> -int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
> -{
> -	struct cxl_register_map map;
> -	int rc, count = 0;
> -
> -	while (1) {
> -		rc = cxl_find_regblock_instance(pdev, type, &map, count);
> -		if (rc)
> -			return count;
> -		count++;
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
> -
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
>  {
>  	struct device *dev = map->host;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..3fbbd76da819 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -294,8 +294,8 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
>  			struct cxl_device_regs *regs);
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
>  
> +#define CXL_INSTANCES_COUNT -1
>  enum cxl_regloc_type;
> -int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..5aa4dfda4a73 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -915,7 +915,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
> +	rc = cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_PMU, &map, CXL_INSTANCES_COUNT);

I think that I can clearly understand what cxl_count_regblock() does from the name of it, not sure if repalcing cxl_count_regblock() with cxl_find_regblock_instance() is a good choice.

Let us see if other reviwers have more comments on it.


> +	if (rc < 0)
> +		return rc;

Before this patch, any error happened in cxl_count_regblock() will cause cxl_count_regblock() returning current PMU instance counter, it will not stop cxl pci probing.

But this patch will change this code logic, any error happened during counting PMU instance counter will stop cxl pci probing, is it expected?

My understanding is that cxl_pci driver allows PMU initialization failure(in below loops), so I guess that counting PMU instances failure is allowed, just initializing the number of PMU instances returned by cxl_count_regblock() is OK.


> +
> +	pmu_count = rc;
> +
>  	for (i = 0; i < pmu_count; i++) {
>  		struct cxl_pmu_regs pmu_regs;
>  


