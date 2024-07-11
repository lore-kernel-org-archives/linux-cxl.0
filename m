Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D6128FF
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712339; cv=none; b=UqZsEQbGvAz2plCTzVl5D2mpazK4Yfi+c1f3cZ+yxP4Rp6fBP7vOGr3uEjhbXA7TQKzfbX3I8Uk/P7AYlPrhMw3iR/xhWY2uKh8HJeUEJj193VounajRaQL+912iaA7CPg3EtCU3DADhY0sxO3IneqceDAgiLLRTB/cLIczRkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712339; c=relaxed/simple;
	bh=WNIY3qyKdEanCd2lydV2Xnhtp8tIaHBlGopTKUH8+vc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHwm3Z/vaQnYTrBHTnd2i8gMYq2Md9/pGVwyV2jB0/4HHUObLPw0mnxoyXjAoku8nm8AzkJh1h5HfBr1npEVxK6TLtWEtYQh6kCNtBghxmhEDZWbtbFDFJmX25ca7p/OWeK7jaCIMUGsyUYTsqAFvj3XJLSU7GM2hl/QZ6MW1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WKf3M3f8Dz67y8R;
	Thu, 11 Jul 2024 23:36:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D2C91400D3;
	Thu, 11 Jul 2024 23:38:53 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 16:38:52 +0100
Date: Thu, 11 Jul 2024 16:38:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
	<linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 06/13] acpi/pci: Move Generic Initiator object
 handling into acpi/pci.*
Message-ID: <20240711163851.00002f93@Huawei.com>
In-Reply-To: <20240711141240.0ec77fd2@imammedo.users.ipa.redhat.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
	<20240702131428.664859-7-Jonathan.Cameron@huawei.com>
	<20240711141240.0ec77fd2@imammedo.users.ipa.redhat.com>
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


> > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > index 20b70dcd81..174b490e5f 100644
> > --- a/hw/acpi/pci.c
> > +++ b/hw/acpi/pci.c
> > @@ -24,8 +24,12 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu/error-report.h"  
> 
> > +#include "qapi/error.h"  
> is this necessary? 
> it seems to be compiling just fine without it.
The error_fatal extern is in there.

I guess there is a non obvious path via which that's getting included
anyway. is in there and it's not obvious how it is included I'd rather
keep it as an explicit include to reduce fragility if the chain of
includes involved gets changed.


> 
> > +#include "hw/boards.h"
> >  #include "hw/acpi/aml-build.h"
> >  #include "hw/acpi/pci.h"
> > +#include "hw/pci/pci_device.h"
> >  #include "hw/pci/pcie_host.h"
> >  
