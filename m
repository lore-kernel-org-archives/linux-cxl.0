Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60832B981;
	Fri, 19 Dec 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155828; cv=none; b=ogb7FpekrMWul52kEj+CfQ+W/N56JZUVLfHU2/NDK8lMpqvMIzw8riBXCzTfDvFcwfiC4g9B2RMSlPOb6G1OjqLdr5bsHOhtaIqmaZhnPUG5F2oegxhdetbMZJjdOSJ+9KFbCDfmmVvalYMGnx1s3t7vncK2ZDuXqUMccLeSjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155828; c=relaxed/simple;
	bh=diXfoksOnTBJJqaVMdnjmsZNa+G+lgmt0/AkhAteGv0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzC5rBhoYHhngMxgSzYLVh7uhBsRwCujT8kTt89YyVUCYrcmdGBYH1diqYFpYZ1LwZrtDnB/t5+MQk5h9f2Uy5AEoSyoEEG+i86pfXE7iXnvc4mCyiBDWGN7NLkUso68rW5/YmvyX1EsoBGyqfxDRGpwVUVzW3kXUSHpHnF2zvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXr6Q6nC3zJ46ZY;
	Fri, 19 Dec 2025 22:49:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AE3F940565;
	Fri, 19 Dec 2025 22:50:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 14:50:22 +0000
Date: Fri, 19 Dec 2025 14:50:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Message-ID: <20251219145021.00001071@huawei.com>
In-Reply-To: <aUVhxIJzGiiGs9ee@gourry-fedora-PF4VCD3F>
References: <20251218170747.1278327-1-gourry@gourry.net>
	<20251219105518.00005ca6@huawei.com>
	<aUVhxIJzGiiGs9ee@gourry-fedora-PF4VCD3F>
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

On Fri, 19 Dec 2025 09:31:32 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Dec 19, 2025 at 10:55:18AM +0000, Jonathan Cameron wrote:
> > On Thu, 18 Dec 2025 12:07:47 -0500
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > +
> > > +Multi-Endpoint Memory Device Present at Boot
> > > +--------------------------------------------
> > > +A hot-plug capable CXL memory device, such as one which presents multiple
> > > +expanders as a single large-capacity device, should report the maximum
> > > +*possible* capacity for the device at boot. ::
> > > +
> > > +                  HB0
> > > +                  RP0
> > > +                   |
> > > +     [Multi-Endpoint Memory Device]  
> > 
> > So this is the weird switch as end point thing?   Maybe a reference.
> > My guess is these will go away as switch and memory device vendors catch
> > up with the spec, but maybe I'm wrong.
> >   
> 
> I guess I just don't want to dictate the innards of a multi-endpoint
> memory device.  It *really really* implies there must be some kind of
> switch inside - but that switch might not even be runtime programmable
> or discoverable (basically all the settings get locked on boot and it
> becomes passthrough).
> 
> If you'd rather just not have this section at all, I'm ok with that.
> The switch case below this covers the base case for a switch-based
> device where everything is programmable.

Maybe just state at the top of this section that these things are
outside of the types of device that the CXL specification explicitly
talks about. That should be enough of a future breadcrumb for people
to decide if they can ignore these.


> 
> > > +              _____|_____
> > > +             |          |
> > > +        [Endpoint0]   [Empty]
> > > +
> > > +
> > > +Limiting the size to the capacity preset at boot will limit hot-add support
> > > +to replacing capacity that was present at boot.  
> > 
> >   

