Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F3EC6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 22:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiINWVF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiINWUb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 18:20:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D474DC8
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663193991; x=1694729991;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=WlGOfTAvlR0qFWlO3HlumqpzSVdsn75bv6A7jovADuU=;
  b=CDo71kf7IiYH2mLROU2sIIrhGjrMe1Z3QxlT470ZO80733K+/OY7UbuS
   8RUDrLA4B4rlmHqmrgDlM7ZVYkbQNv27Yh7NL8uPmRsITVG4tV1AGJhz7
   vXncivf6Js812jW4ztmlj0CFWsBkmbiQobNX8BpDRHBG5Tiyt0MdGAJP9
   +DsGRUSkgBWVAbJqb3bh4B9ARC0BHJot0wI98pnF0ZSHZIUYVNFO3ErY+
   ptLoIW7Hrv43GWN0txUfyR9IsZQD/7Nsa9AInBVvKqrObC1DKGdoAziji
   hf1l/Fbf88kgna171DPlj5dbH1KvlTExnJG1aqUN9EwnGn1Lbhm+qAZ7P
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298552099"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="298552099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:19:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="568180889"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.90.43]) ([10.212.90.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 15:19:50 -0700
Message-ID: <d4ccbf2d-e068-d686-ca6d-2d6ecc25d17a@intel.com>
Date:   Wed, 14 Sep 2022 15:19:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 0/7] ndctl: cxl: add monitor support for trace events
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 9/14/2022 1:47 PM, Dave Jiang wrote:
> This patch series for ndctl implements the monitor command for the cxl tool.
> The initial implementation will collect CXL trace events emitted by the
> kernel. libtraceevent and libtracefs will be used to parse the trace
> event buffer. The monitor will pend on an epoll fd and wait for new event
> entries to be posted. The output will be in json format. By default the events
> are emitted to stdio, but can also be logged to a file. Each event is converted
> to a JSON object and logged as such. All the fields exported are read by the
> monitor code and added to the JSON object.
>
> ---
>
> Dave Jiang (7):
>        ndctl: cxl: add helper function to parse trace event to json object
>        ndctl: cxl: add helper to parse through all current events
>        ndctl: cxl: add common function to enable event trace
>        ndctl: cxl: add common function to disable event trace
>        ndctl: cxl: add monitor function for event trace events
>        ndctl: cxl: add logging functions for monitor
>        ndctl: cxl: add monitor command to cxl

Missing man page and systemd service. Will add in v2. Also will add 
default log file path when running in daemon mode.


>
>   cxl/builtin.h     |   1 +
>   cxl/cxl.c         |   1 +
>   cxl/event_trace.c | 236 ++++++++++++++++++++++++++++++++++++++++++++++
>   cxl/event_trace.h |  23 +++++
>   cxl/meson.build   |   4 +
>   cxl/monitor.c     | 235 +++++++++++++++++++++++++++++++++++++++++++++
>   meson.build       |   3 +
>   7 files changed, 503 insertions(+)
>   create mode 100644 cxl/event_trace.c
>   create mode 100644 cxl/event_trace.h
>   create mode 100644 cxl/monitor.c
>
> --
>
