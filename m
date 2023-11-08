Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C561CFBB
	for <linux-cxl@vger.kernel.org>; Wed,  8 Nov 2023 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWAgV/4K"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C5258A
	for <linux-cxl@vger.kernel.org>; Wed,  8 Nov 2023 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699480842; x=1731016842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kjE1NzKDZ0befCWNKzAWi/n6wdocCF3xETcLFALmmY8=;
  b=BWAgV/4KokaOeJuU4xN+Auueu4oZfJxXtQYPq0fn8PUAz+G9DfvhAvDN
   AIsyiRAhBbNEKX+u4ClkH4A/jZbJgsG332qw0ef3YjfHlDelf0SYAmJxR
   +fsyFbr5pwBAoWlijSx/iU1djJDw95RzFTRIEwwtboM8TBYpCh7IbWxYM
   oHU40B16Kp9BXxy0Ev7+40AFSUX64ZjBKFGEuS3gzDB9jpMW3vpteLnIV
   Vt4fc6iy2cPpImsMVey7PwFRKtP+4VvVjAKGqIzgVY+oHGfMIwefyPqwh
   eUASl0ir2pxbS399tdXr8EHVW8qBETaZLJ1+OSbW4R8dZkGO18voZ9vkj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="420969271"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="420969271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 14:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="11328400"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.35.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 14:00:41 -0800
Date: Wed, 8 Nov 2023 14:00:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v3] cxl: Add cxl_num_decoders_committed() usage to
 cxl_test
Message-ID: <ZUwFCM61s0864EA6@aschofie-mobl2>
References: <169929160525.824083.11813222229025394254.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169929160525.824083.11813222229025394254.stgit@djiang5-mobl3>

On Mon, Nov 06, 2023 at 10:26:45AM -0700, Dave Jiang wrote:
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper") missed the
> conversion for cxl_test. Add usage of cxl_num_decoders_committed() to
> replace the open coding.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>

Search for more usages of commit_end in cxl.c that may use new helper. 


> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Move export of symbol to cxl_test (Dan)
> v2:
> - Add missing changes, stg refresh foobar
> ---
>  tools/testing/cxl/Kbuild             |    1 +
>  tools/testing/cxl/cxl_core_exports.c |    7 +++++++
>  tools/testing/cxl/test/cxl.c         |    5 +++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/cxl/cxl_core_exports.c
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 90f3c9802ffb..95dc58b94178 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -62,5 +62,6 @@ cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
> +cxl_core-y += cxl_core_exports.o
>  
>  obj-m += test/
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> new file mode 100644
> index 000000000000..077e6883921d
> --- /dev/null
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +
> +#include "cxl.h"
> +
> +/* Exporting of cxl_core symbols that are only used by cxl_test */
> +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index b88546299902..f4e517a0c774 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -669,10 +669,11 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
>  		return 0;
>  
>  	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
> -	if (port->commit_end + 1 != id) {
> +	if (cxl_num_decoders_committed(port) != id) {
>  		dev_dbg(&port->dev,
>  			"%s: out of order commit, expected decoder%d.%d\n",
> -			dev_name(&cxld->dev), port->id, port->commit_end + 1);
> +			dev_name(&cxld->dev), port->id,
> +			cxl_num_decoders_committed(port));
>  		return -EBUSY;
>  	}
>  
> 
> 
