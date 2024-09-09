Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F861AD40D;
	Mon,  9 Sep 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865895; cv=none; b=JKh0+FI1YdQtIWUgYrXSceK+ea2ICD1tbE6MpU9Nwfbjr9HzjZPradNm0UxO6szWzh6RSXkLKO0Xs70/RuPaMa6lPUzvp1s9RTP9pa0f7+GEMf1/87N1YBpLUMIiixim0ml1CL9xpCQRCiafSgvZDQW/IbehcEPfp1D9WFdW7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865895; c=relaxed/simple;
	bh=HEiW+hKYJvZs6VW5BHpJq8GDxL0+eQcdyn+G9+ESbDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNxVPhXN+WkDJJ4OCeqhdwH3flj3pJtPP48WZMw3p5EX9LcWksKV08OSjDUl6NbVhnm1/2J4EnwKAEgX34k+TsnRAih8n0POSR7wXtebIv3314Nay24ExAsGn/OO+geAGWGK/DUlKdd9pxVBD/P28lf5iolKu6eVMLqm0CgCl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtsRWNXD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtsRWNXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725865893; x=1757401893;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HEiW+hKYJvZs6VW5BHpJq8GDxL0+eQcdyn+G9+ESbDs=;
  b=XtsRWNXDuCoHw9nUhMVzuGRgTIipg1o8++i5DWEskUT1omxTPQ4N9oXi
   t/5G4I6Nvq9rUtsdDHaYLYtyNYn9BuKcAeETCkZ9TqRLzxlNuYwaRK8ii
   NcATHIXEpn1wGtt/pcd86V9nfj4ECnXJTW6EXR/lmZxyeT5jTPbYOimKd
   VVLYS3LG9glu4LuNrR/TQbmQliKj/uaZJSKUuyytLqs4wb1hiiFZQFKOE
   JgA0ctivwS+1NQK4hwVMQayQEwDa51SPMZBUq3FSi3435WhHBrhUEClZM
   acFJCISxDic2i+9QE/tUZYEyLcY66iO4IZlGD5Fa0gwRin2v61Vl4WozX
   A==;
X-CSE-ConnectionGUID: Akx6uhUaQ6yfyXLg/6QzRg==
X-CSE-MsgGUID: LNvvIGOVQqW+zdW4IYoSUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="13435583"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="13435583"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:11:30 -0700
X-CSE-ConnectionGUID: X8dz3/fEQK2RNTLfS6HrmA==
X-CSE-MsgGUID: BCPV/t7FTOuLZ9dwvweIQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66256125"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:11:27 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  Dan Williams
 <dan.j.williams@intel.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Alistair Popple <apopple@nvidia.com>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v3 2/3] resource: Make alloc_free_mem_region() works
 for iomem_resource
In-Reply-To: <28bbd51b-cc47-4468-9523-45dab25d20dd@redhat.com> (David
	Hildenbrand's message of "Mon, 9 Sep 2024 09:04:17 +0200")
References: <20240906030713.204292-1-ying.huang@intel.com>
	<20240906030713.204292-3-ying.huang@intel.com>
	<28bbd51b-cc47-4468-9523-45dab25d20dd@redhat.com>
Date: Mon, 09 Sep 2024 15:07:54 +0800
Message-ID: <878qw11f05.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, David,

David Hildenbrand <david@redhat.com> writes:

> On 06.09.24 05:07, Huang Ying wrote:
>> During developing a kunit test case for region_intersects(), some fake
>> resources need to be inserted into iomem_resource.  To do that, a
>> resource hole needs to be found first in iomem_resource.
>> However, alloc_free_mem_region() cannot work for iomem_resource now.
>> Because the start address to check cannot be 0 to detect address
>> wrapping 0 in gfr_continue(), while iomem_resource.start == 0.  To
>> make alloc_free_mem_region() works for iomem_resource, gfr_start() is
>> changed to avoid to return 0 even if base->start == 0.  We don't need
>> to check 0 as start address.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> ---
>>   kernel/resource.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 235dc77f8add..035ef16c1a66 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -1873,7 +1873,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
>>   		return end - size + 1;
>>   	}
>>   -	return ALIGN(base->start, align);
>
> You should add a comment here. But I do find what you are doing here
> quite confusing.

Sure.  And sorry for confusing words.

> Above you write: "We don't need to check 0 as start address." -- why?
> To make the code extra confusing? :)

After the change, we will not return "0" from gfr_start().  So we cannot
check "0" as start address.  And I think nobody need to check "0", so it
should be OK to do that.

> /* Never return address 0, because XXX. */
> if (!base->start)
> 	retrn align;
> return ALIGN(base->start, align);
>
>
> And i still haven't understood XXX. For whom exactly is address 0 a problem?

Because the following lines in gfr_continue()

	/*
	 * In the ascend case be careful that the last increment by
	 * @size did not wrap 0.
	 */
	return addr > addr - size &&
	       addr <= min_t(resource_size_t, base->end,
			     (1ULL << MAX_PHYSMEM_BITS) - 1);

If addr == 0, then addr < addr - size.  gfr_continue() will return
false, and we will not check any address.

>> +	return ALIGN(max(base->start, align), align);
>>   }
>>     static bool gfr_continue(struct resource *base, resource_size_t
>> addr,

--
Best Regards,
Huang, Ying
