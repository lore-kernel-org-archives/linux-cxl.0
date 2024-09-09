Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3D184F;
	Mon,  9 Sep 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725843680; cv=none; b=NqJccD+vNo+bkVz+E+5m6jS6KUyLtFFWHJPAXBBUytUnOOQa85F5H+ZedBvLIGLujotLz8UmCDBjq4FAnx1Fz8au5uS89bqIyUdX4YTzHxpuSPK5vmvvWEfxy25mp3/AuqMd3UkP3cuMpuJLWz+YXx3z4DhAfHo6+RRdb1zqbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725843680; c=relaxed/simple;
	bh=Cfif+2grFsAgkHSxIqtVjnMKRz859fMvwDOX+OGEQa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M97K7M/F6qt2CEoIOJMFs1/j0ZJV7nFPTD2i0DocdUeW2MLiCE7n5mB7oWRxZtgAtMjhPSCcLfBLEOR8vZME1RJjwa6yiu5+wTvkqB2r0dyHIY9L8/SfG13peqG3dcREoqIA3TpbzA0hOgbMF5F8oj680Fjvt407nsH0UfzTR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1SKlNPW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1SKlNPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725843678; x=1757379678;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Cfif+2grFsAgkHSxIqtVjnMKRz859fMvwDOX+OGEQa0=;
  b=m1SKlNPWS8c4259RGMByKsb+hVEE43AOVEiXIm0VITLpfwiM9HGM4C1Y
   pC94x9l2n4FhA9O781bv+k+jQL3qCvXEo/HosqZPwkuFbfeMyLilukn8F
   LsAxBk872KS/vHZUPocgnfPJ2iCuKG7uiVKo29Ngws5meAXbRPgonfRwS
   nQB3pQvEoP9sknxS8+dQan8lTEKT8tjjTSYQYE5PimmEHEenOkIWLDYMH
   RXby3lNS/25/DZgqQ021FeZIqQMpOCEr+2bkCDv7XqOkUNNdpQZXlLtqA
   5rkdqBMgWpBkazJthZGXkyyQeW9nRJ53UpEbJ2yju0lmoAOU+mzjOb0mC
   w==;
X-CSE-ConnectionGUID: 3jsTfUAGSzq0C4XnaBmOJQ==
X-CSE-MsgGUID: MHGURW1jRoKhYflba03Mmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="13433168"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="13433168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:01:17 -0700
X-CSE-ConnectionGUID: NdfFDBWRRW6RUDsVFOZwZQ==
X-CSE-MsgGUID: IY2cAeqqTEuJRe1/9/hxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66296717"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:01:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-cxl@vger.kernel.org,  Dan Williams <dan.j.williams@intel.com>,
  David Hildenbrand <david@redhat.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Jonathan Cameron <jonathan.cameron@huawei.com>,
  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alistair Popple <apopple@nvidia.com>,
  Andy Shevchenko <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v3 1/3] resource: Fix region_intersects() vs
 add_memory_driver_managed()
In-Reply-To: <20240907202458.dfe90bfee071021706af91eb@linux-foundation.org>
	(Andrew Morton's message of "Sat, 7 Sep 2024 20:24:58 -0700")
References: <20240906030713.204292-1-ying.huang@intel.com>
	<20240906030713.204292-2-ying.huang@intel.com>
	<20240907202458.dfe90bfee071021706af91eb@linux-foundation.org>
Date: Mon, 09 Sep 2024 08:57:40 +0800
Message-ID: <87le011w57.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri,  6 Sep 2024 11:07:11 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> On a system with CXL memory, the resource tree (/proc/iomem) related
>> to CXL memory may look like something as follows.
>> 
>> 490000000-50fffffff : CXL Window 0
>>   490000000-50fffffff : region0
>>     490000000-50fffffff : dax0.0
>>       490000000-50fffffff : System RAM (kmem)
>> 
>> Because drivers/dax/kmem.c calls add_memory_driver_managed() during
>> onlining CXL memory, which makes "System RAM (kmem)" a descendant of
>> "CXL Window X".  This confuses region_intersects(), which expects all
>> "System RAM" resources to be at the top level of iomem_resource.  This
>> can lead to bugs.
>> 
>> ...
>> 
>> Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")
>
> Do you believe this should be fixed in earlier (-stable) kernels?

Yes.  I think that we should fix this in -stable kernels.  Although no
severe bug will be triggered on x86 in the earlier kernels, it may be a
real bug for some other architectures.

--
Best Regards,
Huang, Ying
