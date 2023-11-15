Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF1ZEXKK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5069E6
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 15:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700091224; x=1731627224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXAbnEqKMJdFtlhecrJOv8LkO4iR8mM6egu1sZB0w5M=;
  b=lF1ZEXKKIUxTovhUDt4SwTNtbO7nHF0UWIB+/RZ9TNss68V01YX2jh77
   qr3qgLRR4bPzRxOAOHz8nY2Jj0x8DIa83bbVKAXj8i8z2D0pGdLZ5IiH+
   NLiXeTC3cBosNKWb/W9PD3UuDW0SE078JgMMROohSwhejr4PDeRF6hv9L
   9UAh2Ljd1YZ914/25lmk6yNbexa/+7gaPQuct/i5xQ/b/QSF2Wphdp82P
   hLHEcwMNcz6qD3vRKsXH6U0DhvI2IINt6y+BOp9zTTLfWv3zYihSwiRx1
   7tfoqCnPpUnQmAWsf70eOSiK01Mr0taScJ1IL6emDA2J0uXlWpp5VWXR6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9617800"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="9617800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938639699"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="938639699"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.210.71])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:32:48 -0800
Date: Wed, 15 Nov 2023 15:32:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH] cxl: Convert pioson ops rwsem usages to scope based
 resource management
Message-ID: <ZVVVH8ITotdk1nyN@aschofie-mobl2>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
 <169998626910.1958731.10157698499207717733.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169998626910.1958731.10157698499207717733.stgit@djiang5-mobl3>

On Tue, Nov 14, 2023 at 11:25:20AM -0700, Dave Jiang wrote:
> Cleanup the rwsem usages in the poison ops to reduce complexity and reduce
> code lines.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Hi Alison, follow on patch to yours. Can't be backported, but nice clean
> up going forward.

Tell me more about your backport worry.  Are we expected to avoid using
the new guard any place where there is a backport possibility?  

I'm thinking I should just rev the patch with your updates.

> 
>  drivers/cxl/core/memdev.c |   32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 961da365b097..9ab748fadb38 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -227,8 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> -	down_read(&cxl_region_rwsem);
> -	down_read(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>  
>  	if (cxl_num_decoders_committed(port) == 0) {
>  		/* No regions mapped to this memdev */
> @@ -237,8 +237,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  		/* Regions mapped, collect poison by endpoint */
>  		rc =  cxl_get_poison_by_endpoint(port);
>  	}
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> @@ -324,12 +322,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	down_read(&cxl_region_rwsem);
> -	down_read(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	inject.address = cpu_to_le64(dpa);
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -339,7 +337,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	};
>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -352,11 +350,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> -out:
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
>  
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>  
> @@ -372,12 +367,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	down_read(&cxl_region_rwsem);
> -	down_read(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	/*
>  	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> @@ -396,7 +391,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -409,11 +404,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
> -out:
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
>  
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
>  
> 
> 
