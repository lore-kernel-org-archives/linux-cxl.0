Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8331FFC5B
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395083; cv=none; b=kMRlBy/RQXPpIRCwAXB/C05KVfr98xIvRyHT3Qg6NZmFFNlAHmiZrOmXYreDGV/1ni3tohsZTUBwsXE6Gb5p3gCme2AF1Bc3rsFmG4ZnYjjSUzt0s4C6VGBcVdVn0acE3IQ8Ul/Ytm+K3ZEl7K2ogZgSfHtdCfW3h374gD/BosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395083; c=relaxed/simple;
	bh=8ne+BbXFiSdnt7nLIEuSUXxMhVgOFJ6RuSoYjQ8XUzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4F916SykUanxB1I4Lbj1J5ETSYmbjs/dcD4M8uJ5nO6qt9v7iWCVhawASKPl+v6cIx1kEJU5F85OXyYW6eMKU4BaZLEk5kH6GSpkCEMC2rvSqEf39mkNBm/eJQV6yrI0lJinNkXeO052AKi8id90bKRwUofsgFxu+PfHi4BzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb2vDWjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb2vDWjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4B9C4CEDF;
	Wed, 12 Feb 2025 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739395082;
	bh=8ne+BbXFiSdnt7nLIEuSUXxMhVgOFJ6RuSoYjQ8XUzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pb2vDWjFSYNCpZYxFrSVlL0tdOaQ/PzAuiUk9WU1i5bIGTm1rXDWxwloQfAzgwTLU
	 CwN0ry6szxLBVzH4uU9jLbC1BOplaJtWXJr2Q93uOqdjwfi9OCxvnlFIfEd0P7j/E1
	 Qeb02VwcqQ/jpOLHAWphqxL/GK2fFSs9SHz0eP7aN7ieH+zJynM+k3eGmCcsUkIrkW
	 N9/gAopMKVdgd6zmCSvDgwg33R4wE9bUp9o0L92efwaGYSaAsLNbULXTSHP6nbdZb4
	 8t1seRvTW8+vUzQgkU8EbVM7vAwv27S3eLc9F7Cr2pbiv+d+voGfxiq6xe5Z9MS+qW
	 8MHHlVMvaVmCw==
Date: Wed, 12 Feb 2025 13:18:01 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, jgg@nvidia.com, shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <Z60QCS6o-3VInenG@x130>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250211182909.1650096-9-dave.jiang@intel.com>

On 11 Feb 11:28, Dave Jiang wrote:
>Add definition for fwctl_ops->info() to return driver information. The
>function will return a data structure with a reserved u32. This is setup
>for future usages.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Li Ming <ming.li@zohomail.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>---
> drivers/cxl/core/features.c | 11 +++++++++--
> include/cxl/mailbox.h       |  1 +
> include/uapi/fwctl/cxl.h    | 19 +++++++++++++++++++
> 3 files changed, 29 insertions(+), 2 deletions(-)
> create mode 100644 include/uapi/fwctl/cxl.h
>
>diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>index db48a8fbde81..923c054599ad 100644
>--- a/drivers/cxl/core/features.c
>+++ b/drivers/cxl/core/features.c
>@@ -354,8 +354,15 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
>
> static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
> {
>-	/* Place holder */
>-	return ERR_PTR(-EOPNOTSUPP);
>+	struct fwctl_info_cxl *info;
>+
>+	info = kzalloc(sizeof(*info), GFP_KERNEL);
>+	if (!info)
>+		return ERR_PTR(-ENOMEM);
>+
>+	*length = sizeof(*info);
>+
>+	return info;
> }
>
> static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
>index c4e99e2e3a9d..60a26a0d8f1f 100644
>--- a/include/cxl/mailbox.h
>+++ b/include/cxl/mailbox.h
>@@ -4,6 +4,7 @@
> #define __CXL_MBOX_H__
> #include <linux/rcuwait.h>
> #include <cxl/features.h>
>+#include <uapi/fwctl/cxl.h>
> #include <uapi/linux/cxl_mem.h>
>
> /**
>diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
>new file mode 100644
>index 000000000000..d21fd6b80c20
>--- /dev/null
>+++ b/include/uapi/fwctl/cxl.h
>@@ -0,0 +1,19 @@
>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>+/*
>+ * Copyright (c) 2024, Intel Corporation
>+ *
>+ * These are definitions for the mailbox command interface of CXL subsystem.
>+ */
>+#ifndef _UAPI_FWCTL_CXL_H_
>+#define _UAPI_FWCTL_CXL_H_
>+
>+#include <linux/types.h>
>+
>+/**
>+ * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
>+ * @reserved: zero
>+ */
>+struct fwctl_info_cxl {
>+	__u32 reserved;
>+};

I would add some useful info such as: num_user_features, mbox->feature_cap,
etc ...

Maybe if the callback is not implemented by the fwctl driver, then fwctl
subsystem should make sure to return a default info struct or some zero
response buffer.

>+#endif
>-- 
>2.48.1
>
>
