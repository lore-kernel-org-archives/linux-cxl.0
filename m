Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA241B47D0;
	Tue,  2 Jul 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936009; cv=none; b=c9RDENQDQbvahO/vJXONS1IzEqFcwnP2jroTYXbicRMXRT9UfZ0MAz/Jt4ltJy0ev6+d+Y7AWpev9NNrCikGSKsi366+LjPdLtdTlXZ+ZSWIZiagX6rdSckD+MGXdHWNxtnt6K+AiGIuqqB+OqFRsDbnJhKl4wWd//ZNWH50DWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936009; c=relaxed/simple;
	bh=9MIzvidVb1BfdAy2uCEv2PU++evxMNjDgRBeTcl20DA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxWsTAeIuZybVUMpwo/R92UCnBDvYPkfhfnczeEL6QXZr+EO4C/BKpTFyLPioUL+P+yX4xrXnyVdieP9VREI0xwYE6L0rmxwCp4AHWrKr0bD1g2ekhGPigpO+pclneuWkkjPIEBYJ/UmnKi1iTpOdHz+6ceSltXrDmr4XX0d0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD6zj1QGfz6J9fv;
	Tue,  2 Jul 2024 23:59:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 432B5140C98;
	Wed,  3 Jul 2024 00:00:05 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 17:00:04 +0100
Date: Tue, 2 Jul 2024 17:00:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 9/9] cxl/pci: Enable interrupts for CXL PCIe ports'
 AER internal errors
Message-ID: <20240702170003.00002657@Huawei.com>
In-Reply-To: <c5c1a814-0706-462e-81b2-f8ce814bbe9a@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-10-terry.bowman@amd.com>
	<20240620141514.00007c6d@Huawei.com>
	<c5c1a814-0706-462e-81b2-f8ce814bbe9a@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 11:46:01 -0500
Terry Bowman <Terry.Bowman@amd.com> wrote:

> Hi Jonathan,
> 
> I added responses inline below.
> 
> On 6/20/24 08:15, Jonathan Cameron wrote:
> > On Mon, 17 Jun 2024 15:04:11 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> CXL RAS errors are reported through AER interrupts using the AER status:
> >> correctbale internal errors (CIE) and AER uncorrectable internal errors  
> > 
> > correctable
> >   
> 
> Thanks.
> 
> >> (UIE).[1] But, the AER CIE/UIE are disabled by default preventing
> >> notification of CXL RAS errors.[2]
> >>
> >> Enable CXL PCIe port RAS notification by unmasking the ports' AER CIE
> >> and UIE errors.
> >>
> >> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
> >>              Switch Ports
> >> [2] PCI6.0 - 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h),
> >>              7.8.4.6 Correctable Error Mask Register (Offset 14h)
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> > 
> > I'm not sure doing this from a driver other than the one handling the
> > errors makes sense.  It is doing a couple of RMW without any locking
> > or guarantees that the driver bound to the PCI port might care about
> > this changing.
> >   
> 
> I think this could fit into the helper function mentioned in our earlier 
> discussion. When the portdrv's notifier enabler is called it could also
> enable the UIE/CIE.
> 
> > I'd like more info on why we don't just turn this on in general
> > and hence avoid the need to control it from the 'wrong' place.
> > 
> > Jonathan
> >   
> 
> I was trying to enable only where needed given the one case is not a 
> pattern, yet. At this point it is only for CXL RCH downstream port 
> and CXL VH ports (portdrv).
> 
> Would you like for the UIE/CIE unmask added to the AER driver init ?

If we can get away with it, yes!


