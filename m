Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9946BC7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 02:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDLCzW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 22:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLCzV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 22:55:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643719A8
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681268120; x=1712804120;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=bmmVPN1E0noe7kMQzpmF/q1kXcSL0ht9eiRXgfNIaRI=;
  b=nyj/wPKvLMLlhxGsuYdyxy0Z3nZenbjLmOQBuNs5uhRyiqWjlmjOeYez
   C1ZMNbf3uy/5nPAq+0GM5tp/JbmlW/CSsgXs+lRcBChIKPKuqESH5Wykp
   dsRmCGqUXuA2N7LWTf7MfR8txmIUBdO5VEiwbpLDSTLYTw1BLXuYydR0A
   jlmft2i34VnKUlKzLSpHPkGSAy8Cguk12o+qd53A0fvMD+RhEsuMEXunW
   NloHdBbPAPzDsD66ewosl8Q8YRdHueUV0NuQW8NI648SK5LKTkGns2ued
   VubXebUKZq941FC9bXzfSfoD0jfVRUt7ayOa3Wz7JegO2kAsJ1YAtfXhJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="342543965"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="342543965"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 19:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="691375821"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="691375821"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 19:55:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Dragan Stancevic <dragan@stancevic.com>,
        <lsf-pc@lists.linux-foundation.org>,
        <nil-migration@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL =?utf-8?Q?m?=
 =?utf-8?Q?emory=E2=80=8B?=
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
        <ZDCv3lxLbquITy8M@memverge.com>
        <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZDV+f7+QH5W/vXAt@memverge.com>
Date:   Wed, 12 Apr 2023 10:54:13 +0800
In-Reply-To: <ZDV+f7+QH5W/vXAt@memverge.com> (Gregory Price's message of "Tue,
        11 Apr 2023 11:36:31 -0400")
Message-ID: <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> [snip]
>> 
>> > 2. During the migration process, the memory needs to be forced not to be
>> >    migrated to another node by other means (tiering software, swap,
>> >    etc).  The obvious way of doing this would be to migrate and
>> >    temporarily pin the page... but going back to problem #1 we see that
>> >    ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>> >    troublesome.
>> 
>> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
>> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
>> but I think it is fixable.
>> 
>> Best Regards,
>> Huang, Ying
>> 
>> [snip]
>
> That feels like a hack/bodge rather than a proper solution to me.
>
> Maybe this is an affirmative argument for the creation of an EXMEM
> zone.

Let's start with requirements.  What is the requirements for a new zone
type?

> Specifically to allow page pinning, but with far more stringent
> controls -

> i.e. the zone is excluded from use via general allocations.

This can also be controlled via memory policy.  The alternative solution
is to add a per node attribute.

> The point of ZONE_MOVABLE is to allow general allocation of userland
> data into hotpluggable memory regions.

IIUC, one typical requirement of CXL.mem is hotpluggable, right?

Best Regards,
Huang, Ying

> This memory region is not for general use, and wants to allow pinning
> and be hotpluggable under very controlled circumstances.  That seems
> like a reasonable argument for the creation of EXMEM.
>
> ~Gregory
