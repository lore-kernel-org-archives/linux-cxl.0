Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRshFSVz"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1DC138
	for <linux-cxl@vger.kernel.org>; Tue, 12 Dec 2023 13:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702415898; x=1733951898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViaVs4cr5GDr3HhDcQ6K8fZIPznYzJktyGi7b6yE5Mo=;
  b=nRshFSVzhFlZu4iej0SLN6ki3Id8WjqlsocfhF0pHkXRFicviB6o0vlE
   75Zjdaepqw5LDDCfEZngFfp4tXgvvrKqLQP19w7UJmdoD6e4+63eGqgt8
   zQo8kLH9KPzwEwRfOggjtI01UWsaMuwgYGDu66GbAFHhO1u2l+hSWO7xW
   AqckF/yBrsUf3AWRh8YWFIlbnSh7Jn5ef+bpMYASYTeGFeD5SxxPl3781
   UAmQ9PG+picKa5BX33o4oNoBEwIaZAgVb3+eSYH/Rn8Mu9OihOJdAngTx
   4t4fyzObKYLU2//w23W4KTJHqfbyyyGp8jubeHLXXsFPfPdMeKnL4ICEj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="393743570"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="393743570"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897058835"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="897058835"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.111.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:18:17 -0800
Date: Tue, 12 Dec 2023 13:18:16 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Add dev_dbg() detail on failure to
 allocate HPA space
Message-ID: <ZXjOGHLEYhvjoS+x@aschofie-mobl2>
References: <20231129003953.1252985-1-alison.schofield@intel.com>
 <656e80f2bb9f7_45e0129484@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656e80f2bb9f7_45e0129484@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Dec 04, 2023 at 05:46:26PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>

snip

> > 
> > 
> > Changes in v2:
> > - Improve the message text (Vishal)
> > - Add reviewed by tags (DaveJ, Vishal)
> > - Link to v1:
> > https://lore.kernel.org/linux-cxl/20231114040147.1124696-1-alison.schofield@intel.com/
> > 
> > 
> >  drivers/cxl/core/region.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 56e575c79bb4..ec792af873c4 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >  	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
> >  				    dev_name(&cxlr->dev));
> >  	if (IS_ERR(res)) {
> > -		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
> > -			PTR_ERR(res));
> > +		dev_dbg(&cxlr->dev,
> > +			"HPA allocation error:%ld for size:%#llx in %s %pr\n",
> > +			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
> 
> I notice that this did not pick up Vishal's suggested "error (%d) ..."
> style for conveying the error code.
> 
>    "HPA allocation error (%d) for size: %llx in %s ..."
> 
> I prefer that style as well.

I should have said something in the changelog. I rejected the
parentheses based on this: 

"Printing numbers in parentheses (%d) adds no value and should be
avoided."  in Documentation/process/coding-style.rst

Since it's a dev_dbg() msg I'll go ahead and add those parens.
(But this is not a precedent for parens all over ;))

Alison

