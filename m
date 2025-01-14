Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A222DC2A;
	Tue, 14 Jan 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853200; cv=none; b=CBCgsPDwjh30Vtqp88PKnQXntMXZxNb6RKTvFLoHiNAHBjkPoOKFFL1xalVDAib2TSRlWkmkxqU4iuUaQU0g3wl2ibGCmMzntPNz1bkt+3PCPRg4UXPfIIJgXiaEzg87yQCgrZ/YEyHTtDDaYiBJnPkMN36xLQuj+4sppWYLox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853200; c=relaxed/simple;
	bh=n8gPe1C7uZN7HdIXOKT8xet6RfMxJsLe/KSwAi9VgwE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPPhuG07KqlKNG2NDctXqo11rrvUdP0FhdF2GikAftR7I8YRceHH2gdxCNqQF4oEtZZdbxxTbcWdlj6dYob8gTwIh0wX4KU65RKwNGpYztaYbeMN4BVQTwhacJGA2ur9RGQvZoPMA2P6y2tvhwhwdbpfshT/iSxu40Se7pRitXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRFF1Cngz6K9HJ;
	Tue, 14 Jan 2025 19:08:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 50D3314039F;
	Tue, 14 Jan 2025 19:13:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:13:08 +0100
Date: Tue, 14 Jan 2025 11:13:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Gregory Price <gourry@gourry.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Terry
 Bowman" <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <20250114111307.0000028b@huawei.com>
In-Reply-To: <Z3-hlYh3voRFLG6o@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-26-rrichter@amd.com>
	<Z36eR5oXcv3rpEZ-@gourry-fedora-PF4VCD3F>
	<Z3-hlYh3voRFLG6o@rric.localdomain>
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

On Thu, 9 Jan 2025 11:14:46 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 08.01.25 10:48:23, Gregory Price wrote:
> 
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 901555bf4b73..c8176265c15c 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> > >  			    &cxl_einj_inject_fops);
> > >  }
> > >  
> > > +static void cxl_port_platform_setup(struct cxl_port *port)
> > > +{
> > > +	cxl_port_setup_amd(port);
> > > +}
> > > +  
> > 
> > Assuming this gets expanded (which it may not), should we expect this
> > function to end up like so?
> > 
> > static void cxl_port_platform_setup(struct cxl_port *port)
> > {
> > 	cxl_port_setup_amd(port);
> > 	cxl_port_setup_intel(port);
> > 	cxl_port_setup_arm(port);
> > 	... etc ...
> > }
> > 
> > I suppose this logic has to exist somewhere in some form, just want to make
> > sure this is what we want.  Either way, this is easily modifiable, so
> > not a blocker as I said.  
> 
> Yes, it is exactly designed like that. I will update the patch
> description.

If we need it on ARM then we might wrap this in an arch_cxl_port_platform_setup()
as never building a kernel that does x86 and arm.  Could rely on stubs but that
tends to get ugly as things grow.

Other than that, all makes sense.

Jonathan

> 
> -Robert

