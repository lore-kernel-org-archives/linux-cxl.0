Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B125B67C
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382290; cv=none; b=Lv7ld16685T3Qn4+w6m0Xm57CzdCDcDKybjV73+30y6K+2eiXO5MlON92u4lw/MOtKDpILavsfZch0150FdNyu6PNSYeVc/j6WoqRbjKu7rh3ExxwDtELV9lSZXLGqpn4z1NBPqc4LHgUaXbca6abKFMLeX9KV1ScEZgwg9zXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382290; c=relaxed/simple;
	bh=Ekt/WOAXwPaaOqgAXCwpdkJxfNp4lo1xdjufBgn3SMs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abuEQu7t519y9aDGq4d3MG2K2nUTlineBlFeZUk1FMyHVT5hIA1xe+f92KIibyYWw+ApWwjtyOQ6u/qlxUw40jo6gn3PlJVXL2osY0ukx12ORmAYemr4AJHGSnapdIpnitQZf4JUR1ssHYL3WFG+RqZhdUyZlAreuSJeTza0lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtQcS6tzmz6H7c4;
	Thu, 13 Feb 2025 01:42:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 89148140441;
	Thu, 13 Feb 2025 01:44:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 18:44:42 +0100
Date: Wed, 12 Feb 2025 17:44:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v5 07/15] cxl: Add FWCTL support to CXL
Message-ID: <20250212174440.0000701c@huawei.com>
In-Reply-To: <20250211182909.1650096-8-dave.jiang@intel.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
	<20250211182909.1650096-8-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 11:28:01 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits. The
> CXL PCI probe function will call cxl_setup_fwctl() after the cxl_memdev
> has been enumerated in order to setup FWCTL char device under the
> cxl_memdev like the existing memdev char device for issuing CXL raw
> mailbox commands from userspace via ioctls.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A comment inline, but not a request to change anything for this
series.  More a suspicion that the simplification Dan suggested
will bite later :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 02558f46883d..db48a8fbde81 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -1,5 +1,6 @@

> +
> +int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)

I slightly wonder if we would be better passing
struct device *parent, struct cxl_dev_state *cxlds.

However, that can happen if this gets reuse I guess
rather than now.  We might have to put back a specific
fwctl structure to enable that given we could know
where to find cxlds in the structure containing the parent
device though.

Meh, might be my problem if I try to reuse this for
switch-cci which is my plan if I get time to do an RFC / PoC.



> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_features_state *cxlfs;
> +	int rc;
> +
> +	cxlfs = to_cxlfs(cxlds);
> +	if (!cxlfs)
> +		return -ENODEV;
> +
> +	/* No need to setup FWCTL if there are no user allowed features found */
> +	if (!cxlfs->entries->num_user_features)
> +		return -ENODEV;
> +
> +	struct fwctl_device *fwctl_dev __free(free_fwctl_dev) =
> +		_fwctl_alloc_device(&cxlmd->dev, &cxlctl_ops, sizeof(*fwctl_dev));
> +	if (!fwctl_dev)
> +		return -ENOMEM;
> +
> +	rc = fwctl_register(fwctl_dev);
> +	if (rc)
> +		return rc;
> +
> +	cxlfs->fwctl_dev = fwctl_dev;
> +
> +	return devm_add_action_or_reset(&cxlmd->dev, free_memdev_fwctl,
> +					no_free_ptr(fwctl_dev));
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fwctl, "CXL");
> +
> +MODULE_IMPORT_NS("FWCTL");

