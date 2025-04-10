Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AD1D6DAA;
	Thu, 10 Apr 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299820; cv=none; b=DpRr1vEDHj/kAA40IsHa1lG6WuqZQ5IENwXW3cjZwDRvHQhAVmSIeuDfHIgvSfipjXyAjlMfrgBqlzQg8mbul32CS+/tDmjPtE/5hY8WriOzwzXHjuSDlJvPGmO1bMHX7DDa+uh466XZ6R2eSGH0cmW+WqZnWB0mSRMmBw8JYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299820; c=relaxed/simple;
	bh=ervI1TJmsGtY0DgxChlWBEjJAWpFVRrPVvZnzvGcfmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSFfSCWMT6dZ4G3URbqGQMU2QOdGRqBIKL1k+wn4HU+LFV5AqUH2Q0m8VZM4eFsX4FAK5PP6ZriFjNkVyKVtA0Meha11u+X+ilJg3smZE97s6JaAnJcypOqa4xCectUX+QTvPDjVRSPHFJA1Ua8qaF0AdOAJgvJ/BsxEQbD0kfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EttXrDsf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EttXrDsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299817; x=1775835817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ervI1TJmsGtY0DgxChlWBEjJAWpFVRrPVvZnzvGcfmw=;
  b=EttXrDsf9f8sntQ9mu2Q8e15WC8hRwZuzEDeEq3olVrW+zMdHI5gmn7B
   k5kw3Ay4h4eRFdYxj5MAGGD8GgxYE3QBtoIkw29davLRAjtbhGI0SHMjC
   SOb4njFebtwzU1CfOajtza1MSA6mA2h3GTPQsp/3pioNW8g9Y/aMs254G
   KLJjGJ4xNADzi72vis4G2qj/IyDCw4EpGXBv5bcd6diKnu7GkxnF42juj
   OQBOE+KoeBsa/7bMW/Ez8mfiQnkD+/4qgMIUMp08y47hLG9mC4uGQI550
   SnmQDtUVIFP1WC1n0F2+lUC6pliCtfL/JlR2Hkm+kcu6qmP8Alks93Tpp
   Q==;
X-CSE-ConnectionGUID: 418Cck4QQ7OqxpcYCmaU7w==
X-CSE-MsgGUID: FnnNkd2eQ1yJfWfe8/JAPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45959133"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45959133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:43:37 -0700
X-CSE-ConnectionGUID: LgsXyOJOQj+EvO00hwZZYg==
X-CSE-MsgGUID: kHmXvw1dSZuF4uHbS1ZHiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="133668153"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:43:35 -0700
Message-ID: <079fd012-eba6-4772-91b9-d58b20bfe425@intel.com>
Date: Thu, 10 Apr 2025 08:43:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/acpi: Verify CHBS length for CXL2.0
To: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>
References: <20250410010545.99590-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250410010545.99590-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 6:05 PM, Li Zhijian wrote:
> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> own length, verify it to avoid an invalid CHBS.
> 
> Additionally, this patch also removes the redundant macro CXL_RCRB_SIZE,
> favoring the use of `ACPI_CEDT_CHBS_LENGTH_CXL11`, which offers clearer
> semantic meaning.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied to cxl/next with Dan's suggestion.

> ---
> V3:
>  - say more words in removing CXL_RCRB_SIZE # Alison
>  - Collected Reviewed-by
> V2: don't factor out, just validate # Dan
> ---
>  drivers/cxl/acpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..2e63e50b2c40 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,8 +11,6 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> -#define CXL_RCRB_SIZE	SZ_8K
> -
>  struct cxl_cxims_data {
>  	int nr_maps;
>  	u64 xormaps[] __counted_by(nr_maps);
> @@ -478,8 +476,10 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  
>  	chbs = (struct acpi_cedt_chbs *) header;
>  
> -	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> -	    chbs->length != CXL_RCRB_SIZE)
> +	if ((chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11) ||
> +	   (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
> +	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20))
>  		return 0;
>  
>  	if (!chbs->base)

