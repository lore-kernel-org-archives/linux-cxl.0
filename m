Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E471C6FA82
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Sep 2022 16:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiIWQT4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiIWQTa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Sep 2022 12:19:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DE14A78D
        for <linux-cxl@vger.kernel.org>; Fri, 23 Sep 2022 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663949885; x=1695485885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2j6YOJbRNidSzoxVdfG5XPyqHuoIKbKoyF3mn4CCIAg=;
  b=UrPWxx1kGODWDxxRCgtjrHq+i1GPyJjiuJDqk/9hT6sx41MgIzplqUCr
   ySCf89RYXLKJ6LyeH6YYLhS8qy/ZuJu2a2idOMeW+FQ/f97CJnPR02CUK
   UtIBgHMpooDmZoSR4llxT2YibOCzbiP1zWiduSJywOig6AZAbAfpKFXPl
   4p6eM1qNDD7Vu9XO3pA6crJmCRkD2PX69GDThmagRq+q0BFfd7oaXcsHz
   xkKi0/s5UnBlTWoBsV6oc5gt8J7Zrf+8mVO4N184bVGYN36Cp5m7HoA+r
   DFBluGNADuvbTZ9WyW829Qk0g1lpRFhNQMeW0tN6NYNLXuR39ccxMLXs3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283725744"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283725744"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:18:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="682708390"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.52.203]) ([10.212.52.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:18:04 -0700
Message-ID: <ef36340d-6bd3-34f4-c728-d7f434f672c1@intel.com>
Date:   Fri, 23 Sep 2022 09:18:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v2 19/19] cxl: add dimm_id support for __nvdimm_create()
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
 <166377440119.430546.15623409728442106946.stgit@djiang5-desk3.ch.intel.com>
 <20220923103108.wt62gzebnyovpjjr@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220923103108.wt62gzebnyovpjjr@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 9/23/2022 3:31 AM, Davidlohr Bueso wrote:
> On Wed, 21 Sep 2022, Dave Jiang wrote:
>
>> Set the cxlds->serial as the dimm_id to be fed to __nvdimm_create(). The
>> security code uses that as the key description for the security key 
>> of the
>> memory device. The nvdimm unlock code cannot find the respective key
>> without the dimm_id.
>
> Maybe I'm being daft but I don't see why cxlds->serial could not just be
> used for __nvdimm_create() instead of adding a new member.
>
The reason is cxlds->serial is a u64 and __nvdimm_create() wants a 
string for dimm_id. And also __nvdimm_create() just points to the 
original string instead of duplicating it. So we need a string member 
defined instead of creating a temp string derived from cxlds->serial for 
__nvdimm_create().
