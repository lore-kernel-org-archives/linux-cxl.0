Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BB7C6379F
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 23:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAMXjC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAMXjA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 18:39:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006075770
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 15:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673653140; x=1705189140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zoU3VRR4k67vCrbAOYLziEBFjwMfiZs0b0Vt8vX5OTc=;
  b=Jzfbqg+77lLu5VuoJySIesF4qLQ/Yw4yMx1zAOFr5Fiaz5TLgEq8lDo8
   spsAWIDMi7GPUrkyMpeaSZYFV/hdWj+w1toDYmuDEjYo/f3g2r6rKM2yr
   Xahr062kQw7XThPbEuEoGhUYS8oVrvbNT/k5OZwxIFY+umg5HzCAWb0B9
   hgSVNz9mdr39jJbdX+G+T4cZXWJO/Xgy20WUM6pFXETD6S9XHM7MW+npj
   nEdMy/hvMI9Y5HcilQRO0+D1ATORJGMd9XWfDx49y9DX3EWm/lVON63u2
   MIFAVRI13UXM5AcXV0TNslx3VspGp2t0AdmJ3uAm0SxeyPNVvQXTXvLz2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322830830"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="322830830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 15:38:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="832228989"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="832228989"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.60.10]) ([10.212.60.10])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 15:38:59 -0800
Message-ID: <db7638b1-f452-9177-4b3a-25f4b91d4e49@intel.com>
Date:   Fri, 13 Jan 2023 16:38:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl: fix cdat_available state post error
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <167364543268.908947.8539778012050364814.stgit@djiang5-mobl3.local>
 <Y8HrPQo/9CmJh1WZ@iweiny-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Y8HrPQo/9CmJh1WZ@iweiny-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/13/23 4:37 PM, Ira Weiny wrote:
> On Fri, Jan 13, 2023 at 02:30:34PM -0700, Jiang, Dave wrote:
>> Given that the sysfs attributre for CDAT_read() checks port->cdat_avilable,
>> it indicates that the binary backing cdat must be present.
>>
>> port->cdat_available is set to true in read_cdat_data() before the data is
>> actually read. When error happens during read, this state is never set to
>> false. Move the setting of the attribute to after everything is done to
>> ensure it's always true.
> 
> Actually port->cdat_available does not indicate that the data was read.  Only
> if the sysfs entry should be there:
> 
> ...
>   * @cdat_available: Should a CDAT attribute be available in sysfs
> ...
> 
> The table pointer should be checked to see if the data is actually available.
> If data is not available the sysfs will return no data.

Ok that makes sense. I only verified to see if cdat_available was 
checked in the sysfs function but didn't read further. Patch dropped.

> 
> Ira
> 
>>
>> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/pci.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 1d1492440287..91cdd6a00964 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -601,8 +601,6 @@ void read_cdat_data(struct cxl_port *port)
>>   		return;
>>   	}
>>   
>> -	port->cdat_available = true;
>> -
>>   	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
>>   		dev_dbg(dev, "No CDAT length\n");
>>   		return;
>> @@ -621,6 +619,8 @@ void read_cdat_data(struct cxl_port *port)
>>   		port->cdat.length = 0;
>>   		dev_err(dev, "CDAT data read error\n");
>>   	}
>> +
>> +	port->cdat_available = true;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>   
>>
>>
