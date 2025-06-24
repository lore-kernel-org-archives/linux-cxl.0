Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F12C08B0
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772310; cv=none; b=fo6sH4KnpKMi9WsF5Ebr+p/ZIizZcwH4Y3RyaMD1FAVeZFmC+1lvrmZ6WwcsyLf8sgEReYq4K0LiNBCzMvxtxqRCWIHgsywYssSf2GGasBkjTVnse5T2Jm2GiZIf6sw9Pp5GT8nRkMZBvxlEBU43I/0bveGy2NJ9P1g3Q4xU2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772310; c=relaxed/simple;
	bh=BA8cMC4jycaIE+E2cPfUVt4QMolwpjOJ/RBwCddFSCk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAWmi44El+2bbBgp7E6NG7wvCiqAVC83o77Sby3Z3Qpieu53//Bu0YIqbJYxh1NeQhfuLkK+eh5ckDJY/uFLp3q+jHgfMW24jSgIie4ELYFoQ2rzCzTks9iNChjgb2+zyc7rgmp/IOt7LtRc46Z92QnTzB30fkRbPibVTnCpf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRQxJ3W51z6GFW6;
	Tue, 24 Jun 2025 21:37:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B4B761402F5;
	Tue, 24 Jun 2025 21:38:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Jun
 2025 15:38:24 +0200
Date: Tue, 24 Jun 2025 14:38:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/core: Add locked variants of the poison inject
 and clear funcs
Message-ID: <20250624143822.00003256@huawei.com>
In-Reply-To: <71f51bcc7d335c9f558441bb68f05f546230696a.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
	<71f51bcc7d335c9f558441bb68f05f546230696a.1750725512.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 17:53:34 -0700
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

This will clash with Dan's ACQUIRE() set.  Up to Dave on how
to handle that but my gut feeling is that if we want to queue much
else this cycle and that we should ask for patches on top of the
ACQUIRE() series.  The risk being that gets some later push back.

Ah well I'll apply the someone else's problem field.

Given reuse of these in patch 3 this looks sensible to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  drivers/cxl/core/memdev.c | 77 +++++++++++++++++++++++++--------------
>  drivers/cxl/cxlmem.h      |  2 +
>  2 files changed, 52 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..b38141761f47 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -280,7 +280,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  	return 0;
>  }
>  
> -int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +int __inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_inject_poison inject;
> @@ -292,19 +292,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc) {
> -		up_read(&cxl_region_rwsem);
> -		return rc;
> -	}
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_region_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	inject.address = cpu_to_le64(dpa);
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -314,7 +307,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	};
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -327,7 +320,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> -out:
> +
> +	return rc;
> +}
> +
> +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	int rc;
> +
> +	rc = down_read_interruptible(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
> +	rc = __inject_poison_locked(cxlmd, dpa);
> +
>  	up_read(&cxl_dpa_rwsem);
>  	up_read(&cxl_region_rwsem);
>  
> @@ -335,7 +347,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
>  
> -int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +int __clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_clear_poison clear;
> @@ -347,20 +359,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc) {
> -		up_read(&cxl_region_rwsem);
> -		return rc;
> -	}
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_region_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> -
> +		return rc;
>  	/*
>  	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
>  	 * is defined to accept 64 bytes of write-data, along with the
> @@ -378,7 +382,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -391,7 +395,26 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
> -out:
> +
> +	return rc;
> +}
> +
> +int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	int rc;
> +
> +	rc = down_read_interruptible(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
> +	rc = __clear_poison_locked(cxlmd, dpa);
> +
>  	up_read(&cxl_dpa_rwsem);
>  	up_read(&cxl_region_rwsem);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 551b0ba2caa1..c0643e8b9d8f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -861,6 +861,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> +int __inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
> +int __clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
>  
>  #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);

