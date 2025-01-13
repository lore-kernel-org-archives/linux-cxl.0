Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302213C8F3;
	Mon, 13 Jan 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786857; cv=none; b=rmwyeX8P2Ab1wWa9uHzEgKPw+4qFuSUaTxnMFz/5IIb1yh+8kgWKeAIyTD0B4W53dDF2mZ0/EjEeeEADexvCYmNfVFTxUg/ssDz8q3k+sgCFNkzVy0vTG6eQvhYiNjpOHVuzkmhezPLfv6kUYnJ5Ls0FOIfgUnyGbW0TQcpO1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786857; c=relaxed/simple;
	bh=PRaewmve395yrt562JUl2VMR5ixlBGmdgmNVberTV84=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJdBcvniuJdZomXSA0YPfNly6y7BKEC1cWdg+c8c3UTR2GG5L3RuDrwCqH6AIfbIdCKfvpHWeo5Npe67v6PWo45kGZ08GB6CmvI/syxb5tBB4uwRyREko11xzcGtf7oF8UZG+2kzh0wCI2SFIexlafHdOn32hFxBcxG0kRrL/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWynV6Hqpz6L4y6;
	Tue, 14 Jan 2025 00:46:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 28676140B39;
	Tue, 14 Jan 2025 00:47:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 17:47:30 +0100
Date: Mon, 13 Jan 2025 16:47:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 04/29] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <20250113164728.00005f40@huawei.com>
In-Reply-To: <Z31bizrgbgjj-RXG@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-5-rrichter@amd.com>
	<Z31bizrgbgjj-RXG@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 11:51:23 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Jan 07, 2025 at 03:09:50PM +0100, Robert Richter wrote:
> > There are various configuration cases of HDM decoder registers causing
> > different code paths. Add comments to cxl_hdm_decode_init() to better
> > explain them.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >   
> 
> This addresses some of my prior questions, but I still think this
> function is worth some extra scrutiny.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
Definitely an improvement.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c7050c13f71a..4d2154457efb 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -416,9 +416,17 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
> >  		return devm_cxl_enable_mem(&port->dev, cxlds);
> >  
> > +	/*
> > +	 * If the HDM Decoder Capability does not exist and DVSEC was
> > +	 * not setup, the DVSEC based emulation cannot be used.
> > +	 */
> >  	if (!hdm)
> >  		return -ENODEV;
> >  
> > +	/*
> > +	 * The HDM Decoder Capability exists but is globally disabled.
> > +	 */
> > +
> >  	/*
> >  	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> >  	 * [High,Low] when HDM operation is enabled the range register values
> > @@ -426,7 +434,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> >  	 * are expected even though Linux does not require or maintain that
> >  	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> > -	 * Decoder Capability Enable.
> > +	 * Decoder Capability Enable. Else, use the HDM Decoder Capability and
> > +	 * enable it.
> >  	 */
> >  	if (!info->mem_enabled) {
> >  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> > -- 
> > 2.39.5
> >   

