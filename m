Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104001A58C
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955E1B9;
	Fri,  3 Nov 2023 07:16:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMN505bbhz689SY;
	Fri,  3 Nov 2023 22:13:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:16:37 +0000
Date: Fri, 3 Nov 2023 14:16:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gregory.price@memverge.com>
CC: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Gregory Price <gourry.memverge@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <aneesh.kumar@linux.ibm.com>,
	<weixugc@google.com>, <apopple@nvidia.com>, <tim.c.chen@intel.com>,
	<dave.hansen@intel.com>, <shy828301@gmail.com>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <20231103141636.000007e4@Huawei.com>
In-Reply-To: <87fs1nz3ee.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
	<rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
	<20231031152142.GA3029315@cmpxchg.org>
	<jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
	<ZUCCGJgrqqk87aGN@memverge.com>
	<pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
	<ZUKDz5NpMsoyzWtZ@memverge.com>
	<a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
	<ZUMVI4YG7mB54u0D@memverge.com>
	<87fs1nz3ee.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 03 Nov 2023 15:45:13 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Thu, Nov 02, 2023 at 10:47:33AM +0100, Michal Hocko wrote:  
> >> On Wed 01-11-23 12:58:55, Gregory Price wrote:  
> >> > Basically consider: `numactl --interleave=all ...`
> >> > 
> >> > If `--weights=...`: when a node hotplug event occurs, there is no
> >> > recourse for adding a weight for the new node (it will default to 1).  
> >> 
> >> Correct and this is what I was asking about in an earlier email. How
> >> much do we really need to consider this setup. Is this something nice to
> >> have or does the nature of the technology requires to be fully dynamic
> >> and expect new nodes coming up at any moment?
> >>    
> >
> > Dynamic Capacity is expected to cause a numa node to change size (in
> > number of memory blocks) rather than cause numa nodes to come and go, so
> > maybe handling the full node hotplug is a bit of an overreach.  
> 
> Will node max bandwidth change with the number of memory blocks?

Typically no as even a single memory extent would probably be interleaved
across all the actual memory devices (think DIMMS for simplicity) within
a CXL device. I guess a device 'could' do some scaling based on capacity
provided to a particular host but feels like they should be separate controls.
I don't recall there being anything in the specification to suggest the
need to recheck the CDAT info for updates when DC add / remove events happen.

Mind you, who knows in future :)  We'll point out in relevant forums that
doing so would be very hard to handle cleanly in Linux.

Jonathan
