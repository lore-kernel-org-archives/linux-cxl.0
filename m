Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B92905;
	Fri, 18 Oct 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234474; cv=none; b=g+pQYoat220uJTo9ilJyTIUsgCfqUWoxg5T9K3rPd/MwM4RgNKoM1J3MC3dB2JLna+YCflOhK/ctIIpzmKQOC85orJqgOjhYCLX/IhZVLCuXEjIxmAmPLwclRJXK9Cfusag6zQ60mvdl8uEA6+Lv7d1PHuOvFujQIPe3NXQQeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234474; c=relaxed/simple;
	bh=evsN8uwCBAtyjbwFtrCAwBpQZhHeAvzprdl3LY6tz3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BK3gZDm48zapyecKV0aspLn+faqiNAyu88irFy4axw1tH/6a3lbG9GA6TLMzRMnSJgOSFvugaxmMN2ZdtZHv8nv48ZqIT4pQyuVhxUUz/LSGKKk2mbIoinZF+pZgcCyfvQ5I9PB/i27GqQfAfc6jA35S8ARBgfG9iA3AdkDlzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dm+LwOBn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dm+LwOBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234473; x=1760770473;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=evsN8uwCBAtyjbwFtrCAwBpQZhHeAvzprdl3LY6tz3U=;
  b=Dm+LwOBn0Nh90O/JGObiOLOS5img1VwCaLUU9PcqN0Is5sPr6vaq9VRa
   TBuNndyoTHBHf7s3vpc9d9+3WeR2O1D2mjvlQ1+bhyH+NvksqZqzcTUVn
   6RxPGlsXmAoY4xl8kDEIj1HRytgkJpJsicu03yvZ17/TmlMmLd/GGrdfX
   XDfW8kspWV8VeKhBMbjiS4D9Uh00KOjLt7UlpK4fWCYdqhglFUIjl7slr
   LkVUX32Y4IP4M+UYTkH/0XK2QEdyfGwhbMyLw8ea4j3u06bhjbO9FRvpg
   Jdh2JY/YpHgUizXFK4l9ZPJ78c58Z4dTR33cy+QvHWbGyv+LBP88fDdBH
   Q==;
X-CSE-ConnectionGUID: 8h0Fn3zeSrmkZ0UJT/xo+g==
X-CSE-MsgGUID: otK4w6LFQ32781WxnABPNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28886411"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28886411"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:54:32 -0700
X-CSE-ConnectionGUID: FDCaoVJPTG6h5ptq3w01fA==
X-CSE-MsgGUID: iE95uR4uSeq0XWRqum53vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78388662"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:54:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Gregory Price <gourry@gourry.net>,
  Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alejandro Lucero <alucerop@amd.com>,
  Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/5] cxl: Set type of region to that of the first endpoint
In-Reply-To: <6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 17 Oct 2024 15:33:00 -0700")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-5-ying.huang@intel.com>
	<6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 18 Oct 2024 14:50:56 +0800
Message-ID: <877ca57vlb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang Ying wrote:

[snip]

>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21b877d8582f..d709738ada61 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>  		return -ENXIO;
>>  	}
>>  
>> -	if (cxled->cxld.target_type != cxlr->type) {
>> +	/* Set the type of region to that of the first endpoint */
>> +	if (cxlr->type == CXL_DECODER_INVALID) {
>> +		cxlr->type = cxled->cxld.target_type;
>> +	} else if (cxled->cxld.target_type != cxlr->type) {
>
> No, the type of the region is determined by the caller and should be
> gated by the region capability. For type-2 region creation I doubt
> userspace is going to be creating those vs the accelerator so this all
> seems backwards to me.

How do we determine the type of the endpoint?  Specify it in type2/type3
device driver?

If so, we will specify the type of both the endpoint and the region in
type2/type3 device driver.  Then, why not only specify the type of the
endpoint?  The type of region can be determined from the type of the
endpoint.

--
Best Regards,
Huang, Ying
