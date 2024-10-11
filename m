Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223F210C11;
	Fri, 11 Oct 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643902; cv=none; b=kQgWSpNtlaGf2lbPNlP/eUvQn1n7wUPu3qsutUSZMdQA2W2JzFawEEW7oOdVmu+69Rf1i3BWrC7NxTh5uVV6Ia3WchZ77MPcQBJNg709rt7EW+VLvhRdRtjHqZj+7nwf/mKgRGBU9sawYm10gwrc6xtB4COTXRYbCjMP2Xz5UDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643902; c=relaxed/simple;
	bh=xK+rYngvYiUscTEdDy+/rpHpRK/7KxHf7CjQU9W/Ctg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8O9ss3wepCIHlzgW7aVeQqphrwzcr4vWy85KVu2QZLhiwaSHt7pJHeWtZgvFwD3BCNs0jdwCwsKVjRgAM1clbWZUTnzHudxHxEFnzQs2mmiXa45+2oJAqw58L1emxV1mIvtdw0GAwZcutsryu1pB4sSr2fQT99FkqiOgopnZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxdqiQW3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxdqiQW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728643901; x=1760179901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xK+rYngvYiUscTEdDy+/rpHpRK/7KxHf7CjQU9W/Ctg=;
  b=YxdqiQW35dKX+Flb6Wfg5aF34r3syPAvD8ZMlUe93BCQ44eVnFSJTFaZ
   zaRFO2EJWgr7E0TUHvKedqkFxYzORpibmZziOCWrJ/Dzy7SDUz62rjq4Q
   MsCSx+8XANqbUcMzEoLbtZPnOMmrxI9Q05Ho6jAcQ4pQbeS5MAFJpdPah
   JcRyQXONOAp6rnOOJHoMz/DujqgIb3Ax86Aq8Nkn+Zk12fjSptxpV6o/E
   Zui3TkDREtGVB2Dyst4enz1UyV8shBrUrH0PdLZ2dBL2eiSpmhEZTEmnV
   Hl/r7jQoWG5p6+f4Em1d++wofcL6yH6XLdag/tdL0Q41nBwD93wkZ7+Qk
   Q==;
X-CSE-ConnectionGUID: 08h0DepTSZaN4GQdMj6X8A==
X-CSE-MsgGUID: VUHMgM/KTGaabe+GpTB8Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38608912"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="38608912"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:51:40 -0700
X-CSE-ConnectionGUID: YZEE/DDDRvCYyPmjwCU96w==
X-CSE-MsgGUID: gOb3QGdsSP2kehfJDhTsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76533250"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:51:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDF7-00000001rgN-3fjH;
	Fri, 11 Oct 2024 13:51:33 +0300
Date: Fri, 11 Oct 2024 13:51:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <ZwkDNVhg495XmoPV@smile.fi.intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <38566dbf-1293-4fd5-9cbd-385e6c35344c@redhat.com>
 <87zfnb81pi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfnb81pi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 04:48:25PM +0800, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> > On 11.10.24 03:06, Huang, Ying wrote:

...

> > And just I understand what we want to achieve: we want to walk the
> > subtree below "root" and prevent going to root->sibling or
> > root->parent if "root" is not actually the "real root", correct?
> >
> > X
> > |--------|
> > A----D   E
> > |
> > B--C
> >
> > So assume we start walking at A, we want to evaluate A,B,C but not D,E,X.
> >
> > Does that sum up what we want to achieve?
> 
> Yes.

Can this explanation be added to the commit message of the next version of
the patch?

-- 
With Best Regards,
Andy Shevchenko


