Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B825A2C2;
	Fri, 14 Feb 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548203; cv=none; b=ktZRA4t7wU9YEaWUIVN+LpDapG1lR0SO/09rVMu9d7CAplozA2xuw33oRqfATZmQfJfASPb9N34JKAiTNBGRWQ4MyQTe6OuLfd3009LYVtqRT/pkdJCDImGFEDFXHWCc+XoCMbdMo4t2lLfjt2yryei6V/uHL+2GFRll1hrnopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548203; c=relaxed/simple;
	bh=bVS0iV2eZqMxVSCplFTRbZw0fu/mH0w4L9OzNH7NcV8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KInLycG1cE1iUGz+twVi6PfBxRsYFt13u2jdEakFT9HikGBXhgImABi28oTEO3/4SRA0JSG757N2EgGBZU/L4Bccq5HeGvayAY90QdnbmW5+Iqy5tbReL2G2CXWQ4o0J/XX/YGveYjozVe0vbM+COEkvnLhqShbaPxBRbkFZtuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvbz50ZJ1z6H7Rh;
	Fri, 14 Feb 2025 23:47:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AFD2140390;
	Fri, 14 Feb 2025 23:49:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 16:49:56 +0100
Date: Fri, 14 Feb 2025 15:49:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <20250214154955.00006b0c@huawei.com>
In-Reply-To: <Z60-UF3VGPsyqHjX@rric.localdomain>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-4-rrichter@amd.com>
	<20250212180910.00005839@huawei.com>
	<Z60-UF3VGPsyqHjX@rric.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Feb 2025 01:35:29 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 12.02.25 18:09:10, Jonathan Cameron wrote:
> > On Tue, 11 Feb 2025 10:53:33 +0100
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > The comment applies to the check, move it there.  
> > 
> > I think I disagree. It was in the right place as far as I can tell.
> > It is an odd place for comment, but it's kind of describing
> > why it is not an error to get down there.  
> 
> Ah, that was not obvious to the reader. :-)
> 
> >   
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > Tested-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/cxl/core/pci.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index f8e22bc278c3..c49efc419285 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -419,6 +419,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> > >  	if (!hdm)
> > >  		return -ENODEV;
> > >  
> > > +	/*
> > > +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> > > +	 * [High,Low] when HDM operation is enabled the range register values
> > > +	 * are ignored by the device, but the spec also recommends matching the
> > > +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> > > +	 * are expected even though Linux does not require or maintain that
> > > +	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> > > +	 * Decoder Capability Enable.  
> > 
> > This check is about mem_enabled. Would be fine to add another comment here to
> > say.  
> 
> The next patch extends the comment for more clarification (I hope so).

Not to me.  It says 'else' when referring to what happens in the if.

> 
> > 
> > 	/*
> > 	 * If mem_enabled is not set prior configuration is irrelevant and we
> > 	 * can do what we like so enable HDM decoders and ignore DVSEC registers.
> > 	 */  
> > > +	 */
> > >  	if (!info->mem_enabled) {
> > >  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> > >  		if (rc)
> > > @@ -454,15 +463,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> > >  		return -ENXIO;
> > >  	}
> > >  
> > > -	/*
> > > -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> > > -	 * [High,Low] when HDM operation is enabled the range register values
> > > -	 * are ignored by the device, but the spec also recommends matching the
> > > -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> > > -	 * are expected even though Linux does not require or maintain that
> > > -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> > > -	 * Decoder Capability Enable.
> > > -	 */  
> > 
> > This is the path the comment is talking about because only if we get to this
> > return path are we 'skipping' the HDM decoder capability and not returning
> > an error.  The path representing an HDM decoder equipped device that
> > was configured by a BIOS that decided to use the DVSEC registers.
> > 
> > I'm not sure why we care about how the hdm decoders are programmed inthis
> > case though.
> > 
> > I'm confused :(  
> 
> There is an HDM, but it is disabled (CXL_HDM_DECODER_ENABLE is
> cleared). If the DVSEC range regs do not have valid values
> (!info->mem_enabled, firmware indicates it is not used), just go and
> enable the HDM.
> 
> We try to use the hdm decoders here to be able to use them for a
> non-auto setup. Else, decoder emulation is used
> (should_emulate_decoders()) and decoders are locked
> (CXL_DECODER_F_LOCK will be set).
> 
> Maybe take a look at the whole change with added comments including
> patch 4/18?
> 
> I hope to not add confusion here. :-)
> 
> -Robert
> 
> >   
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");  
> >   

