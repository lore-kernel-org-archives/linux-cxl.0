Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06E4A23
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605490; cv=none; b=LSNQ05O7AsNnBJXm9LaqwjO5nq6k7ckjwl7yfrb/lij0IKmalgPUHPWuwN91uT7OnodNkzwInFqmAxk5KUA/VnWjv34ehKSCnFg4M7Qc+65OuZKnxUWFAcDJaHUOCRE3yo0xKwagPtLWWeDbvc/S+83WJAJkAvNtlarbqdenRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605490; c=relaxed/simple;
	bh=RslSh2XgNkAf5WzmyzBjoSXygCSNSarApMb//8oMve8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzoHLyvUDVCUmsorr4Hclg6TmPFbnk2frN78rf2LolLuqG0hapBR+iB9ERBxbQ6tA5HyXQHI9U0CmrJICe41qnMVaOOZ80vng2Kc+fzrTsr/vDw9OsGqd2dtWSWpnGzzDrfRzRm4eiqoAcIviKY2YFG/tG2iUF5Ly0z1eLlzjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5pMd0Ypdz6D8v4;
	Tue, 19 Aug 2025 20:11:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A8FF1400DC;
	Tue, 19 Aug 2025 20:11:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 14:11:18 +0200
Date: Tue, 19 Aug 2025 13:11:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 10/18] cxl/cache: Add cxl_cache driver
Message-ID: <20250819131117.00001e84@huawei.com>
In-Reply-To: <20250812212921.9548-11-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-11-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:13 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add the cxl_cache driver which will manage struct cxl_cachdev devices.
> This driver will provide common management functions for some of a cache
> capable endpoint. This driver will also be responsible for validating
> the system's CXL.cache configuration.
> 
> The driver expects the device's cache capabilities to be prefetched by
> the endpoint-specific driver. The required capabilities can be gotten by
> calling cxl_accel_get_cache_info().
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>


> +static struct cxl_driver cxl_cache_driver = {
> +	.name = "cxl_cache",
> +	.probe = cxl_cache_probe,
> +	.drv = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,

Why?  I'd add a comment.

> +	},
> +	.id = CXL_DEVICE_ACCELERATOR,
> +};
> +
> +module_cxl_driver(cxl_cache_driver);
> +
> +MODULE_DESCRIPTION("CXL: Cache Management");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("CXL");
> +MODULE_ALIAS_CXL(CXL_DEVICE_ACCELERATOR);

