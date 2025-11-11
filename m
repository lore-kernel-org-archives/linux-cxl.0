Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EED304994;
	Tue, 11 Nov 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872117; cv=none; b=RWdtng/S9H4H8leVV6zGYnmKHqFngvDAULSVhWN4IALEnHabb0uDifm4duQaQMeeBTKPFqlEkwnVInLiThqA69JRQrpEeQJ5yPxqDgrnVfyipDDQ++MM4Lk/wR8MeIYDSqiduU+kkyus1SxPk0uPRiXBWeWc8tl9iTlsqWfw20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872117; c=relaxed/simple;
	bh=ewWPghOlpShkgcZg6ReXF7OA4p30iuReGJpeYovkw7w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VarAp2n2UHY4VyoTX/zhG/p7dZr6mQ49jyGRjJJL21euQWZfAZBkbJm/vLkBPPHD6f720trqrU9lizFBtgV35O6vEcofP6bQAKS4AVPgyEB/rGEEYgT8dAeSyrKLRmo+cjLLpSg3LBGgkePzt+4Um8Aturgpkt2p9JnBtNXkBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Tk84T4szJ46Dv;
	Tue, 11 Nov 2025 22:41:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DA19140136;
	Tue, 11 Nov 2025 22:41:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:41:50 +0000
Date: Tue, 11 Nov 2025 14:41:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 03/14] cxl/region: Rename misleading variable name
 @hpa to @hpa_range
Message-ID: <20251111144149.00007c63@huawei.com>
In-Reply-To: <20251103184804.509762-4-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-4-rrichter@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:44 +0100
Robert Richter <rrichter@amd.com> wrote:

> @hpa is actually a @hpa_range, rename variables accordingly.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Passing comment below on readability (unrelated to the change you made)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Dave, I wonder if it is reasonable to queue at least some of Robert's series
like this one so that people can start basing on top of those and the
merge conflicts will be less painful in the long run.

> ---
>  drivers/cxl/core/region.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a780e65532a7..bb889c891cf7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

> @@ -3577,12 +3578,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  		return -ENXIO;
>  
>  	/*
> -	 * Ensure that if multiple threads race to construct_region() for @hpa
> -	 * one does the construction and the others add to that.
> +	 * Ensure that if multiple threads race to construct_region()
> +	 * for the HPA range one does the construction and the others
> +	 * add to that.

Unrelated but a few commas would make this easier to read. Something like:

	 * Ensure that, if multiple threads race to construct_region()
	 * for the HPA range, one does the construction and the others
	 * add to that.

>  	 */
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
> -		cxl_find_region_by_range(cxlrd, hpa);
> +		cxl_find_region_by_range(cxlrd, hpa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);

