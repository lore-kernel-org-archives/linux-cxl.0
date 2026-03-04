Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34E274641
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645316; cv=none; b=j49nWrVeBEZE1GzWvR/oSo8+LNdxT9ZKCTXhUrmDhr6rocjYKxJjohfB1Wf3s0crymmPZA8uRoVIPlWmX4vEvMeGIy4XlDpLFy+PC7AoR3kZkOLGIRy1smKJbK8W1W9VpOr7oinUf8rqAPvFDKLv3ResBFrpigVul7ZIB7vFN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645316; c=relaxed/simple;
	bh=hiMpEyo3rReosXhPAgmbOwyWcaT3wXn/umUJAA+PD5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjEoUXYPujih0P5BwoSjssCz9+qLtvNPxsLUsxN7pl0RK2nuuMevhywzGpE/rnK/NXTLrat2ww6EG8YDudV5DkiG8wGEiCpn7QMa9SHErPCInh2GOZz/kBwRr/Nwhh3v98IYFuSbuKkms5eLjAAE9MCqL5uoUEUNaTD70/daYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSDyenkN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSDyenkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772645312; x=1804181312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hiMpEyo3rReosXhPAgmbOwyWcaT3wXn/umUJAA+PD5c=;
  b=SSDyenkNuUfIEgJH5IQoiG75Cm7PfdPi7XNMZK403aUlxaldlY/WrI6s
   xB98MlXaW66Lbdd9fxN91sN0FJd6BsX4iRiLCWntoYRH4xGOgJ3ocJF9U
   xuCvFO0e1n3BDBSkAFk1wxSh0nNDIZ2CurwBWbidWHX0KNWpewt1EhzJt
   bUnCoynqvSVjF4xxGiijPYj8pM2WmcWRNAupVo+uyH03TXWp8qiOXM9bO
   PR2X2qYZy3HIym2L9hlimN/km7cAtjRFu5ZmzghF/LoypcM8izgkOxmDn
   ss1w58ZfptXSI+nIi3EqNWXu++GkmHmi1WoqGmNx/oTrZG6b1ggXNqicF
   w==;
X-CSE-ConnectionGUID: tw6IvvIMTIG3d/uF5eZdbQ==
X-CSE-MsgGUID: YOVDa0r5Qm2fvVZ/zE8RzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72740432"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72740432"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 09:28:31 -0800
X-CSE-ConnectionGUID: 08vpAY46S0yZZiIRQ2lbQA==
X-CSE-MsgGUID: 8g2DBHNyTnOI/B4WyCleJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223373650"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 09:28:30 -0800
Message-ID: <37d5e8ee-8a1f-4382-acc7-34c75e1cb6dd@intel.com>
Date: Wed, 4 Mar 2026 10:28:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260202191330.245608-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260202191330.245608-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/2/26 12:13 PM, Davidlohr Bueso wrote:
> Failing the first sysfs_update_group() needs to explicitly
> kfree the resource as it is too early for cxl_region_iomem_release()
> to do so.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/fixes
77b310bb7b5ff8c017524df83292e0242ba89791

> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 96888d87a8df..28d70497283d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
> -	if (rc)
> +	if (rc) {
> +		kfree(res);
>  		return rc;
> +	}
>  
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {

