Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFBCC77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Apr 2023 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDMQtG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDMQtF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 12:49:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD7BF
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681404543; x=1712940543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjGcnU8oiazqnMhgt3B8p4XydfEoJnCL9G1Xfm4S9uI=;
  b=TSB1s1DEaYVHnJxCghTKXTkHJ1Xwbymntd+AQL1guw/kq74p7ANoJjo/
   saNGzcHRRBWN7hpw1vDmKiDOtgFYdk8qrXd7tIL4IH4ZzJoyyTnbi6Emr
   ZXCFnH7kCJfNz24q//XN+0V8Objqm9+CCD08pwaXnvGxwaRd3d/OCegCT
   jaDm9SKgJcdZUDfx05YxQdVXnqV4frwMjky/HoVijU6RvyJ8PiWmbTsFh
   I18+Vp8/yYEsoz2LFylBvSi74ibNKPzaqPuk2DLdYEw1N8is7AlUP7QG4
   jAPmYxwDdo6YsBKw9FLDF1DBjKodJVoYSiBEzq9Bk+cHcHy8Dk7nay8c9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="328380158"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="328380158"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 09:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="800869653"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="800869653"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.194.26])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 09:49:01 -0700
Date:   Thu, 13 Apr 2023 09:48:59 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <ZDgyezzrVAxV/Kdx@aschofie-mobl2>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 

follow up on the deprecate patch...

snip

> 
> With this new interface I do not expect we want to support user tooling
> that wants to retrieve the list via ioctl. So I think this wants a
> lead-in patch that deprecates the poison command support so that the
> linux-cxl community only has one mechanism to maintain going forward.
> 
> Something like the below as a lead-in, and then you would add code to
> cxl_walk_cel() to set a flag for the "get poison" machinery.
> 
> -- >8 --
> From f2cd1d1e09fe6f36255f3b8cd831b2b4903045d4 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 11 Apr 2023 17:48:45 -0700
> Subject: [PATCH] cxl/mbox: Deprecate poison commands
> 
> The CXL subsystem is adding a formal mechanism for retrieving the poison
> list. Minimize the maintenance burden going forward, and maximize the
> investment in common tooling by deprecating direct user access to issue
> this command outside of CXL_MEM_RAW_COMMANDS debug scenarios.

I'm expanding the scope of this deprecate patch to include Scan
commands, and want to make above statement correct, wrt what is
allowed in raw mode.

Today, Scan Media (& Results) are not allowed in raw.
It seems like in the spirit of raw, we should allow the scans. That
would be same as the raw allowed commands Get Poison, Inject & Clear.

Thoughts?

Alison

> 
> A new cxl_deprecated_commands[] list is created for querying which
> command ids defined in previous kernels are now deprecated.
> 
> Effectively all of the commands defined in:
> 
> 87815ee9d006 ("cxl/pci: Add media provisioning required commands")
> 
> ...were defined prematurely and should have waited until the kernel
> implementation was decided. To my knowledge there are no shipping
> devices with poison listing support and no known tools that would
> regress with this change.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/mbox.c      |  3 ---
>  include/uapi/linux/cxl_mem.h | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..8e24038b8769 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -61,9 +61,6 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
>  	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> -	CXL_CMD(GET_POISON, 0x10, CXL_VARIABLE_PAYLOAD, 0),
> -	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
> -	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 86bbacf2a315..90f17343f1ba 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -40,19 +40,22 @@
>  	___C(SET_ALERT_CONFIG, "Set Alert Configuration"),                \
>  	___C(GET_SHUTDOWN_STATE, "Get Shutdown State"),                   \
>  	___C(SET_SHUTDOWN_STATE, "Set Shutdown State"),                   \
> -	___C(GET_POISON, "Get Poison List"),                              \
> -	___C(INJECT_POISON, "Inject Poison"),                             \
> -	___C(CLEAR_POISON, "Clear Poison"),                               \
> +	___DEPRECATED(GET_POISON, "Get Poison List"),                     \
> +	___DEPRECATED(INJECT_POISON, "Inject Poison"),                    \
> +	___DEPRECATED(CLEAR_POISON, "Clear Poison"),                      \
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> +#define ___DEPRECATED(a, b) CXL_MEM_DEPRECATED_ID_##a
>  enum { CXL_CMDS };
>  
>  #undef ___C
> +#undef ___DEPRECATED
>  #define ___C(a, b) { b }
> +#define ___DEPRECATED(a, b) { "Deprecated " b }
>  static const struct {
>  	const char *name;
>  } cxl_command_names[] __attribute__((__unused__)) = { CXL_CMDS };
> @@ -68,6 +71,28 @@ static const struct {
>   */
>  
>  #undef ___C
> +#undef ___DEPRECATED
> +#define ___C(a, b) (0)
> +#define ___DEPRECATED(a, b) (1)
> +
> +static const u8 cxl_deprecated_commands[]
> +	__attribute__((__unused__)) = { CXL_CMDS };
> +
> +/*
> + * Here's how this actually breaks out:
> + * cxl_deprecated_commands[] = {
> + *	[CXL_MEM_COMMAND_ID_INVALID] = 0,
> + *	[CXL_MEM_COMMAND_ID_IDENTIFY] = 0,
> + *	...
> + *	[CXL_MEM_DEPRECATED_ID_GET_POISON] = 1,
> + *	[CXL_MEM_DEPRECATED_ID_INJECT_POISON] = 1,
> + *	[CXL_MEM_DEPRECATED_ID_CLEAR_POISON] = 1,
> + *	...
> + * };
> + */
> +
> +#undef ___C
> +#undef ___DEPRECATED
>  
>  /**
>   * struct cxl_command_info - Command information returned from a query.
> -- 
> 2.39.2
