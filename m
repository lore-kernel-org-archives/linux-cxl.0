Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCbgeWpM"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DC102
	for <linux-cxl@vger.kernel.org>; Sun, 26 Nov 2023 16:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701043582; x=1732579582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PbEJ0xvaA5mauqkjMoqMq3zOkKe+Rwrq5we7OfKeicw=;
  b=FCbgeWpMVBgQ7YPc3dUfMiuwObSGcsbww8vA7GJYyRyOF92vADyDwjkP
   9vt7EFdQipOdSBu8TeQf+IYxNNwnfrlF4EPCEpjsH8AdaYGbmndQcuaPU
   ZhOBcl/z7+HsnD3tG7LJ/kYRG7WcFCnPW87W33wYiHEeBzQN5qaJjOKWk
   HigI178BLA6YCd9d3F8U9bknVW35ReNq0k+IyQhLAuDZk0fsWkvxIE1a1
   QyCk4u3cTW5yKYQV0X/0hLEhUwI8k4N4rQx0qFP3MfIcfRi1bZyCk55t5
   JRjZedAz0DZgPSikhIDEsriScjTY41T9pB7oFilM219UjJEykvaptNkfy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391483191"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="391483191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:03:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="717875071"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="717875071"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.90.230])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:03:52 -0800
Date: Sun, 26 Nov 2023 16:03:50 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: Hold the region rwsem during poison ops
Message-ID: <ZWPc5gganv6rwvj+@aschofie-mobl2>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
 <655eaf7d73e_b2e82943a@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655eaf7d73e_b2e82943a@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Nov 22, 2023 at 05:48:45PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>

snip

> > 
> > 
> > Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
> > Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
> > Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
> > Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
> 
> I think this is an indication that the fixes would benefit from being
> broken up into at least 2 commits so that the specific side effect of
> each can be commented upon.
> 

Agree. I've split into 2 patches and expanded the impact in each commit
message.

> For example:
> 
> - Fix walking committed decoders in cxl_trigger_poison_list()

That's not where I found the lock issue. When walking committed
decoders, the region_rwsem was held. It is when we think there
are no regions mapped, and collect by memdev only, that I found
a gap.

> 
> - Fix walking dpa to region lookups in cxl_{inject,clear}_poison()

We're probably in sync here, albeit different words.

> 
> ...look like 2 separate topics in this combined patch.
> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/memdev.c | 18 +++++++++---------
> >  drivers/cxl/core/region.c |  5 -----
> >  2 files changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index fc5c2b414793..961da365b097 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -227,9 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
> >  	if (!port || !is_cxl_endpoint(port))
> >  		return -EINVAL;
> >  
> > -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> > -	if (rc)
> > -		return rc;
> 
> What the rationale for dropping interruptible, it seems appropriate here
> since this function is directly servicing a debugfs trigger and maybe
> someone gets tired of waiting.
> 

This one is the sysfs, not debugfs, trigger. They shouldn't get tired of
waiting as it is only reading static info - the existing poison list of 
the device.

However, I did put back the _interruptible...for now.

I am not clear on how it all trickles down if this gets interrupted and
need to understand that further. We are trying to maintain a poison
state, and prevent partial reads of poison lists. That is not part of 
this patch, so I will study that some more and come back at it if I 
still think it's an issue.


> > +	down_read(&cxl_region_rwsem);
> > +	down_read(&cxl_dpa_rwsem);
> >  

snip

> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2467,10 +2467,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
> >  	struct cxl_poison_context ctx;
> >  	int rc = 0;
> >  
> > -	rc = down_read_interruptible(&cxl_region_rwsem);
> > -	if (rc)
> > -		return rc;
> > -
> >  	ctx = (struct cxl_poison_context) {
> >  		.port = port
> >  	};
> > @@ -2480,7 +2476,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
> >  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
> >  					     &ctx);
> >  
> > -	up_read(&cxl_region_rwsem);
> >  	return rc;
> 
> This hunk deserves to be called out that region locking is being
> upleveled as part of topic 1, and this reinforces splitting the 2 topics
> into 2 patches.

done.

> 
> Keep the _interruptible versions throughout, if you want to drop
> interruptible that should be a separate follow-on behavior change patch.
> The need to keep _interruptible also obviates conversion to cleanup.h
> helpers for now.

done.
