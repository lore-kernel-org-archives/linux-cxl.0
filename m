Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE2C64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 03:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB0DVv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 26 Feb 2023 22:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjB0DVu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 26 Feb 2023 22:21:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA47016309
        for <linux-cxl@vger.kernel.org>; Sun, 26 Feb 2023 19:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677468106; x=1709004106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPcJ+bNYXMnGXy+TrhNqkxgksoxehd/wTUEEVWdy0BE=;
  b=j+nsIReIL8wSjnhb2u5q9J9w16lcjiWf1in7mM9R4DcEvi7Ibk94noTy
   z40ssDVbAYqMJdiFIiW8p91lTwvH+HbnU8xGNsdYYX9/3vePqwDCWP+zh
   pMjGE8thyf40cIiLbgDCDcJvXQNDr+ISr1LAimLoO9Ajy0sFqtv0EoylR
   aThyRkYNIHQ5I7qdYlf+c+pL9N6RmiEzZr3iwGnF4MfKHBOBUecfgQ8if
   ywBmkFciDFE+0/vNJnN/kfkkDPAGzIUx2+vntQicXF93OUPTwlpBhZ0cI
   JkJoTExaeOePZgELwc4MbjoEZKUwUkpfXTI1wCwEz6hRXx7Mt/wrrgK5z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="361325196"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="361325196"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 19:21:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="1002545322"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="1002545322"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.83.169])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 19:21:45 -0800
Date:   Sun, 26 Feb 2023 19:21:44 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Junhyeok Im <junhyeok.im@samsung.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Message-ID: <Y/whyOESQ0fRIpNZ@aschofie-mobl2>
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
 <CGME20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec@epcas2p1.samsung.com>
 <20230220045709.94027-3-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220045709.94027-3-junhyeok.im@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 20, 2023 at 01:57:08PM +0900, Junhyeok Im wrote:
> Add new command to cli tool, to inject poison into dpa(-a) on the
> memory device.
> 
> DPA written in sysfs attribute(inject_poison) is converted by
> kstrtou64 with 0 base by 'inject_poison_store' of CXL driver, so if
> it begins with 0x the number will be parsed as a hexadecimal
> (case insensitive), if it otherwise begins with 0, it will be parsed
> as an octal number. Otherwise it will be parsed as a decimal.
> 
> Since the validity verification of the dpa would be done in
> 'cxl_validate_poison_dpa' of CXL driver, no additional logic
> is added.

I'm not sure that zero validity checks on that DPA is best here.
That validity checks in the driver always returns -EINVAL, and
the driver emits a dev_dbg message offering more details. So, for
a user that is not running a debug kernel, figuring out which
validity check they failed is not so trivial.

The driver fails the validity check for these reasons:

device has no dpa resource
dpa in resource
dpa is not 64-byte aligned
dpa mapped in region

I lean towards the cxl command checking all of these, but I'm not
clear of the precedence here, so let's see what others say.

> 
> Also since it is expected no use case of injecting poison into the
> same address for multiple devices, this command targets only one
> memdev, like write-labels command.
> 
>  usage: cxl inject-poison <memdev> -a <dpa> [<options>]

maybe -m memdev (to be like others)
> 
>     -v, --verbose         turn on debug
>     -S, --serial          use serial numbers to id memdevs
>     -a, --address <dpa>   DPA to inject poison

Let's open up the naming discussion again.  This isn't solely about
your patch here. With the cxl list --media-errors patch, Jonathan and I
had a discussion about whether that should be --poison or --media-errors
and stuck with --media-errors to align with the CXL spec and be like ndctl.

Our prior thoughts:
https://lore.kernel.org/nvdimm/20221121105711.0000770c@Huawei.com/

Note that this is all pending work, nothing has been merged. I started
using 'poison' for the sysfs attributes: trigger_poison_list, inject_poison,
clear_posion.

But, in the CXL tool, I went with 'media-errors', cxl list --media-errors.

Following that pattern, s/inject-poison/inject-media-error  

I'd like to revisit that, because now it seems like less of a match as
we grow to include inject_poison and clear_poison.

> 
> Link to corresponding kernel patch:
>   https://patchwork.kernel.org/project/cxl/patch/97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com/
> 
> Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
> ---
>  cxl/builtin.h |  1 +
>  cxl/cxl.c     |  1 +
>  cxl/memdev.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/builtin.h b/cxl/builtin.h
> index 34c5cfb..ddc4da9 100644
> --- a/cxl/builtin.h
> +++ b/cxl/builtin.h
> @@ -23,4 +23,5 @@ int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
>  int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
>  int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
>  int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
> +int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx);
>  #endif /* _CXL_BUILTIN_H_ */
> diff --git a/cxl/cxl.c b/cxl/cxl.c
> index 3be7026..aa8d090 100644
> --- a/cxl/cxl.c
> +++ b/cxl/cxl.c
> @@ -77,6 +77,7 @@ static struct cmd_struct commands[] = {
>  	{ "disable-region", .c_fn = cmd_disable_region },
>  	{ "destroy-region", .c_fn = cmd_destroy_region },
>  	{ "monitor", .c_fn = cmd_monitor },
> +	{ "inject-poison", .c_fn = cmd_inject_poison },
>  };
>  
>  int main(int argc, const char **argv)
> diff --git a/cxl/memdev.c b/cxl/memdev.c
> index 0b3ad02..7a10f79 100644
> --- a/cxl/memdev.c
> +++ b/cxl/memdev.c
> @@ -34,6 +34,7 @@ static struct parameters {
>  	const char *type;
>  	const char *size;
>  	const char *decoder_filter;
> +	const char *poison_address;
>  } param;
>  
>  static struct log_ctx ml;
> @@ -85,6 +86,10 @@ OPT_STRING('t', "type", &param.type, "type",                   \
>  OPT_BOOLEAN('f', "force", &param.force,                        \
>  	    "Attempt 'expected to fail' operations")
>  
> +#define INJECT_POISON_OPTIONS()				\
> +OPT_STRING('a', "address", &param.poison_address, "dpa",	\
> +	   "DPA to inject poison")
> +

git clang-format doesn't like the above.

-#define INJECT_POISON_OPTIONS()                                \
-OPT_STRING('a', "address", &param.poison_address, "dpa",       \
-          "DPA to inject poison")
+#define INJECT_POISON_OPTIONS()                                  \
+       OPT_STRING('a', "address", &param.poison_address, "dpa", \
+                  "DPA to inject poison")



>  static const struct option read_options[] = {
>  	BASE_OPTIONS(),
>  	LABEL_OPTIONS(),
> @@ -135,6 +140,12 @@ static const struct option free_dpa_options[] = {
>  	OPT_END(),
>  };
>  
> +static const struct option inject_poison_options[] = {
> +	BASE_OPTIONS(),
> +	INJECT_POISON_OPTIONS(),
> +	OPT_END(),
> +};
> +
>  enum reserve_dpa_mode {
>  	DPA_ALLOC,
>  	DPA_FREE,
> @@ -351,6 +362,24 @@ static int action_free_dpa(struct cxl_memdev *memdev,
>  	return __reserve_dpa(memdev, DPA_FREE, actx);
>  }
>  
> +static int action_inject_poison(struct cxl_memdev *memdev,
> +				struct action_context *actx)
> +{
> +	int rc;
> +
> +	if (!param.poison_address) {
> +		log_err(&ml, "%s: set dpa to inject poison.\n",
> +			cxl_memdev_get_devname(memdev));
> +		return -EINVAL;
> +	}
> +	rc = cxl_memdev_inject_poison(memdev, param.poison_address);
> +	if (rc < 0) {
> +		log_err(&ml, "%s: inject poison failed: %s\n",
> +			cxl_memdev_get_devname(memdev), strerror(-rc));
> +	}
> +	return rc;
> +}
> +
>  static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
>  {
>  	if (!cxl_memdev_is_enabled(memdev))
> @@ -755,7 +784,8 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
>  				continue;
>  			found = true;
>  
> -			if (action == action_write) {
> +			if ((action == action_write) ||
> +			    (action == action_inject_poison)) {
>  				single = memdev;
>  				rc = 0;
>  			} else
> @@ -771,9 +801,15 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
>  	}
>  	rc = err;
>  
> -	if (action == action_write) {
> +	if ((action == action_write) || (action == action_inject_poison)) {
>  		if (count > 1) {
> -			error("write-labels only supports writing a single memdev\n");
> +			if (action == action_write) {
> +				error("write-labels only supports writing "
> +				      "a single memdev\n");
> +			} else {
> +				error("inject-poison only supports injection "
> +				      "of poison into a single memdev\n");
> +			}
>  			usage_with_options(u, options);
>  			return -EINVAL;
>  		} else if (single) {
> @@ -893,3 +929,14 @@ int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx)
>  
>  	return count >= 0 ? 0 : EXIT_FAILURE;
>  }
> +
> +int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx)
> +{
> +	int count = memdev_action(
> +		argc, argv, ctx, action_inject_poison, inject_poison_options,
> +		"cxl inject-poison <memdev> -a <dpa> [<options>]");
> +	log_info(&ml, "inject-poison %d mem%s\n", count >= 0 ? count : 0,
> +		 count > 1 ? "s" : "");
> +
> +	return count >= 0 ? 0 : EXIT_FAILURE;
> +}
> -- 
> 2.34.1
> 
