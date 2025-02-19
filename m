Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523821423A
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988730; cv=none; b=m7y6dSSwbtsDMMNbzWongLtRWQi4CjEKhCfkrQtvUDqFQL8S8vNd3llv0FkXTPV1pbh9rz46lVT4xOIZaY0s9JzBj9bvkkYmwx3J48KjXmdidAPIA3iELRhYBr2YV9/oCN1Qd4o1HFm+IK6n5k4H/lGfxyhw2gY1Mm7AzM0c+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988730; c=relaxed/simple;
	bh=vIQM3S433ZZUrmDOab8FoMoXlcEgbqL0kpFeMhS3pl8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjDMPoBqe8ubwrKGnymhRRmeKSlMHv3/LkgouoHyvsCevOFgIjzC7uES6xD6UeX6MRwCz0VGdLpniya2Un/8J3oXOb5HwxnfcTlQaxzjGSXoHBGbtaelNJobk8r09oL4ddBykrAlftwh3A8eer8slMHlqXm0plUAbmt1Yslm9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yyktc0Nhhz67Dqh;
	Thu, 20 Feb 2025 02:09:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F0B6140382;
	Thu, 20 Feb 2025 02:12:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Feb
 2025 19:12:03 +0100
Date: Wed, 19 Feb 2025 18:12:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, <saeed@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v6 11/14] cxl: Add support to handle user feature
 commands for set feature
Message-ID: <20250219181202.00003ed3@huawei.com>
In-Reply-To: <20250218225721.2682235-12-dave.jiang@intel.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
	<20250218225721.2682235-12-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 15:54:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_set_feature() call.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v6:
> - Add set features bits checking bits from two patches ago. (Saeed)
> - Adjust for embedded input payload

Follow on from earlier.  Now I see where op is used.
I think we can do better however.

>  
> +static struct cxl_feat_entry *
> +get_support_feature_info(struct cxl_features_state *cxlfs,
> +			 const struct fwctl_rpc_cxl *rpc_in)
> +{
> +	struct cxl_feat_entry *feat;
> +	uuid_t *uuid;
> +
> +	if (rpc_in->op_size < sizeof(uuid))
> +		return ERR_PTR(-EINVAL);
> +
> +	uuid = (uuid_t *)rpc_in->op;

hmm. So here you use the op, but we know this a set features, so
much like in previous patch we could use

rpc_in->set_feat_in->uuid

That is relying on the fact we know this is being called on a
set feature which the name doesn't imply. So maybe rename?

Or.. check rpc_in->opcode and grab it from rpc_in->get_feat_in->uuid or
rpc_in->set_feat_in->uuid as appropriate.
and error out on anything else as we don't 'know' for sure there
is a uuid at that location.

> +
> +	for (int i = 0; i < cxlfs->entries->num_features; i++) {
> +		feat = &cxlfs->entries->ent[i];
> +		if (uuid_equal(uuid, &feat->uuid))
> +			return feat;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +


