Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955833711D;
	Thu,  9 Jul 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631329; cv=none; b=OWgu/8iagMTZfxxPa/QBjdgTe5yEeExlDhtb9oPjHkfLzEl+LEC2O8pyZbIHs8MjxqhodsDns9Ab0uSGgjq+FxUIKYfonmMDV01c4T5L0z+8iYLqXuN6kNlv99lIPi7NY/UeyVjsk84wjsclBkUIFyZldaqjOgQyoxFI8rBnHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631329; c=relaxed/simple;
	bh=3SV4lrq6dVZ9n9ZqVkK5eNZjHSMb6uBLOemepmuqFw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y32OCyY056Ggd5UEv+f16YOFBT8lVzB0Q3kE7/Nyg0jheG6kLCWn+zLdI94a3vaLuoq66DKY52sAJ5/s31d0aLMkc5R8ajx0DPto0mF9XmvPt/R2P7bYuXIVA47dPxbBK+6SN9hhSBFF9xSzTSRZFGB1QAev9hqulDb6lUWVyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAqRxRvr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAqRxRvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783631327; x=1815167327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3SV4lrq6dVZ9n9ZqVkK5eNZjHSMb6uBLOemepmuqFw8=;
  b=DAqRxRvrpJWh6jqwZMDgoUTXc44F4LMjr+AVttJhFPQLwTetdEnE45pg
   vb7KJORjXC2x5dAYsOv5yzLPY//a02l6D9IUCls1g7FsI684rZRM/vBS6
   TBMKGh2bElPCvJvK3afPL/s/m3XC+4PGerYBBe8cpFa0U7/YAaoFs3q/t
   Wnq1R/f/ZgH8gHhR743Ac+0dvm19Jzim50weOhqQ6beJMBRmfB7NqCkxQ
   qoxiV+m2AU7abVDFASnMZGdl55gsYIER1AMNSuXmI1prz9PBkWXus1DJq
   dC41R92EfMOs8vagFoHFWRCFxLTVZEsd4FkoDwlPfytH3IRcvTyTb3r5I
   w==;
X-CSE-ConnectionGUID: 36WhvjJHQGG2BQdNnwjxnQ==
X-CSE-MsgGUID: 44mVIfdVT+C/yeX79kBseQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71854502"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71854502"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 14:08:47 -0700
X-CSE-ConnectionGUID: tylC+NrwTFaXq228GvGp9Q==
X-CSE-MsgGUID: XmQDIsM8ScqT30l8CVHh2g==
X-ExtLoop1: 1
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.142]) ([10.125.111.142])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 14:08:44 -0700
Message-ID: <bdf0ca14-eec4-43b6-93aa-310e77660d95@intel.com>
Date: Thu, 9 Jul 2026 14:08:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] mm/memory_hotplug: add mhp_online_type_to_str()
 and export string helpers
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, david@kernel.org,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com,
 alison.schofield@intel.com, akpm@linux-foundation.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shuah@kernel.org, iweiny@kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-3-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260630211842.2252800-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 2:18 PM, Gregory Price wrote:
> Add mhp_online_type_to_str() as the inverse of mhp_online_type_from_str(),
> and export both so a driver can render and parse the memory online type
> through its own sysfs interface.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/base/memory.c          | 9 +++++++++
>  include/linux/memory_hotplug.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b318344426fa..3a2f69d3af7b 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -46,6 +46,15 @@ int mhp_online_type_from_str(const char *str)
>  	}
>  	return -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(mhp_online_type_from_str);
> +
> +const char *mhp_online_type_to_str(int online_type)
> +{
> +	if (online_type < 0 || online_type >= (int)ARRAY_SIZE(online_type_to_str))
> +		return NULL;
> +	return online_type_to_str[online_type];
> +}
> +EXPORT_SYMBOL_GPL(mhp_online_type_to_str);
>  
>  #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7c9d66729c60..5d4b628c4a1f 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -127,6 +127,7 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
>  extern u64 max_mem_size;
>  
>  extern int mhp_online_type_from_str(const char *str);
> +const char *mhp_online_type_to_str(int online_type);

Does this need to also be 'extern'?

DJ

>  
>  /* If movable_node boot option specified */
>  extern bool movable_node_enabled;

