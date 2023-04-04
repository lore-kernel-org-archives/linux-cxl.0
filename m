Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B204C76188
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Apr 2023 00:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjDDARC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDARB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Apr 2023 20:17:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20AA6
        for <linux-cxl@vger.kernel.org>; Mon,  3 Apr 2023 17:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680567420; x=1712103420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gK3zfwjjvZEBkTTwY7Pll/xInJNT+a1e9MQ5dXe1oWc=;
  b=d5MKusj2MgXmmJWot1x6s5l4AQomO0h7PZEKl2xTSC1JBexoC+nZ61SL
   3kQANqlIfiUhJzdnW+scZ+s3w+MPUQ9SrjntxUY/AGe8gE5BVMaWfDxQg
   Ej1+lFm47oZkGU7a67coY59SDSc/cqR//UPaAQZpO20G40NAc/oVqFVTy
   Wl+Mu/X0tV41awfVcJf9Ieix3O2icZEmg6Klufhp5WybAp9lI7oB/47rt
   idWZ2n1lxw09Cjbkrg3scSSCPwZb9taiKJtIjzTkQqlOTNXve1bl25lFh
   MB39TDyNBP8X7JgzHXz1iS2o2QAnCiKj9472X58xivXvn8bTr+59ouaMV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="326066102"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="326066102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 17:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="636311991"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="636311991"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.181.144]) ([10.213.181.144])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 17:16:59 -0700
Message-ID: <f2ff608d-d984-1aab-18e2-ae1fcd65413c@intel.com>
Date:   Mon, 3 Apr 2023 17:16:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
 <1dc1b324-8e77-f98d-3fd0-a20cbf328d2f@intel.com>
 <642b6a7a3b806_29cc29486@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <642b6a7a3b806_29cc29486@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/3/23 5:08 PM, Dan Williams wrote:
> Dave Jiang wrote:
>>
>>
>> On 4/3/23 4:06 PM, Dan Williams wrote:
>>> One motivation for mapping range registers to decoder objects is
>>> to use those settings for region autodiscovery.
>>>
>>> The need to map a region for devices programmed to use range registers
>>> is especially urgent now that the kernel no longer routes "Soft
>>> Reserved" ranges in the memory map to device-dax by default. The CXL
>>> memory range loses all access mechanisms.
>>>
>>> Complete the implementation by filling out ways and granularity, marking
>>> the DPA reservation, and setting the endpoint-decoder state to signal
>>> autodiscovery.
>>
>> If you don't mind making a note that the default values of ways and
>> granularity are coming from cxl_decode_init(). Thanks.
> 
> Changed this paragraph to:
> 
> Complete the implementation by marking the DPA reservation and setting
> the endpoint-decoder state to signal autodiscovery. Note that the
> default settings of ways=1 and granularity=4096 set in cxl_decode_init()
> do not need to be updated.

LGTM

> 
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks!
