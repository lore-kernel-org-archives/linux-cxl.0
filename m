Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421134678B;
	Wed, 17 Dec 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986057; cv=none; b=F2u74aflWEe/pNd3z8H4FIIXj/E1BguyRswfR9SoMd7wfzJol1IekzLmCTKRIQFL2vlMvqbsesRenAzjOtazwlMc6KQ+H7dI7IvnrBCWlTyDqKsTNNbBiuITpinsCQMkBLfcrZXUOXrsWk9Uc5yh7islNZqLtjqAj0vJZbCp714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986057; c=relaxed/simple;
	bh=mieFvdmb0UCHzioczhpeBTgA40ha7jMZMTlU92fLngY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTZXZo1b77mBTlOw3j8c4GqjEvpALRm2eJ6tbWTHp8cZLN+IaFJ3/T9tofkD+xgM2wCWGc1k2bosqibntPygPGYMFVaAQWK+0HKCdHOCtzpvjO8TNrl2JlYeaSjdzbMb0ysWIeTzW98M8vRBiunLw2YWY05tCvpZv0ubTDERf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWdKl0nt1zHnGcs;
	Wed, 17 Dec 2025 23:40:27 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 88EC040565;
	Wed, 17 Dec 2025 23:40:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 15:40:51 +0000
Date: Wed, 17 Dec 2025 15:40:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Neeraj Kumar <s.neeraj@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
	<a.manzanares@samsung.com>, <vishak.g@samsung.com>, <neeraj.kernel@gmail.com>
Subject: Re: [PATCH V4 15/17] cxl/pmem_region: Add sysfs attribute cxl
 region label updation/deletion
Message-ID: <20251217154050.00003293@huawei.com>
In-Reply-To: <20251119075255.2637388-16-s.neeraj@samsung.com>
References: <20251119075255.2637388-1-s.neeraj@samsung.com>
	<CGME20251119075337epcas5p2cb576137ca33d6304add4e1ba0b2bdc1@epcas5p2.samsung.com>
	<20251119075255.2637388-16-s.neeraj@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 19 Nov 2025 13:22:53 +0530
Neeraj Kumar <s.neeraj@samsung.com> wrote:

> Using these attributes region label is added/deleted into LSA. These
> attributes are called from userspace (ndctl) after region creation.
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
One quick addition to what Dave called out.

Thanks,

Jonathan

> diff --git a/drivers/cxl/core/pmem_region.c b/drivers/cxl/core/pmem_region.c
> index b45e60f04ff4..be4feb73aafc 100644
> --- a/drivers/cxl/core/pmem_region.c
> +++ b/drivers/cxl/core/pmem_region.c
> @@ -30,9 +30,100 @@ static void cxl_pmem_region_release(struct device *dev)
>  	kfree(cxlr_pmem);
>  }
>  
> +static ssize_t region_label_update_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> +	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> +	ssize_t rc;
> +	bool update;
> +
> +	rc = kstrtobool(buf, &update);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
> +	if (rc)
I'd stick to one style for these.  Elsewhere you have
	if ((rc = ACQUIRE_ERR())

> +		return rc;
> +
> +	/* Region not yet committed */
> +	if (update && cxlr && cxlr->params.state != CXL_CONFIG_COMMIT) {
> +		dev_dbg(dev, "region not committed, can't update into LSA\n");
> +		return -ENXIO;
> +	}
> +
> +	if (!cxlr || !cxlr->cxlr_pmem || !cxlr->cxlr_pmem->nd_region)
> +		return 0;
> +
> +	rc = nd_region_label_update(cxlr->cxlr_pmem->nd_region);
> +	if (rc)
> +		return rc;
> +
> +	cxlr->params.state_region_label = CXL_REGION_LABEL_ACTIVE;
> +
> +	return len;
> +}
