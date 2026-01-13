Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB62D6611;
	Tue, 13 Jan 2026 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343983; cv=none; b=F4xnAMSBSLsdJjbtwB+jE06ybEuXzShoaiiQdVOls/6qPSrNuaK9rSPe3OKVJvxUSP9hD6Lk1gBlIbw4C16azhfQPK57ievxM6XcWPA6tSk/lNA/6xrir6sFLKzppqLBQEEHcPriYNuTltYIOz8vqdg4jSOjU3d9L/peAeI+wLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343983; c=relaxed/simple;
	bh=U+nU7eX+Sg6HubetyPK9g6eKsc7ojIe1cJH3tycsr2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CO8w7urBuKKF/IO9Z3jZyhBxzuSut8VUmxpFmEC+mlQkts3Fam6VdnELRU4QqYc+CK7sezc7o6uMNjTEWxLjsnOabCTMe0ON9l16yqE9kXCcQKLvdcv4Xo6reaHFnVBwfYA3akVQA6D0cRtreor62m3UcRwgvchvAJEWtW4nKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+ualC/U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+ualC/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768343980; x=1799879980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U+nU7eX+Sg6HubetyPK9g6eKsc7ojIe1cJH3tycsr2o=;
  b=V+ualC/UeBCmC3Jw9YiYJsrWAfMP8fRRy3PyjOtHP3Ve7r7begrLbEF2
   bF9HeH9gSy07Oc2cp1Leqb6nMj0mcNDa2/I0N04ktbW49PlZl8qKaFrM3
   i16oKVNUKrDqbPm5jWuMc/k4TXLlvX5N6u2kTjvxQbSI0oOpqE+H+fa12
   ygfUSG9sYYr8hEPKSTb8CDgc8yZOPl8RvSfEU8ibyPDhR7HzdLWCw9uT/
   mkhioNfyHj/ZaPOx+9OztY0L+Z+RtN9CA1OD51KxiEkg3+Tl7O6xQ5U1r
   JKikinL1+NUsi2o6cf+tEZ09kX3NicdfXwHMxgaz/F0eE9d/XSZMLO6Mx
   g==;
X-CSE-ConnectionGUID: JOnMwosmRQm6Cz4G3O3oQw==
X-CSE-MsgGUID: 5KvQpGQOR/i+P1vopBz5mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="92309445"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="92309445"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:39:40 -0800
X-CSE-ConnectionGUID: Jiv6MdFGS163ttp5L478uA==
X-CSE-MsgGUID: vQj+ppfOR0KIhNdLv3f2kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="208668881"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:39:40 -0800
Message-ID: <a9121da1-7e14-4e69-897a-b4da7b7dd1a6@intel.com>
Date: Tue, 13 Jan 2026 15:39:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/13] cxl/region: Factor out code into
 cxl_region_setup_poison()
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-13-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260110114705.681676-13-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 4:46 AM, Robert Richter wrote:
> Poison injection setup code is embedded in cxl_region_probe(). For
> improved encapsulation, readability, and maintainability, factor out
> code into function cxl_region_setup_poison().
> 
> This patch is a prerequisit to disable poison injection for Normalized
> Addressing.
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Funny how I created the same patch yesterday for something else and didn't realize you already posted it.

> ---
>  drivers/cxl/core/region.c | 53 +++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ed8469fa55a9..80cd77f0842e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3916,6 +3916,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_region_debugfs_poison_clear, "%llx\n");
>  
> +static int cxl_region_setup_poison(struct cxl_region *cxlr)
> +{
> +	struct device *dev = &cxlr->dev;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct dentry *dentry;
> +
> +	/* Create poison attributes if all memdevs support the capabilities */
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
> +		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR))
> +			return 0;
> +	}
> +
> +	dentry = cxl_debugfs_create_dir(dev_name(dev));
> +	debugfs_create_file("inject_poison", 0200, dentry, cxlr,
> +			    &cxl_poison_inject_fops);
> +	debugfs_create_file("clear_poison", 0200, dentry, cxlr,
> +			    &cxl_poison_clear_fops);
> +
> +	return devm_add_action_or_reset(dev, remove_debugfs, dentry);
> +}
> +
>  static int cxl_region_can_probe(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -3945,7 +3970,6 @@ static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	bool poison_supported = true;
>  	int rc;
>  
>  	rc = cxl_region_can_probe(cxlr);
> @@ -3969,30 +3993,9 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	/* Create poison attributes if all memdevs support the capabilities */
> -	for (int i = 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled = p->targets[i];
> -		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -
> -		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
> -		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR)) {
> -			poison_supported = false;
> -			break;
> -		}
> -	}
> -
> -	if (poison_supported) {
> -		struct dentry *dentry;
> -
> -		dentry = cxl_debugfs_create_dir(dev_name(dev));
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlr,
> -				    &cxl_poison_inject_fops);
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlr,
> -				    &cxl_poison_clear_fops);
> -		rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
> -		if (rc)
> -			return rc;
> -	}
> +	rc = cxl_region_setup_poison(cxlr);
> +	if (rc)
> +		return rc;
>  
>  	switch (cxlr->mode) {
>  	case CXL_PARTMODE_PMEM:

