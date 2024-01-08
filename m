Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879842940E
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7t624kCwz6K9RQ;
	Mon,  8 Jan 2024 20:04:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C43A140CB1;
	Mon,  8 Jan 2024 20:07:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:07:14 +0000
Date: Mon, 8 Jan 2024 12:07:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <20240108120713.00005f90@Huawei.com>
In-Reply-To: <65974b21859a8_8dc68294dc@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
	<170441210897.3574076.3084661576808646327.stgit@djiang5-mobl3>
	<65974b21859a8_8dc68294dc@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 4 Jan 2024 16:19:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> > region. The bandwidth is the aggregated bandwidth of all devices that
> > contribute to the CXL region. The latency is the worst latency of the
> > device amongst all the devices that contribute to the CXL region.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v3:
> > - Make attribs not visible if no data (Jonathan)
> > - Check against coord.attrib (Jonathan)
> > - Fix documentation verbiage (Jonathan)
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   60 +++++++++++++++++++++++++++++++
> >  drivers/cxl/core/region.c               |   40 +++++++++++++++++++++
> >  2 files changed, 100 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index fff2581b8033..86d3dbe12129 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -552,3 +552,63 @@ Description:
> >  		attribute is only visible for devices supporting the
> >  		capability. The retrieved errors are logged as kernel
> >  		events when cxl_poison event tracing is enabled.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
> > +Date:		Jan, 2024
> > +KernelVersion:	v6.9
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) The aggregated read bandwidth of the region. The number is
> > +		the accumulated read bandwidth of all CXL memory devices that
> > +		contributes to the region in MB/s. Should be equivalent to  
> 
> Perhaps:
> 
> s|Should be equivalent|It the identical data that would appear in
> /sys/devices/system/node/nodeX/access0/initiators/read_bandwidth if /
> when this region is onlined as memory nodeX|.
> 
> Note that I did a s/accessY/access0/ since this data is relative to a
> single Generic Port. The performance from other intiators that go
> through an alternate port is not represented, right?
Hi Dan,

You've lost me on this comment.  access0 is the access class, not enumerating a
particular port etc. This interface always gives me a headache (and is
at least partly my fault :(! but I think this is specifying the access
characteristics from the nearest initiator (CPUs and others) to the port.
access1 would be from a CPU to the port.

The actual initiators are nodeY in
/sys/devices/system/node/nodeX/access0/initiators/nodeY etc

Jonathan
