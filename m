Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923C8C77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjD1VFD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 17:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346736AbjD1VEz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 17:04:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686AE10CF
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682715894; x=1714251894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQLmGcMdnictUZ8svn2C/pH1tjYgS6nksWqNzF35XlA=;
  b=HsOBMNIYT7FcEBKuyiGTXaro8YKd4I9HAflBIppKn4pz3xZERBLPlWcv
   krPwu5FD+SRMIegly1rYwkIDs7cNeBvrTeVHXsyHJxC6OoEVTI6lPAVvb
   920H79JOCeFu7+aYD1kLJp8XLHh1SUfpPRYgGvpWGNQjv6QCQJy6/gQ9G
   PoPDSjfQSyAnnsZDraXiqMKte4k0SxFtEK/Yn9gSYEjFUbUNbXq3xi1Nv
   fkJGOBwENCAhopn4Us4N3iTptr950LSNY6un9l9xfzLEHlP22r6BswkJY
   wMwwgCVGacWeeuZ2iDCbsXpBNw86eVv0ADTyRM8j2ZB7T1LsiJIVPMJGK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349889228"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="349889228"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="694941998"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="694941998"
Received: from egliskay-mobl.amr.corp.intel.com (HELO [10.212.108.170]) ([10.212.108.170])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:04:53 -0700
Message-ID: <c649c0f9-b6ef-d391-143c-eed3c6b5df11@intel.com>
Date:   Fri, 28 Apr 2023 14:04:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
 <cb80b111-c639-aaff-f8dd-8ceacf124b1a@intel.com>
 <lq33scjudy22a7xpa7vrefhfk6uolzy6wvq4wimwvwg4emeo53@aa6n2n5up3gh>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <lq33scjudy22a7xpa7vrefhfk6uolzy6wvq4wimwvwg4emeo53@aa6n2n5up3gh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/28/23 10:18 AM, Davidlohr Bueso wrote:
> On Fri, 28 Apr 2023, Dave Jiang wrote:
> 
>>> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
>>
>> I apologize if I've asked this before and you've already answered.
>> What is the reason the mbox_wait a module global wq instead of a per
>> device wq? Just thinking when you tear down a device, you may want to
>> wake all pending for that device to clean up.
> 
> Yes, I agree that doing the wait per-device is better, and not only
> for tear down reasons. By doing it globally, the queue reflects waits
> from different devices, but the driver really has no control about
> the order of the wait of each device is, so upon a blind wake_up(),
> it could perfectly well be that the first node in the waitq is not
> the node for that device.
> 
> This all goes away with per-device, with the note that because of the
> mbox_mutex there never will only ever be a single waiter, so no concept
> of a queue really.

If there's only a single waiter then I think a 'completion' can be used 
instead right?

> 
> Thanks,
> Davidlohr
