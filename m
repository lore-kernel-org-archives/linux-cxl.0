Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD3C77B70
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 05:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDNFjY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 01:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNFjV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 01:39:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C92729
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681450752; x=1712986752;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=O1LRDFz3R3Vdf4KXd96xJLQIEE7mfukbxNtrhi8lDHE=;
  b=WbAqgNLy1fghYW63o9rm9OLLGJDL6d028UgJ/5xZav9dxGlrDt/f9vl2
   3oGecWByipPdqDPqy31fi4lQ5Fauas07mCkbJOnIHOZgQKaEMc8qElM9y
   JJsD/uw8hXaJTHW4TY9Ze1w3t5tH6xWGn2Om+Q0YhBc1K/KyzIuda6ptF
   /KjbchNXbtBpaN9DsQOrTkP1Ej4Pu8KJxQPa8+Oee8WXDeITfYxPQtR5A
   c+7DN/b/3LiIZevS/KkoqGqWy7ek/pBTa5euX5sYQ15lkxGjrHTTEqr9p
   IFuEkvNc7EJ4CLpGvX1JTlSV34SdttBJfiPLPwmpQ2vTVMNNphxhJhA5C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="324014975"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="324014975"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 22:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="864074929"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="864074929"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 22:39:09 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     Gregory Price <gregory.price@memverge.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL =?utf-8?Q?m?=
 =?utf-8?Q?emory=E2=80=8B?=
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
        <ZDCv3lxLbquITy8M@memverge.com>
        <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <4a1e74f5-284f-7bfe-6a79-42b44909ca23@stancevic.com>
Date:   Fri, 14 Apr 2023 13:35:50 +0800
In-Reply-To: <4a1e74f5-284f-7bfe-6a79-42b44909ca23@stancevic.com> (Dragan
        Stancevic's message of "Thu, 13 Apr 2023 22:33:24 -0500")
Message-ID: <87r0sn10w9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dragan Stancevic <dragan@stancevic.com> writes:

> On 4/11/23 01:37, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> [snip]
>> 
>>> 2. During the migration process, the memory needs to be forced not to be
>>>     migrated to another node by other means (tiering software, swap,
>>>     etc).  The obvious way of doing this would be to migrate and
>>>     temporarily pin the page... but going back to problem #1 we see that
>>>     ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>>>     troublesome.
>> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.)
>> to
>> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
>> but I think it is fixable.
>
>
> Hmmm, I don't know about cpusets. For mbind, are you thinking
> something along the lines of MPOL_MF_MOVE_ALL? I guess it does have
> that deterministic placement, but this would have to be called from
> the process itself. Unlike migrate_pages which takes a pid.

You can still use migrate_pages(2).  But after that, if you want to
prevent the pages to be migrated out of CXL.mem, you can use some kind
of memory policy, such as cpusets, mbind(), set_mempolicy().

Best Regards,
Huang, Ying

> Same for set_mempolicy, right?
>
> I mean I guess, if some of this needs to be added into qemu it's not
> the end of the word...
>
>
>> Best Regards,
>> Huang, Ying
>> [snip]
>> 
