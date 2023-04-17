Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9CC77B7A
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Apr 2023 16:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDQQcP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjDQQcO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Apr 2023 12:32:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C4F10E3
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681749130; x=1713285130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XkJU8ByXIXpkuBWYZJTADvlpAxqTciiOGQmQthcPe/k=;
  b=GfpRy7Ic3iHNti58PF0TsKTzSL8neeoI+j/96N9q5Te8I1+CQVjX0Qpm
   AsisMZgFPjqpcVehJENpG9VvNpXCyELKFWJ0IedmjT7zDvQHlcD0j+RMs
   Ok1Ldqz0dwG1YKFWzmgMUPuypyQBJ13G56Yq07+bzkobyDGK3CmQB3chm
   NiHIBoVu70UVM6OrgEScqHWLqY38O71MdZWwoGZDu2Tt3k2LU693oFG9s
   Cr2UddKTCj4ps/Oaj5OG2x21TKsCN92NCaC6xv7iFhprEmmF384jZ5Alq
   KSH48z4ZmdSenzzlJir9dP3oFWXq6/4uKuHwCwV9DApUboT75AEy58GwU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431226209"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="431226209"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="936898224"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="936898224"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.39.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:32:09 -0700
Date:   Mon, 17 Apr 2023 09:32:06 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <ZD10hpfDnXaatUOE@aschofie-mobl2>
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


Dan, Vishal,

Following up on using the new deprecated list ...

On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices maintain a list of locations that are poisoned or result
> > in poison if the addresses are accessed by the host.
> > 
> > Per the spec, (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> > list as a set of Media Error Records that include the source of the
> > error, the starting device physical address, and length. The length is
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the poison list.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 71 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/pci.c       |  4 +++
> >  3 files changed, 142 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index f2addb457172..69a5d69dd53b 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -5,6 +5,8 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/ktime.h>
> >  #include <linux/mutex.h>
> > +#include <asm/unaligned.h>
> > +#include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  
> > @@ -994,6 +996,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
> >  	struct cxl_mbox_identify id;
> >  	struct cxl_mbox_cmd mbox_cmd;
> > +	u32 val;
> >  	int rc;
> >  
> >  	mbox_cmd = (struct cxl_mbox_cmd) {
> > @@ -1017,6 +1020,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
> >  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> >  
> > +	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
> > +		val = get_unaligned_le24(id.poison_list_max_mer);
> > +		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
> > +	}
> > +
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
> 
> A new cxl_deprecated_commands[] list is created for querying which
> command ids defined in previous kernels are now deprecated.

Dan, Vishal,

With the driver no longer returning these commands in the
cxl_mem_commands[] list, they will appear as -EOPNOTSUPP in
the ndctl:libcxl cxl_query().

Is there something else we need to do to actually show these
cmds as deprecated? Something like query the deprecated list
and add a new status to cxl_query(). 

At the moment, my goal is to do what is needed in the driver
now, and pick up any accompanying libcxl changes after the
driver changes are merged. A bit worried I'm leaving something
undone in driver today.

Thanks,
Alison

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
> -- 8< --

snip
