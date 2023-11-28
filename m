Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38EA1BE
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 09:42:53 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfqXp1yXwz6JBCN;
	Wed, 29 Nov 2023 01:42:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 88BEF140E87;
	Wed, 29 Nov 2023 01:42:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:42:23 +0000
Date: Tue, 28 Nov 2023 17:42:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linuxarm@huawei.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH 1/4] cxl: mbox: Preparatory move of functions to
 core/mbox.c and cxlmbox.h
Message-ID: <20231128174222.0000580e@Huawei.com>
In-Reply-To: <6551693f988f1_46f02942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
	<20231016125323.18318-2-Jonathan.Cameron@huawei.com>
	<6551693f988f1_46f02942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 12 Nov 2023 16:09:35 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > A later patch will modify this code to separate out the mbox
> > functionality from the memdev.  This patch is intended to make
> > that a little more readable.  Related move of cxl_err(), cxl_cmd_err()
> > to make them accessible from other parts of the cxl core code.
> > 
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/cxl/core/mbox.c | 261 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxlmbox.h   | 146 ++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 148 ++--------------------
> >  drivers/cxl/pci.c       | 265 +---------------------------------------
> >  4 files changed, 418 insertions(+), 402 deletions(-)  
> 
> Given that the CXL mailbox format is being adopted by other standards
> efforts in PCIe and OCP I would expect that this functionality is better
> served moving out of cxl_core.ko into its own compilation unit.

Makes sense.

> 
> Something like drivers/cxl/cci/, that CXL can select. The s/mbox/cci/
> rename is a proposal to both drop a letter out of the acronym and
> perhaps make the code a bit more discoverable / palatable for folks
> coming from those non-CXL specs to find the Linux code. However, if
> folks think that's too much thrash I am ok with drivers/cxl/mbox/.

Medium term I might see how bad it is to just rip it out of CXL entirely
and push it to drivers/pci/mmpt.c (with a few hooks to deal with
CXL parts). However, right now I think that's a step 2 (as MMPT whilst
published isn't widely implemented yet)

> 
> As for the policy for raw commands. I would still like for there to be
> some discipline of registratants to this facility to classify production
> vs debug commands to give Linux distributors a single place to set policy.
> I.e. keep up the need for consumers of this to define "Linux" commands
> to avoid the "raw" warning.
> 
> That said, how much of what switch CCI wants to do should be an ioctl()
> ABI vs sysfs / configfs? The raw commands are really only there for
> prototyping until production flows are established.

I'd love us to be in the world where the kernel modeled the topology
being controlled nicely even though it would get complex. There is also
a clear argument that this complexity isn't of interest to the kernel
so it doesn't really belong there anyway.
The main issue here is that the 'other' interface I'd expect a userspace tool
to be poking is MCTP.  There the software model is a network port.
So all the smarts pretty much have to be in userspace.

If the assumption is that it's all in userspace, the kernel won't have enough
visibility to do high quality sanity checking + pretty much everything you
set with the FMAPI is destructive, most likely to 'other hosts'.

We could maybe add commands (so no taint) for the non destructive stuff like
querying topology, and maybe even DCD add / remove (not forced) with the
tunneling wrap up pushed down into the kernel. I'll admit I'm doubtful and
think it likely any software stack is going to use raw anyway because they
have it all implemented for the MCTP path.

I expect we'll get requests to drop the taint on the Switch Mailbox CCI
raw command and it's much harder to argue against that it is for type 3
devices.

Jonathan

