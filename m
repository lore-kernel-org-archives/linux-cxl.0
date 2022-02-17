Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF7C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Feb 2022 17:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiBQREm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:04:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiBQREl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Feb 2022 12:04:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC013209D1F
        for <linux-cxl@vger.kernel.org>; Thu, 17 Feb 2022 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645117466; x=1676653466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wIDjH3uFMkVEJlndjTjsGQwuADq95Ct57Q6/xoqIfOc=;
  b=eG0zZaL64QLIb9fwkkYX7ccy04JCwkMEZr7m3QXEZcy1CmUUWb1F/QjL
   xCKKNO8kV9cxqa79CAk7fQOQ5b4S8Y+cMRJRFLDrY9fLGReisRK8snaNH
   l70GxhVSxzM5MiNKPmmUCVRDcwShjDbW6/Vr6/754v+rHPxuNJZ4NlSJ3
   ZS3qShR45Aed3/6w4OLoIe0mBRSo9fJW3KS1Lc0D9I3VAkDOMAJT+kkVY
   BL+4oPj0Sycrx7M9dOK9HgApMgnxaqoapDLwm8+Uo+L7530PzlgImWjV3
   wFFgIxhIvwxXVbP6r83y1JoD3IBkv8gdQF7a7rDB07fEzNNXfV3C+YwpT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250656990"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="250656990"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 09:04:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="626139916"
Received: from lmmcwade-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.203])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 09:04:25 -0800
Date:   Thu, 17 Feb 2022 09:04:23 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/port: Hold port reference until decoder release
Message-ID: <20220217170423.4x2j4aznppo5xc5i@intel.com>
References: <164505751190.4175768.13324905271463416712.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164505751190.4175768.13324905271463416712.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-02-16 16:25:11, Dan Williams wrote:
> KASAN + DEBUG_KOBJECT_RELEASE reports a potential use-after-free in
> cxl_decoder_release() where it goes to reference its parent, a cxl_port,
> to free its id back to port->decoder_ida.
> 
>  BUG: KASAN: use-after-free in to_cxl_port+0x18/0x90 [cxl_core]
>  Read of size 8 at addr ffff888119270908 by task kworker/35:2/379
> 
>  CPU: 35 PID: 379 Comm: kworker/35:2 Tainted: G           OE     5.17.0-rc2+ #198
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Workqueue: events kobject_delayed_cleanup
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x59/0x73
>   print_address_description.constprop.0+0x1f/0x150
>   ? to_cxl_port+0x18/0x90 [cxl_core]
>   kasan_report.cold+0x83/0xdf
>   ? to_cxl_port+0x18/0x90 [cxl_core]
>   to_cxl_port+0x18/0x90 [cxl_core]
>   cxl_decoder_release+0x2a/0x60 [cxl_core]
>   device_release+0x5f/0x100
>   kobject_cleanup+0x80/0x1c0
> 
> The device core only guarantees parent lifetime until all children are
> unregistered. If a child needs a parent to complete its ->release()
> callback that child needs to hold a reference to extend the lifetime of
> the parent.
> 
> Fixes: 40ba17afdfab ("cxl/acpi: Introduce cxl_decoder objects")
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
