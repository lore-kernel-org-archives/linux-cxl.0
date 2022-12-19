Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1534C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLSQTb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiLSQT3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:19:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33BF1B
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671466768; x=1703002768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lo0w5oZGEwaR9gZ6TrKfBuC0q9w0pafbGvPxRIc8aQM=;
  b=NQ96SX/mhEwfiHDDWGAryCM51EKlDRKNmuoDo1psHOcQGgBTkU02cb1u
   KAG8kC9KqTBwXIMVc8RhJdgkJOqnoOCS0EqKsYuFJIkpUW5f06fZmE/oh
   BuA9DCqT4ZlZmXHaDl/xgL4HNWYZ618cHPNafj49upSsaNr+/o/4AniyY
   R5dpbstLyl017jCKTuhz0KUmEH89W2nAI4q19c/sKZGCBSr4loHS/TFQM
   tmipp19V7QTEZ/IoyfyN5WpZSr1bZA0XtvFuMPqHnyQeDzRKUAQasXB9U
   xAwtdq9QAkXubppFStOhEz+nB7wZQpdHisn0FqsBpSzp4Vr11yLSs59H+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="317024510"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="317024510"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 08:19:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="757681470"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="757681470"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.109.163]) ([10.212.109.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 08:19:16 -0800
Message-ID: <f2625c08-d6d5-2336-843d-13d906c0eccc@intel.com>
Date:   Mon, 19 Dec 2022 09:19:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/8] cxl: Introduce HDM decoder emulation from DVSEC
 range registers
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
 <20221219161223.000077f3@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221219161223.000077f3@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/19/22 09:12, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:12:15 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> This series provides the emulation of HDM decoders from the programmed range
>> registers. From CXL 3.0 spec 8.1.3.8, there can be up to 2 ranges programmed.
>> Some device may not implement HDM decoder registers and some may not be
>> programmed by the BIOS. Under such scenarios, if one of more range registers
>> are programmed, then we can create an emulated HDM decoder per active range
>> indicated by the range registers. The emulated HDM decoders will show up as
>> locked and cannot be reprogrammed.
>>
>> Below is a table that indicates different scenarios the driver may encounter:
>>
>> rr: Range registers not programmed
>> hdm: HDM decoders not programmed
>> RR: Range registers programmed by BIOS
>> HDM: HDM decoders programmed by BIOS
>>
>> emulate HDM: Create HDM decoder software structs and use values from range registers.
>> keep HDM: Populate HDM decoder software structs with values in HDM decoder registers.
>>
>> rr             RR             rr hdm	 rr HDM	     RR hdm        RR HDM
>> unsupported    emulate HDM    keep HDM	 keep HDM    emulate HDM   keep HDM
>>
>> This series is based on the current RCD work [1] that's going through upstream review.
>> For convenience, the kernel branch can be retrieved here [2].
> 
> Just to check, why is this an RFC rather than a normal submission?
> Because of the unstable dependency?

That and also just making sure people are ok with the direction of the 
series. I can remove the RFC for the next rev.

> 
> At least at top level, it looks like a sensible approach.
> 
>>
>> [1]: https://lore.kernel.org/linux-cxl/Y4ePZD776yXv2rG3@rric.localdomain/T/#t
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch
>>
>> ---
>>
>> Dave Jiang (8):
>>        cxl: break out range register decoding from cxl_hdm_decode_init()
>>        cxl: export cxl_dvsec_rr_decode() to cxl_port
>>        cxl: refactor cxl_hdm_decode_init()
>>        cxl: emulate HDM decoder from DVSEC range registers
>>        cxl: create emulated cxl_hdm for devices that do not have HDM decoders
>>        cxl: create emulated decoders for devices without HDM decoders
>>        cxl: suppress component register discovery failure warning for RCD
>>        cxl: remove locked check for dvsec_range_allowed()
>>
>>
>>   drivers/cxl/core/hdm.c | 115 +++++++++++++++++++++++---
>>   drivers/cxl/core/pci.c | 179 +++++++++++++++++------------------------
>>   drivers/cxl/cxl.h      |  20 ++++-
>>   drivers/cxl/cxlmem.h   |  13 +--
>>   drivers/cxl/cxlpci.h   |   3 +-
>>   drivers/cxl/pci.c      |   2 +-
>>   drivers/cxl/port.c     |  19 +++--
>>   7 files changed, 215 insertions(+), 136 deletions(-)
>>
>> --
>>
> 
