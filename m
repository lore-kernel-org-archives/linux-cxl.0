Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E442BB13;
	Mon, 23 Jun 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674736; cv=none; b=ZgsZQrmzl586gVpTixd0FOAc2BO/mmewXhlGsF1eqIuMGvdkJiH8D9AG4Vu2G02pYxfaw/jzPMZ7/V2XdKiZrLCB0x00HCdoiz+S8ER6660PxL2imzDOcjvgsCStfF4gKdlK4q+7mIXKk8yxeoLQ/zf5O3/4fmUvURanmlSbAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674736; c=relaxed/simple;
	bh=ipYKNqVADXMiUbJR3lhZ1tljf2CArscPDzmzuInedO4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYaKQEJQalYgCh4zixRsoVRvRElzgTX8DjQ4NYCCpP7PoVZnSvJKultAIbntegXwmbydYfYbF7nBhARzXn0sj2YPX8k9okF94+fVBKccoH+5uw61tglpScbMRa46deSE+POP8ZLxv7iwaptlHLZkyTnxVmaSCPADXmRG4WwELwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQkm26lgTz6L5j3;
	Mon, 23 Jun 2025 18:27:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C3B921402F6;
	Mon, 23 Jun 2025 18:32:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:32:10 +0200
Date: Mon, 23 Jun 2025 11:32:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Message-ID: <20250623113208.0000768c@huawei.com>
In-Reply-To: <20250619050416.782871-9-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-9-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Jun 2025 22:04:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
> The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
> scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
> scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
> representing the state of the conditional lock.
> 
> The goal of this conversion is to complete the removal of all explicit
> unlock calls in the subsystem. I.e. the methods to acquire a lock are
> solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
> unlock is implicit / scope-based. In order to make sure all lock sites are
> converted, the existing rwsem's are consolidated and renamed in 'struct
> cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
> between old-world (explicit unlock allowed), and new world (explicit unlock
> deleted).
> 
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few comments inline.




> index 010964aa5489..a2ba19151d4f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c


>  static DEVICE_ATTR_RW(interleave_ways);
> @@ -561,15 +537,11 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	ssize_t rc;
> -
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -	rc = sysfs_emit(buf, "%d\n", p->interleave_granularity);
> -	up_read(&cxl_region_rwsem);
>  
> -	return rc;
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if (ACQUIRE_ERR(rwsem_read_intr, &rwsem))
> +		return ACQUIRE_ERR(rwsem_read_intr, &rwsem);

Local variable?

> +	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
>  }

> @@ -2212,19 +2167,19 @@ static int attach_target(struct cxl_region *cxlr,
>  			 struct cxl_endpoint_decoder *cxled, int pos,
>  			 unsigned int state)
>  {
> -	int rc = 0;
> -
> -	if (state == TASK_INTERRUPTIBLE)
> -		rc = down_write_killable(&cxl_region_rwsem);
> -	else
> -		down_write(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	int rc;
>  
> -	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_region_attach(cxlr, cxled, pos);
> -	up_read(&cxl_dpa_rwsem);
> -	up_write(&cxl_region_rwsem);
> +	if (state == TASK_INTERRUPTIBLE) {
> +		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)) == 0) {

I'd lift the warning print to a wrapper function so that you can
return early in error case and avoid this rather messy line.
e.g.

static int do_attach_target(struct cxl_region *cxlr,
			    struct cxl_endpoint_decoder *cxled, int pos,
			    unsigned int state)

	if (state == TASK_INTERRUPTIBLE) {
		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
		rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
		if (rc)
			return rc;

		guard(rwsem_read)(&cxl_rwsem.dpa);
		return cxl_region_attach(cxlr, cxled, pos);
	}
	
	guard(rwsem_write)(&cxl_rwsem.region);
	guard(rwsem_read)(&cxl_rwsem.dpa);
	return cxl_region_attach(cxlr, cxled, pos);		
}

static int attach_target(struct cxl_region *cxlr,
			 struct cxl_endpoint_decoder *cxled, int pos,
			 unsigned int state)
{
	int rc = do_attach_target(cxlr, cxled, pos, state);

	if (rc)
		dev_warn();
	
	return rc;
}

> +			guard(rwsem_read)(&cxl_rwsem.dpa);
> +			rc = cxl_region_attach(cxlr, cxled, pos);
> +		}
> +	} else {
> +		guard(rwsem_write)(&cxl_rwsem.region);
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
> +		rc = cxl_region_attach(cxlr, cxled, pos);
> +	}
>  
>  	if (rc)
>  		dev_warn(cxled->cxld.dev.parent,


> @@ -3569,30 +3520,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>  	struct cxl_region_params *p = &cxlr->params;
>  	int rc;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc) {
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);

Similar to earlier - I'd do this next bit in two lines for slightly
better readability.  Same for the other cases. I don't care that strongly
though.

> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem))) {
>  		dev_dbg(&cxlr->dev, "probe interrupted\n");
>  		return rc;
>  	}


