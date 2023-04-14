Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76488C77B72
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 23:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDNX2P (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 19:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDNX2N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 19:28:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD79B9746
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681514869; x=1713050869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ILRkWBCiI4xpkxe3llonpDgUvzLsa45iQgO0zK7ssg=;
  b=Zg1vDCBGND/4KC8/fSxM5exVkDdAkKvQVmXsXqPkD+d3dsHKBFc+1wx2
   y1tQBOPvfwCbO2uEv7/NXBczYDXdCygNbS8+qvdKrUPyM8KXTmR9v+MrL
   oS6QrQxTzD1Z0EUidAKh4qxwyCTttRhNpvRFaTmxGBy/qun135LPvXO8j
   pN2IJlTSq9PwwKvRFoHemH+wrSLGlJycBwDbihVlQ74n/VHJCJOtD2yD2
   qZKN0i2CIlTJmi6DYzc8MPYDitN5kQQztlo9UZ+DfPOaHBxLU3zBGwvgJ
   KB4jO85V/zyMN47RfvDIkPc1l1W8Ci0ZdTpON+avlQ7glxxB5zsNW1293
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="407478298"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="407478298"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 16:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="720450375"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="720450375"
Received: from tpattadx-mobl1.amr.corp.intel.com (HELO [10.212.122.87]) ([10.212.122.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 16:27:47 -0700
Message-ID: <cbee0ae4-0aa5-d2aa-649d-a0c2ef4b2e83@intel.com>
Date:   Fri, 14 Apr 2023 16:27:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [NDCTL PATCH 0/3] ndctl: Add support of QoS Throttling Group
 (QTG) id for CXL CLI
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
References: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
 <ZDnKciEJe80+2yrz@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZDnKciEJe80+2yrz@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/14/23 2:49 PM, Alison Schofield wrote:
> On Fri, Apr 14, 2023 at 10:42:55AM -0700, Dave Jiang wrote:
>> The series adds support for the kernel enabling [1] of QoS Throttling Group
>> (QTG) id. The kernel exports a QTG id for the root decoders (CFMWS) and as
>> well as for the CXL memory devices. The QTG id exported for a device is
>> calculated by the driver during device probe. Currently a QTG id is exported
>> for the volatile partition and another for the persistent partition. In the
>> future QTG id(s) will be exported for DCD regions. Display of QTG id is
>> through the CXL CLI list command.
>>
>> A QTG id check as also been added for region creation. A warning is emitted
>> when the QTG id of a memory range of a CXL memory device being included in
>> the CXL region assembly does not match the QTG id of the root decoder. Options
>> are available to suppress the warning or to fail the region creation. This
>> enabling provides a guidance on flagging memory ranges being used is not
>> optimal for performance for the CXL region to be formed.
> 
> Can you cut/paste me some cxl list sample output?  I'm not going to be
> trying this out to review.
# cxl list -D
[
   {
     "decoder":"decoder0.0",
     "resource":49660559360,
     "size":4294967296,
     "interleave_ways":1,
     "max_available_extent":4294967296,
     "pmem_capable":true,
     "volatile_capable":true,
     "accelmem_capable":true,
     "qtg_id":0,
     "nr_targets":1
   },
   {
     "decoder":"decoder0.1",
     "resource":53955526656,
     "size":4294967296,
     "interleave_ways":2,
     "interleave_granularity":8192,
     "max_available_extent":4294967296,
     "pmem_capable":true,
     "volatile_capable":true,
     "accelmem_capable":true,
     "qtg_id":0,
     "nr_targets":2
   }
]

# cxl list
[
   {
     "memdev":"mem3",
     "ram_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:c5:00.0"
   },
   {
     "memdev":"mem5",
     "pmem_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:c2:00.0"
   },
   {
     "memdev":"mem2",
     "ram_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:c4:00.0"
   },
   {
     "memdev":"mem7",
     "pmem_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:c3:00.0"
   },
   {
     "memdev":"mem6",
     "ram_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:38:00.0"
   },
   {
     "memdev":"mem1",
     "pmem_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:37:00.0"
   },
   {
     "memdev":"mem4",
     "ram_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:39:00.0"
   },
   {
     "memdev":"mem0",
     "pmem_size":268435456,
     "qtg_id":0,
     "serial":0,
     "host":"0000:36:00.0"
   }
]



> 
> Thanks!
> 
> 
>>
>> [1]: https://lore.kernel.org/linux-cxl/168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3/T/#t
>>
>> ---
>>
>> Dave Jiang (3):
>>        ndctl: Add QTG ID support for the root decoder
>>        ndctl: Add QTG ID support for the memory device
>>        ndctl: add QTG ID check for region creation
>>
>>
>>   Documentation/cxl/cxl-create-region.txt |  9 ++++
>>   cxl/json.c                              | 22 +++++++++-
>>   cxl/lib/libcxl.c                        | 31 ++++++++++++++
>>   cxl/lib/libcxl.sym                      |  3 ++
>>   cxl/lib/private.h                       |  3 ++
>>   cxl/libcxl.h                            |  5 +++
>>   cxl/region.c                            | 57 ++++++++++++++++++++++++-
>>   7 files changed, 128 insertions(+), 2 deletions(-)
>>
>> --
>>
