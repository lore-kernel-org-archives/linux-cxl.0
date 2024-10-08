Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF213541B;
	Tue,  8 Oct 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415105; cv=none; b=LMfyVeA1UuK3c0tsRqxKaGPj+OB9KJdmzpdXrH3cLp734XDSQriqz3sJePVKXxEP7YKxeWUjYO2RILVNppFPyO/PMtxKJe29huOax1ZworcEZfcZF6PL67NbR03hlI/B2ZegsLT1v+2gYjuXUigUfrs8uvHJtq804MbHVE+ATRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415105; c=relaxed/simple;
	bh=uFg0S2Rr8P1/EgjOYhVKli1cEC4yWKwNsV71L1XmBLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaFAatrlztjtfSdUSV7Wimr1rh9iF7oP6yvxlPKxadDgVM368r3TUNrhWPgxGkbBi+4x6Yf0qkg38txb38SgnaXDEFFpWGVLGAlRsl8IB30AwfVppv3qomjLT+IH5NTyiDIyoJRF1uBmaNyMyZy4Jv1PlieAe8JVa7rrz3A9CXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2onej86; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2onej86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728415105; x=1759951105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uFg0S2Rr8P1/EgjOYhVKli1cEC4yWKwNsV71L1XmBLo=;
  b=O2onej86+PDW7zn3tPSzF3WwRWm9VGuYeYgOZkGVnDZTZN8J3j9vXoli
   285BjQcqVUy4knpdG5YH1EzKJa7EWypIHbJCfXDkQAlYpCy/k7SbxtB3V
   odE3Dkoc8PePZsWC8X1mB53mU2r5DzHKmhRXZLifZlXWiRKR4QZsgquXz
   x4dM7NH+UqbJrhkIJkOtuC5qDaEsQ3Rtzpy1csGy7k+VYc5Oz00ry4BBv
   tZRTvenYyI82tHk7e0IwX+aB1RWMHc75xCLHzgHRgOsQDnu3lMiCQgIes
   tvn832EiVphfGeQ+Fs/sTM5Qbxmdhii0yvUFJXNdg6t6aOpzai/E0HHkm
   g==;
X-CSE-ConnectionGUID: UHWIvBLoSm6VPUdJOrGZcQ==
X-CSE-MsgGUID: XkZ7s2W4Sw+E1yZVm9uNKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45118030"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="45118030"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:18:24 -0700
X-CSE-ConnectionGUID: yscp/KodTgWankHwH43E2w==
X-CSE-MsgGUID: eH8ygnYYSV677NcO4QOnSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80742690"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2024 12:18:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 906BE26B; Tue, 08 Oct 2024 22:18:18 +0300 (EEST)
Date: Tue, 8 Oct 2024 22:18:18 +0300
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
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Philip Li <philip.li@intel.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <ZwWFeo1zV4JGpTLw@black.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwPsYqkLF0eWUb9e@smile.fi.intel.com>
 <871q0rnw6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwVlZROV84DDMCnc@black.fi.intel.com>
 <670581c5e7e_174cb329467@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670581c5e7e_174cb329467@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 12:02:29PM -0700, Dan Williams wrote:
> Andy Shevchenko wrote:
> [..]
> > We have all tags and MAINTAINERS database. How do you know if those who
> > are in the Cc list are really interested in receiving this? What make me
> > sure is to have Author of the culprit commit, relevant mailing list and
> > maintainers, also reviewers and testers, if any. All this information is
> > available without Cc list. But if you *really* want it, you should
> > follow the Link tag (for the new commits, for the past ~2+ years) and
> > harvest it there. And actually I use that Link to reply to the thread
> > directly. So, again, the Cc list in the commit message is a historical
> > burden that consumes a lot of time and energy and should be gone in the
> > future.
> 
> Andy, this debate is consuming more time and energy than any amount of
> trimming Cc: lines from commits could save.

Okay, okay, I'm giving up...
...with a thought that this planet is doomed.

-- 
With Best Regards,
Andy Shevchenko


