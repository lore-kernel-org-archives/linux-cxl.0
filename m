Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4A3pBEj"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762429C
	for <linux-cxl@vger.kernel.org>; Mon, 20 Nov 2023 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700507234; x=1732043234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rYAiulsBubaVNNxZkgoR5RJVwDadYxzPoLiBHNA7USw=;
  b=J4A3pBEjmznnSuc13avHXUGgPGoOvNXvcG1X0JI3jfLFahl3d+yWABrM
   HKsiFu1RfMoakxRdJsFjpelSLDyDsZ8Wor3zdIi3/EsLBEoAl4yCS8wH5
   cQpvJAN9o/hxqS50RN9GiecDBbJnrsCT3gTN4BMNmAzlIpqBLUveOm1f1
   9SYanakkML+BXzxlY/Xb85lop1d1tKR1dMZnApWspqi27IHxN4MjilvFL
   7W3F8xgQAkUhuQYVaDLTm89sbKS1ZwnRI3olQT2nbsOOHDcjuOYkkU/bX
   iCQ0QP6EFPd33hfRgDdJsG+eAbrjhsjPuv4kkXjJauepZ6UxVBWfe/6qO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="477892777"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="477892777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 11:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="14667449"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.23.11])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 11:07:06 -0800
Date: Mon, 20 Nov 2023 11:07:03 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: Hold the region rwsem during poison ops
Message-ID: <ZVuuVwjmcIzPSmvX@aschofie-mobl2>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
 <tcc2pnjpfpn45nmc7vqgerm4pinjjx25j2dmcxeihoqdwjq2t4@3zk7uadynsoh>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tcc2pnjpfpn45nmc7vqgerm4pinjjx25j2dmcxeihoqdwjq2t4@3zk7uadynsoh>

On Thu, Nov 16, 2023 at 02:14:37PM -0800, Davidlohr Bueso wrote:
> On Mon, 13 Nov 2023, alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
> > added a lockdep_assert_held() to make sure all callers hold the
> > region state stable while doing work that depends on the number
> > of committed decoders.
> 
> Unrelated, but that kind of helper would be better as a static
> inline in a header file.
> 
> > 
> > That lockdep assert triggered in poison list, inject, and clear
> > functions highlighting a gap between region attach and decoder
> > commit where holding the dpa_rwsem is not enough to assure that
> > a DPA is not added to a region. In such a case, if poison is
> > found in at that DPA, the trace event omits the region info
> > that users expect.
> > 
> > Close the gap by snapshotting an unchangeable region state during
> > all poison ops. Hold the region_rwsem in all the places that hold
> > the dpa_rwsem rather than in the region specific function only.
> 
> Makes sense and lock oder is consistent with that of attach_target().
> I do think that the interruptible semantics should be kept considering
> this is from sysfs/debugfs.

Good eye, bad me!  It was intentional to remove the interruptible,
but I should have noted it in the commit log.

At the point the lock is taken, the driver is committed to completing
the action. It is not interruptible once begun. This notion of a poison
state was first introduced here:
d0abf5787adc ("cxl/mbox: Initialize the poison state")

The basic premise is that the driver will synchronize reads of poison
so as not to return incomplete lists.

> 
> Thanks,
> Davidlohr
