Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E7C7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 15:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDLPPx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDLPPw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 11:15:52 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777515FDC
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1681312548;
        bh=xkBLGR4ioaavPN9y7RmcGfEbICJNVyNyign6g2KnlmU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Se5GfN5k9BcViXcT63nTs8ICsnL80rS1wV6Ub2uCGrDHNRf2qJALnYXUFhMO73t5o
         Dm3ylkMEYXDn+M9IrnIjzcwH+ijL3B7dfES1SH2EuECdPI+milyGUCNbwqmgsobWYH
         GUOpAHujyxvbLLnEAzfnljgKnMvKbThfSeGn9Uro=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 533F21286CBD;
        Wed, 12 Apr 2023 11:15:48 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id l8ayoMz3Dxcj; Wed, 12 Apr 2023 11:15:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1681312548;
        bh=xkBLGR4ioaavPN9y7RmcGfEbICJNVyNyign6g2KnlmU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Se5GfN5k9BcViXcT63nTs8ICsnL80rS1wV6Ub2uCGrDHNRf2qJALnYXUFhMO73t5o
         Dm3ylkMEYXDn+M9IrnIjzcwH+ijL3B7dfES1SH2EuECdPI+milyGUCNbwqmgsobWYH
         GUOpAHujyxvbLLnEAzfnljgKnMvKbThfSeGn9Uro=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 66B1B1286CB1;
        Wed, 12 Apr 2023 11:15:47 -0400 (EDT)
Message-ID: <ec7399fbd74d43a06edc8b344fccddbdef44a101.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL
 =?UTF-8?Q?memory=E2=80=8B?=
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Gregory Price <gregory.price@memverge.com>
Cc:     Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 12 Apr 2023 11:15:45 -0400
In-Reply-To: <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
         <ZDCv3lxLbquITy8M@memverge.com>
         <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <ZDV+f7+QH5W/vXAt@memverge.com>
         <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 2023-04-12 at 10:38 +0200, David Hildenbrand wrote:
> On 12.04.23 04:54, Huang, Ying wrote:
> > Gregory Price <gregory.price@memverge.com> writes:
[...]
> > > That feels like a hack/bodge rather than a proper solution to me.
> > > 
> > > Maybe this is an affirmative argument for the creation of an
> > > EXMEM zone.
> > 
> > Let's start with requirements.  What is the requirements for a new
> > zone type?
> 
> I'm stills scratching my head regarding this. I keep hearing all 
> different kind of statements that just add more confusions "we want
> it to be hotunpluggable" "we want to allow for long-term pinning
> memory" "but we still want it to be movable" "we want to place some
> unmovable allocations on it". Huh?

This is the essential question about CXL memory itself: what would its
killer app be?  The CXL people (or at least the ones I've talked to)
don't exactly know.  Within IBM I've seen lots of ideas but no actual
concrete applications.  Given the rates at which memory density in
systems is increasing, I'm a bit dubious of the extensible system pool
argument.   Providing extensible memory to VMs sounds a bit more
plausible, particularly as it solves a big part of the local overcommit
problem (although you still have a global one).  I'm not really sure I
buy the VM migration use case: iterative transfer works fine with small
down times so transferring memory seems to be the least of problems
with the VM migration use case (it's mostly about problems with
attached devices).  CXL 3.0 is adding sharing primitives for memory so
now we have to ask if there are any multi-node shared memory use cases
for this, but most of us have already been burned by multi-node shared
clusters once in our career and are a bit leery of a second go around.

Is there a use case I left out (or needs expanding)?

James

