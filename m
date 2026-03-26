Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2D3382E8;
	Thu, 26 Mar 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563871; cv=none; b=XOGMFhyxOh07FVeBzQvirXmSsCoaQApND+oQ0Dfo+KR5vJJpAAWTYD8rM8MgXDRbHNcH7KzneswAONZWjJO/pbWUUwX5TFMhcOyy/evIySDA8yF/k3I59FWPMyAYTya23GItUFOYV98sl4deNb15ILBFbKDHye1gXRrh+tnY5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563871; c=relaxed/simple;
	bh=3YFTy2V56orgyhZxtiaVDkmsOBqj4WEHYrioPuzpDTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJJq4nfIr+20VXz3jr3GCowMaAZIs0UXp+6gF9NUlZ4cDDvjRNSLMxvtWrOLp1Qt1AnUgp6vJKh3v66sLv2PmJPX6WZ7kLxXDKaBqcJRw031AVElp0tFwj8e1mxdPw0Gi7n3V6rn2uerxWKMme3hGi/G2I2XmZstNin0YBYFa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAlYlpqn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAlYlpqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774563870; x=1806099870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3YFTy2V56orgyhZxtiaVDkmsOBqj4WEHYrioPuzpDTI=;
  b=YAlYlpqnCLhcjW5KnndG2YUeZC9FXLtm2PZVMhwaMOOPPng6MC5S+HCF
   d2veEWsg+ecARkETX0PsW/QL4K4eSp8FGBaepTSofjjS6jEvOCuVD8kbb
   xdyyDep8vcS7rULGSNOe91m6M8+DApxpsGZbhUALnPXLNGdXnvdR/42bZ
   ZZPOEtFru2/u9yxV4Ksae+8xfGbEoPxujGAxOspd6ApJvr5e0xxw9RIQ9
   5yU8GH6A4XYeUWS7vrutNf6kPr6Yhw2l3v4EjP53TXAMxLUBAz8ZHsviO
   1oFIN7+meg1jWx/kXGWWI18hDOp1RdgXG4YAWFIgixWJI4bV5s1iZOkoJ
   g==;
X-CSE-ConnectionGUID: bsS9cGgSTYWjA5ekfxHkhw==
X-CSE-MsgGUID: Vaqe0sGjQTGZHkTxHKw8tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75351718"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75351718"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 15:24:29 -0700
X-CSE-ConnectionGUID: mh2BvPkTSQ+0bQ+FCapQXA==
X-CSE-MsgGUID: wvh2xao3RgK4tajqGik0WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="263048884"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.122]) ([10.125.110.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 15:24:27 -0700
Message-ID: <66c7fa22-5980-45cb-b1d4-94446231a6d0@intel.com>
Date: Thu, 26 Mar 2026 15:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
To: Rakie Kim <rakie.kim@sk.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: akpm@linux-foundation.org, gourry@gourry.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, byungchul@sk.com,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, david@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, harry.yoo@oracle.com,
 lsf-pc@lists.linux-foundation.org, kernel_team@skhynix.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com, Keith Busch <kbusch@kernel.org>
References: <20260324053549.324-1-rakie.kim@sk.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260324053549.324-1-rakie.kim@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/26 10:35 PM, Rakie Kim wrote:
> On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>>
< --snip-- >

> 
> The HMAT latencies and bandwidths are present, but the values seem
> broken. Here is the latency table:
> 
> Init->Target | node0 | node1 | node2 | node3
> node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
> node1        | 0x89F | 0x38B | 0x3AFC| 0x4268

Do you have the iasl -d outputs of the SRAT and the HMAT somewhere we can look at?

DJ


