Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3A279DDD;
	Mon, 15 Sep 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967739; cv=none; b=fDZm12W6saJZNTGAkL9K9zEUmQK0v609al7uoquQMNopq9jJ3DkWgtLctNXpilbLxjTGSJAUoW5bfSkoFjC/uJH+yG7qZ5MhcZ1TzmUUW6ApCmzikU6cdqzWflqF1lptqYX2ej8/kqA/mdlyIX58595QHVpC+KX+i6DXkZwsTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967739; c=relaxed/simple;
	bh=xtLYGByxjETh9u9GRgGiLvj8wFjrfDUjcAuKpy2DpE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6spjzq5/utqgA6sCnIs5dG13Rbbww59Aa8T78s/qhgYcFbjlrfdmy0yFGCMTUswvArxLFpZfNiSynTwZzFh1BU6BFHA8BqxdYoPtbRRegtBXnYxRI5CeO80GwfU0kturDXe+neRGA9Uw8rU3/VJMfn5WMH3i95CDnCJRLJSh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjJskk2z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjJskk2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757967738; x=1789503738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xtLYGByxjETh9u9GRgGiLvj8wFjrfDUjcAuKpy2DpE0=;
  b=HjJskk2zK50j0PetdvfhS0d1GfmpcpCU8ZijpkXPfx77RnGKE1Ys01PH
   NP4UR6nPYHsxdhupbxA4JWh5i1geaYtKK8yVzkjDpHWt27Ou5WKfEf8dG
   S3VtzH2LVDadY7oJUYIbU1qAq8sucoh4SadyTB7RJfmlgkM6YAigcM1Q2
   sVQVxyEfbez+o+FzXP5rA/scN9/PmNyQddxSPg7DekvUlJxNTfgcOmNDG
   5Wkl1fzKYlnSAiZQaXV3D5yUpI16aAjQNwWrTp0rdl1QkkHYzpv+q4fiY
   gqmgKlfcuhlr12J9sPvHnQKC227mnR78QIM4gLYgyQBMOsCvuOsOZQNIw
   A==;
X-CSE-ConnectionGUID: d3MlD7brSPazOdCVi8Nc+Q==
X-CSE-MsgGUID: SQy6uyqKQiOO5rHNfGJqBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="47804977"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="47804977"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:22:17 -0700
X-CSE-ConnectionGUID: 85ORCBkuTgWWc63Kf8AEag==
X-CSE-MsgGUID: e8gwZsihTjubVCaifjLTlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="179104903"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.129]) ([10.125.111.129])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:22:16 -0700
Message-ID: <2e4a3ff4-72fc-4a67-90be-f08880d5afae@intel.com>
Date: Mon, 15 Sep 2025 13:22:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] cxl: Introduce callback to translate a decoder's
 HPA to the next parent port
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-8-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-8-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> To enable address translation, the endpoint decoder's HPA range must
> be translated when crossing memory domains to the next parent port's
> address ranges up to the root port. The root port's HPA range is
> equivalent to the system's SPA range.
> 
> Introduce a callback to translate an address of the decoder's HPA
> range to the address range of the parent port. The callback can be set
> for ports that need to handle address translation.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/cxl.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f182982f1c14..eb837867d932 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -429,6 +429,17 @@ struct cxl_rd_ops {
>  	u64 (*spa_to_hpa)(struct cxl_root_decoder *cxlrd, u64 spa);
>  };
>  
> +/**
> + * cxl_to_hpa_fn - type of a callback function to translate an HPA
> + * @cxld: cxl_decoder to translate from
> + * @hpa: HPA of the @cxld decoder's address range
> + *
> + * The callback translates a decoder's HPA to the address range of the
> + * decoder's parent port. The return value is the translated HPA on
> + * success or ULLONG_MAX otherwise.
> + */
> +typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
> +
>  /**
>   * struct cxl_root_decoder - Static platform CXL address decoder
>   * @res: host / parent resource for region allocations
> @@ -599,6 +610,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @to_hpa: Callback to translate a child port's decoder address to the port's HPA address range
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -619,6 +631,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	cxl_to_hpa_fn to_hpa;

The more I look at this, the more I feel the callback should be part of 'struct cxl_rd_ops' and not under each port. While this provides flexibility in a general case if there is a need to translate at each level, the actual use case in the field today only requires translation at the top as far as I can tell. And the translate functionality should be part of a decoder and not a port. And in this case, the root decoder would suffice.

DJ 

>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;

