Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30487FA373E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiJYRvh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiJYRvg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 13:51:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1DB80BF9
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666720294; x=1698256294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MBVERkkt70iccYeJsBUjfmiUk6qKecwrBXLayZDC6dk=;
  b=hxQOcKiV4YatcRXFsfV9vVMgDkNSVRiS/jq4CiD/o3xy6EzwO3rGXMuk
   kWN7fl3jxanRybOQB+BasCrKh2nfj88tk5WfPDtOdofLWkF5QNzOw08NC
   YWvkALSJYoDlJzU23KcoHlOixHoxzzfax0c1FHpJxiuGRAHr1nD2ErsA2
   UgMho3DGaG6IkPT5fKeC6za10TCMmIEDlD0KQ8rj3z/k2ONPHLX5rTIGY
   LmWAtkb0rhWZe2DA2ToayVA9BcSoeDYj8SnFuOqHGxaXMF3ssc57ZPaxK
   lOgTp0+SFmU4OakTFtnFh2miguF8vUtEj/TvM16CQhdT42XCGn56WN9uP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="295153535"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="295153535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 10:51:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="626510133"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="626510133"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.126]) ([10.212.108.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 10:51:33 -0700
Message-ID: <26e06276-cc96-3485-a8ef-cd0f91a16e1f@intel.com>
Date:   Tue, 25 Oct 2022 10:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v3] cxl: check decoder count for end device
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <166662616015.232090.4970569004666131514.stgit@djiang5-desk3.ch.intel.com>
 <20221025120842.00003c29@huawei.com>
 <63581f1c896be_4da329499@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63581f1c896be_4da329499@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/25/2022 10:38 AM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Mon, 24 Oct 2022 08:43:30 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
>>> indicates that for devices, only 10 decoders should be advertised. Add
>>> check on number of decoders greater than 10 for devices and emit warning.
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> I wonder... Should warning say CXL r3.0 spec violation?
>>
>> Seems possible this might grow in future versions and so it
>> might be nice to give a hint that it 'might' be valid in a higher spec version?
>>
>> I don't care strongly either way though.
>>
>> FWIW
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>>> ---
>>>
>>> v3:
>>> - Fix commit header and output message to reflect code change from v2.
>>>
>>> v2:
>>> - Remove decoder count reassignment from violation (Dan)
>>>
>>>   drivers/cxl/core/hdm.c |   10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index d1d2caea5c62..c3b756f93261 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>>> @@ -71,9 +71,19 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>>>   static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>>   {
>>>   	u32 hdm_cap;
>>> +	struct device *dev = &cxlhdm->port->dev;
>>>   
>>>   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>>>   	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
>>> +	/*
>>> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
>>> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
>>> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
>>> +	 * found.
> Stale comment, the "Set the decoders to 10" is no longer done.
>
>>> +	 */
>>> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
>>> +		dev_warn(dev, "Endpoint decoder count (%d) > 10, spec violation!\n",
>>> +			 cxlhdm->decoder_count);
> This is still too scary for how the kernel is going to handle it. I
> would expect:
>
> dev_dbg(dev, "Endpoint decoder count %d, expected max 10\n")
>
> ...what downside are you seeing that's prompting this patch? Sometimes
> Linux might want to constrain what hardware can do to avoid code
> maintenance burden, but I do not see that harm here. Otherwise, there
> are users that treat any log message above KERN_NOTICE priority as a
> sign of a broken system. Is a platform with an endpoint with 16 decoders
> broken? Also, if we do this bounds check for endpoints why are we not
> doing it for bridges for the > 32 case?

This is purely the spec changed for 3.0. Should I add check for bridges 
as well and add debug emit for both or just drop it entirely?


