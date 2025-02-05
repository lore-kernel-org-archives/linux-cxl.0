Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF61519AD
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778267; cv=none; b=bO2A8a514VDOjo1ZJdduwKeI3U6F1th3FxFSsSLxGluMboJmXbFHS8InzOsVU5KllYN41ee0qqGrvjiRlTa6LTStO2DwbHXInBaRTTuDyD/c5hv8QYmNsJEo80pFkiMaiN5N/9qa0F7e+3ZmRmliGtPrc5F/1uepxMPmUCnAdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778267; c=relaxed/simple;
	bh=vGC6ZC+5wh1WbWw4PIDvo8WgFOCM2Tf2Y9HeSPOWG9Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6MtWt1Oiv3mgM71iaGvuL55nWVy3wufuRn3hNqYFqEcZ4S2OgC8qeH6Duzh+7Ra+ZNGTZg8FYx6ryaTrWsGycL5qyhleAwx8KhpeF3qZjtd0BATgy/t/s9fcNqf0eV9AzmrUvPrxhPFeT+82ox2lYfE1j4juU/Ab6PHR1SCZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp7DQ6CSHz6L4x1;
	Thu,  6 Feb 2025 01:55:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE4B8140B38;
	Thu,  6 Feb 2025 01:57:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Feb
 2025 18:57:41 +0100
Date: Wed, 5 Feb 2025 17:57:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 05/16] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <20250205175740.000079ab@huawei.com>
In-Reply-To: <67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
	<20250204220430.4146187-6-dave.jiang@intel.com>
	<67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 16:54:43 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > Add support for GET_FEATURE mailbox command.
> > 
> > CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> > The settings of a feature can be retrieved using Get Feature command.
> > CXL spec r3.2 section 8.2.9.6.2 describes Get Feature command.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/Makefile   |  1 +
> >  drivers/cxl/core/features.c | 59 +++++++++++++++++++++++++++++++++++++
> >  include/cxl/features.h      | 29 ++++++++++++++++++
> >  tools/testing/cxl/Kbuild    |  1 +
> >  4 files changed, 90 insertions(+)
> >  create mode 100644 drivers/cxl/core/features.c
> > 
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 9259bcc6773c..73b6348afd67 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -14,5 +14,6 @@ cxl_core-y += pci.o
> >  cxl_core-y += hdm.o
> >  cxl_core-y += pmu.o
> >  cxl_core-y += cdat.o
> > +cxl_core-y += features.o  
> 
> Would have expected:
> 
> cxl_core-$(CONFIG_CXL_FEATURES) += features.o
> 
> I think it is ok to throw all of Feature and FWCTL support behind a
> single config option. That is, until it becomes clear that someone has a
> "yes, kernel internal CXL Features, no FWCTL CXL Features" use case.
> 
> >  cxl_core-$(CONFIG_TRACING) += trace.o
> >  cxl_core-$(CONFIG_CXL_REGION) += region.o
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > new file mode 100644
> > index 000000000000..b01dc5ebb24d
> > --- /dev/null
> > +++ b/drivers/cxl/core/features.c
> > @@ -0,0 +1,59 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> > +#include <linux/device.h>
> > +#include <cxl/mailbox.h>
> > +#include <cxl/features.h>
> > +#include "cxl.h"
> > +#include "core.h"
> > +#include "cxlmem.h"
> > +#include "features.h"
> > +
> > +size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> > +		       enum cxl_get_feat_selection selection,
> > +		       void *feat_out, size_t feat_out_size, u16 offset,
> > +		       u16 *return_code)
> > +{
> > +	size_t data_to_rd_size, size_out;
> > +	struct cxl_mbox_get_feat_in pi;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	size_t data_rcvd_size = 0;
> > +	int rc;
> > +
> > +	if (return_code)
> > +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> > +
> > +	if (!feat_out || !feat_out_size)
> > +		return 0;
> > +
> > +	size_out = min(feat_out_size, cxl_mbox->payload_size);
> > +	uuid_copy(&pi.uuid, feat_uuid);
> > +	pi.selection = selection;
> > +	do {
> > +		data_to_rd_size = min(feat_out_size - data_rcvd_size,
> > +				      cxl_mbox->payload_size);
> > +		pi.offset = cpu_to_le16(offset + data_rcvd_size);
> > +		pi.count = cpu_to_le16(data_to_rd_size);
> > +
> > +		mbox_cmd = (struct cxl_mbox_cmd) {
> > +			.opcode = CXL_MBOX_OP_GET_FEATURE,
> > +			.size_in = sizeof(pi),
> > +			.payload_in = &pi,
> > +			.size_out = size_out,
> > +			.payload_out = feat_out + data_rcvd_size,
> > +			.min_out = data_to_rd_size,
> > +		};
> > +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > +		if (rc < 0 || !mbox_cmd.size_out) {
> > +			if (return_code)
> > +				*return_code = mbox_cmd.return_code;
> > +			return 0;
> > +		}
> > +		data_rcvd_size += mbox_cmd.size_out;
> > +	} while (data_rcvd_size < feat_out_size);
> > +
> > +	if (return_code)
> > +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> > +
> > +	return data_rcvd_size;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");  
> 
> So I see this is exported to a new cxl_fwtcl.ko module, but I think all
> of this can be core built-in functionality similar to memdev ioctl and
> firmware upload support. As long as distributions can opt-out of FWCTL
> and Features at build time then this is no worse than
> CONFIG_CXL_MEM_RAW_COMMANDS from a proprietary use case / security model
> stance. With that software only needs to worry about finding a
> cxl_memdev object and not manually loading a cxl_fwctl module.

It'll get exported shortly anyway as it's used by the EDAC series
and that should be separate modules.  

I'm not disagreeing that it might not be needed for fwctl though
and obviously we can add the exports in that series (subject to
yet more versions as this changes...)


> 

