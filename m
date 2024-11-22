Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125615A8
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287954; cv=none; b=Bpvwi4RtkWjNZWPK8lpmGXeOFoRhFM7H7GUiFJZlcuPyXzfVbX06tpOmaMcjRWEVCz0Wml8/ZF4TdwgvJEajmLMneEl3hk3fTW8RpZcwGJdVj8B9582t7QljHqbfSePf6jCCCITihKxzuRw649JIo2ywkth4g3hIsJx/EpXgZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287954; c=relaxed/simple;
	bh=oqmRYQ4cC9Cd2PcHEUVYId+NMftSgZxZAzu320+98BU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFt8Yy057CnTMMJXF5QPTKrxxV/IqmJMsHc7EVOSQ3hTIPidOI8wF/X8dz/tb8kEkS/S5Z4f/xgYmqqwuF8/YQl/o5q8hmBOyD2ygaOaCNWMsCHrCD7caSvH5h1QPgYZQCz0JJfM4cQZ0vzZqrLkI8IaszujBJd9x0PG+wH+LgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvyxZ3q5Qz688Cb;
	Fri, 22 Nov 2024 23:02:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 89090140B38;
	Fri, 22 Nov 2024 23:05:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 16:05:48 +0100
Date: Fri, 22 Nov 2024 15:05:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 16/20] fwctl/cxl: Add support to filter exclusive
 features
Message-ID: <20241122150546.00004b18@huawei.com>
In-Reply-To: <20241115212745.869552-17-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-17-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add support to allow filtering of CXL features that are exclusive to the
> kernel and make them not visible to user space. The "get supported
> features" mailbox command returned to the userspace is emulated and
> will skip the features that is marked exclusive for the kernel. The
> exclusion allows certain the feature setting of certain commands such
> as claimed by RAS to be exclusive to the kernel.

Well behaved software is only going to issue features that were returned
by get_supported_features.  However we need to block badly behaved software
too.  So a check is needed in the set_feature() / get_feature() paths.

A few queries inline but basically LGTM other than that.

Jonathan

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 115 ++++++++++++++++++++++++++++++++++++----
>  drivers/fwctl/cxl/cxl.c |   7 +--
>  include/cxl/features.h  |  52 ++++++++++++++++++
>  include/cxl/mailbox.h   |   8 ++-
>  4 files changed, 168 insertions(+), 14 deletions(-)
>  create mode 100644 include/cxl/features.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e7c5c709ac79..12ace2951f7c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -5,6 +5,7 @@
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
>  #include <linux/unaligned.h>
> +#include <cxl/features.h>
>  #include <cxl/mailbox.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -897,6 +898,78 @@ static int handle_mailbox_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
>  	return 0;
>  }
>  
> +/*
> + * Emulate the 'get supported features' mailbox command and only copy out the
> + * features that are not marked as exclusive for kernel.
> + */
> +static void cxl_mbox_get_supported_features_filtered(struct cxl_mailbox *cxl_mbox,
> +						     struct cxl_mbox_cmd *mbox_cmd)
> +{
> +	struct cxl_mbox_get_sup_feats_in *feat_in = mbox_cmd->payload_in;
> +	struct cxl_mbox_get_sup_feats_out *feat_out = mbox_cmd->payload_out;
> +	const int feat_out_size = sizeof(*feat_out);
Worth while?  I'd just use sizeof(*feat_out) inline.
Compiler will sort out out and it is self documenting.

> +	struct cxl_feat_entry *pos;
> +	const int feat_ent_size = sizeof(*pos);
Same for this.

> +	int out_count, ents, u;
> +	u32 count;
> +	u16 start;
> +
> +	count = le32_to_cpu(feat_in->count);
> +	start = le16_to_cpu(feat_in->start_idx);
> +	ents = count / sizeof(struct cxl_feat_entry);
> +	ents -= start;

You've lost me on this maths. ents is what?


> +	if (ents < 0) {
> +		mbox_cmd->size_out = 0;
> +		mbox_cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
> +		return;
> +	}
> +
> +	if (mbox_cmd->size_out < feat_out_size) {
> +		mbox_cmd->size_out = 0;
> +		mbox_cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
> +		return;
> +	}
> +
> +	feat_out->supported_feats =
> +		cpu_to_le16(cxl_mbox->num_user_feats);
> +	if (ents == 0) {
> +		feat_out->num_entries = cpu_to_le16(0);
> +		mbox_cmd->size_out = feat_out_size;
> +		mbox_cmd->return_code = CXL_MBOX_CMD_RC_SUCCESS;
> +		return;
> +	}
> +
> +	pos = &feat_out->ents[0];
> +	out_count = feat_out_size;
> +	for (int i = 0, u = 0; i < cxl_mbox->num_features; i++) {
> +		struct cxl_feature *feat = &cxl_mbox->entries[i];
> +
> +		if (feat->exclusive)
> +			continue;
> +
> +		if (u < start) {
> +			u++;
> +			continue;
> +		}
> +
> +		memcpy(pos, &feat->entry, feat_ent_size);
> +		out_count += feat_ent_size;
> +		pos++;
> +		u++;
> +
> +		if (u == count)
> +			break;
> +
> +		/* Make sure it does not go over total output buffer size */
> +		if (out_count + feat_ent_size >= mbox_cmd->size_out)
> +			break;
> +	}
> +
> +	feat_out->num_entries = cpu_to_le16(u);
> +	mbox_cmd->size_out = out_count;
> +	mbox_cmd->return_code = CXL_MBOX_CMD_RC_SUCCESS;
> +}


> diff --git a/include/cxl/features.h b/include/cxl/features.h
> new file mode 100644
> index 000000000000..6074a3f79d70
> --- /dev/null
> +++ b/include/cxl/features.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024 Intel Corporation. */
> +#ifndef __CXL_FEATS_H_
> +#define __CXL_FEATS_H_
> +
> +#include <linux/uuid.h>
> +
> +#define CXL_FEAT_PATROL_SCRUB_UUID						\
> +	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,	\
> +		  0x06, 0xdb, 0x8a)

We should figure out ordering for this one to avoid introducing the UUIDs in
Shiju's set then pulling them here.   Shiju, maybe just use the UUID
part of this file as a patch in your series?

The exclusive array belongs only with this patch.

I guess it doesn't really matter if we end up with repeated UUID definitions
and cleanup after though.

> +
> +#define CXL_FEAT_ECS_UUID							\
> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,	\
> +		  0x89, 0x33, 0x86)
> +
> +#define CXL_FEAT_SPPR_UUID							\
> +	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,	\
> +		  0x75, 0x68, 0xbb)
> +
> +#define CXL_FEAT_HPPR_UUID							\
> +	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,	\
> +		  0xfb, 0x0e, 0x24)
> +
> +#define CXL_FEAT_CACHELINE_SPARING_UUID						\
> +	UUID_INIT(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb, 0xfd, 0xaf, 0x65,	\
> +		  0x03, 0xba, 0xc4)
> +
> +#define CXL_FEAT_ROW_SPARING_UUID						\
> +	UUID_INIT(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98, 0xc2, 0xd5, 0x7f,	\
> +		  0x27, 0x9b, 0xed)
> +
> +#define CXL_FEAT_BANK_SPARING_UUID						\
> +	UUID_INIT(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef, 0xfa, 0xac, 0x5d,	\
> +		  0x18, 0xa8, 0x63)
> +
> +#define CXL_FEAT_RANK_SPARING_UUID						\
> +	UUID_INIT(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76, 0xda, 0x0b, 0x5e,	\
> +		  0x7a, 0x76, 0xa7)
> +
> +#define CXL_FEAT_UUID_MAX	8

Why not size automatically and use ARRAY_SIZE() to figure out size?

> +static uuid_t cxl_exclusive_feats[CXL_FEAT_UUID_MAX] = {
> +	CXL_FEAT_PATROL_SCRUB_UUID,
> +	CXL_FEAT_ECS_UUID,
> +	CXL_FEAT_SPPR_UUID,
> +	CXL_FEAT_HPPR_UUID,
> +	CXL_FEAT_CACHELINE_SPARING_UUID,
> +	CXL_FEAT_ROW_SPARING_UUID,
> +	CXL_FEAT_BANK_SPARING_UUID,
> +	CXL_FEAT_RANK_SPARING_UUID,
> +};
> +
> +#endif

