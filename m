Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4257CEB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 03:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGNDYb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 23:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjGNDY3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 23:24:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D571FFC
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305068; x=1720841068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lstUPfRoWI1oEN5Bl2t9SketFE9yXusTZpvP3sSwEL0=;
  b=kKvKunaJV3QZ066L+xL5FKiaQW7E5Lwg1zCiCLRTKc8P4D+5hw8z+10T
   sUqq7yb3BVuGXbEMHcK1CKB4dQiYRP8dbMe04VgftKH6NAL62RGlpGF7v
   l6nQZu5JfR+B+NvlipywCTz75PEsyolO8YUbai46VDSQoJGzT2182jeSk
   Ucy3Y6yJINSVVP0bGPxwlOB8UQ28bwlX28wYvh3CUanQcZ+G9kvr+js4v
   cTvs9XBcErNgPWKg+RvalbQQUOXjo24UWZuA70NgyDN70l/YFk61XzDMo
   1TdliuBqRDSb3gfR2RmU8j4K38RV8xKdspYUDv0oni1pVW1N7VEr6crqe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429143386"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429143386"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722229537"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="722229537"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.98.14])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:24:28 -0700
Date:   Thu, 13 Jul 2023 20:24:26 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Message-ID: <ZLC/6mWTE+2WxcGd@aschofie-mobl2>
References: <20230713195455.19769-1-dave@stgolabs.net>
 <20230713195455.19769-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713195455.19769-3-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 13, 2023 at 12:54:51PM -0700, Davidlohr Bueso wrote:
> Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
> device sanitation, in either Sanitize and/or Secure Erase, per the
> CXL 3.0 specs.

Hi David,

Seems like maybe the commit msg and log got outdated. You actually
do the whole sh-bang here, not just an Introduction of the libcxl
accessors.

A few tidbits follow -

> 
> This is analogous to 'ndctl sanitize-dimm'.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/cxl/cxl-sanitize-memdev.txt | 68 +++++++++++++++++++++++
>  Documentation/cxl/cxl-wait-sanitize.txt   |  4 ++
>  Documentation/cxl/lib/libcxl.txt          |  1 +
>  Documentation/cxl/meson.build             |  1 +
>  cxl/builtin.h                             |  1 +
>  cxl/cxl.c                                 |  1 +
>  cxl/lib/libcxl.c                          | 16 ++++++
>  cxl/lib/libcxl.sym                        |  1 +
>  cxl/libcxl.h                              |  1 +
>  cxl/memdev.c                              | 47 ++++++++++++++++
>  10 files changed, 141 insertions(+)
>  create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt
> 
> diff --git a/Documentation/cxl/cxl-sanitize-memdev.txt b/Documentation/cxl/cxl-sanitize-memdev.txt
> new file mode 100644
> index 000000000000..25aa3f55b789
> --- /dev/null
> +++ b/Documentation/cxl/cxl-sanitize-memdev.txt
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +cxl-sanitize-memdev(1)
> +======================
> +
> +NAME
> +----
> +cxl-sanitize-memdev - Perform a cryptographic destruction or sanitization
> +of the contents of the given memdevs.
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'cxl sanitize-memdev' <mem0> [<mem1>..<memN>] [<options>]
> +
> +DESCRIPTION
> +-----------
> +The 'sanitize-memdev' command performs two different methods of
> +sanitization, per the CXL 3.0+ specification. It is required that
> +the memdev be disabled before sanitizing, such that the device
> +cannot be actively decoding any HPA ranges at the time. This
> +permits avoiding explicit global CPU cache management, relying
> +instead on the implict cache flushing when a region transitions
> +between active to commited.

s/implict/implicit
s/commited/committed

snip
> +--sanitize::
> +	Sanitize the device to securely re-purpose or decommission it. This is
> +	done by ensuring that all user data and meta data, whether it resides

s/meta data/metadata or meta-data

snip
>  
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 172dfb47a2dd..baf2a917ea6c 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -4046,6 +4046,22 @@ CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev)
>  	return rc;
>  }
>  
> +int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op)
> +{
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	char *path = memdev->dev_buf;
> +	int len = memdev->buf_len;
> +
> +	if (snprintf(path, len,
> +		     "%s/security/%s", memdev->dev_path, op) >= len) {
> +		err(ctx, "%s: buffer too small!\n",
> +		    cxl_memdev_get_devname(memdev));
> +		return -ERANGE;
> +	}
> +
> +	return sysfs_write_attr(ctx, path, "1");

Write that attribute w new line "1\n"


> +}
> +
snip

> +static int action_sanitize_memdev(struct cxl_memdev *memdev,
> +				  struct action_context *actx)
> +{
> +	int rc = 0;
> +
> +	if (cxl_memdev_is_enabled(memdev))
> +		return -EBUSY;
> +
> +	/* let Sanitize be the default */
> +	if (!param.secure_erase && !param.sanitize)
> +		param.sanitize = true;
> +
> +	if (param.secure_erase)
> +		rc = cxl_memdev_sanitize(memdev, "erase");
> +	if (param.sanitize)
> +		rc = cxl_memdev_sanitize(memdev, "sanitize");
> +	else
> +		rc = -EINVAL;

What's the deal w supporting secure erase with sanitize?
Seems useless, but perhaps it's cheap.

Alison

> 
