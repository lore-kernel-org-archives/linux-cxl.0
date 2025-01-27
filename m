Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C341D540
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976216; cv=none; b=j30dSjU4ouSIPJimdrpVc0uu3caOXoI5PxTQoTyLDI32LFZnUmk8Dak/TW7OR1/OzkaD24Z7UiKQsJ/vvnxOMlCGBr+dVMkpMcT7e9q0Q85NxNNVOGzyt7AwnPlmJkuCsOKGSnK48zNyr1Xb49qCjsiRfjm1wNr9jp9qELgpPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976216; c=relaxed/simple;
	bh=4WPT1Z4Aj/KQZl23Kq0JGIBCLGqJgplk9BV6cGEqQPg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0wDKwe4Pjbv09q7zJctm+UB1VaPJQ1tZRBFNL2mSmDbdWlgd94x55fsGIpzORVXiy0VPaEy8t4tJBMusYnU6kALjfEYESGvGhv6lKDYm3y5K8BCCarARWpy0WzkisRigGB5xkIOh5fvIxTo4NcviK4NrU3NwT82vdhShfOxpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhQfr5nxqz6K98x;
	Mon, 27 Jan 2025 19:09:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D21A31400D4;
	Mon, 27 Jan 2025 19:10:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 12:10:10 +0100
Date: Mon, 27 Jan 2025 11:10:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 04/19] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <20250127111008.000002c1@huawei.com>
In-Reply-To: <6792df1982a19_20fa294db@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-5-dave.jiang@intel.com>
	<6792df1982a19_20fa294db@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 23 Jan 2025 16:30:17 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> > The command retrieve the list of supported device-specific features
> > (identified by UUID) and general information about each Feature.
> > 
> > The driver will retrieve the feature entries in order to make checks and
> > provide information for the Get Feature and Set Feature command. One of
> > the main piece of information retrieved are the effects a Set Feature
> > command would have for a particular feature.
> > 
> > Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v1:
> > - Change input param from cxlds to cxl_mbox
> > - Move mbox_out declaration inline. (Jonathan)
> > - Fix __counted_by() input. (Jonathan)
> > - Return count for cxl_get_supported_features_count(). (Dan)
> > - Remove goto from cxl_get_supported_features(). (Dan)
> > - Return cxl_get_supported_feature_entry() directly. (Dan)
> > - Drop user path enumeration. (Dan)
> > - Move to the feature driver model. (Dan)
> > - Add support for 0 feature data requested.
> > - Add missing increment of feature data ptr during copy.
> > ---
> >  drivers/cxl/core/features.c |  28 +++++++
> >  drivers/cxl/core/mbox.c     |   3 +-
> >  drivers/cxl/cxl.h           |   2 +
> >  drivers/cxl/features.c      | 146 +++++++++++++++++++++++++++++++++++-
> >  include/cxl/features.h      |  32 ++++++++
> >  5 files changed, 209 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index eb6eb191a32e..66a4b82910e6 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> >  #include <linux/device.h>
> > +#include <cxl/mailbox.h>
> >  #include "cxl.h"
> >  #include "core.h"
> >  
> > @@ -69,3 +70,30 @@ struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
> >  	return ERR_PTR(rc);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
> > +
> > +struct cxl_feat_entry *
> > +cxl_get_supported_feature_entry(struct cxl_features *features,
> > +				const uuid_t *feat_uuid)
> > +{
> > +	struct cxl_feat_entry *feat_entry;
> > +	struct cxl_features_state *cfs;
> > +	int count;
> > +
> > +	cfs = dev_get_drvdata(&features->dev);
> > +	if (!cfs)
> > +		return ERR_PTR(-EOPNOTSUPP);  
> 
> How could this function be called outside of the driver being enabled?
> 
> If the driver might not be enabled when this is called, what stops it
> from being disabled immediately after this check?
> 
> Went looking for the caller of this function... none in this patch set.
> 
> If this is for the EDAC use case, that enabling had better be triggered
> from a known context where these questions have a satisfactory answer.
> As it stands I think you can just delete it, right?
> 
> This has me thinking that the EDAC integration should just be a feature
> of the cxl_features_driver.

I'm not 100% sure I see what you mean here, but if you mean pushing
the registration code into cxl_features.ko...

I replied to this in the other thread, but just to add a bit here.
I think this creates a worse spiders web than we have today. Not
all EDAC features we might add (e.g. device self test) have anything to do
with get/set features.  I'm not sure we'll support that one in EDAC soon
though it might make sense if there is generality with non CXL systems
(I've been meaning to look into that.)

To me, the CXL features support is providing a service to some of the EDAC
features, but they use other services from CXL drivers and potentially
don't use CXL features at all.  For now we have the repair drivers
that only use the features support for a tiny bit of what they do
(tweaking device initiated aspects and detailed record generation
 - if we even support those yet).

At some point we may have core CXL functionality depending on
get/set features as well as there are things we definitely don't
want in either EDAC or fwctl like metabits storage controls.
So I'd be careful adding any thing to cxl_features beyond stuff
that is definitely clustered with fwctl bit or helpers.

Soon I'd also expect us to add 'features' to fwctl interface
that aren't using get/set features. I think you suggested that we
could do this by making up some guids for them and pushing though
this same interface.

Jonathan


