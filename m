Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C0C77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDNMEW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDNMET (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 08:04:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49D13A
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 05:04:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PyZpW3PMWz6DFgW;
        Fri, 14 Apr 2023 20:03:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 13:04:15 +0100
Date:   Fri, 14 Apr 2023 13:04:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <navneet.singh@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: "release early" preview of DCD enabling
Message-ID: <20230414130414.00007c88@Huawei.com>
In-Reply-To: <ZDWVkJKVThJzhMzM@memverge.com>
References: <64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <ZDWVkJKVThJzhMzM@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Apr 2023 13:14:56 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Sun, Apr 09, 2023 at 12:07:36AM -0700, Dan Williams wrote:
> > Here is an early draft of the DCD work that Navneet has spearheaded.
> > Given the interest level I thought it best to do the remaining
> > development and refinement of the functionality in the open.  For now
> > this is just a git branch that will become a patchkit on the mailing
> > list in a few weeks.
> > 
> > Questions are welcome, but I do not recommend a formal review until the
> > patches hit the mailing list.
> > 
> > This has had some checkout on an internal functional model, I expect
> > QEMU and/or cxl_test grows an emulation of DCD before this patchkit is
> > committed for mainline.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview  
> 
> Awesome!
> 
> for the QEMU folks, has anyone be actively working on a DCD device? I
> was going to start looking at it, but didn't want to duplicate work.

Not that I know of.  Was thinking I might hack some of it together, but
not gotten to it yet. 

For and end goal I think we want:

a) Add all the config stuff for DCD regions - perhaps hardcode one initially.
b) Device that generates DCD events (don't care on interface to make them happen but maybe start
   with QMP similar to injection interfaces).
c) Device that maps the DCD extents through to doing the correct read and write behavior for
   reads that aren't in DCD extents.
d) A standards based way to poke the FM-API. Tunneling and / or MCTP CCIs


Can probably split this up though so if multiple people are hacking on it they don't clash.

(a) and (b) needed to do anything useful with kernel side.
(c) needed for testing long term, but don't care initially.

(d) mostly separable - needed for a 'nice' test setup but not for basic functionality testing.

If you want to take a look at (a) and (b) and maybe (c) that would be great.

There is lots of independent stuff to do for (d) so maybe I'll focus on that in short term?

How's that work for you?

Jonathan


> 
> ~Gregory

