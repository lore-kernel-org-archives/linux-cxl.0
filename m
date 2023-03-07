Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492BEC678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 20:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCGUSo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 15:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCGUSn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 15:18:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579BA335C
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678220320; x=1709756320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8gOnVNtZS73YCyh/mLSbcZ+RPbESqS/Y8BbGwsy4gwc=;
  b=hPNeez4G+lJlLC8SqnfxikmP5SqB89MfdRO/C4n/iW/tiV7GfNbJ/9VS
   FxTLmlJ30UtnbT2FJE+f7H9TGAQUuHYW71haWDIF0dCd6wG+ZZ6gaiY/u
   bYgKXxfNiNFB8Lyi60bHqv3qd18XFcaDk9ORPZVtd+CKFPwXu55GR9/45
   1PHd1Wcdyf8rDJh5QHsHQ1asspM0atipmNnKO9bLUbPXQZFpoQsPvbxeO
   OaVdrtgjevyrHUa+xdte2B4TEm8SH65SHAVLj9TiTiiWo+IBfOUWwH+3e
   uCKPHCn2JLXTecc5ZnWM8ZNO8DleWRsCMSZfj6kGCdvIK8nKkuWSU1gms
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="315622375"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="315622375"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:18:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="709178532"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="709178532"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.214.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:18:39 -0800
Date:   Tue, 7 Mar 2023 12:18:38 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jehoon Park <jehoon.park@samsung.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl patch RFC 0/2] add support for IDENTIFY command
Message-ID: <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
 <20230307082102.27195-1-jehoon.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307082102.27195-1-jehoon.park@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 07, 2023 at 05:21:00PM +0900, Jehoon Park wrote:
> From: jehoon park <jehoon.park@samsung.com>
> 
> This patchset supports CXL IDENTIFY mailbox command and corresponding
> cxl tool interface command.
> 
> CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
> information about CXL memory device. The information consist of device's
> firmware version, capacity, LSA size, event log size, poison list size,
> inject poison limit, poison handling capabilities and QoS telemetry
> capabilities. Firmware version, capacity and LSA size are already supported
> and used for partition commands or sysfs attributes while others are not.
> Since patches about event log [1] and poison [2] are discussed recently,
> support for those information will be helpful.

Hi Jehoon,

Does this need to be a separate command? Identify fields can be included
in cxl list options. For example, the -I option to cxl list, issues the
identify command and includes the partition related entries in that json
output.

There are other identify fields that need to be picked up, like the
poison related fields.  They need to be added to the cxl list 
options. We may want to include some when we list the poison, and
some as an option in the memdev listing.

Is there some reasoning behind separating this out? If not, can we look
to add the missing fields to the various cxl-list options and add
new cxl-list options where needed?

Alison

> 
> Example:

Users expect json formatted output here.


> # cxl identify mem0
> FW Revision                              : BWFW VERSION 00
> Total Capacity                           : 1.00 GB
> Volatile Only Capacity                   : 1.00 GB
> Persistent Only Capacity                 : 0 B
> Partition Alignment                      : 0 B
> Informational Event Log Size             : 0
> Warning Event Log Size                   : 0
> Failure Event Log Size                   : 0
> Fatal Event Log Size                     : 0
> LSA Size                                 : 0 B
> Poison List Maximum Media Error Records  : 256
> Inject Poison Limit                      : 0
> Poison Handling Capabilities
> Injects Persistent Poison                : Not Supported
> Scans for Poison                         : Not Supported
> QoS Telemetry Capabilities
> Egress Port Congestion                   : Not Supported
> Temporary Throughput Reduction           : Not Supported
> cxl memdev: cmd_identify: identified 1 mem
> 
> This patch is RFC because some of the information are already provided by
> "list -m <memdev>" command and sysfs attributes.
> I think a separate cxl tool interface command for identify is useful to provide
> device's information clearly. In case of nvme-cli, there are separate
> interface commands for identifying controller and namespace: id-ctrl and id-ns.
> 
> [1] https://lore.kernel.org/linux-cxl/20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com/
> [2] https://lore.kernel.org/linux-cxl/cover.1676685180.git.alison.schofield@intel.com/
> 
> jehoon park (2):
>   libcxl: add accessors for IDENTIFY command
>   cxl: add identify command to cxl tool
> 
>  Documentation/cxl/cxl-identify.txt |  57 ++++++++++++
>  Documentation/cxl/meson.build      |   1 +
>  cxl/builtin.h                      |   1 +
>  cxl/cxl.c                          |   1 +
>  cxl/lib/libcxl.c                   |  73 +++++++++++++++
>  cxl/lib/libcxl.sym                 |  11 +++
>  cxl/lib/private.h                  |  11 +++
>  cxl/libcxl.h                       |  16 ++++
>  cxl/memdev.c                       | 141 +++++++++++++++++++++++++++++
>  9 files changed, 312 insertions(+)
>  create mode 100644 Documentation/cxl/cxl-identify.txt
> 
> 
> base-commit: b830c4af984e72e5849c0705669aad2ffa19db13
> -- 
> 2.17.1
> 
