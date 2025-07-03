Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80A2EA49D
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552740; cv=none; b=Igs8D3oh2AcvABHOyCtCAQqfetczOIunQLMfmocpJRZ6UfDPpznnmddRuX5h3mUnCDTK9fclEpw73ueyUKQkX9FSxOXVXg5f0jRxSYeCUK8V37Jb96fJfA1A3N/KOv6mk97N/EQa3F/vMKZQNu7Jca9dP+2VMhsAAnbv9SqE34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552740; c=relaxed/simple;
	bh=h6i5+FR38oPa936PNqbd5WPdYVR6nJTWdl/KK7fEWOs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpwkJ6PiNvvjKiFomXXiyyU31pO64SaapW2mxLAdYSAPYoYzSXzVebLtcY950tvft8rxdpRkS1GiCh5x723yR6qCgDu6kCzMOv2NnaQB3bBcnlEbWIcpt84B+9o8jSiHiVPzH6MDw8eIWb1hPi4ofmkh0GRJJRinhA/xx3orkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXzYL4PVWz6M4lV;
	Thu,  3 Jul 2025 22:24:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CAD401402F7;
	Thu,  3 Jul 2025 22:25:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 16:25:35 +0200
Date: Thu, 3 Jul 2025 15:25:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl/core: Add locked variants of the poison
 inject and clear funcs
Message-ID: <20250703152534.00001b5c@huawei.com>
In-Reply-To: <2b713ef8bc5e090ec5da61157749bb6ac315ed3c.1751513505.git.alison.schofield@intel.com>
References: <cover.1751513505.git.alison.schofield@intel.com>
	<2b713ef8bc5e090ec5da61157749bb6ac315ed3c.1751513505.git.alison.schofield@intel.com>
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

On Wed,  2 Jul 2025 21:03:22 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The core functions that validate and send inject and clear commands
> to the memdev devices require holding both the dpa_rwsem and the
> region_rwsem.
> 
> In preparation for another caller of these functions that must hold
> the locks upon entry, split the work into a locked and unlocked pair.
> 
> Consideration was given to moving the locking to both callers,
> however, the existing caller is not in the core (mem.c) and cannot
> access the locks.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
A few minor things inline.

> ---
> 
> Changes in v2:
> Return the rc from locked variants in cxl_clear/inject_poison
> Remove the not customary __ prefix from locked variants
> 
> 
>  drivers/cxl/core/memdev.c | 60 +++++++++++++++++++++++++++------------
>  drivers/cxl/cxlmem.h      |  2 ++
>  2 files changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f5fbd34310fd..7af626f69ac4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -276,7 +276,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  	return 0;
>  }
>  
> -int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_inject_poison inject;
> @@ -288,13 +288,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> -		return rc;
> -
> -	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> -		return rc;
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	lockdep_assert_held(&cxl_rwsem.region);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -322,11 +317,28 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>  
> -	return 0;
> +	return rc;
> +}
> +
> +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
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
> +	rc = cxl_inject_poison_locked(cxlmd, dpa);
> +
> +	return rc;

	return cxl_inject_poison_locked(cxlmd, dpa);

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
>  
> -int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_clear_poison clear;
> @@ -338,13 +350,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> -		return rc;
> -
> -	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> -		return rc;
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	lockdep_assert_held(&cxl_rwsem.region);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -381,7 +388,24 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>  
> -	return 0;
> +	return rc;

Why this change?  Nothing locally visible seems to make rc != 0 in
a fashion that wasn't true before.


> +}
> +
> +int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
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
> +	rc = cxl_clear_poison_locked(cxlmd, dpa);
> +
> +	return rc;

	return cxl_clear_poison_locked();

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f5b20641e57c..869c73de12c8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -861,6 +861,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> +int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
> +int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
>  
>  #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);

