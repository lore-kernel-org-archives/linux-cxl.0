Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64390C4321E
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 23:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiKRXiQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiKRXhw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Nov 2022 18:37:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8D6D972
        for <linux-cxl@vger.kernel.org>; Fri, 18 Nov 2022 15:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668813748; x=1700349748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oPwdf6F4F+oocK+wrO2gaCDcf4S6DyiNIMgmWjzmCEg=;
  b=ibaSOUEX9VdGXfxIYRuJQrXsAeSR5yNAGYHypWVNOmYGttvSPttKrrVe
   k4vjG5rMqzNMXJdnadio1Vpt4lyPwDzUypC/nLMPl8ibLWjfzN4ARHu6C
   UvWydtBcENWnG/LW26sx+DSHi5no37vVQRPqnzkvkVv//y/i4SbHaZ1cl
   iArKYlvSECOTdfAYyDmwpLPF94UFShfRvvgb2CSHbCpKJDI/EalyUdzyF
   1YVv7R+hjGI52/ssGvk2KgQpQ4nK/5fvce3zMBbK0io50lhegZfQ81cev
   /LwWyhv0N60MV7WnxjQpeDay4OCUeyQS5jhhYT8rMkpwfXq1nRESWI04n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="292970743"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="292970743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 15:22:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="634593516"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="634593516"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.83.104]) ([10.212.83.104])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 15:22:27 -0800
Message-ID: <eb11a59e-d5ac-8ba7-06ec-ff895caffffd@intel.com>
Date:   Fri, 18 Nov 2022 16:22:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: trace events
Content-Language: en-US
To:     Marek Bykowski <marek.bykowski@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
References: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
 <Y3bW8CLw8xcbrfav@aschofie-mobl2>
 <20221118135311.12cb241d@ubuntu.armcompdev.pub.tds.tieto.com>
 <c71a8cea-b2d1-8190-51d0-754f80aa96a0@intel.com>
 <20221118223913.075752fd@ubuntu.armcompdev.pub.tds.tieto.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221118223913.075752fd@ubuntu.armcompdev.pub.tds.tieto.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/18/2022 3:39 PM, Marek Bykowski wrote:
> On Fri, 18 Nov 2022 08:18:43 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> 
>>
>> Hi Marek. Have you looked into enabling ftrace? Maybe that would be
>> the right starting point for what you are looking for?
>>
>> https://lwn.net/Articles/365835/
>>
> 
> That was my initial idea but if there are no trace events defined for
> the CXL what am I to enable? At least I cannot find any events for CXL,
> there is no file include/trace/events/cxl.h in kernel/git/cxl/cxl.git.
> Also
> 
>    find /sys/kernel/debug/tracing/events/ -name "*cxl*"
> 
> on linux-cxl returns nothing.
> 
> Alison mentioned she is working on some but these are yet in review.
> 
> As putting the trace events throughput the CXL driver/s takes time I
> took a shortcut and added trace_printk scattered around for now. With
> libtraceevent, trace-cmd and kernelshark and it is looking fantastic,
> except it is not the CXL events as per-se.
> 
> root@localhost:~# trace-cmd show |tail -n 2
>     systemd-udevd-520 [004] ..... 21.236650: devm_cxl_enumerate_decoders: \
> 			success adding decoder to port endpoint5
>     systemd-udevd-520 [004] ..... 21.240517: devm_cxl_enumerate_ports.cold: \
> 			find_cxl_port() returned port port2

For kernel we are enabling trace events for CXL. But those events are 
stemmed from hardware events. Ira is enabling CXL events defined by the 
CXL spec and emitted by the devices. Alison is enabling CXL events for 
poison data. And I'm enabling CXL events for PCIe AER errors.

But I think you want different type of events right? i.e. the flow of 
the driver? I believe ftrace can enable function names for ftrace. Is 
that what you are looking for?

https://opensource.com/article/21/7/linux-kernel-ftrace
https://jvns.ca/blog/2017/03/19/getting-started-with-ftrace/
https://lwn.net/Articles/370423/
