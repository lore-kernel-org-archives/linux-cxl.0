Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A927AC6FA82
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Sep 2022 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiIVOpc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiIVOpa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Sep 2022 10:45:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0F8AF492
        for <linux-cxl@vger.kernel.org>; Thu, 22 Sep 2022 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663857929; x=1695393929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=20sb3Wjzl+N9vcq9tCuMImS7/O2aiJpn3n5hHt87sbY=;
  b=gGSskBomzzI5uQPrTewjgUwE80S1j7GyytIiHy9Q+dagaVHLFcG6p8LI
   OTbllG1DmCzqjyBpG4UKOz78bzgGrDwPsguxyc32bsjkiWSFvTAFxouNZ
   Ng8toq/MDS5jX/aTJbqp6jhCB8/9+o+iitvfYcGPJEU2ckD/X4vpd9YEZ
   zK93wY6GDmwLKYzj6Y7exbGV5UHuLQNgh2IzAtiJYFKBe74Hi2K0jdtYn
   S9Kcp+f+p6RkHYoORAVkBmUSu2jGM4ewnASsJJw1MHrc8T4PK4SUCI20L
   JHlVaTMLp66ly+YwrFqR7tuiUnZWACNvxLSztSnxzJQVVpPTP7IP2PhbM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301162697"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301162697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:45:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="682240195"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.80.137]) ([10.212.80.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:45:28 -0700
Message-ID: <d1906809-1c14-f19b-018c-9a6ae1614b82@intel.com>
Date:   Thu, 22 Sep 2022 07:45:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 0/7] ndctl: cxl: add monitor support for trace events
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <20220922152154.00007386@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220922152154.00007386@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 9/22/2022 7:21 AM, Jonathan Cameron wrote:
> On Wed, 14 Sep 2022 13:47:49 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> This patch series for ndctl implements the monitor command for the cxl tool.
>> The initial implementation will collect CXL trace events emitted by the
>> kernel. libtraceevent and libtracefs will be used to parse the trace
>> event buffer. The monitor will pend on an epoll fd and wait for new event
>> entries to be posted. The output will be in json format. By default the events
>> are emitted to stdio, but can also be logged to a file. Each event is converted
>> to a JSON object and logged as such. All the fields exported are read by the
>> monitor code and added to the JSON object.
> Hi Dave,
>
> FYI, I just wanted to mention that we will be aiming to duplicate a bunch
> of this functionality in rasdaemon.
>
> As that is handling the equivalent of many of these events on our systems
> from other components we don't want to grab the data via alternative tooling
> and then have to merge it later.
>
> Absolutely not a problem to have it in this tool as well. I mostly wanted
> to raise it because longer term we'll need to be careful to test with both
> solutions if there are any changes to what they are being sent.

Thanks for the heads up Jonathan!


>
> Thanks,
>
> Jonathan
>
>> ---
>>
>> Dave Jiang (7):
>>        ndctl: cxl: add helper function to parse trace event to json object
>>        ndctl: cxl: add helper to parse through all current events
>>        ndctl: cxl: add common function to enable event trace
>>        ndctl: cxl: add common function to disable event trace
>>        ndctl: cxl: add monitor function for event trace events
>>        ndctl: cxl: add logging functions for monitor
>>        ndctl: cxl: add monitor command to cxl
>>
>>
>>   cxl/builtin.h     |   1 +
>>   cxl/cxl.c         |   1 +
>>   cxl/event_trace.c | 236 ++++++++++++++++++++++++++++++++++++++++++++++
>>   cxl/event_trace.h |  23 +++++
>>   cxl/meson.build   |   4 +
>>   cxl/monitor.c     | 235 +++++++++++++++++++++++++++++++++++++++++++++
>>   meson.build       |   3 +
>>   7 files changed, 503 insertions(+)
>>   create mode 100644 cxl/event_trace.c
>>   create mode 100644 cxl/event_trace.h
>>   create mode 100644 cxl/monitor.c
>>
>> --
>>
