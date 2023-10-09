Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB8374C5
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C22D56
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 08:37:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S433w4y50z6D8Wq;
	Mon,  9 Oct 2023 23:34:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 16:37:18 +0100
Date: Mon, 9 Oct 2023 16:37:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: A confusion about cxl.mem in CXL drivers
Message-ID: <20231009163716.00003325@Huawei.com>
In-Reply-To: <20231008065036.468324-1-wangyuquan1236@phytium.com.cn>
References: <20231008065036.468324-1-wangyuquan1236@phytium.com.cn>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 8 Oct 2023 14:50:36 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Sorry for resending this mail as I still confused about it.
> 
> On 2023-09-20 20:19,  jonathan.cameron wrote:
> 
> Thanks for your patient explanation.
> 
> >
> > So from driver side of things, the CXL.IO stuff is either in ECAM (for config
> > space) or mapped as PCIe BARs.  The CXL.mem stuff is mapped via the Host Physical
> > Addresses described in a CXL Fixed Memory Window.
> > 
> > So the right type of access is used based on the underlying hardware performing
> > the routing for the appropriate Host Physical Address range.  Same applies
> > on top of QEMU.
> >   
> 
> Therefore, from the view of kernel side, the kernel do not need to distinguish the physical cxl subprotocol
> (cxl.io,cxl.cache,cxl.mem). In fact, the underlying hardware would directly finish this work so system software
> don't care about it.

The kernel does distinguish between these and may need to do different things to ensure
ordering of reads and writes etc.  They all work on a simple system by reading and writing
from host physical addresses (after mapping them into a virtual address in the kernel).

CXL.io is two things:
1.PCI config space accesses so those will typically be done via ECAM which is
a special region of the host physical address space where reads and writes resolve in PCI
config space transactions.
2. PCI Bar access.  Just like any normal PCI device these end up mapped to specific
host addresses programmed into the EP either by firmware or the kernel during bus enumeration.
As with PCI config reads and writes, accessing this memory address range results in the
right protocol messages being sent over the PCI bus.

CXL.cache is only relevant to accelerators - today we only support memory devices.
There is a Type 2 prototype around from Ira, but we haven't upstreamed it.

CXL.mem is accessed by the kernel via a host physical address range.  We program various
encoders in CXL.io space and make use of fixed system address decoders (described by the
ACPI CEDT table) to work out how to route a particular host physical address.  The CXL
root complex (or some protocol translation agent near that will route to the device in
question).

So the kernel basically needs to know what region to send read and writes to.  Note that
not all systems have simple memory based access to some of these protocols but most
systems likely to run CXL probably do.

> 
> According to the instance of qemu virt machine, my understanding is below:
> 1) CXL.IO: finding, setting and enumerating CXL ECAM/BARs (programmed in cxl_acpi, cxl_pci drivers)
>     Underlying hardware performing the routing : PCIe RC

Yes.

>     
> 2) CXL.MEM: host is going to access the memory mapped in CFMWs 
>     Underlying hardware performing the routing : HDM decoders

+ the host decoders which are described by CXL Fixed memory windows.

> 
> Many thanks
> Yuquan
> 
> 

