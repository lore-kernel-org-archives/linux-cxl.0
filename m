Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857B25C82E
	for <linux-cxl@vger.kernel.org>; Wed,  1 Oct 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329850; cv=none; b=R/Ws+ZwP7FVVLcqBIfrwhtlLztOdPb9riGzxsuMqgNrDDO0fX5Q1kYjJfueNpAevh2ZlrcChNBIEJkcocJAYTwTTJnoHUSiyiVMueTIX5Pk9okQN+4iVpwiC/ug80WYHR3QghBj2lShkNvj+0d/h41Czj7Xag/P/tR+kq87byQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329850; c=relaxed/simple;
	bh=q9F0aJtlzg01YCEMTcaLS60UwKjp65bnCj5Yii+GGyM=;
	h=Date:From:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0ZmE3BhBpbPG0CdmPbIHubYS4oVwVSGz91UWOnLwhZ3DMomzXhVMSr7LdcarO6X6MadU94RzPvq/3c5aMVQJAD0ugrCgw2v1V7bVu4lvsrhcqKCvNGwvGseSRFKoCx1yfP3LPTrpbLPbRnt6bJ5o+FvLC3dNDMIfMC9xhtT53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccHjv48y0z6K5rs;
	Wed,  1 Oct 2025 22:43:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 10310140114;
	Wed,  1 Oct 2025 22:44:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 15:44:04 +0100
Date: Wed, 1 Oct 2025 15:44:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Qing Huang
	<qing.huang@intel.com>
Subject: Re: [PATCH] cxl/region: Translate DPA->HPA in unaligned MOD3
 regions
Message-ID: <20251001154402.00006f3e@huawei.com>
In-Reply-To: <20250930040838.353229-1-alison.schofield@intel.com>
References: <20250930040838.353229-1-alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 29 Sep 2025 21:08:36 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL driver implementation of DPA->HPA address translation depends
> on a region's starting address always being aligned to Host Bridge
> Interleave Ways * 256MB. The driver follows the decode methods
> defined in the CXL Spec[1] and expanded upon in the CXL Driver Writers
> Guide[2], which describe bit manipulations based on power-of-2
> alignment to translate a DPA to an HPA.
> 
> With the introduction of MOD3 interleave way support, platforms may
> create regions at starting addresses that are not power-of-2 aligned.
> This allows platforms to avoid gaps in the memory map, but addresses
> within those regions cannot be translated using the existing bit
> manipulation method.
> 
> Introduce an unaligned translation method for DPA->HPA that
> reconstructs an HPA by restoring the address first at the port level
> and then at the host bridge level.
> 
> [1] CXL Spec 3.2 8.2.4.20.13 Implementation Note Device Decoder Logic
> [2] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation
> 
> Suggested-by: Qing Huang <qing.huang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

My 'favourite' headache inducer in the spec. Anyhow, questions on the comments
inline.

J

> ---
> 
> Changes in v1 (was RFC):
> - Replace "/" with do_div() to quiet i386 build warning (lkp)
> - Replace 'cxld->interleave_ways' with 'hbiw' for clarity
> - Use div64_u64_rem() for alignment alignment
> - Fix up a printk format specifier (lkp)
> - Update code comments and commit log
> - Rebase on v717-rc7
> 
>  drivers/cxl/core/region.c | 125 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 119 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 71cc42d05248..4fc0d1450c2c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2918,13 +2918,115 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>  	return false;
>  }
>  
> +static int decode_pos(int region_ways, int pos, int *pos_port, int *pos_hb)
> +{
> +	switch (region_ways) {
> +	/*
> +	 * Extract the port and hb positions from an endpoint position.
> +	 * Knowing there is only one possible decode** for each of these
> +	 * regions, decode logic is:
> +	 *	 3-way: port always 0, hb is pos
> +	 *	 6-way: port cycles thru 0,1, hb increments every 2

Why is 6 host bridge option not relevant?

> +	 *	12-way: port cycles thru 0,1,2,3, hb increments every 4

Why is 6 host bridge option, cycle every 2 or indeed 12 host bridge option
not relevant?

> +	 *
> +	 *	**CXL Spec 3.2 9.13.1.1 Legal Interleaving Configurations
> +	 */
> +	case 3:
> +		*pos_port = 0;
> +		*pos_hb = pos;
> +		break;
> +	case 6:
> +		*pos_port = pos % 2;
> +		*pos_hb = pos / 2;
> +		break;
> +	case 12:
> +		*pos_port = pos % 4;
> +		*pos_hb = pos / 4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

...


