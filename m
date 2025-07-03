Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7821CF96
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553106; cv=none; b=Gotx9YFZ5tZkMcbxBIzNxpF4zciPeBoSOYwONVU1BbdriiIb58258nYPz3MSeglRYOwgWtVDokSiQNUFfZx44o2X2cmuD2W9++9NQNwZ5JD6n8/G0w57YJek+DzTEVwQMjkaIIkV5NHhTTl47UrWW7JwzKq+bBkhLTnFUKc+I4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553106; c=relaxed/simple;
	bh=Pb5SIV1/JScE0iD1MtcKrjjcc4kjLTrxCloE53E2e0A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1w69QzUSelnuao7WfvcSvmzfo6sBecftQnY/DKLz2glF0IDSdNMdfMi1+alGqJKo2a4tXx1tnYshuSKppzKBwQs/2NbL/4o7LO/JBwwe7rDmSBn3I86kZozG3IItKHDe3LYUwIK6WC2WHQ+zzChE6bIQ0FDY9yfj9tsB6OuN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXzhv0nxHz67Ct6;
	Thu,  3 Jul 2025 22:31:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 65F641402F3;
	Thu,  3 Jul 2025 22:31:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 16:31:39 +0200
Date: Thu, 3 Jul 2025 15:31:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl/region: Add inject and clear poison by
 region offset
Message-ID: <20250703153138.00000a00@huawei.com>
In-Reply-To: <4f33bcb42217139e0884784e60139e29c647f62b.1751513505.git.alison.schofield@intel.com>
References: <cover.1751513505.git.alison.schofield@intel.com>
	<4f33bcb42217139e0884784e60139e29c647f62b.1751513505.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  2 Jul 2025 21:03:23 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add CXL region debugfs attributes to inject and clear poison based
> on an offset into the region. These new interfaces allow users to
> operate on poison at the region level without needing to resolve
> Device Physical Addresses (DPA) or target individual memdevs.
> 
> The implementation uses a new helper, region_offset_to_dpa_result()
> that applies decoder interleave logic, including XOR-based address
> decoding when applicable. Note that XOR decodes rely on driver
> internal xormaps which are not exposed to userspace. So, this support
> is not only a simplification of poison operations that could be done
> using existing per memdev operations, but also it enables this
> functionality for XOR interleaved regions for the first time.
> 
> New debugfs attributes are added in /sys/kernel/debug/cxl/regionX/:
> inject_poison and clear_poison. These are only exposed if all memdevs
> participating in the region support both inject and clear commands,
> ensuring consistent and reliable behavior across multi-device regions.
> 
> If tracing is enabled, these operations are logged as cxl_poison
> events in /sys/kernel/tracing/trace.
> 
> The ABI documentation warns users of the significant risks that
> come with using these capabilities.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v2:
> Simplify return using test_bit() in cxl_memdev_has_poison() (Jonathan)
> Use ACQUIRE() in the debugfs inject and clear funcs (DaveJ, Jonathan)
> Fail if offset is in the extended linear cache (Jonathan)
> Added 'cxl' to an existing ABI for memdev clear_poison
> Redefine ABI to take a region offset, not SPA (Dan)
> Remove KernelVersion field in ABI doc (Dan)
> Warn against misuse in ABI doc (Dan)
> Add validate_region_offset() helper
> 
> 
>  Documentation/ABI/testing/debugfs-cxl |  89 ++++++++++++++++-
>  drivers/cxl/core/core.h               |   4 +
>  drivers/cxl/core/memdev.c             |   8 ++
>  drivers/cxl/core/region.c             | 131 +++++++++++++++++++++++++-
>  4 files changed, 228 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index 12488c14be64..2989d4da96c1 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -19,8 +19,22 @@ Description:
>  		is returned to the user. The inject_poison attribute is only
>  		visible for devices supporting the capability.
>  
> +		TEST-ONLY INTERFACE: This interface is intended for testing
> +		and validation purposes only. It is not a data repair mechanism
> +		and should never be used on production systems or live data.
>  
> -What:		/sys/kernel/debug/memX/clear_poison
> +		DATA LOSS RISK: For CXL persistent memory (PMEM) devices,
> +		poison injection can result in permanent data loss. Injected
> +		poison may render data permanently inaccessible even after
> +		clearing, as the clear operation writes zeros and does not
> +		recover original data.
> +
> +		SYSTEM STABILITY RISK: For volatile memory, poison injection
> +		can cause kernel crashes, system instability, or unpredictable
> +		behavior if the poisoned addresses are accessed by running code
> +		or critical kernel structures.
> +
> +What:		/sys/kernel/debug/cxl/memX/clear_poison

Moved or previously a bug?  Looks like a bug, so separate patch.
Not sure we will bother asking for a backport, but having it in here made
me stare at that line for an unhealthy game of spot the difference.

>  Date:		April, 2023
>  KernelVersion:	v6.4
>  Contact:	linux-cxl@vger.kernel.org



> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d965f07ba8a8..cc26623250bf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2,6 +2,7 @@



> +static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
> +{
> +	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
> +	struct cxl_region *cxlr = data;
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	if (validate_region_offset(cxlr, offset))
> +		return -EINVAL;
> +
> +	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> +	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> +		dev_dbg(&cxlr->dev,
> +			"Failed to resolve DPA for region offset %#llx\n",
> +			offset);
> +
> +		return -EINVAL;

If rc was set, preferable to return that. I'd split the condition
into two parts to avoid this.

> +	}
> +

