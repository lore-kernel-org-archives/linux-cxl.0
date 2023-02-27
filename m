Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A74C6FA8E
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 02:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjB0Con (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 26 Feb 2023 21:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjB0Co3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 26 Feb 2023 21:44:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55CFF0A
        for <linux-cxl@vger.kernel.org>; Sun, 26 Feb 2023 18:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677465846; x=1709001846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SSyUMLzNzhlN2l7QCTctklsYJzqM8BzjdwaUL3g60zk=;
  b=aOvx7T7CtCkl8QUpMVGe3uV8qMt8bHZ9GECHOuYbSj1CIiAX2TQroUDO
   t77zz9QafdxGdEzo5B+4jgYHfCDgsfhabRTJED/eYLzFBh/zvGJIPP7Z2
   BaxhyNtSQvWDJKMe8ibq4g7IeFXGDqks8/PWiSHORCo24HfB60yHPOn9D
   u1rZ8+182fm2qO7AQs22+QYZkNWaSJP9AoSVLnbmdmHurxORH+bvjOSgw
   cAH39mkF8z5mnzqjcSmnIX7gHqVNQOvCV9tbBm3l2fKD+JpIpmxjBZm5/
   AitEXZbixucJJ+IIbhpo4ixsBQd5Uc4W55NNKtuSfAg59P/QxOukZLIBu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="322008401"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="322008401"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 18:43:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="737480313"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="737480313"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.83.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 18:43:56 -0800
Date:   Sun, 26 Feb 2023 18:43:54 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Junhyeok Im <junhyeok.im@samsung.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 1/3] libcxl: add memdev inject poison support
Message-ID: <Y/wY6laqNd+oz6FB@aschofie-mobl2>
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
 <CGME20230220045606epcas2p15419bab5979bcaa9cf5bd6ecdb84cac5@epcas2p1.samsung.com>
 <20230220045709.94027-2-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220045709.94027-2-junhyeok.im@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Commit message needs to include PATCH for all of these.
ie [ndctl PATCH 1/3]

On Mon, Feb 20, 2023 at 01:57:07PM +0900, Junhyeok Im wrote:
> Add ability to inject poison based on the kernel inject poison sysfs interface.
> 
> This interface trigger inject poison function by writing DPA to the memory device
> sysfs attribute ('inject_poison').

I'm not so sure about no validation on that address, but I'll comment on
that in the next patch.

Alison

> 
> Link to corresponding kernel patchset:
>   https://lore.kernel.org/linux-cxl/cover.1674101475.git.alison.schofield@intel.com/
> 
> Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
> ---
>  cxl/lib/libcxl.c   | 26 ++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  5 +++++
>  cxl/libcxl.h       |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 4859bd5..d2b8e19 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1407,6 +1407,32 @@ CXL_EXPORT int cxl_memdev_enable(struct cxl_memdev *memdev)
>  	return 0;
>  }
>  
> +CXL_EXPORT int cxl_memdev_inject_poison(struct cxl_memdev *memdev,
> +					const char *address)
> +{
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	char *path = memdev->dev_buf;
> +	int len = memdev->buf_len, rc;
> +
> +	if (snprintf(path, len, "%s/inject_poison",
> +		     memdev->dev_path) >= len) {
> +		err(ctx, "%s: buffer too small\n",
> +		    cxl_memdev_get_devname(memdev));
> +		return -ENXIO;
> +	}

git clang-format suggests this reformatting:
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 08ee9e61c4ca..8d8a01330891 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1459,8 +1459,7 @@ CXL_EXPORT int cxl_memdev_inject_poison(struct cxl_memdev *memdev,
        char *path = memdev->dev_buf;
        int len = memdev->buf_len, rc;

-       if (snprintf(path, len, "%s/inject_poison",
-                    memdev->dev_path) >= len) {
+       if (snprintf(path, len, "%s/inject_poison", memdev->dev_path) >= len) {
                err(ctx, "%s: buffer too small\n",
                    cxl_memdev_get_devname(memdev));
                return -ENXIO;


> +	rc = sysfs_write_attr(ctx, path, address);
> +	if (rc < 0) {
> +		fprintf(stderr, "%s: Failed write sysfs attr inject_poison\n",
> +			cxl_memdev_get_devname(memdev));
> +		return rc;
> +	}
> +
> +	dbg(ctx, "%s: poison injected at %s\n", cxl_memdev_get_devname(memdev),
> +	    address);
> +
> +	return 0;
> +}
> +
>  static struct cxl_endpoint *cxl_port_find_endpoint(struct cxl_port *parent_port,
>  						   struct cxl_memdev *memdev)
>  {
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 6bc0810..c6ba248 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -242,3 +242,8 @@ global:
>  	cxl_target_get_firmware_node;
>  	cxl_dport_get_firmware_node;
>  } LIBCXL_3;
> +
> +LIBCXL_5 {
> +global:
> +        cxl_memdev_inject_poison;
> +} LIBCXL_4;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index d699af8..7a2cc5f 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -68,6 +68,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
>  		size_t offset);
>  int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
>  		size_t offset);
> +int cxl_memdev_inject_poison(struct cxl_memdev *memdev, const char *address);
>  
>  #define cxl_memdev_foreach(ctx, memdev) \
>          for (memdev = cxl_memdev_get_first(ctx); \
> -- 
> 2.34.1
> 
