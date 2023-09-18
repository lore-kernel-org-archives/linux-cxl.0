Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11599C46CA1
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjIRQvg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjIRQvg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 12:51:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD3B83
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695055891; x=1726591891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7lAbUFpNBFxu4mjW7Kw5rp1Dm96KLHlOrxEFd8+kb4=;
  b=WLn7R96ZY/wKnhY9Nij/ChRnTJ5NXNwA4JAqfUmSU7/Uh1XsOA2VNhr5
   W2/NPFNUNJASOaA8p2kkg69ZBIK0duaUYilKlktvlGPKpkl+FopwhO7kz
   8qrd0jfkg9qLMbnbsDHpjAtOTxMQjmdPuLxxxMTRSOAyvbYvCIoyWpoij
   90BToGf/AH1A53YScMoxQPIFfkFVN+84QMVg4wUmzutKGppmjmuQoJuXp
   VLgKomEjKqZ/Q2sVMOXoB0t4lWOHE2kIuQB+z30qy7PPmsmJ+/SBVQY+o
   al92Un4d0PH32xwCEMhNhrv3+F6I6eakYM+bzEVT375G/3m5eMrfGy/Id
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359130339"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359130339"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836111575"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="836111575"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.224])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:51:30 -0700
Date:   Mon, 18 Sep 2023 09:51:27 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave@stgolabs.net,
        jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 2/2] cxl: Move opcode reporting from dev_dbg() to
 traceevent
Message-ID: <ZQiAD7AyXZJ9eMEY@aschofie-mobl2>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
 <169480883568.2690926.2900058137618374817.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169480883568.2690926.2900058137618374817.stgit@djiang5-mobl3>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 15, 2023 at 01:13:55PM -0700, Dave Jiang wrote:
> Alison has reported that against certain hardware devices the opcode
> discovery dev_dbg() can emit several hundred "unsupported by driver"
> messages while parsing the CEL. Move the emission to traceevent to reduce
> dmesg spamming and let software parse the output if there are interested
> parties.

Thanks for reducing the spew Dave.

Considering that tracing may or may not be 'on' can we just not
spew anything at this point - no dev_dbg(), no trace. Let the user
ask for the opcode list at their leisure, at which time we'd dump
it to trace log.

Is there a mechanism in place for user to ask for logs?
(cxl list -m mem1 'show me my opcodes')
Barring that, I'm assuming users can do a pass thru of this cmd
and get whatever they want.

Counterpoint - is there a subset of opcodes that we'd really like
to dev_dbg() about at this point in time?  ie missing opcodes that
are going to make the device useless.

Alison

> 
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c  |    7 +++----
>  drivers/cxl/core/trace.h |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ab6b6c4d7a48..59089b540add 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -707,7 +707,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  {
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
> -	struct device *dev = mds->cxlds.dev;
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>  	int i;
>  
>  	cel_entry = (struct cxl_cel_entry *) cel;
> @@ -718,8 +718,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  
>  		if (!cmd && (!cxl_is_poison_command(opcode) ||
>  			     !cxl_is_security_command(opcode))) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +			trace_cxl_opcode(cxlmd, opcode, false);
>  			continue;
>  		}
>  
> @@ -732,7 +731,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		if (cxl_is_security_command(opcode))
>  			cxl_set_security_cmd_enabled(&mds->security, opcode);
>  
> -		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
> +		trace_cxl_opcode(cxlmd, opcode, true);
>  	}
>  }
>  
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 817c5377eca2..c48e4c836d77 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -734,6 +734,36 @@ TRACE_EVENT(cxl_log_type,
>  	)
>  );
>  
> +TRACE_EVENT(cxl_opcode,
> +
> +	TP_PROTO(const struct cxl_memdev *cxlmd, u16 opcode, bool enabled),
> +
> +	TP_ARGS(cxlmd, opcode, enabled),
> +
> +	TP_STRUCT__entry(
> +		__string(memdev, dev_name(&cxlmd->dev))
> +		__string(host, dev_name(cxlmd->dev.parent))
> +		__field(u64, serial)
> +		__field(u16, opcode)
> +		__field(bool, enabled)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(memdev, dev_name(&cxlmd->dev));
> +		__assign_str(host, dev_name(cxlmd->dev.parent));
> +		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->opcode = opcode;
> +		__entry->enabled = enabled;
> +	),
> +
> +	TP_printk("memdev=%s host=%s serial=%lld opcode=%d state=%s",
> +		  __get_str(memdev),
> +		  __get_str(host),
> +		  __entry->serial,
> +		  __entry->opcode,
> +		  __entry->enabled ? "enabled" : "unsupported"
> +	)
> +);
>  #endif /* _CXL_EVENTS_H */
>  
>  #define TRACE_INCLUDE_FILE trace
> 
> 
