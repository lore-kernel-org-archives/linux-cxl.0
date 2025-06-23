Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E494239E84;
	Mon, 23 Jun 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673314; cv=none; b=XmBEIxgOmwSxAqnwJ7+5ifCJR5GG/kyYhqfpRnlCA0aI8aGKd6Bm3Z6NYuq+JhPWdfPs+8g7ezBm4cJy+xpUYGvpnOb5Zxbs0a0GvsaHEAL9iyVyZQGLcNhzG9GolVn2bbi+x90LKiUoVQIX8ANuuMN3B8+edZEcUZEUsUDKCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673314; c=relaxed/simple;
	bh=rxytXpv5wo27moJlcA5NuL2zOOMcZuDo39JoSMJKbhc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD3PnhWvcZmUZ5ZYs/7+JuTL5YyUVgVGyZwQTTnI+3Y9wyxiVJP9g4EkWijD4Qi2bBlc9mQTWotRVLHwaPKig5BTaNgyCEt4/pb8HjvxYCdErjWIsFzHnGXAAEM9EpSXCdRthpflLYGiaaHseNAM9A11763LKs+PR6enoIDUNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQkHC3zccz6HJrx;
	Mon, 23 Jun 2025 18:05:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CAAA1402EA;
	Mon, 23 Jun 2025 18:08:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:08:09 +0200
Date: Mon, 23 Jun 2025 11:08:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/8] cxl/mbox: Convert poison list mutex to ACQUIRE()
Message-ID: <20250623110808.00003fcb@huawei.com>
In-Reply-To: <20250619050416.782871-3-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Jun 2025 22:04:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Towards removing all explicit unlock calls in the CXL subsystem, convert
> the conditional poison list mutex to use a conditional lock guard.
> 
> Rename the lock to have the compiler validate that all existing call sites
> are converted.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One trivial inline. Either way

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 7 +++----
>  drivers/cxl/cxlmem.h    | 4 ++--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2689e6453c5a..81b21effe8cf 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1401,8 +1401,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int nr_records = 0;
>  	int rc;
>  
> -	rc = mutex_lock_interruptible(&mds->poison.lock);
> -	if (rc)
> +	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);

I'd slightly prefer the 'canonical' style from the cleanup.h docs in previous patch.

	rc = ACQUIRE_ERR(mutex_intr, &lock);
	if (rc)
		return rc;

> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
>  		return rc;
>  
>  	po = mds->poison.list_out;
> @@ -1437,7 +1437,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		}
>  	} while (po->flags & CXL_POISON_FLAG_MORE);
>  
> -	mutex_unlock(&mds->poison.lock);
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
> @@ -1473,7 +1472,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
>  
> -	mutex_init(&mds->poison.lock);
> +	mutex_init(&mds->poison.mutex);
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, "CXL");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 551b0ba2caa1..f5b20641e57c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -254,7 +254,7 @@ enum security_cmd_enabled_bits {
>   * @max_errors: Maximum media error records held in device cache
>   * @enabled_cmds: All poison commands enabled in the CEL
>   * @list_out: The poison list payload returned by device
> - * @lock: Protect reads of the poison list
> + * @mutex: Protect reads of the poison list
>   *
>   * Reads of the poison list are synchronized to ensure that a reader
>   * does not get an incomplete list because their request overlapped
> @@ -265,7 +265,7 @@ struct cxl_poison_state {
>  	u32 max_errors;
>  	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
>  	struct cxl_mbox_poison_out *list_out;
> -	struct mutex lock;  /* Protect reads of poison list */
> +	struct mutex mutex;  /* Protect reads of poison list */
>  };
>  
>  /*

