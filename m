Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8717F394;
	Mon,  2 Sep 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278200; cv=none; b=I1pSltAhKOcGmDHyYCl0woKz4SZaircHkKV9RSJQwHKcZufpwG0BM6QqU0qT0Z1nzB3nK7UjB6LobjljgPS7Vrzm6qUrsZAOCoogx3hZH4oAL7dxYG6U2wIEz6lj1pQ33ENmZcFOnzM5uaFKd9VlEOc9AiGoYaahRZRM8+Hw8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278200; c=relaxed/simple;
	bh=ogysHab2ITgzOya/rnTiaisDdPz2TDKDRj6Qyg5aZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyEf9lF36YdKML9vnaZpV8glEtsqFrz0zZKuh2wH8J8BfduWaevXO5MdNHmA5L19Wo/n6sTFUqlgglml+ROAn8KD+L4KisETatcHwp/Ej6zGC36u0X9oherGRS2+vdGhsP6TDgZnOsgCvF9qgiaK4WXQsETFww+QxcMq9g+9/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRPfPhmH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRPfPhmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725278199; x=1756814199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogysHab2ITgzOya/rnTiaisDdPz2TDKDRj6Qyg5aZX8=;
  b=mRPfPhmHVk0TI7lvVe29QsuMXxknM4EcSmYJuzJs3mbYJTzLffh5R0CR
   XaW+LhMxkJesS05DCbEbN63rPgFtl0QQeSwzTDTphouJqjSzYCulDzIwg
   8KTT86iRw69ATs4Kh5/ea7wabMjfe6XmHEfTbCxql+8Gu+GS+K05gfWB2
   gJj4Iutbj2nwCuKNR+31bAd5dSFJ1TwenijRmVznF/b2J3TmPSWT4+aGh
   U1fNM89ZYEoBZBC9SigvTpYKTN91axnAKM0OjNePqKdF4imTRyf2a7CLQ
   hgw/xIKpLGU7jXFBwAjioAFz7ziC6PnOoKC1WqMW+Nu18wlu+n2nZrX1N
   Q==;
X-CSE-ConnectionGUID: JvOBvFZ0SD+i/ktyMk3L6Q==
X-CSE-MsgGUID: aebszWPSTdqg99TQbEiuYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23987189"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23987189"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:56:38 -0700
X-CSE-ConnectionGUID: xP2f3aSMTxK5usDCHVOtFA==
X-CSE-MsgGUID: E6BWlAkmSVuMuhjtsQmyjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64946399"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:56:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5fa-00000004LiE-2WFN;
	Mon, 02 Sep 2024 14:56:30 +0300
Date: Mon, 2 Sep 2024 14:56:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
Message-ID: <ZtWn7rVhwcOUwvfM@smile.fi.intel.com>
References: <20240816020723.771196-1-ying.huang@intel.com>
 <66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y14wj4ju.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66c69470ae357_7605294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87r0a2g64n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0a2g64n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 10:07:52AM +0800, Huang, Ying wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> > Huang, Ying wrote:
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >> > Huang Ying wrote:

[..]

Looking at how many troubles touching kernel/resource.c may lead to, here is
the question(s):
1) do we have a test cases in general for this library?
2) can this change be coupled with an addition/update of the test cases?

-- 
With Best Regards,
Andy Shevchenko


