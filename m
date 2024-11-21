Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A41BC9EC
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211119; cv=none; b=dbgcZnTIoa1UrUW5X6HfgjLcuPba8edRheFJw2ihydlJ70OEixtiQewguMhn5aiqOhwWX13V1575TZrM+b7BjPEgJkQluPk5RbqcpcOC8q1rcKjp7yhsVzsyMcJaEFhwndRjAWENm4Kzc1N9trzBf1ob1YWgRro54gGxEWx7bcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211119; c=relaxed/simple;
	bh=nWDvl9RUpnHVFdUnnOmSMeOdT1XJSwV5tyumttLjaWo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n20wgHLvqCcnQnm5Sm0gOYxJOa+tAPZu3rR1n9E+slHxONEeorek/KXzI+g/tmhDzrjNQ6QC/zcJgCjm2P1RUdw3BOoHmsh5hZ4JPGPCueRPh6MxkjhY9H+ISGd7v+pJxp5F7HfgjPm0LUBQm0KEZgTUWHrabX6EwIgwaHXyPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQX106mkz6K6QY;
	Fri, 22 Nov 2024 01:41:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 348B914038F;
	Fri, 22 Nov 2024 01:45:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 18:45:11 +0100
Date: Thu, 21 Nov 2024 17:45:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 03/20] cxl/test: Add Get Supported Features
 mailbox command support
Message-ID: <20241121174510.00003a44@huawei.com>
In-Reply-To: <20241115212745.869552-4-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-4-dave.jiang@intel.com>
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

On Fri, 15 Nov 2024 14:25:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add cxl-test emulation of Get Supported Features mailbox command.
> Currently only adding a test feature with feature identifier of
> all f's for testing.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave,

One endian issue inline. With that tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +
> +static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
> +				       struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_get_sup_feats_in *in = cmd->payload_in;
> +	struct cxl_mbox_get_sup_feats_out *out = cmd->payload_out;
> +	struct cxl_feat_entry *feat;
> +	u16 start_idx, count;
> +
> +	if (cmd->size_out < sizeof(*out)) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Current emulation only supports 1 feature
> +	 */
> +	start_idx = le16_to_cpu(in->start_idx);
> +	if (start_idx != 0) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
> +		return -EINVAL;
> +	}
> +
> +	count = le16_to_cpu(in->count);
> +	if (count < sizeof(*out)) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
> +		return -EINVAL;
> +	}
> +
> +	out->supported_feats = cpu_to_le16(1);
> +	cmd->return_code = 0;
> +	if (count < sizeof(*out) + sizeof(*feat)) {
> +		out->num_entries = 0;
> +		return 0;
> +	}
> +
> +	out->num_entries = 1;

cpu_to_le16(1) I think.

> +	feat = out->ents;
> +	fill_feature_vendor_test(feat);
> +
> +	return 0;
> +}


