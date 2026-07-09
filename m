Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089B40B6E4;
	Thu,  9 Jul 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619961; cv=none; b=Zr4HJiXzKe3DX9MfTVLnXCp9sSfuy9l5/jgJgCRqk3UF5IHuBWZ9EgxjzexZ0S8r1F/EPwm1Ckv0s5gi2Vq0/1HIl8lxAQsrB6AlbstcJHpTcfSGZyvvE3aGYzVDF1uwkatMrhczF8fQm+3uDFE5tYDCBMB1VSBySeTRny+q1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619961; c=relaxed/simple;
	bh=IeL1oxUC9sGqcnSkpWpKrEd+SnQglbBpUQgEgR4fVhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbr0KOdLt+yPAxOoPC2RJnstks126fG3o0EMqw70bHj0EnU8IdEOBNPtgJee1dsBKr3cE+cS5N6q1xJ4WWdnjS5/Qk0JrU2xvoB0z95n9B8Y0O1Zxj2Tdb908Pw/7HZfSUn5d7CXehsNVnbrYcfwLyq9VbJrimUJiTVXa+nj8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6MD/U0F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6MD/U0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783619960; x=1815155960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IeL1oxUC9sGqcnSkpWpKrEd+SnQglbBpUQgEgR4fVhc=;
  b=U6MD/U0F7Xb7wqiBtg+q9yO7uDjuU23dArzMyCtzO4bsL8rWyrIAtQya
   4p7KyG9G9SaeGJCIdJhgqBdvFSNaZp8gqoTypgrHIGzp6rrIC5jHBk+9S
   Q+yp+LLUNrkLGcdeNAS2lZaFXJF5QorcYd3ZS9jci4Y4oAHhsnWLxespa
   wLp3V0szug3T7euzxEZAzePfGIJ7OS3qMxxLwvI3XdBC2T7JaAPIclgZ0
   Y6Si2aypAMCCrBH6tQ+WmcxqJnZvVMiYoWUVrQ9KiNLdFgwxme2IJ/IWq
   bhil7uvWkpL0PgDbEzsxL9QpNdmxHa+EGwQg5KXYFIIR6Lsm5i8fJ+hgt
   A==;
X-CSE-ConnectionGUID: 6C/iiJiHQhOjTnkvj6EBOQ==
X-CSE-MsgGUID: X82vtOegT5+o1X8AjEZ1FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88139721"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88139721"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:59:06 -0700
X-CSE-ConnectionGUID: NTSX3/2GQH6HiLFnWbczgA==
X-CSE-MsgGUID: ot/6hvFVQieZNeL412g8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252920873"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.142]) ([10.125.111.142])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:59:05 -0700
Message-ID: <f8005e88-51d9-4cc4-8a7e-596347de5d84@intel.com>
Date: Thu, 9 Jul 2026 10:59:04 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
>  
>  /* If movable_node boot option specified */
>  extern bool movable_node_enabled;

