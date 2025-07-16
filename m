Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F16194A60
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663495; cv=none; b=W0gYIn9GdqY7mfp78D5fht+TFMuBasEQ6Fi1uf3ibE9bBbQONBBX2Vv+1uEPkUhD0SF/PnO/zPru9Bp4VxfrorjA8oHOLM25eMo5igVd29ogqVBgd710grdhJvolCnCPTscL7IRDDfAiDMWgz2x68rURFc9U3bF5H6mZfxssfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663495; c=relaxed/simple;
	bh=CpuVUbyFkCmNLdvXjTectka8h+VlJJqNxcHLMISJsDw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2Ns0h+4OHmEvynHlWjnotbBS1If5iP4n2BYPQXOsEd379bxjyJP7zsG5Ge93I1xtS7Q4umcN9oaGnWNzGzXoTfrxx215gbyJ0X5jOrAW1mcG7HVGNDkVzAJ6lLu9JO9k/sOrAuX4LGZfXbUrUtK8lBzBGosGW34juhZbMchb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhtKl6RhPz6L531;
	Wed, 16 Jul 2025 18:56:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 85D90140371;
	Wed, 16 Jul 2025 18:58:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 12:58:10 +0200
Date: Wed, 16 Jul 2025 11:58:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cxl/core: Add locked variants of the poison
 inject and clear funcs
Message-ID: <20250716115809.000057db@huawei.com>
In-Reply-To: <fce084f133cd1d53fe442ae67dc0cf3b00b2c2af.1752365427.git.alison.schofield@intel.com>
References: <cover.1752365427.git.alison.schofield@intel.com>
	<fce084f133cd1d53fe442ae67dc0cf3b00b2c2af.1752365427.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 12 Jul 2025 19:37:56 -0700
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

Trivial comment to cleanup inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> @@ -324,9 +319,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  	return 0;
>  }
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

> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");

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
> +}

	return cxl_clear_poison_locked(cxlmd, dpa);

I wondered if this was to save churn in a later patch, but
not seeing anything related in patch 4.

>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");


