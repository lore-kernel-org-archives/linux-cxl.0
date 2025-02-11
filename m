Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39B24C690;
	Tue, 11 Feb 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295016; cv=none; b=PnphlQYKnKkjxFG7t+ygvIcZv3T4jQAZFuHME8xl+hbhEPPYRwR2twXJ0W0ET9W3g9GE/ExWvFqfRf39QC5qx4GWMFtIUUy8O71qxpSyadDYRWmcCP8wzEOw+YWZZsA9aOOsPlKiIA5jZmmcbmwAFBnS6OyHnArCNpO9gGZXQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295016; c=relaxed/simple;
	bh=Y1PxTkrmKYmDBY2ZL2ybRY6xmPsJ6JhrI54vpe+BC8A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QihJoWX3+1HCHkG2dCqX+/aUVyiu4AKMaNyHQ4LVL08rVDWObo7TIGSAXNWG8Ft2khXsHxCu4BlqIkqQhuwqAFkmXPQQI9qjCuYRIb2aKy2QGJdK3t9U0BthF+vXy8pMDHO4x+wDl7y+xmrxJmX+JXtpBthLWB3W3K6ZoeUVQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspKW3cVPz6L59Q;
	Wed, 12 Feb 2025 01:27:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E9941402A4;
	Wed, 12 Feb 2025 01:30:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:30:08 +0100
Date: Tue, 11 Feb 2025 17:30:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/7] cxl/core: Use guard() to drop the goto pattern
 of cxl_dpa_free()
Message-ID: <20250211173007.00001f26@huawei.com>
In-Reply-To: <20250211075727.351895-5-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-5-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:57:24 +0800
Li Ming <ming.li@zohomail.com> wrote:

> cxl_dpa_free() has a goto pattern to call up_write() for cxl_dpa_rwsem,
> it can be removed by using a guard() to replace the down_write() and
> up_write().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 2bb2782a72ad..4d753520a79a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -384,35 +384,27 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct device *dev = &cxled->cxld.dev;
> -	int rc;
>  
> -	down_write(&cxl_dpa_rwsem);
> -	if (!cxled->dpa_res) {
> -		rc = 0;
> -		goto out;
> -	}
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	if (!cxled->dpa_res)
> +		return 0;
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>  		dev_dbg(dev, "decoder enabled\n");
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  	if (cxled->cxld.id != port->hdm_end) {
>  		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
>  			port->hdm_end);
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
> +
>  	devm_cxl_dpa_release(cxled);
> -	rc = 0;
> -out:
> -	up_write(&cxl_dpa_rwsem);
> -	return rc;
> +	return 0;
>  }
>  
>  int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,

