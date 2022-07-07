Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F46C43334
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Jul 2022 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiGGVGU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGGVGU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Jul 2022 17:06:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B02CDC1
        for <linux-cxl@vger.kernel.org>; Thu,  7 Jul 2022 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657227979; x=1688763979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QRuNPKChp7cHoABJo+go0CvrTx0iZTVftvc5GdOUH7E=;
  b=M17IPlgB0TNi+i4A6YEUone/Nuca1fofgWYXHgjP5+M9o1G9XiaWB83h
   bgMtR2reQYGSl9NAPZ+p6QTkISVDc8UsyEXapwDcRijGhGwM6PaYb7K3y
   HX5dSnh7BZLAphGjGA9To9xGHfQPvpg4syJ9S4bqWkM97b9IiZ+agbFqD
   GEsq73UC3d1EwB7WWY5qy8r5e97MHq8RRwrsk7A4uzn9NvFldwPv/XvT0
   7sLOXOZ0Bd+rXF0XxXDP4YT8AgsW7ExbKkjh972VTjPEVT6byxT97l0dN
   1ntzojXaBVvLWbjjSf7nhPrrsFhPJfXJcjC4TcscO6RVSNbSqYd6KbyNW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348106836"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="348106836"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 14:06:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="920743489"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.55.84]) ([10.212.55.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 14:06:18 -0700
Message-ID: <375b39c8-ee8b-96ec-8842-b3de1b3a0634@intel.com>
Date:   Thu, 7 Jul 2022 14:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: CXL device sanitation and pmem security questions
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        a.manzanares@samsung.com
References: <20220707190524.i2fxgk5ez6c35vw6@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220707190524.i2fxgk5ez6c35vw6@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 7/7/2022 12:05 PM, Davidlohr Bueso wrote:
> Hello,
>
> While going through the Sanitize and Pmem Data-at-rest security parts
> of the 2.0 spec, I was wondering if the community had any ideas about
> how this would look when implemented. I am not a security person, but
> this is how I'm interpreting this stuff.
>
> 1. Sanitize (8.2.9.5.5) which includes volatile and persistent regions.
>
> Have a /sys/bus/cxl/devices/memX/erase write-only file which upon 0 or 1
> values will do sanitize or secure erase, respectively. In case of the
> sanitize command, if this is a background operation, the echo/write will
> wait until complete. Alternatively we could just rely on the next 
> sanitize
> command to just return media disabled error if the previous one is still
> running and not worry.
>
> While this command is running with media disabled state, what happens
> when successfully complete? Does the state change and loads/stores have
> effect again? Does the driver need to do anything here? There is little
> info about this. Similarly, the secure erase is done entirely by hw (both
> having no in/out payloads).
>
> Both commands note that prior to using them, "any security applied to
> the user data areas of the device shall be disabled" (or unlocked for
> secure erase). Is this referring only to the PMEM part (below)? Iow,
> get security capabilities would need to be consulted (for the
> CONFIG_CXL_PMEM cases)? Or would this check be done by hardware instead
> and return error if the security requirements are not met?
>
> The cxl cmd would look like:
>
> #> cxl sanitize mem0 (alternatively pass -E for secure erase).
>
> 2. Pmem Security (8.2.9.5.6)
>
> Will this be along the same lines as what nvdimm does[1]? and have a
> /sys/bus/cxl/devices/memX/security file that multiplexes the
> different security features. Alternatively I guess the above could
> also be done within the same security file, instead of having two.
>
> The cxl cmd would look like, based on what ndctl(1) does; as well
> as the -m master option:
>
> #> cxl load-keys <params>
> #> cxl setup-passphrase mem0
> #> cxl update-passphrase mem0
> #> cxl remove-passphrase mem0
> #> cxl unlock mem0
> #> cxl sanitize -PE mem0 (passphrase secure erase)
> #> cxl freeze-security mem0
>
> [1] 
> https://www.kernel.org/doc/html/latest/driver-api/nvdimm/security.html


Hi Davidlohr, I'm actually looking at the implementation of this right 
now. I think initially if we provide a CXL secruity_ops to nvdimm 
similar to EFI NFIT provider, we should theoretically be able to do all 
the security bits through ndctl via nvdimm. I think I'll probably have 
better answers to your questions once I get some code going and see how 
things work.

>
> Thanks,
> Davidlohr
