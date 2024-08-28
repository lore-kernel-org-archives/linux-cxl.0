Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D61459FD
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835624; cv=none; b=F35Mq5IjGzfeLb1zPCX/mAC9DRW9vb/oXa2M0Cl7edptssXBaF4BZLICEZNlWXnddnWba9+I7fLDCSLPSsSf8lLyaU7U4jd4U9dvWvrcDzbbk2634Crro2T8Wtk7GJymJ/IIDmzwtZhCfnQQ9Jc0/Y6CpJDmU7oCdci1cI5Nh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835624; c=relaxed/simple;
	bh=SI3EKb/+2YCz9qQMJz1xHELer7He0gVsQNCnEVhOnDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6CUzWW81zY2knA1puRhpHepMW49laz6iw6rhyEf/zLo7jF9Tv9ttU1gyNKj4YLNGIfzhcESlGd+tVA9ocPYlx0JjeRhU61whh4J7tos1uzMmBhODMcpWM2oBYhvphiS08Cny+wPWRDn35PMOl4+bvvi+6rdSqCOrj/RYEpquyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wtyvw3YN2z6D9j0;
	Wed, 28 Aug 2024 16:57:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DE8A1140447;
	Wed, 28 Aug 2024 17:00:16 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 10:00:16 +0100
Date: Wed, 28 Aug 2024 10:00:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v7 3/3] cxl: Add documentation to explain the shared
 link bandwidth calculation
Message-ID: <20240828100015.000010a0@Huawei.com>
In-Reply-To: <3c325ad2-e483-417a-a952-1357df3382c4@intel.com>
References: <20240710222716.797267-1-dave.jiang@intel.com>
	<20240710222716.797267-4-dave.jiang@intel.com>
	<20240827170640.000007ab@Huawei.com>
	<3c325ad2-e483-417a-a952-1357df3382c4@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 15:38:27 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/27/24 9:06 AM, Jonathan Cameron wrote:
> > On Wed, 10 Jul 2024 15:24:02 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Create a kernel documentation to describe how the CXL shared upstream
> >> link bandwidth is calculated.
> >>
> >> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > Oops. Missed this previously.  A few minor things inline.
> > 
> > J  
> >> ---
> >>  .../driver-api/cxl/access-coordinates.rst     | 90 +++++++++++++++++++
> >>  Documentation/driver-api/cxl/index.rst        |  1 +
> >>  MAINTAINERS                                   |  1 +
> >>  3 files changed, 92 insertions(+)
> >>  create mode 100644 Documentation/driver-api/cxl/access-coordinates.rst
> >>
> >> diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/access-coordinates.rst
> >> new file mode 100644
> >> index 000000000000..973e63872f06
> >> --- /dev/null
> >> +++ b/Documentation/driver-api/cxl/access-coordinates.rst
> >> @@ -0,0 +1,90 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +.. include:: <isonum.txt>
> >> +
> >> +==================================
> >> +CXL Access Coordinates Computation
> >> +==================================
> >> +
> >> +Shared Upstream Link Calculation
> >> +================================
> >> +For certain CXL region construction with endpoints behind CXL switches (SW) or
> >> +Root Ports (RP), there is the possibility of the total bandwdith for all  
> > spell check. bandwidth  
> >> +the endpoints behind a switch being more than the switch upstream link.  
> > 
> > Could also be the Generic Port bit of the topology. Mind you I'm still failing
> > to come up with text for the qemu GP Documentation that the reviewers can follow
> > so maybe that's just too hard to describe here.  Could use weasel words.
> > 
> > "A similar situation can occur within the host, upstream of the root ports."
> > 
> >   
> >> +The CXL driver performs an additional pass after all the targets have
> >> +arrived for a region in order to recalculate the bandwidths with possible
> >> +upstream link being a limiting factor in mind.
> >> +
> >> +The algorithm assumes the configuration is a symmetric topology as that
> >> +maximizes performance. When asymmetric topology is detected, the calculation
> >> +is aborted when such topology is detected. An asymmetric topology is detected  
> > 
> > is detected is duplicated.  
> 
> I don't follow here.
> 
>+ When asymmetric topology is detected, the calculation
                             ^^^^^^^^^^^
>+is aborted when such topology is detected.
                                ^^^^^^^^^^^^
Delete the second one.

> >   
> >> +during topology walk where the number of RPs detected as a grandparent is not
> >> +equal to the number of devices iterated in the same iteration loop.  
> > 
> > Maybe make the point that asymmetric in terms of only properties of devices
> > is not detected. It just uses the first one I think?  
> 
> I also don't follow here.
> 
> I also wonder if I should use "unbalanced" topology rather than "unsymmetric"?

Difference between detecting a topology with different number of links and one
where say one type 3 device in an interleave set has lower bandwidth in it's CDAT.

IIRC this does the first, but not the second.

> 
> DJ
