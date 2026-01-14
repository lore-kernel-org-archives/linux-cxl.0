Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743712FE060;
	Wed, 14 Jan 2026 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415811; cv=none; b=f/2tuYMXlSMSkT36O4ceXLFKYkbx+7ZccN79AxFhorHirmtTMu9vg0T4ScibEExeqvgJPiJc19lFo9wVicZzLcmF6mZAiTW6tUI84qgAgye/SNEi++sJdZttgsCbM17yTuA6KKazpJ23gAe5OTm83x1arX0wh5d5stNfbOOKK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415811; c=relaxed/simple;
	bh=eJwm6iWn5gnkiFBcwBxw8orXS+a1dc6K++zQ+vA5LjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx0baYK4lVrpOWDdhK4IAYDpsWleAavrBPfHvIGGlHX9ddM9tOT13oFj3x1C+HytWQCc1jf7xKJNhGI7dLvBeYXf1B/+wGjron+0Kvy5MVqalIqeP1a4vbi+DJ8c6zF9qwh39TktOuWZIUrG1bPHxI3+i3zKAD0o81a+RFtDLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drvvt4ML6zHnGdy;
	Thu, 15 Jan 2026 02:36:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 08F0540573;
	Thu, 15 Jan 2026 02:36:47 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:36:35 +0000
Date: Wed, 14 Jan 2026 18:36:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and
 region->memctrl
Message-ID: <20260114183633.0000410f@huawei.com>
In-Reply-To: <aWffsUbIx2DUefSS@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
	<20260112163514.2551809-2-gourry@gourry.net>
	<20260114171808.000067e2@huawei.com>
	<aWffsUbIx2DUefSS@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 13:25:53 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Jan 14, 2026 at 05:18:08PM +0000, Jonathan Cameron wrote:
> > On Mon, 12 Jan 2026 11:35:09 -0500
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > The CXL driver presently hands policy management over to DAX subsystem
> > > for sysram regions, which makes building policy around the entire region
> > > clunky and at time difficult (e.g. multiple actions to offline and
> > > hot-unplug memory reliably).
> > > 
> > > To support multiple backend controllers for memory regions (for example
> > > dax vs direct hotplug), implement a memctrl field in cxl_region allows
> > > switching uncomitted regions between different "memory controllers".
> > > 
> > > CXL_CONTROL_NONE: No selected controller, probe will fail.
> > > CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
> > >                   otherwise register a dax_region
> > > CXL_CONTROL_DAX : register a dax_region
> > > 
> > > Auto regions will either be static sysram (BIOS-onlined) and has no
> > > region controller associated with it - or if the SP bit was set a
> > > DAX device will be created.
> > > 
> > > Rather than default all regions to the auto-controller, only default
> > > auto-regions to the auto controller.
> > > 
> > > Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
> > > a failure to probe unless a controller is selected.
> > > 
> > > Signed-off-by: Gregory Price <gourry@gourry.net>  
> > Trivial comments whilst I try to get my head around the series.
> > 
> > ...
> >  
> 
> Recommend piviting to v2 which simplifies and addresses some of your
> notes here already:
> 
> https://lore.kernel.org/linux-cxl/aWfe-r7uEV-ajfhX@gourry-fedora-PF4VCD3F/T/#m791301178876f9b1ab55ed4091c674d4f4ceb07c
> 
> Still need to add some docs.
That came cover letter free so I didn't figure out it was this
until a few patches in!

J
> 
> ~Gregory

