Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54F1F152D;
	Tue, 11 Feb 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266132; cv=none; b=VwcRahfelK6FKOWy9BcgJ01oRhuzD1MvM5SUiCpizkUF6hwzrslVfHTrr5uFRT1S4ek6nG3ZvSelLtaqwvOIVbdHUoyTAyXZXEoQxkL8i43pYtmb5msbCnj/saLEw2rGIMigm3c2I6HXRydhjXqzK4/OTVDmHDA+/NZLUaAP8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266132; c=relaxed/simple;
	bh=ToYy3UqyJwJwNnFvCaaFE1omoUtA2u9i9rN7mDLuG/I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUwRyIi+RLK8sDe5n3sZs7OT+/SP+4hBKk0zXDzGk8anIr/Lg+VUWeWwl3Q2fcg0aQmIycC4OWWL/SavMeA8RrHyoIBzUEEtcq2hKOzdOWf3MihoyrU/PFueHp8O1e+qtdCfDQKkmIP50HQ/AWYUZo1BUXpBRZib/G6XF+YWbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ysbh64PsYz6K9F6;
	Tue, 11 Feb 2025 17:27:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E4E4140498;
	Tue, 11 Feb 2025 17:28:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 10:28:46 +0100
Date: Tue, 11 Feb 2025 09:28:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] cxl/cdat: Remove redundant gp_port
 initialization
Message-ID: <20250211092845.00000d3e@huawei.com>
In-Reply-To: <20250211062054.300108-1-ming.li@zohomail.com>
References: <20250211062054.300108-1-ming.li@zohomail.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 14:20:54 +0800
Li Ming <ming.li@zohomail.com> wrote:

> gp_port is already pointed to the grandparent port during its definition,
> remove a redundant code to let gp_port point to the grandparent port
> again.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/cdat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..c656c1346aa0 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -651,7 +651,6 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	if (IS_ERR(perf))
>  		return PTR_ERR(perf);
>  
> -	gp_port = to_cxl_port(parent_port->dev.parent);
>  	*gp_is_root = is_cxl_root(gp_port);
>  
>  	/*

