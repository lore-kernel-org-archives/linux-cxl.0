Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1EC20B2F
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE491
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 04:04:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5mvD6ff9z6K6B0;
	Thu, 12 Oct 2023 19:02:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 12 Oct
 2023 12:04:52 +0100
Date: Thu, 12 Oct 2023 12:04:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v10 21/22] cxl: Export sysfs attributes for memory
 device QoS class
Message-ID: <20231012120451.000051a9@Huawei.com>
In-Reply-To: <48be28cb-ed68-45c4-a271-bf9492c75eb4@intel.com>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
	<169698642598.1991735.4883136743132463123.stgit@djiang5-mobl3>
	<20231011142626.00002b16@Huawei.com>
	<48be28cb-ed68-45c4-a271-bf9492c75eb4@intel.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 14:43:14 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/11/23 06:26, Jonathan Cameron wrote:
> > On Tue, 10 Oct 2023 18:07:06 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
> >> should show up as /sys/bus/cxl/devices/memX/ram/qos_class0 for the volatile
> >> partition and /sys/bus/cxl/devices/memX/pmem/qos_class0 for the persistent
> >> partition. The QTG ID is retrieved via _DSM after supplying the
> >> calculated bandwidth and latency for the entire CXL path from device to
> >> the CPU. This ID is used to match up to the root decoder QoS class to
> >> determine which CFMWS the memory range of a hotplugged CXL mem device
> >> should be assigned under.
> >>
> >> While there may be multiple DSMAS exported by the device CDAT, the driver
> >> will only expose the first QTG ID per partition in sysfs for now. In the
> >> future when multiple QTG IDs are necessary, they can be exposed. [1]  
> > 
> > I'm not sure this will extent cleanly if we get a two dimensional set to describle
> > 1) Multiple DSMAS entries for RAM (so multiple inputs to pass to the _DSM)
> >    One nice thing here might be to ensure we have the first one seen.
> >    So if in future we do need to extent it this corresponds to the 0th one
> >    described.
> > 2) Want to describe less ideal QTG values from _DSM 
> > 
> > 
> > Maybe it's too early to come to any conclusion and the single 0 is enough.
> > The cynic in me suggests we call it. qos_class0_0 though to give us the space.
> > If we needs DSMAS ranges, then we describe those using first index,
> > and second is the priority index if we have multiple answers from _DSM.
> > For now it's always 0_0  
> 
> I talked to Dan and it seems he prefers the simplest form for the current version until we have a need to move towards something more complex. So qos_class0 -> qos_class. We can move to qos_classN_M when there is a need.
> 
> 
Ok.   We would need to maintain the qos_class interface as whatever it
is today, but that's fine.

J
> > 
> > 
> > Jonathan
> >   
> >>
> >> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
> >>
> >> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >>
> >> ---
> >> v10:
> >> - Export only qos_class0, the first entry. Additional qos_class entries can be
> >>   exported later as needed. (Dan)
> >> - Have the sysfs attrib return -ENOENT unless driver is attached. (Dan)
> >> - Removed Jonathan's review tag due to code changes.
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++++++++++++++
> >>  drivers/cxl/core/memdev.c               |   34 +++++++++++++++++++++++++++++++
> >>  2 files changed, 68 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> >> index 44ffbbb36654..dd613f5987b5 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> >> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> >> @@ -28,6 +28,23 @@ Description:
> >>  		Payload in the CXL-2.0 specification.
> >>  
> >>  
> >> +What:		/sys/bus/cxl/devices/memX/ram/qos_class0
> >> +Date:		May, 2023
> >> +KernelVersion:	v6.7
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) For CXL host platforms that support "QoS Telemmetry"
> >> +		this attribute conveys a comma delimited list of platform
> >> +		specific cookies that identifies a QoS performance class
> >> +		for the volatile partition of the CXL mem device. These
> >> +		class-ids can be compared against a similar "qos_class"
> >> +		published for a root decoder. While it is not required
> >> +		that the endpoints map their local memory-class to a
> >> +		matching platform class, mismatches are not recommended
> >> +		and there are platform specific performance related
> >> +		side-effects that may result. First class-id is displayed.
> >> +
> >> +
> >>  What:		/sys/bus/cxl/devices/memX/pmem/size
> >>  Date:		December, 2020
> >>  KernelVersion:	v5.12
> >> @@ -38,6 +55,23 @@ Description:
> >>  		Payload in the CXL-2.0 specification.
> >>  
> >>  
> >> +What:		/sys/bus/cxl/devices/memX/pmem/qos_class0
> >> +Date:		May, 2023
> >> +KernelVersion:	v6.7
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) For CXL host platforms that support "QoS Telemmetry"
> >> +		this attribute conveys a comma delimited list of platform
> >> +		specific cookies that identifies a QoS performance class
> >> +		for the persistent partition of the CXL mem device. These
> >> +		class-ids can be compared against a similar "qos_class"
> >> +		published for a root decoder. While it is not required
> >> +		that the endpoints map their local memory-class to a
> >> +		matching platform class, mismatches are not recommended
> >> +		and there are platform specific performance related
> >> +		side-effects that may result. First class-id is displayed.
> >> +
> >> +  
> > 
> >   
> 

