Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC118E23
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C5B128;
	Thu,  2 Nov 2023 07:14:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SLm4W0KYZz6H7bF;
	Thu,  2 Nov 2023 22:10:51 +0800 (CST)
Received: from localhost (10.126.170.21) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 2 Nov
 2023 14:14:00 +0000
Date: Thu, 2 Nov 2023 14:13:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravi Jonnalagadda <ravis.opensrc@micron.com>
CC: <ying.huang@intel.com>, <akpm@linux-foundation.org>,
	<aneesh.kumar@linux.ibm.com>, <apopple@nvidia.com>, <dave.hansen@intel.com>,
	<gourry.memverge@gmail.com>, <gregkh@linuxfoundation.org>,
	<gregory.price@memverge.com>, <hannes@cmpxchg.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mhocko@suse.com>, <rafael@kernel.org>,
	<shy828301@gmail.com>, <tim.c.chen@intel.com>, <weixugc@google.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <20231102141359.00000aa6@Huawei.com>
In-Reply-To: <20231102093542.70-1-ravis.opensrc@micron.com>
References: <87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20231102093542.70-1-ravis.opensrc@micron.com>
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
X-Originating-IP: [10.126.170.21]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

icable.  
> >
> >You mean the different memory ranges of a NUMA node may have different
> >performance?  I don't think that we can deal with this.  
> 
> Example Configuration: On a server that we are using now, four different
> CXL cards are combined to form a single NUMA node and two other cards are
> exposed as two individual numa nodes.
> So if we have the ability to combine multiple CXL memory ranges to a
> single NUMA node the number of NUMA nodes in the system would potentially
> decrease even if we can't combine the entire range to form a single node.
>

If it's in control of the kernel, today for CXL NUMA nodes are defined by
CXL Fixed Memory Windows rather than the individual characteristics of devices
that might be accessed from those windows.

That's a useful simplification to get things going and it's not clear how the
QoS aspects of CFMWS will be used.  So will we always have enough windows with
fine enough granularity coming from the _DSM QTG magic that they don't end up
with different performance devices (or topologies) within each one?

No idea.  It's a bunch of trade offs of where the complexity lies and how much
memory is being provided over CXL vs physical address space exhaustion.
 
Long term, my guess is we'll need to support something more sophisticated with
dynamic 'creation' of NUMA  nodes (or something that looks like that anyway)
so we can always have a separate one for each significantly different set of
memory access characteristics.  If they are coming from ACPI that's already
required by the specification.  This space is going to continue getting more
complex.

Upshot is that I wouldn't focus too much on possibility of a NUMA node having
devices with very different memory access characterstics in it.  That's a quirk
of today's world that we can and should look to fix.

If your bios is setting this up for you and presenting them in SRAT / HMAT etc
then it's not complying with the ACPI spec.

Jonathan
