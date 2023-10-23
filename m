Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD58200AE
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkXUppXT"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C19C
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698103368; x=1729639368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qRAEqekCplNXryi5dEri9erTXOGrgJW8rcpyq1XvUXs=;
  b=CkXUppXTFJP6M4myvxHGsgbc/T6U7LvLAodl5j/ctDi/EicHcdsRs2ts
   z+VZtQ5OmJDFaXoTGUd8Pmmb40KEKJW6TaKwa1HfMPVKY/ue3ZJzMw3Go
   XyqfxsIuWVlICvx8UOt6MJ2VlfNzPIwZn2DuGv9AbE2+9GyUfNluMz2Lr
   Bpw0tT8il6fXaH5JfRMMgejDqu2bgtUWx9yPhla2dfqsbSx7LoILyiUaf
   TnXADr8aK7y/T4L/Zrr1kXszM4rJ1mswQktL/twSn1dySYNXMh0cuAL4T
   iESXiqAaIz0u4BTBzCk36b+slb+hlDd7uwYd+TAoThxPSFqSYdQCK/TxR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367176602"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="367176602"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="874857369"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="874857369"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.152.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:22:47 -0700
Date: Mon, 23 Oct 2023 16:22:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
 helper for reuse
Message-ID: <ZTcARXZ8E7SAMbWX@aschofie-mobl2>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <CGME20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5@uscas1p1.samsung.com>
 <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
 <CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>
 <BF2AFEEE-9A92-412E-A9D4-27D82EC6AB38@ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF2AFEEE-9A92-412E-A9D4-27D82EC6AB38@ssi.samsung.com>

On Tue, Oct 17, 2023 at 05:24:45PM +0000, Jim Harris wrote:
> 
> 
> > On Oct 17, 2023, at 9:20 AM, Jim Harris <jim.harris@samsung.com> wrote:
> > 
> > 
> > 
> >> On Oct 15, 2023, at 11:02 PM, alison.schofield@intel.com wrote:
> >> 
> >> From: Alison Schofield <alison.schofield@intel.com>
> >> 
> >> 
> >> -static int decoder_match_range(struct device *dev, void *data)
> >> +static int match_switch_decoder_by_range(struct device *dev, void *data)
> >> {
> >> - struct cxl_endpoint_decoder *cxled = data;
> >> + struct range *r1, *r2 = data;
> >> struct cxl_switch_decoder *cxlsd;
> >> 
> >> if (!is_switch_decoder(dev))
> >> return 0;
> >> 
> >> cxlsd = to_cxl_switch_decoder(dev);
> >> - return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> >> + r1 = &cxlsd->cxld.hpa_range;
> >> + return range_contains(r1, r2);
> >> +}
> > 
> > Hi Alison,
> > 
> > This stray closing brace needs to be removed from this patch.
> > 
> > Rest of the patch looks good, I agree the naming is much better with these
> > changes.
> > 
> > Reviewed-by: Jim Harris <jim.harris@samsung.com>
> > 
> 
> Looking at this again, I think this also needs to check if the switch
> decoder is active. Non-active decoders will have range 0 to UINT64_MAX
> which would pass the range_contains() check.

Combining this and Dan's input, changing this to check for an exact
match on the switch decoder, so not worry about the uncommitteds.


> 
