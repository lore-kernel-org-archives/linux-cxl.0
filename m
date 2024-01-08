Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6D13FF6
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7rNX3YSQz6JBZ3;
	Mon,  8 Jan 2024 18:47:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 55DF5140135;
	Mon,  8 Jan 2024 18:49:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 10:49:21 +0000
Date: Mon, 8 Jan 2024 10:49:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?gb18030?Q?=D6=DC=CD=AF?= <273415826@qq.com>
CC: qemu-devel <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: Question about CXL emulation in QEMU
Message-ID: <20240108104920.00002877@Huawei.com>
In-Reply-To: <tencent_8DDF745FD27897D9F242B6E39129B6B96B06@qq.com>
References: <tencent_8DDF745FD27897D9F242B6E39129B6B96B06@qq.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Jan 2024 19:05:58 +0800
"÷‹ÕØ" <273415826@qq.com> wrote:

> Dear Experts,
> 

+CC linux-cxl as a lot more CXL focused folk there who may be interested
in this discussion.

> I am writing to seek your assistance about CXL emulation in QEMU. I
> am Zhou Tong and I am researching how to use QEMU to simulate CXL
> over Ethernet°£
> 
> I want to implement remote registration of CXL.mem devices based on
> the QOM model. The general idea is: the CXL slave side notifies the
> master side of the size of the CXL memory and other control
> information through Ethernet, and the master side registers the CXL
> device locally based on the control information. When the master
> accesses the CXL device, KVM is responsible for intercepting the
> action of accessing the memory, and encapsulates the CXL message and
> forwards it to the slave through Ethernet£¨

Qemu is not going to see anything that looks like actual CXL messages,
just memory reads and writes - no different to any other RAM.

>ultimately achieving
> remote CXL memory access.. Ask the experts how to register the CXL
> device locally based on the control information without occupying the
> HVA resources of the master host (OR display the CXL device).

This sounds like it will run into the same problem we have with KVM
and the existing emulation of CXL in qemu.  To trap those operations
you'll need to treat it different from normal memory. That generally
limits you to not putting in instructions in that memory. Even in TCG
the performance is shocking as a result.

You could potentially add a caching layer and rely on page faulting
if you are happy with page granularity.  So any writes would result
in a page fault which QEMU could then handle - reads would fault first
time and fetch into a cache.

There are papers on how to do it... (google quickly gave me this)
https://eric-keller.github.io/papers/2020/FluidMem_ICDCS2020.pdf

I've been meaning to look at improving the perf and enabling KVM usage
for simple interleave configurations - particularly as that's one
potential model for virtualization of dynamic capacity devices but
that won't directly help you.

Perhaps there is existing RAM focused work for remote memory on KVM?

I think there are some existing commercial solutions for doing similar
for conventional RAM and the problem is fundamentally the same - I guess
you care about CXL to get a standard Host software stack?

I'm not sure why you'd get HVA resource usage or the host seeing the CXL
device.  This part is just the same as normal CXL device emulation,
it will absorb GPA space etc on the VM host and the PCIe config space etc
for the CXL device will be emulated as normal.

Jonathan

> 
> 
> Thank you in advance for your attention to this email, and I eagerly
> look forward to any insights or advice you may be able to provide. If
> there is a more convenient time for us to discuss this matter
> further, please let me know, and I will be more than happy to
> accommodate your schedule.
> 
> 
> Once again, thank you for your impactful contributions to the
> open-source community, and I greatly appreciate your time and
> consideration.
> 
> 
> 
> Regard,
> 
> 
> Zhou Tong.
> 
> 
> 
> 
> 
> 
> 
> ÷‹ÕØ
> 273415826@qq.com
> 
> 
> 
> &nbsp;
