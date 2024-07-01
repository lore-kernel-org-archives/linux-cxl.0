Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB13236
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848882; cv=none; b=h/NrW551mlaY4Ds6Vj+yqgg/jEGk1g6MhhfGM5ccMTnFXm7DYUsPr4IolAdY41E9qMjto8TtqRpVIjK28kFTl2Jqg3sn5Oo5ZL7qD13617V8CLPMkoSb/anw4w57K4VnMRrcWdDenzF6kLhB6xdk5xdcpMRztfCd4NT/AWnkfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848882; c=relaxed/simple;
	bh=nd5/blkXf3vLBX6rCoUkulZN/Etu+k6hYYOmzNLEOWs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfevEuwUBdZgiiOCPyQ2CSsSMcMmV4ae+WW/PFGdeNuqRtLo0z+f74Qn642odpWxGuXTLWbsxUG37KNb03UEwoJDTFKo+gkO+QcGUpNV4XUuDWW3pw6u/MbOJ94Ml24ERXpxnRbm59AG0GJq17lYe9Z+MoXi9eaPknymu4WO51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCVlg4f2Rz6K71W;
	Mon,  1 Jul 2024 23:46:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F69C140CB1;
	Mon,  1 Jul 2024 23:47:53 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 16:47:52 +0100
Date: Mon, 1 Jul 2024 16:47:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
	<linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 08/11] hw/acpi: Generic Port Affinity Structure
 support
Message-ID: <20240701164751.000000a9@Huawei.com>
In-Reply-To: <20240701105219.09f2b1fd@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-9-Jonathan.Cameron@huawei.com>
	<20240701105219.09f2b1fd@imammedo.users.ipa.redhat.com>
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

On Mon, 1 Jul 2024 10:52:19 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Jun 2024 17:03:16 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > These are very similar to the recently added Generic Initiators
> > but instead of representing an initiator of memory traffic they
> > represent an edge point beyond which may lie either targets or
> > initiators.  Here we add these ports such that they may
> > be targets of hmat_lb records to describe the latency and
> > bandwidth from host side initiators to the port.  A discoverable
> > mechanism such as UEFI CDAT read from CXL devices and switches
> > is used to discover the remainder of the path, and the OS can build
> > up full latency and bandwidth numbers as need for work and data
> > placement decisions.
> > 
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v3: Move to hw/acpi/pci.c
> >     Rename the funciton to actually registers both types
> >     of generic nodes to reflect it isn't GI only.
> >     Note that the qom part is unchanged and other changes are mostly
> >     code movement so I've kept Markus' Ack.
> > ---
> >  qapi/qom.json                            |  34 ++++
> >  include/hw/acpi/acpi_generic_initiator.h |  35 ++++
> >  include/hw/acpi/aml-build.h              |   4 +
> >  include/hw/acpi/pci.h                    |   3 +-
> >  include/hw/pci/pci_bridge.h              |   1 +
> >  hw/acpi/acpi_generic_initiator.c         | 216 +++++++++++++++++++++++
> >  hw/acpi/aml-build.c                      |  40 +++++
> >  hw/acpi/pci.c                            | 110 +++++++++++-
> >  hw/arm/virt-acpi-build.c                 |   2 +-
> >  hw/i386/acpi-build.c                     |   2 +-
> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
> >  11 files changed, 443 insertions(+), 5 deletions(-)  
> 
> this is quite large patch, is it possible to split into
> a set of smaller patches?

Oops.

It's bigger that it should due to a messed up rebase.
The acpi_generic_initator.c/.h shouldn't exist!

With those gone will be much more manageable.

