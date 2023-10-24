Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127C7E
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdiPJ2o1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968859B
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698108158; x=1729644158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yJlvYoUJ6EQ/vdentIJPxKseXgl/7upZnSJ5peaCLQ=;
  b=VdiPJ2o1wF3rPdu5i288NWLbD0uxJ0ebhFRSe/BsTX4JTbJKxxlmuuyt
   yfGOMU/2/q0wDr52JdBrG5xgOd/IelITXLmqTl3TrlkRv5ln5ixzmiyPz
   XlH7qmx4PlNBrrfbMySAvkDMoBzv2NsFdDH1z4o6htRlZIYYfZlRyhFSY
   g1wKlnwwl1lg73drSpG/sxrvOZvIJFPKXJhuPPcFD0xwCugrNvCVkfGS5
   lmm70Eg+JW2HkYFT42/Xb2lu4LjjS0V7NwfcNJEtHBL+bxXxe44MRl9NS
   KOTyp+vNf2KpFKTu0fXb5X9JPmUQLroZhV+kpXnFv4uwll8bYDPWir6Yi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="418082239"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="418082239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="787614396"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="787614396"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.152.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:42:37 -0700
Date: Mon, 23 Oct 2023 17:42:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 3/3] cxl/region: Use calc_interleave_pos() with
 autodiscovered regions
Message-ID: <ZTcS/BLCxw1hayJr@aschofie-mobl2>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <533d9fe49c10d7cb878ea9157232aaa5bb657ae0.1697433770.git.alison.schofield@intel.com>
 <6536ec70bc34_7258329498@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6536ec70bc34_7258329498@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Oct 23, 2023 at 02:58:08PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 

Dan, Picked up your changelog suggestions

snip...

> 
> Maybe a comment on the testing this passes, or the plan for keeping this
> algorithm regression tested?

Will add more info to v3 changelog:
Short answer: 
Passed cxl-test for the following configs:
1, 1+1, 1+1+1, 2, 2+2, 2+2+2, 2+2+2+2, 4, 4+4 
where each number represents the count of endpoints per host bridges.
ie. 2+2 is 2 HBs with 2 endpoints each.

I'm using a new unit test for this. The posting of which is lagging
this patchset a bit as it depends on kernel cxl/test changes to
support configurable topologies (so we can have all those flavors!)

>
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> [..]
> 
> Code looks good.
