Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26829A2
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977405; cv=none; b=m3Ms4wJJzxWO2kRBQXpvz+x8j3K9sG7EiBZpwEC6PLtYKgnyZjq4Dv6DIdCaSC3bx9QIMHzaHmsfJNZX5ErI1cvHfzqGbCofi1vMdgt1Q5m74Gs4ZoUA5wOZq4K085dv8S5XcIhIqQxfWVcPPVoUya/wBVTcWz1Dm+2jBtDTB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977405; c=relaxed/simple;
	bh=XEEGa1fUKOvRs5Gpmwj0HvhoG7XvD+Y9Vn46e6XrrTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKRsKBsMtFInjk7aAkbMHkX0oB8WSSGwHFPvNDmhIbyLLup+zJAmE8ITvOz749A6HrfnlQDn4sRAdJj9pCb9syfDxAs+SMuNatWFOvpFnffkeiZtKmJiF3la3J4oKl0PVC/eMc/OxgJoL1pFzjePM3wLz2jCfNKAI0czALAAAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmfUnOJD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmfUnOJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738977404; x=1770513404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XEEGa1fUKOvRs5Gpmwj0HvhoG7XvD+Y9Vn46e6XrrTM=;
  b=dmfUnOJDYnAI8Yh+JeNxjkWxk7WWK7fCgTabYjRJsymyjW67Fj3dEeaO
   3y8V+jcKijHjON4ScJbiottjITbDf3TX9G1bk6rtvP7QnyhfL4ar3DMvb
   LVwW0ELoUIdWQIZ+EgiHPEk1Nso07cvlc4IfN7wDToxgPrAeBMGA/1NuL
   T6iwjVJuEJTO8Vtzb+FkvIXaCCY1pSKIoUXAWF07YHC8fBmvDTxdLIvm3
   nUVYgt5EiDbm+9qtTWzbniR/5FMkYttKJhs5XWxRd9gV+nSENU70HsOIC
   ry6x2AxnZzbYsIyXMlIFM6g+QDw/cVgJlr2p0mT/uJlLtvp+NPy1kPTdj
   w==;
X-CSE-ConnectionGUID: HV/E768hTZKtPRYPYLdZKQ==
X-CSE-MsgGUID: 88fY7j/OTsei/ZtIFetoXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39536293"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39536293"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:16:43 -0800
X-CSE-ConnectionGUID: gNeuckfHR6mlXF0jKxrw6w==
X-CSE-MsgGUID: 8dPjeJzgTe6y8fTIx4muuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116616132"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:16:44 -0800
Message-ID: <8513109f-6cd7-40f2-b13d-613a23ef0ff1@intel.com>
Date: Fri, 7 Feb 2025 18:16:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] cxl: Setup exclusive CXL features that are
 reserved for the kernel
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-7-dave.jiang@intel.com>
 <67a6af169d221_2d1e294ae@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <67a6af169d221_2d1e294ae@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 6:10 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Certain features will be exclusively used by components such as in
>> kernel RAS driver. Setup an exclusion list that can be later filtered
>> out before exposing to user space.
> 
> This last comment is stale, the list is not filtered in v4.

I'll change it. In my mind, altering the entry is also filtering it. 

> 
> Other than that my tag still stands.

