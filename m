Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6529EC433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbiKRPSt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Nov 2022 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiKRPSr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Nov 2022 10:18:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954991CB08
        for <linux-cxl@vger.kernel.org>; Fri, 18 Nov 2022 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668784725; x=1700320725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R1M0sNPEEoGr2usmtHfeE3jJ02PLnpogHAOg+ZtLG/k=;
  b=AHOGqKhzV+GUWR3OKEOR34SwucGRLlju+whJwlbLFITxweRm2NVUClXo
   FkrLmZjnkDTcC9s5ersVauLG7WrfMNg4bMmZnst27xIUoEZdBnaVJhTcK
   xPeRFq6b6Di04ZlCav0IyVPpajK0hL3HOwoe4RqYPTLhExV0/yu790VdX
   iA4EcyP9qK5ycQwNVCb2yW70rdOiztmoA5C3QZ+FakX2X6r3N3OIUorZB
   eEPQux8jFwlnGHJwlzl6nDJFiskMzzJ+AFHfyN921JBWPrKK5+QXpXTGo
   GluyQ7OdldMxmDm5pm+/hEJXdb7oQIZBdoziaz2jkPjiWa5rfme840Hca
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313166872"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313166872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:18:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618038985"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="618038985"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.83.104]) ([10.212.83.104])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:18:44 -0800
Message-ID: <c71a8cea-b2d1-8190-51d0-754f80aa96a0@intel.com>
Date:   Fri, 18 Nov 2022 08:18:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: trace events
Content-Language: en-US
To:     Marek Bykowski <marek.bykowski@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org
References: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
 <Y3bW8CLw8xcbrfav@aschofie-mobl2>
 <20221118135311.12cb241d@ubuntu.armcompdev.pub.tds.tieto.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221118135311.12cb241d@ubuntu.armcompdev.pub.tds.tieto.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/18/2022 6:53 AM, Marek Bykowski wrote:
> On Thu, 17 Nov 2022 16:50:56 -0800
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
>> There are a few patchsets under review that are using trace events
>> in CXL. I'm working on one for CXL Poison Retrieval.
>>
>> There is also tool support, the monitor patchset, making its way
>> upstream for ndctl that uses the trace events.
>>
>> I haven't looked at lttng.
>>
>> Can you share more about your project?
> 
> Hi Alison,
> 
> There should be already plenty of tools using the trace events,
> libtraceevent, libtrracefs and trace-cmd, lttng, but I guess
> another one may be of use too. When do you think it should be out
> for testing?
> 
> For the project, it is strictly secret, and I shouldn't reveal too
> much publicly, as I was told at least, but what we do we basically
> test a CXL root complex in RTL/verilog that instead of being synthesized,
> gets compiled to a VCS sim (a simulator) that in turn gets
> connected through the BFM (bus-function-model) to another simulator,
> simics or qemu. The connection to another simulator is for having
> the root complex to test it against something.
> 
> So to serve the purpose I need a good grip at what is happening at
> a very low level, ideally with the CXL operation taken down to the
> register access/mnemonics, especially throughout the enumeration
> phase, which we think will the primary source of all the defects to be
> caught up and fixed in RTL.
> 
> I hope our paths would cross at some point in which the HW will be
> finding its way to Linux with all the support it requires.
> 
> Any tips/suggestions how I can use Linux for now effectively to
> achieve my goals is highly appreciated.

Hi Marek. Have you looked into enabling ftrace? Maybe that would be the 
right starting point for what you are looking for?

https://lwn.net/Articles/365835/

> 
> Thanks,
> Marek
