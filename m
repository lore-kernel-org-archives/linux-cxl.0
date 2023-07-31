Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F033BC001DE
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Jul 2023 11:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGaLgA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGaLfz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jul 2023 07:35:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17112B
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jul 2023 04:35:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RDx0d27H9z6J7Tn
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jul 2023 19:32:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 12:35:36 +0100
Date:   Mon, 31 Jul 2023 12:35:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Parthasarathy, Mohan (HPC/AI and Labs)\" <mohan_parthasarathy@hpe.com>"@domain.invalid
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        <shiju.jose@huawei.com>
Subject: Re: CXL RAS flows on Linux
Message-ID: <20230731123535.00002d5c@Huawei.com>
In-Reply-To: <PH7PR84MB1582BBE2FB47C45DC4BFE78D8805A@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
References: <PH7PR84MB1582BBE2FB47C45DC4BFE78D8805A@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 31 Jul 2023 06:06:27 +0000
"Parthasarathy, Mohan (HPC/AI and Labs)"         <mohan_parthasarathy@hpe.com> wrote:

> Hi all,

Hi Mohan,

Great to have more interest in this aspect.

> 
> I am very interested in the RAS enablement for CXL on Linux. Is there a RAS project for CXL/Linux ?

I'm not aware of a separate project, just mixture of work in the kernel and standard
tools such as RAS daemon.  You'll find all the relevant stuff in the archive linux-cxl
https://lore.kernel.org/linux-cxl/

We are definitely only part of the way there for RAS flows - have reporting but beyond
that there is a lot of work still to do.

> 
> 1)	Do we have a design specification somewhere on the RAS interfaces on Linux for CXL that I can read on this ? Any document describing the correctable and uncorrectable error flows for CXL.mem?

From Linux side of things I'm not aware of any public docs (there will be various internal ones in the
companies are contributing).


> 2)	Are there any error injections tests and testcases that I can experiment with to see the RAS flows with CXL on Linux, using QEMU ?

The infrastructure is there but we don't have any automated scripted flows yet.  Note we got
some of this stuff upstream only recently so you will want to build directly from the master branch
or wait for the next qemu release in a few weeks time. My staging branch at 
gitlab.com/jic23/qemu (cxl-* whatever latest date available is) runs ahead of that for features
but I don't think we have much ras stuff in the queue currently.
https://gitlab.com/jic23/qemu/-/commits/cxl-2023-07-17/


Documentation is lagging as well, so most of the instructions are in the commit messages
e.g. For poison
https://gitlab.com/qemu-project/qemu/-/commits/master/hw/cxl
For DRAM event records etc
https://lore.kernel.org/linux-cxl/20230530133603.16934-1-Jonathan.Cameron@huawei.com/
Similar for Uncor and Cor events... They've been in for a while, so easiest
is to look at the json files for cxl
https://elixir.bootlin.com/qemu/v8.1.0-rc1/source/qapi/cxl.json

For now RAS Daemon upstream support is lagging though you can see the RAS events
are there and there is a pull request for the various event queue based reports.
https://github.com/mchehab/rasdaemon/commits/master 
https://github.com/mchehab/rasdaemon/pull/104

Injection is all done via the QMP interface qemu provides.

I've not used it but I gather https://github.com/pmem/run_qemu is useful
for bringing up suitable qemu configs to poke.

If no events are coming through, check that the internal errors aren't
masked in AER as I don't think we've fully resolved how to control
that masking in the kernel yet.

Let me know how you get on. We should document this stuff better but
as ever there are too many things on the todo list :(

Jonathan

> 
> Any pointers for both would be very much appreciated. 
> 
> Thanks and Regards,
> Mohan

