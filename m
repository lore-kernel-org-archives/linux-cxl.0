Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F1DC433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 19:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKCTvh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCTvg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 15:51:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E41E3D8
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667505095; x=1699041095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RvRUbkSRFBVUM5JyBvla2L5H0XGb+q/bPnzMAdRnbvo=;
  b=eJXZuLu824NJ2O4+gN0UGBiD5VX+4RPyGjmpNVocO0KcdnrNByvzYQFy
   vlq6qmrlSk/ajDFBWtNUQVLMBCHiFyrOmxN1jtsNN5dxAUr3XSDCQa3cZ
   0PQN9ld42aLg/0LkN82AmJSyMXIBo7M2gr2pK53BgYomMeMv/avzqPKJi
   xr2xV9sFBx0spnzy8V2roXgylVLcRk2i5nfbs9dOAMd2nLeuN/4oU1HK4
   EmhUSVpPOgGN9RuAJlorPjo89wmz6JCxhF/ehUkHR8cRQY3inFFS2J2Gu
   cQc+QpcJ0xucnoysQ60yMZS1ztZRgSIs5APR2CoKS/KaTYl9fvXvIWQRA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308504382"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="308504382"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 12:51:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="777438044"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="777438044"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.164.233])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 12:51:34 -0700
Date:   Thu, 3 Nov 2022 12:51:32 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 1/3] For ACPICA: Add the CXIMS structure definition to
 the CEDT table
Message-ID: <Y2QbxKMi9uIgYjvC@aschofie-mobl2>
References: <cover.1666841669.git.alison.schofield@intel.com>
 <a8832a0e46cad02e76648cc79181392113dabcf7.1666841669.git.alison.schofield@intel.com>
 <20221103180248.00007989@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103180248.00007989@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 03, 2022 at 06:02:48PM +0000, Jonathan Cameron wrote:
> On Wed, 26 Oct 2022 21:07:41 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > A linux-ized ACPI patch is included here for reference. The ACPI
> > pull request has been merged and we expect the upstream version
> > shortly. https://github.com/acpica/acpica/pull/795
> > 
> > The CXL XOR Interleave Math Structure (CXIMS) is added to the
> > CXL Early Discovery Table (CEDT). This new structure is defined
> > in the CXL 3.0 specification Section 9.17.1.4
> > 
> > https://www.computeexpresslink.org/spec-landing
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> One trivial comment.
> 
> Checked against spec and lgtm
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  include/acpi/actbl1.h | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index 15c78678c5d3..f96f4fe5328d 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -329,7 +329,8 @@ struct acpi_cedt_header {
> >  enum acpi_cedt_type {
> >  	ACPI_CEDT_TYPE_CHBS = 0,
> >  	ACPI_CEDT_TYPE_CFMWS = 1,
> > -	ACPI_CEDT_TYPE_RESERVED = 2,
> > +	ACPI_CEDT_TYPE_CXIMS = 2,
> > +	ACPI_CEDT_TYPE_RESERVED = 3,
> 
> Whilst I struggle to see the point of this RESERVED DEFINE it's almost in keeping
> with other similar definitions.  However they do have comments to say
> that /* 3 and greater are reserved */ and the comma isn't present
> as these are guaranteed to be last element.  Probably want to do the same.

Thanks Jonathan,

I see what you mean (now).
I think my best option here is to submit a separate (new) pull request to
ACPICA for the cleanup: remove comma and add comment.

FYI - The actual linuxized version of this patch, which grew to include
RDPAS is now available here:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=f350c68e3cd5ce605e44c7830029cd936a223f66

and was previously posted to linux-cxl as:
https://lore.kernel.org/linux-cxl/20220916232102.673102-1-alison.schofield@intel.com/

Alison

> 
> >  };
> >  
> >  /* Values for version field above */
> > @@ -380,6 +381,7 @@ struct acpi_cedt_cfmws_target_element {
> >  /* Values for Interleave Arithmetic field above */
> >  
> >  #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
> > +#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR	    (1)
> >  
> >  /* Values for Restrictions field above */
> >  
> > @@ -389,6 +391,16 @@ struct acpi_cedt_cfmws_target_element {
> >  #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
> >  #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> >  
> > +/* 2: CXL XOR Interleave Math Structure */
> > +
> > +struct acpi_cedt_cxims {
> > +	struct acpi_cedt_header header;
> > +	u16 reserved1;
> > +	u8 hbig;
> > +	u8 nr_xormaps;
> > +	u64 xormap_list[];
> > +};
> > +
> >  /*******************************************************************************
> >   *
> >   * CPEP - Corrected Platform Error Polling table (ACPI 4.0)
> 
