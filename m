Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84824C6FA82
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Sep 2022 21:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiITVTz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiITVTw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Sep 2022 17:19:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8D64AD75
        for <linux-cxl@vger.kernel.org>; Tue, 20 Sep 2022 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663708791; x=1695244791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vr9YOJICCI4tMubrOSRByKa3DbSafA0akMjZkC8wOmk=;
  b=iH130DU6IQypjjhe03OupPr7o5gBX3JnlwuWzMUhuYdZMWy3xSCfdox1
   cVPAJ/cLbCgpMEQuwAB+fm0dSvV50mFfsRbH/dfnLzF7lfTPemZ2xX9P9
   X6f3s8FZx0vjXbHodkTXlqCIsMUDkg4wQ4hOOiqUra7KJIo845q509pL0
   ldlRz62UQC62fngYa1AEHULHzy4OrlXVEKsftrpN22lnMUMDb2A/sqI5+
   KtoPNNVx19otx41Seg2TYoaq/bMHQn/2HnWOygbgOn4HtZOMBUfyym0lR
   k90/5Gkg5e1pZEgqIIIQaDhm6KRFQOLNTUEUOl5NqsueHeWVXNRgnBa7X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="286888908"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="286888908"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 14:19:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="652256999"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.25.89]) ([10.212.25.89])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 14:19:49 -0700
Message-ID: <18abd777-ab75-c3fa-5556-0965f2cc58c2@intel.com>
Date:   Tue, 20 Sep 2022 14:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [ndctl PATCH 0/6] cxl/test: Add more region ABI validation
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/5/2022 1:37 PM, Dan Williams wrote:
> Expand cxl-region-sysfs.sh to validate that all decoders in the test
> region are setup per expectations. In support of that testing, decoder
> listings gain 'interleave_ways', 'interleave_granularity', and 'region'
> attributes, while port listings gain a 'depth' attribute. Decoders can
> now be filtered by their associated region.
>
> ---
>
> Dan Williams (6):
>        cxl/test: Validate endpoint interleave geometry
>        cxl/list: Add interleave parameters to decoder listings
>        cxl/list: Add region to decoder listings
>        cxl/list: Filter decoders by region
>        cxl/list: Add 'depth' to port listings
>        cxl/test: Validate switch port settings in cxl-region-sysfs.sh
Reviewed-by: Dave Jiang <dave.jiang@intel.com> for the series
>
>
>   Documentation/cxl/lib/libcxl.txt |    8 ++++++
>   cxl/filter.c                     |   23 +++++++++++++++++
>   cxl/json.c                       |   32 +++++++++++++++++++++++
>   cxl/lib/libcxl.c                 |   39 +++++++++++++++++++++++++++++
>   cxl/lib/libcxl.sym               |    2 +
>   cxl/libcxl.h                     |    2 +
>   test/cxl-region-sysfs.sh         |   52 +++++++++++++++++++++++++++++++++++++-
>   7 files changed, 156 insertions(+), 2 deletions(-)
