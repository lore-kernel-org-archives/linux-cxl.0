Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE73198E77;
	Thu,  5 Sep 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533783; cv=none; b=k/uHDwWof2r009Hu6kz6ibgByS7rlsw0cIBx+LH5dv/5eW3DygVz1MgQKSHR4qJNJnks2cTWyrVyfBrPlSkVSmfQXK1gFiKUHTy9jj200TMM/7Dj02tpp5pLlf8+sKgJMp/Hdh/LbhUuDGbOx1HQ6CGU00iLLcfzC7qPkWYXQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533783; c=relaxed/simple;
	bh=Wk1LIKQbYQFhOY73fCkbnAsWD2OyDkMfbFjwDTD6xHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg7ZY7pEswEIdlR72xWtoE9376AqXWakh0stjWcdUVqQFGYS7ashe/PnqV9JvVmTkanulRBztSLFpVVwkX3CK823rG8GvueyZRW6nwVX6dc5I6tjA7GftriWnof9fYG4DEVQ3DMsEVZ1QYGqABCEv0sitJt0ZKlxLwWmimFtl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgFM7ggN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgFM7ggN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725533781; x=1757069781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wk1LIKQbYQFhOY73fCkbnAsWD2OyDkMfbFjwDTD6xHs=;
  b=RgFM7ggNDFXX7vx3NJVa5LqkCCQPyhLmiJf2yO/KrQI+GDzJ8kcespW4
   oTfONVThJVuh36LWKuqVIIXXDHsYkuK1svgDKUWmp2w4zf9cxOF/TyCWA
   gnYp/nO0Gop7ShZUCG27xzsOLtyNAW1GttHEBRghh0ONPYTpxSJVAqqNU
   B4AzMNQe4RwOsrBaYY0Ao9pKoM+H6Skzqp/VVmloMld90djnrBQXFuEEw
   wfmOBROo598DKoYsSnO3WNgrOgReAjEEsSRts1THqamZU/cfEImAWupB+
   m2DADveUyRt0xpVsEzDpeMn1dY985vZO+eNKamNuMENZoFiUxeWIzr62p
   A==;
X-CSE-ConnectionGUID: xb3eh98FTHeSGVarVBUUVA==
X-CSE-MsgGUID: YdkC7FzbScaFrGu2mkvdeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23800210"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="23800210"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 03:56:20 -0700
X-CSE-ConnectionGUID: U+51NrYkTdW4nYruBTQgKA==
X-CSE-MsgGUID: ZvBcwRMNQhaVASWjD1CDDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70180004"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 03:56:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smA9t-00000005Mov-31NN;
	Thu, 05 Sep 2024 13:56:13 +0300
Date: Thu, 5 Sep 2024 13:56:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> Huang, Ying wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

[..]

> > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > > message.
> > 
> > Emm... It appears that it's a common practice to include "Cc" in the
> > commit log.
> 
> Yes, just ignore this feedback, it goes against common practice. Cc list
> as is looks sane to me.

It seems nobody can give technical arguments why it's better than just keeping
them outside of the commit message. Mantra "common practice" nowadays is
questionable.

-- 
With Best Regards,
Andy Shevchenko


