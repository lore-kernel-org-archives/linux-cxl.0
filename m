Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC302040B2;
	Mon, 28 Apr 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881415; cv=none; b=qan9eTE6YnE82OSQIb86c/6rrPEw6SDyJ2y+5ucqWfBf3DYrbNpByAy8YAKNIT2qTmI+gtosdjSCHiKSJ1l4RsLjky6bq1DLtlOyaFo6kYaY7NHfPWK2OP74bZRca41qbcEo2ABDFnlFK9i7iUo29c9ctQCJIWO2WNfu9OVDeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881415; c=relaxed/simple;
	bh=d96J7/O94xadSvA6zuIRLFQTYEw18yGoq0qlApnvezw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhPjXy88qwktjlJfrOKR99slVm2RS9haVCiYtYIGQbB2k1iMdi7b7XEwgOWfDT7Zql713WSE/9iE3TozlOMZlAmzweNCMmYRmi7HqGcqIaLFtRBCH/p7BEOOwvvqAL8/Bgird45KEsLJAv1iluU4VYK/l7yYFBTAxvI+mjDZiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCZRLrjM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCZRLrjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745881411; x=1777417411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d96J7/O94xadSvA6zuIRLFQTYEw18yGoq0qlApnvezw=;
  b=JCZRLrjM8cLlF7od4a4k2gEr2kqZesAicEHUNopUX76ZDsisSXDl+52j
   qyjlWWNNLYho0SoYGhAd+IRjrzvoMmKVohz7N2VraZxF2qN6H+Pux+7wk
   JmN1K92xW6gFNnjgK2FbpNv3p0RtHek3BKr3PQh07Se4QZXbgiVV03IVc
   ctr3E93llKPn22swK4cRctv6VxTYvuGDyFom0geUhQF2rGd+Ixq2LTrrw
   GZXWTnCzYF/SomTNJCx0c7X8eyFSCJRY4t5/Jzastrbrdi1a0rzjJsgm4
   mp+EBnh31AY5kboX1TKoPWe7GXvgyFCPfvfUm311pW6Aw9GH3Bfiklk1q
   A==;
X-CSE-ConnectionGUID: /dw6Ff4sTSGydc+dqJHzKw==
X-CSE-MsgGUID: hlD2nsnaSYCBh4hvkx3q6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51156506"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="51156506"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 16:03:30 -0700
X-CSE-ConnectionGUID: NXDABcl3Sx6lL3EUtd9DpQ==
X-CSE-MsgGUID: dR1Atr8eRkalc7zlpmDo+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="138841492"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 16:03:28 -0700
Message-ID: <f6ad2f58-4bd6-4238-8baf-a185d58e497d@intel.com>
Date: Mon, 28 Apr 2025 16:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] cxl/port: Replace put_cxl_root() by a cleanup
 helper
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-9-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250428214318.1682212-9-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 2:43 PM, Robert Richter wrote:
> Function put_cxl_root() is only used by its cleanup helper. Remove the
> function entirely and only use the helper.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 9 ---------
>  drivers/cxl/cxl.h       | 4 ++--
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c9087515d743..e325f08aaf32 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1037,15 +1037,6 @@ struct cxl_root *find_cxl_root(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, "CXL");
>  
> -void put_cxl_root(struct cxl_root *cxl_root)
> -{
> -	if (!cxl_root)
> -		return;
> -
> -	put_device(&cxl_root->port.dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
> -
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 960efcc60476..ea06850ecaea 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -737,10 +737,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  struct cxl_root *devm_cxl_add_root(struct device *host,
>  				   const struct cxl_root_ops *ops);
>  struct cxl_root *find_cxl_root(struct cxl_port *port);
> -void put_cxl_root(struct cxl_root *cxl_root);
> -DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>  
> +DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);

