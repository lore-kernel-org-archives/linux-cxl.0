Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FDC77B7A
	for <linux-cxl@archiver.kernel.org>; Sat, 20 May 2023 11:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjETLDr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 May 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjETLDr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 May 2023 07:03:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01141B5
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pbpmI7q14NH5+ugtQMHEnwYTK5oIB+jMVt44UMMpmYo=; b=mXyL3YYmKoOzwKrr5qS+wzCHgt
        pa+OPwG4tTCzXwgFnVs9WkUIrPreEBJU9mGFT1BTUHKW8GKdAshnqhZe8kKz6Gxk7Wb54GtKjrv+S
        aSNe5Sc9UTbuZUPH4k4/HJCBRIzkBr2zNlIxQkVCp+EIZ15kCg04lNU7kWkv7FzsDngQQ+7uBO4Hu
        6uC041Jrhz4ZX8Eh/ow2uJ1ayZb+xc7TKToEq+QqMStInXRPOtoIFzqWMjDk5YrY/2hy3ViOSXWUS
        LR5Cz/iJHvvHoKv2tofLX9sWGOrvBfm918MHVsZ0e1MuCmBlLlPZC8lmDu9njSgoPwIXivAYUDIeR
        JvANbHLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0KMp-007J96-7M; Sat, 20 May 2023 11:03:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84706300095;
        Sat, 20 May 2023 13:03:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 115DB212978B2; Sat, 20 May 2023 13:03:17 +0200 (CEST)
Date:   Sat, 20 May 2023 13:03:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH 1/3] rcuwait: Support timeouts
Message-ID: <20230520110316.GA2985205@hirez.programming.kicks-ass.net>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-2-dave@stgolabs.net>
 <6467ec6ae116d_682c12942e@dwillia2-xfh.jf.intel.com.notmuch>
 <lmlp2meczedtkxdlv7gnbom232nnn7mrx2xejhpufphhzljxvl@2ox2qf4skxqg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lmlp2meczedtkxdlv7gnbom232nnn7mrx2xejhpufphhzljxvl@2ox2qf4skxqg>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, May 19, 2023 at 03:55:04PM -0700, Davidlohr Bueso wrote:
> On Fri, 19 May 2023, Dan Williams wrote:

> > What acks are required to take this through the CXL tree? Or are you
> > the rcuwait maintainer?
> 
> No, I am not the maintainer, changes have been routed usually through
> tip folks. Conceptually at least I think Peter was ok with it, but
> ultimately an explicit ack/nack would be required.

Yeah, would normally be me routing it through the sched tree -- that
also takes all the other wait (wait and swait) crud.

If this needs to go elsewhere,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
