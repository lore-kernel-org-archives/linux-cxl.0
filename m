Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D24BC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Nov 2022 20:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKQUoo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 15:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiKQUom (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 15:44:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9C6C73F
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668717881; x=1700253881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i8It5fkVHqJcmj5OPiUXRfI95QCdPg7L9hw2KF8+f+k=;
  b=MN0yEptIIc0vgQOIHPQFb8dzF/OleSA3MlxGP+5tIKE3PCvAqEFGP8sU
   FUuJ90jSf7SXky9B/8fCQXEHxULHn01Pzo7DOJ52bGlupl5wRRG/l5lLV
   MJchppuvJKvr6st/efcHhQzoRZgD+eqAfct99L2vaul14qQtmVigSixin
   ql8hoIv6Os9M8wzaU2zAiDFn/5DyWKlVuOfABLcvO64gqi65vnxoJ62MP
   7+H/GU40sr59pAwoI6rRuIQFWrOpNyjmvt69S2eY9Xag+RDflqfVd+ned
   2VwT747M0f4thmib1LEq0OUztxAHUaEnelLf+ifhtTRJXLUch9WRhSv34
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292674301"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="292674301"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 12:44:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="885024669"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="885024669"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.213.166.194]) ([10.213.166.194])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 12:44:41 -0800
Message-ID: <0098a689-0887-fe52-27ec-3526ada0fcff@intel.com>
Date:   Thu, 17 Nov 2022 13:44:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v4 05/10] cxl: add monitor function for event trace events
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
 <166793221692.3768752.18351228388707416243.stgit@djiang5-desk3.ch.intel.com>
 <20221117133743.67ecd167@gandalf.local.home>
 <61ddbc4e-2b2c-020e-b872-39d23e94ddb5@intel.com>
 <20221117153345.478f2b67@gandalf.local.home>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221117153345.478f2b67@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/17/2022 1:33 PM, Steven Rostedt wrote:
> On Thu, 17 Nov 2022 13:29:42 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>>> as well iterate over the live stream:
>>>
>>>     https://www.trace-cmd.org/Documentation/libtracefs-doc/libtracefs-iterator.html
>>
>> Hi Steve,
>> After looking those over, I'm uncertain how the new APIs would apply
>> here. I'm only using fd to the trace_pipe for epoll notification of new
>> events for the instance. Otherwise I'm using
>> tracefs_iterate_raw_events() to retrieve and parse the events.
> 
> Ah sorry, I didn't look farther to see how it was being used.
> 
> And I plan on adding a tracefs_wait(instance, percentage) function that
> will do just that, but haven't implemented it yet.

Ah great! Looking forward to convert the code to use that in the future.

> 
> -- Steve
