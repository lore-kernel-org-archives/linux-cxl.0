Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB2286B6
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsZaFm7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704389764; x=1735925764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rclrex4AODSml36s6an3Y2FtDeBlQ7CoAwnRcRqpD2A=;
  b=bsZaFm7JluTXOJgK3C1IrpXXs5NwD9qVczb6hrfqqutKxNbMR6boR9LT
   Sao1shC9lgAqrj64Z44BdKEYNl1Il9EBiFZxmxZ2jjFfK9ZdFpiw99b3I
   4wTLDUajb5vUfbLyMVGskXB79fNr8a8J1qdoxvC3SJ1yBSJ+EIM7bAgw8
   w+vYQYOQv7iz5mngQ3T7ki+X1KldZDr5sT95iq8f7aWbqcfoFu2W2pifB
   E1S3mhjBRmuvlbwUh6t5JWTJERSrXyzsUJUd1pNFB7Q3zpe/KCQ+mOE1B
   1QwPjgwOWwurYBwrNCnby4hgXW8y1xjXhle79HxK+XHeahkB/3Z3gr8aI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401100337"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="401100337"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="14971682"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.206.13])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:36:03 -0800
Date: Thu, 4 Jan 2024 09:36:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Message-ID: <ZZbsgXH8n7HgJ23N@aschofie-mobl2>
References: <CGME20231204193337uscas1p24b1959cf528b02b8172736a61807fff1@uscas1p2.samsung.com>
 <170171841563.162223.2230646078958595847.stgit@ubuntu>
 <65965214f008e_8dc68294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <ZZbgewv5l5LMmrTk@ubuntu>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZbgewv5l5LMmrTk@ubuntu>

On Thu, Jan 04, 2024 at 04:44:57PM +0000, Jim Harris wrote:

Hi Jim,

Looks really useful, cutting to the part about the individual unit tests....


> > > 4) Improve cxl_region tests to cover error conditions and add extensive
> > >    comments explaining how the topology is being built. This overlaps with #3.
> > 
> > Some comments on the simple tests would help too just to get folks
> > ramped about what's going on.
> 
> Ack. The comments are absolutely critical and I should have added them in the
> v1. They'll be in the v2.

As you might imagine, the first thing I'd like to do with this is try
to spin up a simple unit test that matches something I do with cxl_test,
then grow from there.

Coming to this with cxl_test experience, it would be helpful if you
can draw, comment on some parallels - even to the point of showing,
here' what cxl/test: cxl-topology.sh (or similar) looks like in CUunit.

It would be helpful to separate into multiple patches showing what needed
to be done to add a specific unit test. I'm assuming to add core_region_ut.c
support was added elsewhere in cxl/uunit/*.  Separate patches would make
that dependeny clear and help in mimicing the process of adding a new
test.

I'll try it out on next posting!
Thanks,
Alison

> > 
> > > 
> > > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > > ---
> > >  tools/testing/cxl/uunit/Makefile             |  141 +++++++++++
> > >  tools/testing/cxl/uunit/app/core_hdm_ut.c    |   82 ++++++
> > >  tools/testing/cxl/uunit/app/core_region_ut.c |  237 ++++++++++++++++++
> > >  tools/testing/cxl/uunit/include/post.h       |   21 ++
> > >  tools/testing/cxl/uunit/include/pre.h        |   22 ++
> > >  tools/testing/cxl/uunit/stub.c               |  335 ++++++++++++++++++++++++++
> > >  6 files changed, 838 insertions(+)
> > >  create mode 100644 tools/testing/cxl/uunit/Makefile
> > >  create mode 100644 tools/testing/cxl/uunit/app/core_hdm_ut.c
> > >  create mode 100644 tools/testing/cxl/uunit/app/core_region_ut.c
> > >  create mode 100644 tools/testing/cxl/uunit/include/post.h
> > >  create mode 100644 tools/testing/cxl/uunit/include/pre.h
> > >  create mode 100644 tools/testing/cxl/uunit/stub.c
> > 
> > This overall looks promising, the tools/build/ question might be the
> > only consideration for merging in the near term.
> > 
> > Some inline comments below:
> > 
> > [..]
> > > +
> > > +	CU_ASSERT(add_hdm_decoder(&port, &decoder, targets) == 0);
> > 
> > Likely wants some commentary on why it is ok to pass uninitialized stack
> > variables into add_hdm_decoder().
> 
> Ack.
> 
> > > +}
> > > +
> > > +static void
> > > +cxl_settle_decoders_test(void)
> > > +{
> > > +	struct cxl_hdm hdm;
> > > +	char _regs[0x200];
> > > +	void *regs = _regs;
> > > +	unsigned int msecs;
> > > +
> > > +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(0)] = CXL_HDM_DECODER0_CTRL_COMMITTED;
> > > +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(1)] = CXL_HDM_DECODER0_CTRL_COMMITTED;
> > > +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(2)] = 0;
> > 
> > Can this be made to look more like idiomatic kernel code? E.g.:
> > 
> >     writel(val, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(x))
> > 
> > ...so that code sequences can be copied from the driver into the tests?
> 
> Ack.
> 
> > > diff --git a/tools/testing/cxl/uunit/app/core_region_ut.c b/tools/testing/cxl/uunit/app/core_region_ut.c
> > > new file mode 100644
> > > index 000000000000..770ec200c87f
> > > --- /dev/null
> > > +++ b/tools/testing/cxl/uunit/app/core_region_ut.c
> > > @@ -0,0 +1,237 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "pre.h"
> > > +#include "drivers/cxl/core/region.c"
> > > +#include "post.h"
> > > +#include "../stub.c"
> > > +
> > > +#include <CUnit/Basic.h>
> > > +#include <stdlib.h>
> > > +
> > > +DECLARE_RWSEM(cxl_dpa_rwsem);
> > 
> > This is here because core_region_ut.c is not allowed to use stubs
> > core_hdm_ut.c?
> 
> Correct. This will be fixed in v2 with the changes I referenced above.
> 
> > > +	resource.start = 0x1000000000;
> > > +	resource.end =   0x2000000000;
> > 
> > Spotted this just because of the recent debug adventure here:
> > 
> > http://lore.kernel.org/r/6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.com.notmuch
> > 
> > ...where that resource.end should be the exclusive "end" of 0x1fffffffff
> 
> Ack.
> 
> > [..]
> > > diff --git a/tools/testing/cxl/uunit/include/post.h b/tools/testing/cxl/uunit/include/post.h
> > > new file mode 100644
> > > index 000000000000..231f5bc15c3a
> > > --- /dev/null
> > > +++ b/tools/testing/cxl/uunit/include/post.h
> > [..]
> > > diff --git a/tools/testing/cxl/uunit/include/pre.h b/tools/testing/cxl/uunit/include/pre.h
> > > new file mode 100644
> > > index 000000000000..1eb88e51740f
> > > --- /dev/null
> > > +++ b/tools/testing/cxl/uunit/include/pre.h
> > 
> > These last 2 files look like a lot of hard fought meticulous magic,
> > hence the question above about expected ongoing maintenance burden.
> 
> See above. But some extra comments around this wouldn't hurt - I'll add that
> in v2.
> 
> > > diff --git a/tools/testing/cxl/uunit/stub.c b/tools/testing/cxl/uunit/stub.c
> > > new file mode 100644
> > > index 000000000000..208dab1e7d6d
> > > --- /dev/null
> > > +++ b/tools/testing/cxl/uunit/stub.c
> > 
> > It might be worthwhile to let clang-format do a once over on this and all
> > the other files if only to keep the automated coding-style bots from
> > tripping on these files.
> 
> The formatting is horrible. I need to clean this up and will run clang-format
> before sending out the v2.
> 
> -Jim
