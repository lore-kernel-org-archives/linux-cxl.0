Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF85C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 02:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjESCeR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjESCeQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 22:34:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4EDE5C
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 19:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684463655; x=1715999655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZ6bUFzWMxQ9oDDTbnFvaw3RybfZnQ5V4IVVCut4K/c=;
  b=J+cTXoxIqKrVrjO5YzLizB1dmks20aKq99FDxOOglOsfjPu6LJHlMYHb
   YGVK3hr+S5dX2ODkxiZj9gnUAE9vDOsdVNUCcgs89DJ/yBd5sXUauWQJw
   QrX7AoBt6Vjz4kdxJc+RjTf1Gb3sIDDsjKxkjNv1gcK9/HSSFFU7uuDdu
   9QV94ypf5d5qQoJknKgSiSNYBQNO2t82RYM5TdVAY8tZlYQyvQaFW02Ar
   yUVcvelTIoVU1nzc0xrjuqrzYLeusI3aAK+6Ks3GAnizaFwJ7y0/lTHjY
   noPbE8rQ7kfyMek/60q5iamdfv2AKMoYSuF2x8VH3MvXfY6IiQzashkYy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349775622"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="349775622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="652881199"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="652881199"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.20.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:34:14 -0700
Date:   Thu, 18 May 2023 19:34:13 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Junhyeok Im <junhyeok.im@samsung.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        ks0204.kim@samsung.com
Subject: Re: [ndctl PATCH v2 2/2] cxl: add inject-poison & clear-poison
 commands to cxl tool
Message-ID: <ZGbgJWnC+sCttmhw@aschofie-mobl2>
References: <20230517032311.19923-1-junhyeok.im@samsung.com>
 <CGME20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705@epcas2p4.samsung.com>
 <20230517032311.19923-3-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517032311.19923-3-junhyeok.im@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 17, 2023 at 12:23:11PM +0900, Junhyeok Im wrote:
> Add new commands to cli tool, to inject and clear poison into dpa(-a) on the
> memory device(memdev), and add man page documentation for the commands
> (inject-poison, clear-poison).
> 
> Since the validity verification of the dpa would be done in
> 'cxl_validate_poison_dpa' of CXL driver, no additional logic is added
> in this patch.

Hi Junhyeok,

Thanks for syncing this up with the driver changes.

How about supporting the end user with checks on that DPA cmdline parameter?

As you stated, the driver validate the DPA. It does emit meaningful messages
in a debug kernel:
dev_dbg(cxlds->dev, "device has no dpa resource\n");
dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n"
The driver returns the same, -EINVAL response, to all those errors.

In addition to being more user friendly, stopping the bad input,
as soon as it can be detected, is just good practice.

a bit more below...

> 
> Also since it is expected no use case of injecting / clearing poison into the
> same address for multiple devices, this command targets only one memdev,
> like 'write-labels' command.
> 
>  usage: cxl {inject,clear}-poison <memdev> -a <dpa> [<options>]
> 
>     -v, --verbose         turn on debug
>     -S, --serial          use serial numbers to id memdevs
>     -a, --address <dpa>   DPA to inject or clear poison

What do you think about adding a length option and supporting the inject
and clear of a range of addresses?

That's all for now,
Alison

--snip
