Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1218035;
	Fri, 30 Aug 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000432; cv=none; b=f/bHUOyXibl2SP7t5749GJDRyg3WIR0ONHYWR2xUxlMGrOUXTPKKDXubirn0U2jlhnMZoiLaVvCqBCKk0Vk/reObDTqILI2Zylwl9t79Sicut4AikoBSGZNat5cyyyvmPPDFxrR/tqtQvqUxlatpcCuTt00JAXNiWeVI8ma7BzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000432; c=relaxed/simple;
	bh=9u2NqNAZxyH1bxD3bDF0tMDXFzDorwQV4MNtYJzaT4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQiYsYtBTeSlEdJkv9qLkSPkmsUxwxKFpfY8EunZX4FcxWbGzQTcpnfvVv9wapmNvio/ceMsEIeo8iOByiRJSGfBlrDsbZmKTOlkR+mPay70bqgjQ8jDSBK17ba9CXFYBSQufBN+4ThqCfWezzc/CikQcouz4nfh+eV/xYlThQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RukbArmv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RukbArmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725000431; x=1756536431;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9u2NqNAZxyH1bxD3bDF0tMDXFzDorwQV4MNtYJzaT4E=;
  b=RukbArmv41jZwJFubau3oYT8vgSBAKiWi+yv8TsUL9YDOghFkz2tx90x
   5RVLTDXiyefvZ+U1sazxCeMcXbLrd2KY+lFSJpHBRxTj8YzMr0p5rq2TN
   EeBAHhfT2y3Un9Q/oHaeRFo8RIxle9IF6tzvm6pL3qOY9grlJhoEJOTzM
   6cs+VPX0KodFy/S2Hi7DdoIuy63ICeP72Fo8e03xOms3zpgdUee/CLXX5
   REdBH4ElAAJC3jJQkz1vNiyZKxO3vJiLZeTpT0Y0EIqiogsolqQRrXj3z
   9/F63CmSJG0+zh97F/QTFTYJLlgN2bmD705Q/ipXPY4ARYq1G4ZsYp5sT
   g==;
X-CSE-ConnectionGUID: YJ7pdPKCSZKytzRpyffFMw==
X-CSE-MsgGUID: FJaxjeqLSCy9YFGdNPK33w==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="13293383"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="13293383"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:47:09 -0700
X-CSE-ConnectionGUID: JCyq5GFqRwmdUMOVp3v6Lw==
X-CSE-MsgGUID: A5ioDctSRmeYvZMdNk8v6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68472946"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:47:06 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  David
 Hildenbrand <david@redhat.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Alistair Popple <apopple@nvidia.com>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
In-Reply-To: <66c697cf7b95a_760529414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Wed, 21 Aug 2024 18:43:43 -0700")
References: <20240819023413.1109779-1-ying.huang@intel.com>
	<20240821184615.GA262749@bhelgaas>
	<66c697cf7b95a_760529414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Fri, 30 Aug 2024 14:43:32 +0800
Message-ID: <87ikvih5nv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Dan,

Dan Williams <dan.j.williams@intel.com> writes:

> Hi Bjorn,
>
> Ying is out for the next week or so, so I will address your comments and
> resubmit as I think this is a potentially urgent fix.

Just come back.  Thank you very much for your kind help!

> Bjorn Helgaas wrote:
>> On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:
>> > On a system with CXL memory installed, the resource tree (/proc/iomem)

[snip]

>> > In the above resource tree, "System RAM" is a descendant of "CXL
>> > Window 0" instead of a top level resource.  So, region_intersects()
>> > will report no System RAM resources in the CXL memory region
>> > incorrectly, because it only checks the top level resources.
>> > Consequently, devmem_is_allowed() will return 1 (allow access via
>> > /dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
>> > doesn't allow to map System RAM and reject the access.
>> > 
>> > However, region_intersects() needs to be fixed to work correctly with
>> > the resources tree with CXL Window as above.  To fix it, if we found a
>> > unmatched resource in the top level, we will continue to search
>> > matched resources in its descendant resources.  So, we will not miss
>> > any matched resources in resource tree anymore.  In the new
>> > implementation,
>> > 
>> > |------------- "CXL Window 0" ------------|
>> > |-- "System RAM" --|
>> > 
>> > will look as if
>> > 
>> > |-- "System RAM" --||-- "CXL Window 0a" --|
>> 
>> Where did "0a" come from?  The /proc/iomem above mentioned
>> "CXL Window 0"; is the "a" spurious?  Same question applies to the
>> code comment below.
>
> Not sure where that came from, will clean up and provide a test that can
> upstreammed as well.

Sorry for confusing!  

>> > |-- "System RAM" --||-- "CXL Window 0a" --|

This isn't the real resource tree.  The real resource tree is still

>> > |------------- "CXL Window 0" ------------|
>> > |-- "System RAM" --|

While,

>> > |-- "System RAM" --||-- "CXL Window 0a" --|

is just used to demonstrate the effect of the algorithm.  That is, a
part of "CXL Window 0" is covered (or masked) by "System RAM" now.  The
remaining effective part of "CXL Window 0" is smaller, I used "CXL
Window 0a" to designate that it comes from "CXL Window 0", but it's not
exactly "CXL Window 0".

--
Best Regards,
Huang, Ying
