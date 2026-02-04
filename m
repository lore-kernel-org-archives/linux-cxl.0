Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D429ACDB
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205570; cv=none; b=jtlXdxXWbe8BV/oysZjUug7YX8RLR2HGIwUqEOwQsvNf8lJvCxg5j9EPYQxvypIcgt3xs0Awr3Z0aK5xTn/cVTOSvbVsuP4HV1F9blokH1CFTPZwy/YbnXVY6J4Qqxh4Jiy8TsHZlLAPkPCVqGCxNHPCt9az7IyqGB298hzLGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205570; c=relaxed/simple;
	bh=lHqHAnc1ju0jO7+DGDgYiYSeDNWG5VbCUsfBQVbdIOk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9S8gw9rM2n6fpEWEIS0qi2qZE53WAeYI+ViZPNyt7JyuVZ9DEUlNlItvfigYCMBPdQaOUTXE28+hGRwJeAB20J/EPczPtjXk6BmQbjHe5ACgfaYZ0epK3ia1GEuFGzSe/yxLzepI1OAG2EDo4kB+UnLt12HPi43bBpVvf5oeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5dnn5c8szJ46jC;
	Wed,  4 Feb 2026 19:45:17 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B80DF4056A;
	Wed,  4 Feb 2026 19:46:06 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 11:46:04 +0000
Date: Wed, 4 Feb 2026 11:46:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Markus Armbruster
	<armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe
 Flit mode)
Message-ID: <20260204114600.00003910@huawei.com>
In-Reply-To: <20260204111202.000051d2@huawei.com>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
	<20260203153759-mutt-send-email-mst@kernel.org>
	<20260204111202.000051d2@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 4 Feb 2026 11:12:02 +0000
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> On Tue, 3 Feb 2026 15:39:22 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jan 09, 2026 at 02:45:04PM +0000, Jonathan Cameron wrote:  
> > > Lightly reworked version of Davidlohr's v4.
> > > https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
> > > 
> > > Whilst I have several other series posted for merge this applies fine
> > > to upstream, so no dependencies.
> > > Davidlohr, please check I didn't mess anthing up and perhaps give tags
> > > for the 3 new patches.    
> > 
> > applying this on top does seem to conflict.
> > let me get rest merged then this can be rebased.  
> Hi Michael
> 
> So I assume this is your v01-04-02-2026 branch.
> 
> I tried rebasing on that and ran into some issue.
> 
> Looks like you have a stale version of 
> [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> https://lore.kernel.org/all/20260119111542.788389-1-Jonathan.Cameron@huawei.com/
> 
> Markus had some comments that needed a new version.
> Mostly updating a few more version numbers in the comments to keep things consistent.
> 
> Not sure that has anything to do with the merge conflict.

Looks like it was a context change that trips git up.
I'll post a rebased version 6 on top of the 3 series that I think should merge
before this one. (It might be fine to pass with the media operations fixes one as
that is pretty tightly isolated).

Thanks

Jonathan

> 
> >   
> > > v5 changes:
> > > - Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
> > >   I was carrying that is not ready for upstream just yet.
> > > - Update the CFMWS flags directly as the patch doing restriction control needs
> > >   some more thought.
> > > - Bios tables test data updates.
> > > - Don't provide flit mode control for gen_pcie_root_port as we don't need it
> > >   for the rest of the series which is all about CXL.
> > > 
> > > The following allows support for component basic back invalidation discovery
> > > and config, by exposing the BI routing table and decoder registers. Instead
> > > of going the type2[0] route, this series proposes adding support for type3
> > > hdm-db, which allows a more direct way of supporting BI in qemu.
> > > 
> > > As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
> > > add support for enabling that for CXL components. Negotiation is handled
> > > via an equivalent of what we do for link speed.
> > > 
> > > Davidlohr Bueso (3):
> > >   hw/pcie: Support enabling flit mode
> > >   hw/cxl: Support type3 HDM-DB
> > >   hw/cxl: Remove register special_ops->read()
> > > 
> > > Ira Weiny (1):
> > >   hw/cxl: Refactor component register initialization
> > > 
> > > Jonathan Cameron (3):
> > >   tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
> > >     relaxation.
> > >   hw/cxl: Update CXL Fixed Memory Window ACPI description to include
> > >     Back Invalidate support.
> > >   tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
> > > 
> > >  docs/system/devices/cxl.rst               |  23 +++
> > >  include/hw/cxl/cxl_component.h            |  87 +++++++--
> > >  include/hw/cxl/cxl_device.h               |   4 +
> > >  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
> > >  include/hw/pci/pcie.h                     |   2 +-
> > >  include/hw/pci/pcie_port.h                |   1 +
> > >  hw/acpi/cxl.c                             |   2 +-
> > >  hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
> > >  hw/mem/cxl_type3.c                        |  15 +-
> > >  hw/pci-bridge/cxl_downstream.c            |  10 +-
> > >  hw/pci-bridge/cxl_root_port.c             |  11 +-
> > >  hw/pci-bridge/cxl_upstream.c              |  18 +-
> > >  hw/pci-bridge/pci_expander_bridge.c       |   2 +-
> > >  hw/pci/pcie.c                             |  23 ++-
> > >  tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
> > >  15 files changed, 313 insertions(+), 97 deletions(-)
> > > 
> > > -- 
> > > 2.48.1    
> > 
> > 
> >   
> 
> 

