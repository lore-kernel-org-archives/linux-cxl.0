Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CC24BBF0;
	Tue, 27 Jan 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529803; cv=none; b=E29BPxg4MdYhrtCrs+n++obIlykV4h38Ncy3gN6IeSydewFmSOxpXbcCWDlif8iLTyulmc6hld9BYyCXOdDcHtOO7jRXbkwuZab1vRiK4tiVrO0+lxWFX6I1LV6r64rEZ3afrml2w625FzEEJz4GIVrI7CerT7UGgqZVuz+iQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529803; c=relaxed/simple;
	bh=OGLE7nKn6iQIzNpyiWMppK5i4mFCCDl+Lo+QbkH29Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZQCHAQ086/tMV6IUS7JKUc10JCIWjGyQAxOJNkiPnw9Y4LA7G1UHz+yqH1TTIKe/DhF8OXbpKK11i/dj1XPONru2f2RDW5j/mFQJaapqCIYP/eXqpKMvBs8hu4R+b3Cj+5hS9204d+6xcQsI1P2175z0a0EJIjx4qciK+Ght28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuacYaAd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuacYaAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769529802; x=1801065802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OGLE7nKn6iQIzNpyiWMppK5i4mFCCDl+Lo+QbkH29Mk=;
  b=SuacYaAd4zXtF0t3AiU0Mbns5PK5d7g00+hY+ZgcusZmpgfBDUQRZyE0
   T2rFWCa46W6bvlI/KBF4oNcUgxpoX9mtEudsIqfsFYh6HllItD0zcPdvd
   R/AtjlrKbd8aBwO0GVwtoI5npp05MkjxR+abubzY2503/ISE16X0tYhhC
   XgLtOLWVxHPqbc0/XCckJIn+We33GzFnPfJbC7gTgapIlk1kdzDfhTLeK
   L86sbN/uAgvw2fKOSoMpNqi4WxJ7hoOOj9BM5IACrK73nJg5ZqrAOB5gb
   Z/5pYaZuZxpPQW8vmZql0s6pPKQxr9ieB275gQwd/QqAtKfQfDBrgDhEB
   Q==;
X-CSE-ConnectionGUID: JRnnGrdIQRezHZXod9zOPQ==
X-CSE-MsgGUID: 33G+v+cdQRiN4oY8bbHXUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70630036"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70630036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:03:21 -0800
X-CSE-ConnectionGUID: Y53KRha7QkisTLoghmbYtg==
X-CSE-MsgGUID: knP+VnwTScybgVlADZg7Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207620096"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.136]) ([10.125.109.136])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:03:19 -0800
Message-ID: <13989dff-7d3c-4bdb-9768-8b3c935a003e@intel.com>
Date: Tue, 27 Jan 2026 09:03:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
 <aXibR6DjiWSzsd6l@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aXibR6DjiWSzsd6l@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/27/26 4:02 AM, Robert Richter wrote:
> Dave,
> 
> On 14.01.26 17:48:16, Robert Richter wrote:
>> This patch set adds support for address translation using ACPI PRM and
>> enables this for AMD Zen5 platforms. The current approach bases on v4
>> and is in response to earlier attempts to implement CXL address
>> translation:
>>
>>  * v1: [1] and the comments on it, esp. Dan's [2],
>>  * v2: [3] and comments on [4], esp. Dave's [5],
>>  * v3: [6] and comments on it, esp. Dave's [7],
>>  * v4: [8].
>>
>> In this version there are a view minor but no major changes. See the
>> changelog for details. Thank you all for your reviews and testing.
>>
>> Documentation of CXL Address Translation Support will be added to the
>> Kernel's "Compute Express Link: Linux Conventions". This patch
>> submission will be the base for a documentation patch that describes CXL
>> Address Translation support accordingly.
>>
>> The CXL driver currently does not implement address translation which
>> assumes the host physical addresses (HPA) and system physical
>> addresses (SPA) are equal.
>>
>> Systems with different HPA and SPA addresses need address translation.
>> If this is the case, the hardware addresses esp. used in the HDM
>> decoder configurations are different to the system's or parent port
>> address ranges. E.g. AMD Zen5 systems may be configured to use
>> 'Normalized addresses'. Then, CXL endpoints have their own physical
>> address base which is not the same as the SPA used by the CXL host
>> bridge. Thus, addresses need to be translated from the endpoint's to
>> its CXL host bridge's address range.
>>
>> To enable address translation, the endpoint's HPA range must be
>> translated to the CXL host bridge's address range. A callback is
>> introduced to translate a decoder's HPA to the CXL host bridge's
>> address range. The callback is then used to determine the region
>> parameters which includes the SPA translated address range of the
>> endpoint decoder and the interleaving configuration. This is stored in
>> struct cxl_region which allows an endpoint decoder to determine that
>> parameters based on its assigned region.
>>
>> Note that only auto-discovery of decoders is supported. Thus, decoders
>> are locked and cannot be configured manually.
>>
>> Finally, Zen5 address translation is enabled using ACPI PRMT.
>>
>> This series bases on v6.19-rc1.
>>
>> V10:
>>  * updated sob-chains,
>>  * renamed flags to CXL_*_F_NORMALIZED_ADDRESSING (Dave),
>>  * fixed spelling in 07/13 patch description (Alison),
>>  * be more precise on poison support in 12/13 patch description (Alison),
> 
> are you fine with the series? I have also submitted the documentation
> update with the changes Dan requested, see this one:
> 
>  [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> I don't see any open items. Should I resend a v11 with all remaining
> reviewed-by tags and the small update in the description of 13/13?
> Please let me know.

Hi Robert, I have both the doc and the code series locally queued and was waiting to see if there are any additional discussion or objections around PRM usage. I plan to merge it with cxl/next this week. Thanks for the reminder of the small update for 13/13.

> 
> Thanks,
> 
> -Robert

