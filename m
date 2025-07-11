Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CF944E
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252336; cv=none; b=QtP/Efg5r7WelAdimAl1nKt/a0n9A61asQiNeW9lZvmNvxptZEd6dTL03458hQ0dyloArK0n4Zpi7lgnFTAlt+dOC3Sqt68SvPTO4rfdZyI+QvGtFFc3e24N4kZ7tWi7BWYf40UFJHPb1JtvbajRSjCOCsr4/Yqo4yZGSYGRwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252336; c=relaxed/simple;
	bh=oXkVsn/SNRWaVlKPFL+jyyVFQZtF/GRVYpjd6HZtO4o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJZ+eq1bJlOCZN11gcg/P4JqHq/VxJLFCJZcFvW92D9oZiMCctlGnz6aQ5WMuk+q4kzGyZaTdDd46Ht3YJbb1q/DYjc2K2K8ylfBXhCbBlyoxqRprV/GVd5egCbZVwJjJ24O1Iv36821Kb85AYEEJ1Q1M2/wOvCPGvwTIcGV1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdyDQ01WFz67Ct5;
	Sat, 12 Jul 2025 00:42:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A9C11400D3;
	Sat, 12 Jul 2025 00:45:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:45:32 +0200
Date: Fri, 11 Jul 2025 17:45:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add hpa_to_spa to the root decoder callback
 operations
Message-ID: <20250711174530.0000291a@huawei.com>
In-Reply-To: <20250709200746.2567860-1-dave.jiang@intel.com>
References: <20250709200746.2567860-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Jul 2025 13:07:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Remove cxl_hpa_to_spa_fn callback from cxl root decoder and add the
> callback function to cxl_decoder_ops. Refactor to group all the root
> decoder callbacks together.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Question inline about mixture of types of CFMWS entry.

> ---
>  drivers/cxl/acpi.c        |  9 +++++++--
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/core/region.c | 11 ++++++++---
>  drivers/cxl/cxl.h         | 13 ++++++++-----
>  4 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 48478bc406ee..9f7e2a49dc5a 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -20,6 +20,10 @@ static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> +static u64 cxl_default_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> +{
> +	return hpa;
> +}
>  
>  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
>  {
> @@ -342,8 +346,9 @@ static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>  }
>  
> -static const struct cxl_rd_ops acpi_rd_ops = {
> +static struct cxl_rd_ops acpi_rd_ops = {
>  	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
> +	.hpa_to_spa = cxl_default_hpa_to_spa,
>  };
>  
>  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> @@ -425,7 +430,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	cxlrd->qos_class = cfmws->qtg_id;
>  
>  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
> -		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
> +		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;

What happens if we have a mixture for different CMWS entries?
Some xor, some not.

>  
>  	rc = cxl_decoder_add(cxld, target_map);
>  	if (rc)
