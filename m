Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F247221554
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617443; cv=none; b=Mn5h3q4DlQO15bT/vpySxJSzPYctgkDjz99DURe7MSpLejxyyDjltmFTxsct7VoW3q78HGJObHTvxAVRAaIaBNYcjzRR0Rn7ARHiJmcN3WmWZNNaOCCz6pjTVAFk9+hW4fPsv91jyuB2WVheF3d4TK6rJBrxQW+dPIo9z5lNdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617443; c=relaxed/simple;
	bh=vSWucWixzmp1DLYcz8NJxHXUOFySXfP77hYdmzR/cR4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKaygrvBLtoSUAAm0KEWxFgtqYQVLGj5Fg+BPVTr17ftYrBafBJHRB1cGjtbVGap4gulN4KDfr50GLNdwN9gnkHfKJKsQ+8wfPG9ka+WeRzBC50eZ6bo/10ZjF8i6xwlZBUJvyYRusZK3xNsk///akXJingrt7U/fkGusZEFkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5tkJ2zsjz6GCBs;
	Tue, 19 Aug 2025 23:27:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CEBB0140427;
	Tue, 19 Aug 2025 23:30:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 17:30:36 +0200
Date: Tue, 19 Aug 2025 16:30:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 16/18] cxl/cache: Add cache device counting for CXL
 ports
Message-ID: <20250819163034.00006479@huawei.com>
In-Reply-To: <20250812212921.9548-17-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-17-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:19 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Having more than one CXL.cache enabled device under a port requires CXL
> cache id capabilities (CXL 3.2 8.2.4.28/29).
> 
> Add tracking of how many cache devices are under a port. If the required
> capabilities are absent and more than one device is enabled under the
> port, fail allocation of a cache id.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

...

>  
> +static void cxl_deactivate_cache(void *data)
> +{
> +	struct cxl_cachedev *cxlcd = data;
> +	struct cxl_port *port = cxlcd->endpoint;
> +
> +	for (port = cxlcd->endpoint; port && !is_cxl_root(port);
> +	     port = parent_port_of(port)) {
> +		scoped_guard(device, &port->dev) {

I think you need to check this succeeded if the aim is to ensure
that port didn't go away before this decrement.
It might have gone away just before we tried to take the guard.

> +			port->cache_devs--;
> +		}
> +	}
> +}
> +
>  static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>  {
>  	struct cxl_port *endpoint = cxlcd->endpoint, *port;
> @@ -167,9 +176,17 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>  		rc = cxl_dport_program_cache_idd(dport, cxlcd);
>  		if (rc)
>  			return rc;
> +
> +		port->cache_devs++;
>  	}
>  
> -	return 0;
> +	if (!is_cxl_root(port)) {
> +		cxl_deactivate_cache(cxlcd);
> +		return -ENODEV;
> +	}
> +
> +	return devm_add_action_or_reset(&cxlcd->dev, cxl_deactivate_cache,
> +					cxlcd);
>  }
>  
>  static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
> @@ -239,7 +256,6 @@ static int cxl_cache_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -

No comment. :)

>  	return devm_cxl_cachedev_allocate_cache_id(cxlcd);
>  }
>  
