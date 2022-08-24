Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55710C3F6B0
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiHXVN5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiHXVN4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 17:13:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9067B2AD
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375635; x=1692911635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MZCR5t9kMwGt8i1e7Fnn6UKi1XS/kmrAImLDSqTijeo=;
  b=ctETVGdMETqejP9mZhv+5cK85GlxXssL+eCt+bAb8SxjwnMvr7NgvsqW
   Ehkhbmhh64uOeZsedoicCtF+8ZhHy8Wgr8vCaonc1o6I/vgc4nIwMgNnW
   fZc4mViDFGAPnJhEMOKN8XgRA8fV3DBB0R6whCehQtf23do2wvGr601rl
   ziOnEfvTWZzOLDb7F39NnO2RjfRjz1XQyBB90wvJgrHH2GP8i4mauugrq
   PSxhdhaHdPTzWxos3o/zif2PYpYVklth88ZWnoTHYxr1ZN1kRLf2un/OV
   qJIkjTtfgB4pXXNk+rhfB7z9UzXcMG7fQrcD+P2PEMd84wm2dSUmKvuAz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273830654"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="273830654"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:13:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678199329"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.178.56]) ([10.213.178.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:13:54 -0700
Message-ID: <a1f87adb-fe54-be84-5bdb-52dc27417474@intel.com>
Date:   Wed, 24 Aug 2022 14:13:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v4 3/6] tools/testing/cxl: Add interleave check support to
 mock cxl port device
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
 <166077131383.1743055.4589788759198107631.stgit@djiang5-desk4.jf.intel.com>
 <20220824155902.00007b3c@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220824155902.00007b3c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/24/2022 7:59 AM, Jonathan Cameron wrote:
> On Wed, 17 Aug 2022 14:21:53 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
> I couldn't follow what was going on here, until I realized you've renamed
> this function.  Now cxl_interleave_capable().
>
> Are the tests broken (null dereference) between patch 1 and 3?
>
> Seem like dev_set_drvdata() should move to patch 1.
You are right. Will move.
>
>> to check the interleave configuration. Set the interleave_mask as well
>> to support the new verification code.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   tools/testing/cxl/test/cxl.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index a072b2d3e726..3ce353a20b80 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -398,6 +398,9 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>>   		return ERR_PTR(-ENOMEM);
>>   
>>   	cxlhdm->port = port;
>> +	cxlhdm->interleave_mask = GENMASK(14, 8);
>> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
>> +	dev_set_drvdata(&port->dev, cxlhdm);
>>   	return cxlhdm;
>>   }
>>   
>>
>>
