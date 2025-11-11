Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7F369977
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870431; cv=none; b=M6AdpzZWBemMrh/qjewKxlk5B5x/lRHlR7JUzxNWnXa8dM/nP5mT9RfHFDQOw5o8nXtz+BFKDLc9Y55syV4xPaQ3+bMtZoGWkXnfSo9b4UyGalzoWTFan9UTcBMiVts80PP/4ad12WEYqFIJA3mytPfYoEVo/fpQVmJd7o0mD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870431; c=relaxed/simple;
	bh=GHQdnX6wvdohrrmBumiWvtixdmsQxge0BpOexhxEzL8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDa3DMpKZF91gmZTok5az6QjNaXzMGnZDRVK3hQc8T9jOYsgXeUAu8Rs08WdBiAu+7/Hbw29t89Qrm9upVYztqbESFXK2dxnh4FTjYofOn+1mQJmSi+K3+G/Udb1x0MtkIQX8qiM6jY9WMtaLJjl6Aucyo8Bl5zP4gJpLQRB4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5T5m2w5yzJ46bK;
	Tue, 11 Nov 2025 22:13:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E89F140122;
	Tue, 11 Nov 2025 22:13:47 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:13:46 +0000
Date: Tue, 11 Nov 2025 14:13:45 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/4] cxl/test: Add support for acpi extended linear
 cache
Message-ID: <20251111141345.000038f8@huawei.com>
In-Reply-To: <20251031173224.3537030-4-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
	<20251031173224.3537030-4-dave.jiang@intel.com>
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

On Fri, 31 Oct 2025 10:32:23 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the mock wrappers for hmat_get_extended_linear_cache_size() in order
> to emulate the ACPI helper function for the regions that are mock'd by
> cxl_test.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
