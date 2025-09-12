Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D021E097;
	Fri, 12 Sep 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712080; cv=none; b=UqJR9FFz5IOcqZWt9HGKvJ3H181J6sB7QAdbsLt6qdzDUZ4q97li5stNe0gSsa9+T5DRPmamC3azsilDTBrZDElztZ4GuuHp/tEINi0jV3yxoUupxyypWvOWlmFWjJIbS8WkMVmBlOqV8pmR8A6tfqxMSmpgr6OnsUxURKErRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712080; c=relaxed/simple;
	bh=qa7lPK8UAXm8q99e2nmS2RFFR8iqR2JHBvidTMJzSGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJuEMVci14ATCK1QRJLyjgfP1lRI4MfrLWGi5IDz0BGDMBII/CwxS1SU40yN0AkwPAfQw9bjOfKAewulB4an7cdW9IkHMMi5k56yEkLz14rwjq4leAY4osnjq1yt/64V9/nqmV6ma3Do1t3qEVuO75N7QY2oGl5z16QoJBSU9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrcFcU6J; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrcFcU6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757712078; x=1789248078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qa7lPK8UAXm8q99e2nmS2RFFR8iqR2JHBvidTMJzSGU=;
  b=OrcFcU6J1jkR4+Md7b4nTm60AQyVCOwmjrVuzhsCH2yd/dVyZM3JI1+o
   HXE50DtqWxu2Mmj9xB3/X18p6OoT5Tq424KMwGU2qeLp8yyqvEVeLRQ05
   2zLWIUBMHTOEhbjAOs3gybOAmrxforfpiiXmJFoCflUd6/RV7zPi4PTxI
   CbnDeghb8SIQopzcBnvGT83Vjl/ksSN6eu6pN9tM7MBwWk2rmE8baUKtf
   e50KnXKvtqzQ4Ybnt3fjdN/34brxXGyifJj/XRyk8xG4KrHdY57z365DX
   vaG6iktkXOxCsPc8vYbvUGmb1j8tn/DXwGO+UEY5wsSzO6X/nF8EU1xSM
   g==;
X-CSE-ConnectionGUID: YuRrvm9kQJKMXaSytyXlQA==
X-CSE-MsgGUID: aZ9lU2vBTK2fDIHW+/uo6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="59761467"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="59761467"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 14:21:17 -0700
X-CSE-ConnectionGUID: O+RpWiKEQ9uHK3CNwfB52Q==
X-CSE-MsgGUID: mXLy4rNNR76FCz/cdoVtRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="178421845"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 14:21:17 -0700
Message-ID: <7c132aed-e10e-499f-9442-aa8df110390d@intel.com>
Date: Fri, 12 Sep 2025 14:21:16 -0700
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

cxl_to_parent_hpa_fn()?

DJ 

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
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;

