Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHa4CV1Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38169E6
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700091233; x=1731627233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=69m6d/50Y77JiFypgN0i4C0f+EQC+yhjyLyT775Uz2M=;
  b=VHa4CV1Yk6xL7RYKnBvvbEBJppcpAfJBhYU32m+yX9aOvAgqWIOsAsZq
   PdRJaQSHIcr34CYPczPhlwmNNZGLsNQCQvi6BbLIYKv+1MNfduMSpTpez
   YoWmwv3prqdAHqxSuvyCUmy9yJz+nG7UerNkrHItQeI0l2QsZSrWPCVKr
   GoHy35sI1FQap3P0sjZpn77fVXApK3SNzCcTjwVjSsLNNjHsbUXB4pHl0
   uWh7RKin1sXJXWWB1W4SsilkH0RrVo82p1UM+mq411QR/Bi0MwDLJ3XPR
   5LU6jNVLN7dXNLtqxu9qBMlwbWeVIqqrFmXttolYS15KBbXN1ooDBZ1D6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477195730"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="477195730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:33:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741580395"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="741580395"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.210.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:33:52 -0800
Date: Wed, 15 Nov 2023 15:33:50 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Add dev_dbg() detail on failure to allocate
 HPA space
Message-ID: <ZVVVXstwrcz9/1Nd@aschofie-mobl2>
References: <20231114040147.1124696-1-alison.schofield@intel.com>
 <0f1537ef6a0798d1f59a426834e035e122d856f2.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1537ef6a0798d1f59a426834e035e122d856f2.camel@intel.com>

On Wed, Nov 15, 2023 at 10:20:12AM -0800, Vishal Verma wrote:
> On Mon, 2023-11-13 at 20:01 -0800, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > When the region driver fails while allocating HPA space for a
> > new region it can be because the parent resource, the CXL Window,
> > has no more available space.
> >
> > In that case, the debug user sees this message:
> > cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34
> >
> > Expand the message like this:
> > cxl_core:alloc_hpa:555: cxl region8: failed to allocate HPA:-34 size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]
> >
> > Now the debug user can examine /proc/iomem and consider actions
> > like removing other allocations in that space or reducing the
> > size of their region request.
> >
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 56e575c79bb4..0e6a378f1913 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >         res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
> >                                     dev_name(&cxlr->dev));
> >         if (IS_ERR(res)) {
> > -               dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
> > -                       PTR_ERR(res));
> > +               dev_dbg(&cxlr->dev,
> > +                       "failed to allocate HPA:%ld size:%#llx in %s %pr\n",
> > +                       PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
> 
> Very minor, but the format of this print can make it seem like we're
> talking about HPA -34 instead of an error code of -34. Might be nice to
> take the chance to reword it to something like:
> 
>   "HPA allocation error (%d) for size: %llx in %s ..."

Yes - much clearer. Will do.
Thanks!


> 
> Other than that, looks good,
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> >                 return PTR_ERR(res);
> >         }
> >
> >
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> 
> --
> 
