Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8C2459E5;
	Thu, 17 Jul 2025 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794468; cv=none; b=tCDPXC0rogvfqPMuB9zc/2jnObe8mNiIciyrenSEW4C9bzCp8dTq5XRWpElJsL8gQ80CYXbC0/oV18ofvFrX5JEcJLYmrc93gmof5zEC57X+bK7B1d9XB8UoqL+lJUGVZdMkiWcEZqZgVK2XMCJA4nHvTHuh98IA5O2tYUW0L1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794468; c=relaxed/simple;
	bh=Z91spb535ClmCzUk8z8x6barffOcqj52JPK73PApQ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYPcMztefuzcV3xszZY9s5v9PHdjLo4ShJ+XFhXWExw+q7anc0IceVs8JgEK7hSr8azwRzU/AStRGriWAl3kbIAHIZMe9asYF872SlSLOnKokidjAGq4ZYzzNkVp9EJhXqc+BwMm+Hn3HgSV3aUvKslNXPCt8KM8lEZSGeojr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIdMjRx4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIdMjRx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752794467; x=1784330467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z91spb535ClmCzUk8z8x6barffOcqj52JPK73PApQ3Q=;
  b=VIdMjRx41I+zkB+FFhbBsRJZdz4RHaF+K8WNnsvatWc7tT6RSliYZ1cp
   jL6Pl9ayQdiaSe6UpzfrHWR0Oxj6zTRMOcFvf89oWdkzWJSk6b7oRwfhD
   ipv7Bo2tiw90W27korhYDDu0TTcgIVwdgvUXmM6hENaDqAT+EKLy5tXef
   /THee+jC1Ppps75oXk63baogltbBpH5icNlgfGKSrNoIpePwqcLq1+4k9
   jIZoylAOjLLFchQ//witrW+SLt9HaQC+4HHSp3doWBCGSahWiDGns6Wml
   3L50fdw9+2MWmvRqVHx22UocuXNlPunnhcODiP1tHy7vk1AhLH1OjVQwi
   g==;
X-CSE-ConnectionGUID: tyQeKpxSQei4czD4BOxhsg==
X-CSE-MsgGUID: CH3zP29FSTeOZw5hoSVRFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54300202"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54300202"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 16:21:06 -0700
X-CSE-ConnectionGUID: KmB15xNWR52oofoENDVxBw==
X-CSE-MsgGUID: OB0qRmbGSii18EWBWWt2qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157994511"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.3]) ([10.125.108.3])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 16:21:06 -0700
Message-ID: <848e0e2f-c2cf-4c07-ae48-b12cf1d0b332@intel.com>
Date: Thu, 17 Jul 2025 16:21:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] cxl: Fix -Werror=return-type in
 cxl_decoder_detach()
To: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-kernel@vger.kernel.org
References: <20250717031251.1043825-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250717031251.1043825-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/16/25 8:12 PM, Li Zhijian wrote:
> Fix following compiling errors:
> In file included from ../drivers/cxl/core/pmu.c:10:
> ../drivers/cxl/core/core.h: In function ‘cxl_decoder_detach’:
> ../drivers/cxl/core/core.h:65:1: error: no return statement in function returning non-void [-Werror=return-type]
>  }
>  ^
> cc1: some warnings being treated as errors
>   CC [M]  drivers/nvdimm/claim.o
> make[6]: *** [../scripts/Makefile.build:287: drivers/cxl/core/pmu.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
>   CC [M]  drivers/infiniband/core/verbs.o
> 
> Fixes: b3a88225519c ("cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks! I applied to cxl/next

1d0d1bc44e98dc90d478badb40de5e3adb747c2e


> ---
> I'm curious why the LKP robot didn't report this.

Yes. Odd. I guess randconf has not turned off CONFIG_CXL_REGION

DJ 

> ---
>  drivers/cxl/core/core.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 705a5f09aa78..2669f251d677 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -62,6 +62,7 @@ static inline int cxl_decoder_detach(struct cxl_region *cxlr,
>  				     struct cxl_endpoint_decoder *cxled,
>  				     int pos, enum cxl_detach_mode mode)
>  {
> +	return 0;
>  }
>  static inline int cxl_region_init(void)
>  {

