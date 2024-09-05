Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0395476B;
	Thu,  5 Sep 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505455; cv=none; b=AzZ0oSkRT7Y+mmOuMpWZ84CVqguwTAk4LOnNUQ+mF21/reR0HupZpgQ5eSsk1yOzf+lE7VU67faCwooUwmI5BhMYkwRWUMxbygG4Bj7nUZTfyCuhGRZCSkYO4qjPg/vWxTAWDdb3D4EkCzZEueagAAwrJ/19eB3aOnuiHghwnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505455; c=relaxed/simple;
	bh=0JSnG5HRLCKfbdDlK8qTrHejGQWFOx7ylq1ibs1Fn1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r59GN05fTkIobycZMVwTXTL6K3v7ohDxRaUjzjKQZgILLsb1PQJ8FmF/h0OWQJ1M9K5Cavdp2plaKDKkvcMYMfUP/EjGRb96twjEtIyIEPkeEQgvt46HfvlSGOdEQN3cZwO3dzzJJVtC3tPzawaK68xd5mmvEFZuuozW4wYvHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFPrCVH+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFPrCVH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725505453; x=1757041453;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0JSnG5HRLCKfbdDlK8qTrHejGQWFOx7ylq1ibs1Fn1c=;
  b=gFPrCVH+JhhACsM9TazArPpdfXT4JDAssY5il2gi3Z/tWBnVF44nS6o6
   LabevFCSXro0DMoekhUv4hRt2evjoFroTm6l+lgODvnNmvcl+oIwToT+t
   mqWulYXr32SNwY/BQW5PbJwNvnsLxnxofWGYvEJz8pNq4w2K9epoz1n4C
   dTMhXn7kIDt6/ApvjWPUqwozFjREQPyaXKtzXLz5gOweT7nb8ULQQlkQ3
   6/dpN7dmBkCbffCioDvKd3I/6KiaHEMk+whK8dH+RamkImn8sg5FggkTL
   wq9RCHgFWfk5OZSDFRGsX0NerMRVxdLnElzQhrgdjFyLYUhGvZz9ii807
   Q==;
X-CSE-ConnectionGUID: 0jVHs0/kTVC9bNo1qFx6rA==
X-CSE-MsgGUID: 5D+z8H40Qam5BI6qZ+qIvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35357204"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35357204"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:03:50 -0700
X-CSE-ConnectionGUID: Z8iGrkMfSI2AHVkBUG0Zeg==
X-CSE-MsgGUID: ucmmtiruRcCC+/WXqLY2Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65516118"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:03:47 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,  Dan
 Williams <dan.j.williams@intel.com>,  David Hildenbrand
 <david@redhat.com>,  "Davidlohr Bueso" <dave@stgolabs.net>,  Jonathan
 Cameron <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,
  Alison Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  "Ira Weiny" <ira.weiny@intel.com>,  Alistair
 Popple <apopple@nvidia.com>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
In-Reply-To: <ZthWCrUR4VmroXZv@smile.fi.intel.com> (Andy Shevchenko's message
	of "Wed, 4 Sep 2024 15:43:54 +0300")
References: <20240819023413.1109779-1-ying.huang@intel.com>
	<ZsL-wfDYsUmWKBep@smile.fi.intel.com>
	<874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZthWCrUR4VmroXZv@smile.fi.intel.com>
Date: Thu, 05 Sep 2024 11:00:14 +0800
Message-ID: <87tteu6c01.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, Sep 04, 2024 at 03:48:44PM +0800, Huang, Ying wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:
>

[snip]

>
>> >> +		ostart = max(res.start, p->start);
>> >> +		oend = min(res.end, p->end);
>> >
>> > Isn't a reinvention of resource_intersection()? With that in place you may also
>> > drop the above resource_overlaps().
>> 
>> sizeof(struct resource) == 8 * sizeof(unsigned long)
>> 
>> Just want to avoid to define another struct resource on stack.
>
> Is it a problem?

Not a serious problem.  Just prefer to avoid too much stack usage.
IMHO, the benefit isn't large too.

--
Best Regards,
Huang, Ying
