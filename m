Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6002C3245
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988251; cv=none; b=LXUpXqq/BodTM2soK+dcyouWZgmk+Plhqr0sogUxOlOG9uZt+w6WSgvV23phkWr4JdW3BjN9F5dg5MRkCvXR2Nq7c8IDofnh1H2N6qccyyfIFDZImAQlKGcsTEzcEAyQWmITmkLOBgEY+vnrhjbJHp/ORH8s1Hp8a/42s98EuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988251; c=relaxed/simple;
	bh=Nq65wiDxglVgCEV2zMqB5gwpN3Ko/mylqNHAJPCoe84=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6wcMZ0ifDydiVhcouGOwNx8j/SjDx9VlvSdWQFB2Ipgm7bSw8IiJeHTLCwBjW3m//V1ghglGsy3Qz0GbxfT7aoXYxqaS+E9TytCowbY54gyTf6/k15xDKo+Vv77EkrVUca3/jCssIpuGinReSpFVen51nbVouu0CFT/qJgBVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWf7k5z4RzJ46ZP;
	Thu, 18 Dec 2025 00:16:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B63A40571;
	Thu, 18 Dec 2025 00:17:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:17:19 +0000
Date: Wed, 17 Dec 2025 16:17:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 05/17] cxl/cache: Add cxl_cache driver
Message-ID: <20251217161718.00004005@huawei.com>
In-Reply-To: <20251111214032.8188-6-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-6-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:20 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add the cxl_cache driver which will manage struct cxl_cachdev devices.

cxl_cachedev

> This driver will provide common management functions for some of a cache
> capable endpoint. This driver will also be responsible for validating
> the system's CXL.cache configuration.
> 
> The driver expects the device's cache capabilities to be prefetched by
> the endpoint-specific driver. The required capabilities can be gotten by
> calling cxl_accel_get_cache_info().
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Trivial thing inline.

> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> new file mode 100644
> index 000000000000..6f410fae9437
> --- /dev/null
> +++ b/drivers/cxl/cache.c

> +
> +/**
> + * devm_cxl_add_cachedev - Add a CXL cache device
> + * @host: devres alloc/release context and parent for the cachedev
> + * @cxlds: CXL device state to associate with the cachedev
> + * @ops: optional operations to run in cxl_cache::{probe,remove}() context

Run kernel doc over these as it will point out there is no such
parameter yet.

> + *
> + * Upon return the device will have had a chance to attach to the
> + * cxl_cache driver. This may fail if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached)
> + * or the CXL.cache system configuration is invalid.
> + *
> + * The cache state of @cxlds needs to be populated before calling this function,
> + * use cxl_accel_read_cache_info() to do so.
> + */
> +struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
> +					   struct cxl_dev_state *cxlds)


