Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E92D46B3;
	Thu,  4 Dec 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861772; cv=none; b=nKm80WLUW3vHCQ//krqRZEDgiKV6zwDKtMLDDTNwK5+2uvs+aFiMGdWGM4+X64yUqJq+NW01Q44dXPY+kmCSli/MP8fKeMqUAefDDdUVYTLwR/a3xnobAHzuvs7NZkdNlb3l3iRH1u/l0PMt+gFuAf8BRceop5PnqmN0S8ierrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861772; c=relaxed/simple;
	bh=AtG6V41tRNLSBeH0QVyr9oYTYe7p2nCevvJJAVEqvdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM5d6/O662Cc8SOMYyqV2LyAB2mqLK0mhNsXR3R1+D5sq1nECoBRj5sJsQaG9WUyqjYzCfOVSAJ2SMm31FGot5RgsZ+oXCiJiPzpfa3GmilU3MTWcm3vwPdR9TCmAqV9rJ8MdJ7gvgWg0NE+gwAj1exlpY841CU0DTgu48Dmaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b349mCVe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b349mCVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764861770; x=1796397770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AtG6V41tRNLSBeH0QVyr9oYTYe7p2nCevvJJAVEqvdw=;
  b=b349mCVe2pgq2HWYJQA9tl61oJs9GzyppJ6vC5Zm6Ufb3BZtO6UzOQ/4
   fVx8sZ6lYMGxo6ZZwju3qoUtCOKwpzBz3D13HUrElZwWwCSH6XtLugZE0
   cKtjIBK+66Avb0OsEtq6lwb+Ke+dBX2xZO6JPyqKcil2LeMF8wuI8uqqe
   63ggZwNYv565MU2pBb2oqNC6A59ebWiYJVw4XcGYWJc4l0tvnUJlzmERc
   cpUJLsjToo7wC9Cp9r2wP1a9VLI1soFSbmNJbMwUklr6nrYG1ukPWU9tT
   xbMoaC+aVowPiCKAwXJnjC6rerudpGS+HGopYJHcxplJG4J+ZJ4kdXozz
   w==;
X-CSE-ConnectionGUID: SGbVoM72SNaVLx+sXJSWww==
X-CSE-MsgGUID: 0/QcKy4vSgOQQFolDxshEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77992117"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="77992117"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 07:22:47 -0800
X-CSE-ConnectionGUID: +rbVuqn/QPSE1LqCz2yEAQ==
X-CSE-MsgGUID: 0b8MxBPIRHiFUwc9xHM6Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="195431462"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.95]) ([10.125.108.95])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 07:22:45 -0800
Message-ID: <4ef90eea-5a42-4c41-bfd0-9e46d0ade81d@intel.com>
Date: Thu, 4 Dec 2025 08:22:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: fix format string for resource_size_t
To: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Gregory Price <gourry@gourry.net>,
 Robert Richter <rrichter@amd.com>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204095237.1032528-1-arnd@kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251204095237.1032528-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/25 2:52 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The size of this type is architecture specific, and the recommended
> way to print it portably is through the custom %pap format string.
> 
> Fixes: d6602e25819d ("cxl/region: Add support to indicate region has extended linear cache")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..fc36a5413d3f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -759,7 +759,7 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
>  	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> -	return sysfs_emit(buf, "%#llx\n", p->cache_size);
> +	return sysfs_emit(buf, "%pap\n", &p->cache_size);
>  }
>  static DEVICE_ATTR_RO(extended_linear_cache_size);
>  

