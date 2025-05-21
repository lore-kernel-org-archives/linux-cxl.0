Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2896DF58
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870698; cv=none; b=Ga+Ox6joY4XdfFmsyVD7R8uv/UIfXKKMfSALFqVZRDow9YR95jmcuCNXaAPxlBxctRnVDlVmExNkoFJgYdRynTthTaKMsot8X4BVaFptKMt6CURgU+PVRr5WxFn8z/L5JYora6HTtUBomz06obuds3MA3Hb2Qu/eqLNrhSsymfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870698; c=relaxed/simple;
	bh=jsSu27zzRgNmR++YJzyU/cnblZYiSfPLXTrkGgEGzwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXx/pOP+ByQVIVK/eWnZ2qwkdhz9o9maUKpLywRVgqmPH207t7aerAkXdd0XDNV6hc1fdCauKSP/rFFoixh6oZimoqeykcN8WxAXYIiD2sJBeZjnpwyhUScS25NIa5mmNVR/GS19/HkEimyGj79rl1Kup7qttTjMNvkdKqjoaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9lX7RHD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9lX7RHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870697; x=1779406697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jsSu27zzRgNmR++YJzyU/cnblZYiSfPLXTrkGgEGzwE=;
  b=f9lX7RHD4lMXl+GK5pYZLS9q9JbSeWNJ76b2nZeBUHhGi2AikWzOstIa
   G7jolcJ2/PY/6K3lraUi/571Csti2bDO3yStRzfNXR23Mium0Mlkms7Hq
   apX93P8Kq/ONchiC4fXpH0eZKb8Pfb8VpwaniphrpQl7bAShMIpfgpF/P
   Vu7q5bC+jTOnLDs/dnLgQwPAljXIttrNGeujpDm6KbtkT6/tKwC4OJiA8
   dPHtAuW3RaGTzcAzDTHSQJzPNpgtcqRWAXGZGxsBkXJ2CHpbHjkCgZPjt
   x40rwtdLlbkhRyPbXnKk+YYVZhp85yGzx5zPzdPrT2fZsWGQIPLyeUCv+
   A==;
X-CSE-ConnectionGUID: 12KPDLvfRoC98k9mtaVsxQ==
X-CSE-MsgGUID: qgN3H0e9TiycMUWLT67nbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60924532"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60924532"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:38:16 -0700
X-CSE-ConnectionGUID: fQk0ad/fRVmhpcSNp3jkcw==
X-CSE-MsgGUID: gNGiJLm+Tp6VUnhnDzK5mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140824146"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.106]) ([10.125.109.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:38:16 -0700
Message-ID: <0dd822cc-b3a9-4df5-bbca-b04dadc7cfe0@intel.com>
Date: Wed, 21 May 2025 16:38:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: Remove the inline specifier from to_cxlfs()
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>
Cc: linux-cxl@vger.kernel.org
References: <20250521233625.1745849-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250521233625.1745849-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 4:36 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> to_cxlfs() was declared 'inline' in the header but only defined in
> drivers/cxl/core/features.c. This has worked because features.c was
> the only file using the function and the definition happened to be
> available in the same compilation unit.
> 
> However, in preparation for a second .c file using the header and
> needing to call the function, the inline specifier became an issue.
> Sparse flagged the declaration as invalid since 'inline' requires a
> visible definition at the point of use.
> 
> Defining the function in the header was considered but rejected, as
> it depends on internal symbols not visible at that level.
> 
> Remove the inline specifier to correct the linkage violation.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> I intentionally did not add a Fixes Tag at the point this was
> introduced because there is no breakage until the second user
> comes along. 
> 
> The second user is this patchset being reviewed:
> [PATCH v6 0/8] cxl: support CXL memory RAS features
> https://lore.kernel.org/linux-cxl/20250521124749.817-1-shiju.jose@huawei.com/
> 
> 
>  drivers/cxl/core/features.c | 2 +-
>  include/cxl/features.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 1498e2369c37..efe88c043227 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -36,7 +36,7 @@ static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
>  	return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
>  }
>  
> -inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
> +struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>  {
>  	return cxlds->cxlfs;
>  }
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 5f7f842765a5..b9297693dae7 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -64,7 +64,7 @@ struct cxl_features_state {
>  struct cxl_mailbox;
>  struct cxl_memdev;
>  #ifdef CONFIG_CXL_FEATURES
> -inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
> +struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
>  int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
>  int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
>  #else
> 
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb

