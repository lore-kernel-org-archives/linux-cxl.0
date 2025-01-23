Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562891487ED
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654216; cv=none; b=BWiEy/ybCLplQmhaj76r8vwEEHgtNRYx588dBVTD+C+wqqFecIyhYDfA8XjheN4Hgig3GnIy0NRy3ZF/k1LW058s7TSIrSWDQ3Gs7L9YRPKjT8bHBY1QRNTJGq55RATlmXHECqebNd8j3Sib7zDifVv8Z6dzqTi43ljmDigQaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654216; c=relaxed/simple;
	bh=d6cbQrsLmtx431B+LMEws4x3StGQ9RAuPx7GOhAN/6Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REHtX0PLJW4HmMwAc+Zrhfei8pn3OXdIB+1Y5H/+srLzgcnU/iG8L8a74AvQb3BXvmlKPCdozLd8Lss6HTavlcBesv3W6m3uW3Acf+e6LCOODkvFID24KDtqm7uSyHgZiAyy2HLvn/RfPKLLEGIt8m0yPaahnC58/rdT0Tpkfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf7Xt1YMgz6L4ry;
	Fri, 24 Jan 2025 01:41:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A82931404C4;
	Fri, 24 Jan 2025 01:43:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:43:30 +0100
Date: Thu, 23 Jan 2025 17:43:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 04/19] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <20250123174328.0000727e@huawei.com>
In-Reply-To: <20250122235159.2716036-5-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-5-dave.jiang@intel.com>
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

On Wed, 22 Jan 2025 16:50:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
One stray change below that either wants dropping or pushing to
earlier patch.

Not sure why I haven't given a tag on this one before now
in either of the patch sets it features in.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v1:
> - Change input param from cxlds to cxl_mbox
> - Move mbox_out declaration inline. (Jonathan)
> - Fix __counted_by() input. (Jonathan)
> - Return count for cxl_get_supported_features_count(). (Dan)
> - Remove goto from cxl_get_supported_features(). (Dan)
> - Return cxl_get_supported_feature_entry() directly. (Dan)
> - Drop user path enumeration. (Dan)
> - Move to the feature driver model. (Dan)
> - Add support for 0 feature data requested.
> - Add missing increment of feature data ptr during cop

> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 644add26975f..a5949312a4ab 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c

>  static int cxl_features_probe(struct device *dev)
>  {
>  	struct cxl_features *features = to_cxl_features(dev);
> +	int rc;
> +
>  	struct cxl_features_state *cfs __free(kfree) =
>  		kzalloc(sizeof(*cfs), GFP_KERNEL);
> -
Stray change that belongs in earlier patch if anywhere.


>  	if (!cfs)
>  		return -ENOMEM;
>  
>  	cfs->features = features;
> +	rc = cxl_get_supported_features(cfs);
> +	if (rc)
> +		return rc;
> +
>  	dev_set_drvdata(dev, no_free_ptr(cfs));
>  
>  	return 0;


