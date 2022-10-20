Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2ADC433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJTRwh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTRwg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 13:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4678B1ABA1B
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 10:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C1461CD0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 17:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327E1C433D6;
        Thu, 20 Oct 2022 17:52:33 +0000 (UTC)
Date:   Thu, 20 Oct 2022 13:52:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com
Subject: Re: [PATCH RFC v2 8/9] cxl/pci: add tracepoint events for CXL RAS
Message-ID: <20221020135237.021c62a7@gandalf.local.home>
In-Reply-To: <d70a5bc5-2d1d-c038-fb78-b7f36a31677c@intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336989980.3803215.5292431481210955312.stgit@djiang5-desk3.ch.intel.com>
        <20221020180235.00007320@huawei.com>
        <d70a5bc5-2d1d-c038-fb78-b7f36a31677c@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 20 Oct 2022 10:07:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> > Given the useful review we've gotten on other race points seems wise to
> > Cc Stephen.  
> Yes I will next rev.

You can Cc me instead of this Stephen ;-)

-- Steve
