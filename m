Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007B2686A8
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739661; cv=none; b=JUEcAvOSi+fjgKHcE1Regc9wwLtaQgLab4dEqzNcPRku/1cj+nl6hKWQscXqvAG+YgXZIaFOV0o0B5Uq43xF1hxGDE008XMqDlFM7zM2tmvXCyAtZFXAj52XanOCRVB2OlxltF6FwnJUNrVKCmc5I8lZOuIkjgcubhQewzNP014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739661; c=relaxed/simple;
	bh=zj+651xCWt3lUeuuRz+gjObL1mI9asrOrAKxa73EnFg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p34qABSZq2ifK28OE6IvCqRHOa/RQ/z46TVs2hnZ9bN8NyGC8PCKVuG2O5BexT4ZUNo3cAR5Ciz0aWckN6Y/sCJbjs5Xy915mno/285RH3xtqZw0spBKZ+g/8WgQ9iBlkYKqyZyM9jgCRHy9oVppu5i2QeWiDlFQgTgjpihipvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1sJR4NxYz6M4s1;
	Tue, 20 May 2025 19:09:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 73D9B1402F0;
	Tue, 20 May 2025 19:14:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 13:14:17 +0200
Date: Tue, 20 May 2025 12:14:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 01/10] cxl/region: Add decoder check to
 check_commit_order()
Message-ID: <20250520121415.000026db@huawei.com>
In-Reply-To: <20250507004310.3536991-2-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 17:43:01 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Stands on it's own so maybe queue this up even if later patches
are still under discussion?

I'm keen to reduce what is floating around in a good state!

Jonathan

> ---
>  drivers/cxl/core/region.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..a91d4eb061e4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -788,7 +788,12 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  
>  static int check_commit_order(struct device *dev, void *data)
>  {
> -	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(dev);
>  
>  	/*
>  	 * if port->commit_end is not the only free decoder, then out of
> 
> base-commit: 3c746d4821f507304b08789e3c7c151554fc2356

