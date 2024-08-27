Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA872E62C
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775372; cv=none; b=Rr7qur4ZZG31/tI15o5Q1RgYxUrF9+34/cAtR0zCxmA41U7MSQ6hgVKB+N6VLpsKBCn2sF9yK21lEzVBx8yzeIcyiuRm5HHw/iyUcxVITucjJpYMrz0FHJNPonfgxVpcG3iyrFmwbOeekml+wJzTuJ37YSDKa7QwumekHpu/XVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775372; c=relaxed/simple;
	bh=ZBrvBY5xuuFiKhv/xVGQI+vyGu4uPJDrwqsuFwTx8+Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOHRHDO9p9HpDC8qBRhVe5Sb9KuODDpiEEugLHB2w7XFHw6J4cQ4d8pufpPq9+fp6RRKMKHYUihnSfkKbnwPyPQagPLME+7XQP0sXT2xCFuS9SwkmQTBy9CeBVbmqBgtSGdNNjwb2RIcemwIzik/iteJv6V1e+baGC88n4dgidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXcS6bW0z6J6k8;
	Wed, 28 Aug 2024 00:12:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E93A140D27;
	Wed, 28 Aug 2024 00:16:07 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:16:07 +0100
Date: Tue, 27 Aug 2024 17:16:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yanfei Xu <yanfei.xu@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [v3 2/4] cxl/pci: Remove duplicated implementation of waiting
 for memory_info_valid
Message-ID: <20240827171606.0000603a@Huawei.com>
In-Reply-To: <20240813110532.870869-3-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
	<20240813110532.870869-3-yanfei.xu@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Aug 2024 19:05:30 +0800
Yanfei Xu <yanfei.xu@intel.com> wrote:

> commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
> related info") added another implementation of waiting for
> memory_info_valid without realizing it duplicated wait_for_valid()
Mention here the name of the other duplicate function

Also good to call out why you picked this duplicate to remove
over the other one.

Otherwise looks good to me. 
So with that info added.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  drivers/cxl/core/pci.c        | 41 +++++------------------------------
>  drivers/cxl/cxl.h             |  2 +-
>  drivers/cxl/port.c            |  2 +-
>  tools/testing/cxl/test/mock.c |  4 ++--
>  4 files changed, 9 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 2d69340134da..38c567727dbb 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
>  
> -static int wait_for_valid(struct pci_dev *pdev, int d)
> -{
> -	u32 val;
> -	int rc;
> -
> -	/*
> -	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
> -	 * and Size Low registers are valid. Must be set within 1 second of
> -	 * deassertion of reset to CXL device. Likely it is already set by the
> -	 * time this runs, but otherwise give a 1.5 second timeout in case of
> -	 * clock skew.
> -	 */
> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> -	if (rc)
> -		return rc;
> -
> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
> -		return 0;
> -
> -	msleep(1500);
> -
> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> -	if (rc)
> -		return rc;
> -
> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
> -		return 0;
> -
> -	return -ETIMEDOUT;
> -}
> -

