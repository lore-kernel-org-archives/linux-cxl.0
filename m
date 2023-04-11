Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58900C76196
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 18:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDKSAG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDKSAG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 14:00:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691365267
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681236005; x=1712772005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vmA3xk4DjZmDJu8SYkGhKpH80tDfxKa0abTU4/7ZjRU=;
  b=eVeF8kkX4aazWEuHVT6Gm+upqBHSlr3wYGkNzKCnm5eHnEj9uz/KPOhr
   ABjXnAiTpWgvPnERRg1OZxfnLEs4ANa0MEfLCObF0X+ePpao2awonaKyE
   pwddKycDNgtVCGVL5LD5EPf3rHhAUdIwuwS1LSdZi+cT9cahZ0t9rsAUY
   DJwYXqnkqbxUh01ffqF1jVHwnDXUlPXfzK7I9pUxRyhOGRS2lsKxxfPzv
   xO14n2Z6HU2RdrBh0Y3LJozmdzyUiaNNcmbN6kBMOONJpYbxUlwP2HuEM
   T3sRmCHVuNi9qx1AjgMv7fTPKdKYyfXZuHjU/WIiMcbEByQ3sR6DRqh/P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343699268"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343699268"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 11:00:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="757942293"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="757942293"
Received: from gtryonx-mobl.amr.corp.intel.com (HELO [10.209.72.81]) ([10.209.72.81])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 11:00:03 -0700
Message-ID: <14a601ea-8cf8-bb9c-a87a-63567c5aba5b@intel.com>
Date:   Tue, 11 Apr 2023 11:00:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     nil-migration@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/7/23 14:05, Dragan Stancevic wrote:
> I'd be interested in doing a small BoF session with some slides and get
> into a discussion/brainstorming with other people that deal with VM/LM
> cloud loads. Among other things to discuss would be page migrations over
> switched CXL memory, shared in-memory ABI to allow VM hand-off between
> hypervisors, etc...

How would 'struct page' or other kernel metadata be handled?

I assume you'd want a really big CXL memory device with as many hosts
connected to it as is feasible.  But, in order to hand the memory off
from one host to another, both would need to have metadata for it at
_some_ point.

So, do all hosts have metadata for the whole CXL memory device all the
time?  Or, would they create the metadata (hotplug) when a VM is
migrated in and destroy it (hot unplug) when a VM is migrated out?

That gets back to the granularity question discussed elsewhere in the
thread.  How would the metadata allocation granularity interact with the
page allocation granularity?  How would fragmentation be avoided so that
hosts don't eat up all their RAM with unused metadata?
