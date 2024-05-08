Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A395382
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189419; cv=none; b=DAcXbVsWrodnGapHIYdgTtwMOx4mgv5by2a9z6kU0U/6rNCwLVjIdMiDjtf0KxbGV2m0TnzjbR3kSdSY9lEUBQy5UCkFqGi9zxTcXYZc8/Yigci84qsXElLY8p6V2V7uhWUYsQDR05WqsVmS8y1CSkE8tG8ygbZDMw9ED6Hevyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189419; c=relaxed/simple;
	bh=ldtoUbKs1VIWLZXhkulonRp5HO79Eih7S7QBqPi1KBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgYYoo7PIveZTzEXWVJYBxHngLcZPCpBND6IR6yGDeajD1cpTXJ/8gbtGxrzWSSwSM7kV6Grs56DbOBr2VfxK6+VvHODCYpplhr/cEn3sHSEp6ANCb4KxnHH+JdmIxw2DxKqdwoFKUfQAnNxay2jBsHrzKlybtJVXsQtSOlwzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp/2nFIl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp/2nFIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189417; x=1746725417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldtoUbKs1VIWLZXhkulonRp5HO79Eih7S7QBqPi1KBo=;
  b=fp/2nFIlJU7xmXekMD9b0QO8Mg+JiFHbKzS/a5KJ4GfkJC8d6L+4IINv
   xaSfw/dZJ7OCFy+onhAObaiPw2DeGO95cJMJt0fUOt5VkUAg6GScZMxBj
   lzoeyP/E8snxq00ZqGckws2p8KOFU4R1/cQTBjoOaWfcEviHaj0nCose3
   nTbdBIFcrYFe2XCsdVOgghwoSkltTzcMUFa1yziJuS13OfJXEGoYuNEl2
   KX6y7EOUE3pjJHY/q48niKRfZ/Ryv1czbDwWFGH/2H3z+ykyKvN6GfaS8
   seG0O+bP2H1Q9XzKPfHpOIsGlVpIN386glJ3+AIwMoNyMs/9JzNW9sHZB
   w==;
X-CSE-ConnectionGUID: d/BX4S+KQJSU+2HtyAyPmQ==
X-CSE-MsgGUID: IusLPTCnQnaNqrNV4+YdLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10908712"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10908712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:30:16 -0700
X-CSE-ConnectionGUID: Bu0+HrYST9ObTE0ENJAKUA==
X-CSE-MsgGUID: Fb4mcGRxRHm19bqoJ1D0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33514137"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.242.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:30:16 -0700
Date: Wed, 8 May 2024 10:30:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/region: Verify target positions using the
 ordered target list
Message-ID: <Zju2pg7I3AfrLfbk@aschofie-mobl2>
References: <cover.1714159486.git.alison.schofield@intel.com>
 <a5121a8d37dd62581015452a77113f88df2ede25.1714159486.git.alison.schofield@intel.com>
 <663177ea1ca3_10c21294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663177ea1ca3_10c21294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, Apr 30, 2024 at 03:59:54PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a root decoder is configured the interleave target list is read
> > from the BIOS populated CFMWS structure. Per the CXL spec 3.1 Table
> > 9-22 the target list is in interleave order. The CXL driver populates
> > its decoder target list in the same order and stores it in 'struct
> > cxl_switch_decoder' field "@target: active ordered target list in
> > current decoder configuration"
> > 
> > Given the promise of an ordered list, the driver can stop duplicating
> > the work of BIOS and simply check target positions against the ordered
> > list during region configuration.
> > 
> > The simplified check against the ordered list is presented here.
> > A follow-on patch will remove the unused code.
> > 
> > For Modulo arithmetic this is not a fix, only a simplification.
> > For XOR arithmetic this is a fix for HB IW of 6,12.
> > 
> > Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..3c20f8364b26 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1559,10 +1559,17 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
> >  				      const struct cxl_dport *dport, int pos)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> > +	struct cxl_decoder *cxld = &cxlsd->cxld;
> > +	int iw = cxld->interleave_ways;
> >  	struct cxl_port *iter;
> >  	int rc;
> >  
> > -	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> > +	if (dev_WARN_ONCE(&cxld->dev, iw != cxlsd->nr_targets,
> > +			  "misconfigured root decoder\n"))
> > +		return -ENXIO;
> 
> This is a nop because root-decoders by definition have all of their
> targets covered in the interleave, and the driver passes the CFWMS
> interleaves_ways setting directly to the @nr_targets parameter of
> cxl_switch_decoder_init().
> 
> So drop this warning, which in retrospect was never needed , and it all
> gets cleaned up in your next patch.

Got it.

> 
> > +
> > +	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> 
> Looks ok, but I don't understand why this patch is tagged as a fix?
> There should be no end user visible change of this conversion, right?

In the commit log I note that this is a 'Fix' for XOR, not for MODULO.

It is a fix for XOR because the previous calculation for the by 3's
can fail to find the correct Host Bridge position.

The diff belows shows the fix needed to properly mask the hpa prior
to the MOD 3 operation. (Described in Table 9-22 HPA[51:NIW+HBIG])

---
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..611e5b995d46 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -30,6 +30,7 @@ static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
 			  int ig)
 {
 	int i = 0, n = 0;
+	u16 eig;
 	u8 eiw;
 
 	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
@@ -37,11 +38,14 @@ static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
 		for (i = 0; i < cximsd->nr_maps; i++)
 			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
 	}
+
 	/* IW: 3,6,12 add a modulo calculation to 'n' */
 	if (!is_power_of_2(iw)) {
 		if (ways_to_eiw(iw, &eiw))
 			return -1;
-		hpa &= GENMASK_ULL(51, eiw + ig);
+		if (granularity_to_eig(ig, &eig))
+			return -1;
+		hpa = (hpa & GENMASK_ULL(51, eiw + eig)) >> (eiw + eig);
 		n |= do_div(hpa, 3) << i;
 	}
 	return n;
-- 

I guess in some cases the above patch may be easier to apply to
prior kernels but we really want to replace the mechanism as
'this' patch does.

-- Alison







