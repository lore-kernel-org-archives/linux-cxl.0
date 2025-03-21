Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119931F09B8;
	Fri, 21 Mar 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559784; cv=none; b=sPQCuSiZoCUttGOwkhtOQ1tgYMzmXxM39Fl570wAjHCrPYgxGOpwpF88iBQPX1+886KkrU+j1OSCNEbQdgCYb05Jdmqqfagf2QCnyNIfQ0GpH8UV98FF9cIji6N3LWA9F0Faw1AB0ob+tid061OWaFYe+7qwj1fO0Hnvy6pZrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559784; c=relaxed/simple;
	bh=6osDAqHhTQk35P2HfjdW6nQ1yC6Edj3au9slaslnFZ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSm3aO02F6kZAxf366XMoZW9YLmwGGpdsTy/9F4DPodXN2DV7H9a4SbaiJr8rSty/K9WUSUfRVDPbAe3wRm2/t/PTSk7IOOH33OWM8uWCxVRq4a7nGpqG/1J4wfYIMqpU6C4nYk/6bnbA8/k3mtkZqgEH5f2wDhviRD+p/OTvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK1j466kJz6M4L6;
	Fri, 21 Mar 2025 20:19:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A5B8140517;
	Fri, 21 Mar 2025 20:22:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 13:22:57 +0100
Date: Fri, 21 Mar 2025 12:22:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <anisa.su887@gmail.com>
Subject: Re: [RFC] cxl/region: set numa node for target memdevs when a
 region is committed
Message-ID: <20250321122256.00005b71@huawei.com>
In-Reply-To: <67da0ccb80781_201f029449@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250314164629.6937-1-nifan.cxl@gmail.com>
	<ac564c1e-95e4-46d0-95c7-7f72c8fee0c2@intel.com>
	<67d9e4d43360e_201f0294d6@dwillia2-xfh.jf.intel.com.notmuch>
	<Z9n9qpySEkwbXN_F@debian>
	<67da0ccb80781_201f029449@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Mar 2025 17:16:11 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Fan Ni wrote:
> > On Tue, Mar 18, 2025 at 02:25:40PM -0700, Dan Williams wrote:  
> > > Dave Jiang wrote:  
> > > > 
> > > > 
> > > > On 3/14/25 9:40 AM, nifan.cxl@gmail.com wrote:  
> > > > > From: Fan Ni <fan.ni@samsung.com>
> > > > > 
> > > > > There is a sysfs attribute named "numa_node" for cxl memory device.
> > > > > however, it is never set so -1 is returned whenever it is read.
> > > > > 
> > > > > With this change, the numa_node of each target memdev is set based on the
> > > > > start address of the hpa_range of the endpoint decoder it associated when a
> > > > > cxl region is created; and it is reset when the region decoders are
> > > > > reset.
> > > > > 
> > > > > Open qeustion: do we need to set the numa_node when the memdev is
> > > > > probed instead of waiting until a region is created?  
> > > > 
> > > > Typically, the numa node for a PCI device should be dev_to_node(),
> > > > where the device resides. So when the device is probed, it should be
> > > > set with that. See documentation [1]. Region should have its own NUMA
> > > > node based on phys_to_target_node() of the starting address.    
> > > 
> > > Right, the memdev node is the affinity of device-MMIO to a CPU. The
> > > HDM-memory that the device decodes may land in multiple proximity
> > > domains and is subject to CDAT, CXL QoS, HMAT Generic Port, etc...
> > > 
> > > If your memdev node is "NUMA_NO_NODE" then that likely means the
> > > affinity information for the PCI device is missing.
> > > 
> > > I would double check that first. See set_dev_node() in device_add().  
> > 
> > Thanks Dave and Dan for the explanation. 
> > Then the issue must be from qemu setup.
> > 
> > I added some debug code as below
> > ---------------------------------------------
> > fan:~/cxl/linux-fixes$ git diff
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 5a1f05198114..c86a9eb58e99 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3594,6 +3594,10 @@ int device_add(struct device *dev)
> >         if (kobj)
> >                 dev->kobj.parent = kobj;
> >  
> > +        dev_dbg(dev, "device: '%s': %s XX node %d\n", dev_name(dev), __func__, dev_to_node(dev));
> > +        if (parent) {
> > +                dev_dbg(parent, "parent device: '%s': %s XX node %d\n", dev_name(parent), __func__, dev_to_node(parent));
> > +        }
> >         /* use parent numa_node */
> >         if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> >                 set_dev_node(dev, dev_to_node(parent));
> > ---------------------------------------------
> > 
> > The output after loading cxl related drivers looks like below. All
> > numa_node is -1 in the cxl topology. 
> > 
> > Hi Jonathan,
> >    do I miss something in the qemu setup ??  
> 
> IIUC the typical expectation for communicating the affinity of PCI
> devices is an ACPI _PXM property for the host bridge object in the
> [DS]SDT. As far as I can see QEMU does not build _PXM information for
> its host bridges.
> 
First a side note.  _PXM on device is in theory also an option, but
long ago the 'fix' for that was reverted due to some really broken old
AMD platforms that put devices in non existent nodes. Hmm. I should
revisit that as I 'think' all the allocation with broken numa nodes
is long fixed (included an ACPI spec clarification so took a while!)
https://lore.kernel.org/linux-pci/20181211094737.71554-1-Jonathan.Cameron@huawei.com/

As for _PXM on host bridges, the gpex ACPI code does assign them for
PCI Expander Bridges, if you pass in the node
https://elixir.bootlin.com/qemu/v9.2.2/source/hw/pci-host/gpex-acpi.c#L178
(So we are good on ARM :)
https://elixir.bootlin.com/qemu/v9.2.2/source/hw/i386/acpi-build.c#L1533
does the same on x86. 

Those go via some indirections to a callback here:
https://elixir.bootlin.com/qemu/v9.2.2/source/hw/pci-bridge/pci_expander_bridge.c#L80

So set numa_node=X for each of your PXB instances.

Jonathan



