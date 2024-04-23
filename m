Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01341C2A1
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890273; cv=none; b=TRJohZpmcvaMRMF0IBJnZuWdmfv3Gb4tUTaJGw6BrSus+XCxx94XmEtthFLjVNYxKXM2SL2B2tbrCq5esBveR6tSloPVdg75bSM2YGbVVLzJ90DolAJZW7OC7BR95wyeTcQggJC4yx8ZUH9Pevhsp0HwCGcSeQ2WSLvpxdFu8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890273; c=relaxed/simple;
	bh=p+wbQj3oBiFOC63dVf+nnEcy1Uopgjz0R/HVc1wjpA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q99BGDks+69DRALlPtcBbkHZh7SuHenbM8HxYffR2YRDlWfVpXOPy5XfAmri4vI+xzsLysV89p9rxxDeXjv0WUDn2UybAWVHMS8i5AHBhkL6TlLLzkMMqxJuRgT9bzvuniM3bdNqCEu+6oGXWeWqbZko1iX2yxivl9QQ5Ows/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noH36Wi4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noH36Wi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713890272; x=1745426272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p+wbQj3oBiFOC63dVf+nnEcy1Uopgjz0R/HVc1wjpA4=;
  b=noH36Wi45+dq8xzme5Lc67bX3DhDbaSog3YLtihlkEBfeEqe0qsR8bDW
   1VXO0ZzngAA+5AOe1huxdN887p7XqxNic6xMuBrp1an5lNikgZlDmevt5
   CL4z50dia8wd0uXWzqzi3X/rXZpKkcgzsgof1zxj3VbT++UKsFMYmNhaS
   VI699TsFL3u0RQROg6TmHN0McjceqPUDglw7MWKF/KiYEnBQEsAv9IqYh
   VubgWzvCpXY288UhZbUmwdynn/AJNG8Ex7HnbvwbW9uXtAEjLb2Ye1ot6
   PuTu+7wcreVhU8O9qJuLgP4dk81HRu2zbtSFcGElGki+f3tiiMvtDjzvQ
   g==;
X-CSE-ConnectionGUID: yKo942TSTDmTOKg1LI5Opw==
X-CSE-MsgGUID: ZcJc+hO+SRKiRw7KzZEFvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9652013"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9652013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:37:51 -0700
X-CSE-ConnectionGUID: YPblPD58Q/OhcFc/wcRquQ==
X-CSE-MsgGUID: JhaStYOQTNiHeHW9L90TZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61875148"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.29.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:37:51 -0700
Date: Tue, 23 Apr 2024 09:37:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <Zifj3Y9not9qNc8+@aschofie-mobl2>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
 <662737c4b3e7_bd77929478@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662737c4b3e7_bd77929478@iweiny-mobl.notmuch>

On Mon, Apr 22, 2024 at 09:23:32PM -0700, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> 
> [snip]
> 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 161bdb5734b0..2e24364b2b8d 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -14,6 +14,28 @@
> >  #include <cxlmem.h>
> >  #include "core.h"
> >  
> > +#ifndef __CXL_EVENTS_DECLARE_ONCE_ONLY
> > +#define __CXL_EVENTS_DECLARE_ONCE_ONLY
> > +static inline
> > +void store_region_info(const struct cxl_memdev *cxlmd, u64 dpa, uuid_t *uuid,
> > +		       u64 *hpa)
> > +{
> > +	struct cxl_region *cxlr;
> > +
> > +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> 
> This would normally be:  (somewhat nitty though...)
> 
> 	if (!cxlr) {
> 		uuid_copy(uuid, &uuid_null);
> 		*hpa = ULLONG_MAX;
> 		return;
> 	}
> 
> 	uuid_copy(uuid, &cxlr->params.uuid);
> 	*hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> }
> 
> But in this context I don't think it is critical.

Thanks for pointing out. When I switch to inline I didn't
'see' that. I'd like to fix it up. Let me see what else 
comes in.

--Alison

> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> 
> [snip]
