Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5426E175;
	Mon, 23 Jun 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690177; cv=none; b=Qyxcchwkx77yoxcNjRG37nvdd72d+huQjC8Bbgtr15HPqD5+2YKbxjZ3Ce6hS/FzKybjvWToxNtkVEPlCMQSdkSopUjIG0AeHFTKn0Dwkxr87uLnB6gbdSL8ggBfvQ/PTW4giRwek6QGsap6N5WQNqc7WJu0GKOranUSJZXY26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690177; c=relaxed/simple;
	bh=h9B+FKCtkHoA+eBpzEgqZWOAO0qwpOGRD1LQ2ZTE+F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozwU3g5sD0bz+lpCoIBsB5BB8vwPlcV5IDMT/bSn9Il8FF1H1RsmZA4pz/k6EwPQ/AFpQi+n3REM5bD1g12ogMJl7NujZd66ONL+5MD+0E+6IEOwdMRjJRTy30FrGyBUB0toG9gt72QrGmGMqXKOd2odH3TL67QwA0qNYqoBesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeqK4AfJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeqK4AfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750690175; x=1782226175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h9B+FKCtkHoA+eBpzEgqZWOAO0qwpOGRD1LQ2ZTE+F8=;
  b=AeqK4AfJaVdx4KGaFlsv10nQj+a7PocuW/NMASO3Dt9hwWLecG4+24cY
   eD92rZrf7cZWGewdrsmb2pTqPv34ph6G42/n3/fIa0l+8UqKyApaWxzJ2
   TjcEe5b1LgCcJnsL+fGfjOe0/Hx1VYpDzcQF6zG7ejTYno/jl+mZTOFNI
   5rAHMVWX2zjaQr22OxOIt9rrsBnBGS7vDnbBBUKIgIWmbhKag23dexohv
   W5nlx7EsAHLhw/VmKQUeZrgaAa3IArIT7rurU8xiodLX+HpCnTciZAo3w
   MqYPt9ExlItcqetNhpT2vVYNATpAXgBELIW9qX8bkKstD39pQqDYW8TAg
   w==;
X-CSE-ConnectionGUID: lGZHVYfSRT6es1ypTOZyEQ==
X-CSE-MsgGUID: kS1jD8GORiypxW0HEVDGUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52771057"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52771057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:49:34 -0700
X-CSE-ConnectionGUID: AmSJ52JPTWK/gtafG/Pi7g==
X-CSE-MsgGUID: uqBbw3HAREq7Zc9AW30Fzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="152139645"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.178]) ([10.125.108.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:49:32 -0700
Message-ID: <054ac59c-d088-4267-b0bf-e291ab8f7214@intel.com>
Date: Mon, 23 Jun 2025 07:49:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] cxl/mbox: Convert poison list mutex to ACQUIRE()
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-3-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250619050416.782871-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/25 10:04 PM, Dan Williams wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

