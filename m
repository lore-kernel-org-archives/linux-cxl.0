Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4272FFF8C;
	Fri, 19 Dec 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141396; cv=none; b=QbFLglPQfbD8xFbPavcuVUndtVmHuSfouB5bkP/jGjgFhEupMktkFirHHttLfNw9mG6GR0J0wBxTAP1Lyje+gXlG8GJTE7+oojmb+Krhd9jOBbjtWuyU7EsvBhB7SgKBiPBgMqPseznqTpUcc1Eykb2O/hj8PywDpJnDxqcTAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141396; c=relaxed/simple;
	bh=EA3AGVtIbx9eHxoEUqw+LqmUyI2twMThkPEvTDxdC14=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOZ8EaxWYp00JpKxxGM7nMXAuCSVuKe+GSSRD5x8BDSorbbCejeKwrWEOu8Hsv219+7d/k6cB8hKALMNIqNw/fdNczGPy/LmTvBX4C9JE/BvEWMAQjRCyAGUDwfBtBhzzt+OaNJ/O+aq+JCaIN39LPwbSacdnR6KoT/nrlXzWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXkmk5fPFzJ46nc;
	Fri, 19 Dec 2025 18:49:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 45F9A40565;
	Fri, 19 Dec 2025 18:49:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 10:49:42 +0000
Date: Fri, 19 Dec 2025 10:49:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <corbet@lwn.net>,
	<kernel-team@meta.com>, <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH] Documentation/driver-api/cxl: device hotplug section
Message-ID: <20251219104940.00004446@huawei.com>
In-Reply-To: <aUQllpH-4c2pGugv@gourry-fedora-PF4VCD3F>
References: <20251218144636.1232527-1-gourry@gourry.net>
	<20251218152616.00005b73@huawei.com>
	<aUQllpH-4c2pGugv@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:02:30 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Dec 18, 2025 at 03:26:16PM +0000, Jonathan Cameron wrote:
> > On Thu, 18 Dec 2025 09:46:36 -0500
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > Describe cxl memory device hotplug implications, in particular how the
> > > platform CEDT CFMWS must be described to support successful hot-add of
> > > memory devices.
> > > 
> > > Signed-off-by: Gregory Price <gourry@gourry.net>  
> > 
> > Hi Gregory,
> > 
> > Thanks for drawing this up.  
> 
> ack on most of your notes, discussion on platform/switch stuff
> 
> > > +CEDT CFMWS region with sufficient memory capacity to cover all future
> > > +potentially added capacity.
> > > +
> > > +Switches in the fabric should report the max possible memory capacity
> > > +expected to be hot-added so that platform software may construct the
> > > +appropriately sized CFMWS.  
> > 
> > How do switches report this? I don't think they can as it really has nothing
> > to do with the switch beyond maybe how many DSPs it has (which incidentally
> > is what is used to work out space for PCI HP where the code divides up space
> > left over space between HP DSPs.).
> > 
> > Obviously this excludes the weird switches that are out there than pretend
> > to be a single memory device as those are not switches at all as far
> > as Linux is concerned.
> >   
> 
> Good point - in reality, it probably should say something like:
> 
> ```
> A hot-plug capable CXL memory device should report the maximum possible
> capacity for the device in the CEDT CFMWS, rather than the CFMWS memory
> region to the capacity present at boot time.

Might want to broaden to "the device or possible hot replacements"

> 
> To support memory device hotplug directly on the host bridge (or on a
> switch downstream of a HB without built-in memory device capabilities),
> a platform must construct a CEDT CFMWS at boot with sufficient resources
> to support the max possible (or expected) hotplug memory capacity.
> ```
> 
> In one case, an attached device which supports hotplug (which somewhat
> implies a switch is present), is responsible for presenting the platform

I'd write this to allow for RP hotplug as well. Might not be common yet
but who wants to remember to update the doc when that changes :)

> the resources.  In theory, at least, a platform doesn't need to do
> anything here if the device vendor has set things up correctly.
> 
> In the second case, the platform is responsible for making that decision,
> at it's on the ODM+CPU manufacturers to make sufficient BIOS/EFI/etc
> options available to support this kind of pre-allocation lacking any
> attached device at boot.  (not sure whether i should add this explicitly
> above).

Yeah, this is will be bios menu / reflashing the bios stuff or config
files in flash. Similar to happens for the big PCI storage servers with lots
of hotplug ports where we need to make space in PCI enumeration for stuff
that isn't there yet. CXL brings a few extra corner cases but fundamentally
it's a similar problem.
 
> 
> > > +Platform vendors should work with switch vendors to work out how this
> > > +HPA space reservation should work when one or more interleave options are
> > > +intended to be presented to a host.  
> > 
> > Same as above. Nothing to do with switches as far as I understand things
> > beyond them providing fan out. So if you have
> >        HB0          HB1
> >     RP0 RP1         RP2
> >      |   |           | 
> >    Empty Empty      USP
> >               _______|_______
> >              |    |   |     |
> >             DSP  DSP  DSP   DSP
> >              |    |   |     |
> >                 All empty
> > 
> > You might provide more room for devices below HB1 than HB0 if you don't expect
> > to see switches being hot added.
> >   
> 
> Same note from above
> 
> also *yoink* your ascii :]
I hope you tidied it up!  That's really ugly :(

Jonathan

> 
> ~Gregory

