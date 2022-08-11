Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0459DC25B06
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiHKXW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiHKXWZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:22:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A654A1A47
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660260145; x=1691796145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HYJySIfAgQaXmbb0iZb4Xjciw7Es0s6kz7wp3lAAqUY=;
  b=bkpW1+YT3vIIMUIxt29sHl0tadOnMTSeqcTZxy0P7YkMns3B1MP3y25x
   +FcaUKjkvKvMQBg/QNTprvQu4RDNDITA9Ib7BaremTXohft9TgJ3XVPvU
   DA6NqHMWy+jo70+7QLotjD87OH7mV8OrVYYT99zFX1l3ztVLFVJaxn0MU
   CKkHMF8sn4GJR+sRuCQax44SdH8ImQeNXG64W3m3d1RTr/KHc3UxndFpg
   HrQ5Ukp63gvee7nj+lXI2Ob5H4NA1paxCzj1WG1IxpmHxNX0ig/6APTWs
   V8tpiZ2Z6nUvotN0s5ab6usyODIj0itewL6F2txFhCt3LEtEeW95y/2i4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271256751"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271256751"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:22:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="933510965"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.81.242]) ([10.212.81.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:22:24 -0700
Message-ID: <1cb35809-e86a-61d2-daae-f47a8931fd36@intel.com>
Date:   Thu, 11 Aug 2022 16:22:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] tools/testing/cxl: Add interleave check support to
 mock cxl port device
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999282767.493131.3574006385715039923.stgit@djiang5-desk4.jf.intel.com>
 <62f2898691b06_1f18b29428@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <62f2898691b06_1f18b29428@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/9/2022 9:21 AM, Dan Williams wrote:
> Dave Jiang wrote:
>> Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
>> to check the interleave configuration. Set the interleave_mask as well
>> to support the new verification code.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   tools/testing/cxl/test/cxl.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index a072b2d3e726..5a9f33703ee7 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -398,6 +398,8 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>>   		return ERR_PTR(-ENOMEM);
>>   
>>   	cxlhdm->port = port;
>> +	cxlhdm->interleave_mask = GENMASK(14, 8);
>> +	dev_set_drvdata(&port->dev, cxlhdm);
> This would also need to set cxlhdm->interleave_cap.
Yes with the suggested change in the previous patch, we need to set the 
default 1, 2, 4, 8 bits.
>
> I accidentally called it port->interleave_cap in the last mail, but it
> belong in cxlhdm.
