Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E537DC433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jan 2022 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiAGWqd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:46:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:6629 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbiAGWqd (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 7 Jan 2022 17:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641595593; x=1673131593;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=PLbe2U12s+p3QaQLSUDB0vGbPz4PjL9pp6ut+sJNQyE=;
  b=dHmG4V+d9JWpPa+EzZtRgNTTCmb0VgiBSA9rRHIjR+YfKalxSt0PZYRP
   iHWoKUn2AQE3ZTFDj8TidMxfcGeltr7lIRU2YqtPTGdtjh2StcucNG9rE
   d6cMDOYAA5Lhmg0Oyl8wv0MIGlZbB8aZO/4s6RKQoAzOSPRhnyYRWJ+gg
   bMvWw5HTF6dxrtDUspA9f3nuXsaSUbalRcwcfn8/pXpSLLf2lQgjgnaZ8
   RjDkkD3Mvyp/V3xwA/jVX/lvBLtxzq5P7btwz4+o9Z7phcSg3VCiBSmaD
   L2Y2PSCOeLCH/fH0qmnNAnYZRlWNAI6UcViK5hurdZoOoTFx76ylPa9wB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229761504"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229761504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:46:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="591840552"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:46:32 -0800
Date:   Fri, 7 Jan 2022 14:51:41 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 7/7] cxl: add command set-partition-info
Message-ID: <20220107225141.GC804232@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <fd590fbbc2f1abaeca1fd368d26c4e90c3a89d69.1641233076.git.alison.schofield@intel.com>
 <20220106210526.GH178135@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106210526.GH178135@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 06, 2022 at 01:05:26PM -0800, Ira Weiny wrote:
> On Mon, Jan 03, 2022 at 12:16:18PM -0800, Schofield, Alison wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> 
> "User will need a command line option for setting partition info.  Add
> 'set-partition-info' to the cxl command line tool."
> 
> > The command 'cxl set-partition-info' operates on a CXL memdev,
> > or a set of memdevs, allowing the user to change the partition
> > layout of the device.
>                 ^^^^^^
> 		device(s).
> 

Got it. Thanks!

> > 
snip

> 
> Did I miss the update to the cxl-list command documentation?
You must've blinked ;)
See Patch 4 - cxl: add memdev partition information to cxl-list

> 
snip
>
> > +
> > +	rc = cxl_memdev_set_partition_info(memdev, volatile_request, 0);
> 
> CXL_CMD_SET_PARTITION_INFO_NO_FLAG?

Yeah...I couldn't get to that at the last minute. 
Will figure that out and use it here.
Thanks!

> 
> Ira
