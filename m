Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15346BE49;
	Wed,  4 Sep 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416299; cv=none; b=KC+RETRMNNdCmv2OCLzn90/G/jaJ8eaAC4ovCbjOZyu0tmrxxlYo4YXYbzar4NIDgFbd9xeui2/2h2jY5FbtIVtcPbKimClHCN75WNZVM+hdnsP5NEVESMzgGTcrMvkN91RL3TYQvJHnpEuL5r2aR3oK4sTv+1YUguS5guvsUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416299; c=relaxed/simple;
	bh=DO6RjSIN4ZDhNCSJgxEQTjwxlytLUYkGlVJESIjMu4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nkmu4iDqodpbZS/5AjPSoIstJo9qCeJkzdgBRrWnCPuxMfIabbzxxa84ZF6rlp+cYaRx55ZGOvew4AL/69T26F3kcg7MZuGfv1fz1hwf9Wl3Exb+R1OYjtw4OozkhpQv9fJehmy+Qg7Pmspm/gDV2MWDaGvybzi9bgbraEr41dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrEuRCtg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrEuRCtg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725416297; x=1756952297;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DO6RjSIN4ZDhNCSJgxEQTjwxlytLUYkGlVJESIjMu4I=;
  b=DrEuRCtgDCqqpbeqgeXDHIS8M0Jiq6+i/JGz/L4D0gtPiNnk7pFVGtTM
   CWZA/kP2BSyFa78nDij71RXmMrstixxRlSqoZJ0gayLwStyEB1gJfgKuI
   niAS0h/lVBEsUI270HZhxRAosqP3rcchW0vOJpsasZHsgO1tKXKNVUoIY
   WBK6CZJpqH9SBCf901Lwjz29RmBwiDLKWf3usOOK0TUjR5BCOszUZfakN
   9Vu7EQoX4ksxHOHLM46QMk03+cVm+jRSZrJcvAXJzQ3wxSrrM0Y5cagUw
   E0R4KKLZ2OY+ZZVCsh8DuHltmxAOAv7SjNswRjfmv/1OeqRj+GVY4lMtI
   w==;
X-CSE-ConnectionGUID: o+b1JYLSR/2QDiS40FIG7g==
X-CSE-MsgGUID: ntAgx4szRwezeGG+/dk+ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="26964283"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="26964283"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 19:18:16 -0700
X-CSE-ConnectionGUID: oPS/u5/sQHO7K//PvMXRXA==
X-CSE-MsgGUID: ry9GHRggTXmXEJIZjROQmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="65098036"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 19:18:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Dan Williams <dan.j.williams@intel.com>,
  linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Remove lock from memory notifier callback
In-Reply-To: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com> (Ira Weiny's
	message of "Wed, 14 Aug 2024 12:49:39 -0500")
References: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com>
Date: Wed, 04 Sep 2024 10:14:40 +0800
Message-ID: <87frqgb1wv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Ira,

Ira Weiny <ira.weiny@intel.com> writes:

[snip]

> @@ -2391,18 +2389,6 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  	return true;
>  }
>  
> -static int cxl_region_nid(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct resource *res;
> -
> -	guard(rwsem_read)(&cxl_region_rwsem);
> -	res = p->res;
> -	if (!res)
> -		return NUMA_NO_NODE;
> -	return phys_to_target_node(res->start);
> -}
> -
>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  					  unsigned long action, void *arg)
>  {
> @@ -2415,7 +2401,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>  		return NOTIFY_DONE;
>  
> -	region_nid = cxl_region_nid(cxlr);
> +	region_nid = phys_to_target_node(cxlr->params.res->start);

Better to add some comments about why we don't need to hold
cxl_region_rwsem to access cxlr->params.res here?

Otherwise, LGTM, Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

>  	if (nid != region_nid)
>  		return NOTIFY_DONE;
>  
> @@ -2434,7 +2420,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>  	int *adist = data;
>  	int region_nid;
>  
> -	region_nid = cxl_region_nid(cxlr);
> +	region_nid = phys_to_target_node(cxlr->params.res->start);
>  	if (nid != region_nid)
>  		return NOTIFY_OK;
>  

[snip]

--
Best Regards,
Huang, Ying
