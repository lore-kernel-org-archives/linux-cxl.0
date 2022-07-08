Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC9CCA47F
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Jul 2022 17:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiGHRo2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiGHRo1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Jul 2022 13:44:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B86050E
        for <linux-cxl@vger.kernel.org>; Fri,  8 Jul 2022 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657302267; x=1688838267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kHQ9DXGmjB5d5Ml7pzrEHUaFZYHLqlxnT0l8CQEQoRQ=;
  b=dqrq3zfJwi+g3TpNSMnssfrtMKIYzzaXCG4S4MEkIUUbqADb8QN44Ca7
   js+85VxWZQa3FRwmYVAeMLRpjuyPFN1PbXt47QuIp0c6Ue+85TpnJxpA/
   Nd7eDq2917ihsIdD3Vl4ZFBDX3Tz4EP/DuHvhkE+0btaZhhyhtJ1FQ0oM
   gB3KgRb5A/PeWCt6LeB7b0FJ9DC3VbH5gdgias7yEx9BSvCutIZhJN0MS
   k8tQUkudgnZjRAMqDrK541JOpFlEFViKK/q0nPkfKbxouuqUNtw8hGi/L
   e03YhhUFmcf1yVqmw8SiMd66PJI6SCy1uveJZS/Cx6fblesoajF0ZhtxH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285074389"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285074389"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:44:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="651650398"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.35.156]) ([10.212.35.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:44:26 -0700
Message-ID: <27632579-e20a-7afd-7ae8-5a77bc830d81@intel.com>
Date:   Fri, 8 Jul 2022 10:44:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: CXL device sanitation and pmem security questions
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com
References: <20220707190524.i2fxgk5ez6c35vw6@offworld>
 <375b39c8-ee8b-96ec-8842-b3de1b3a0634@intel.com>
 <20220708172455.gi37dh3od4w5lqrd@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220708172455.gi37dh3od4w5lqrd@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 7/8/2022 10:24 AM, Davidlohr Bueso wrote:
> On Thu, 07 Jul 2022, Dave Jiang wrote:
>
>> Hi Davidlohr, I'm actually looking at the implementation of this right
>> now. I think initially if we provide a CXL secruity_ops to nvdimm
>> similar to EFI NFIT provider, we should theoretically be able to do
>> all the security bits through ndctl via nvdimm. I think I'll probably
>> have better answers to your questions once I get some code going and
>> see how things work.
>
> I assume you mean only the pmem security part #2, right? This makes 
> sense,
> but of course for sanitize this would not work, which might also need to
> consult security state regardless of security_ops::get_flags().
Right. I haven't gotten that far yet. :)
>
> Thanks,
> Davidlohr
