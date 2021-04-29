Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8CEC433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0669761445
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhD2JVh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:21:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2950 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhD2JVf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Apr 2021 05:21:35 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FW8pT5G85z689qt;
        Thu, 29 Apr 2021 17:09:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 11:20:31 +0200
Received: from localhost (10.52.122.22) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 29 Apr
 2021 10:20:31 +0100
Date:   Thu, 29 Apr 2021 10:18:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Dai WeiBin (David Dai)" <david.dai@montage-tech.com>
CC:     <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "'Jin LiZhi (Lynn Jin)'" <lynn.jin@montage-tech.com>
Subject: Re: CXL mailbox background command
Message-ID: <20210429101857.00002f3d@Huawei.com>
In-Reply-To: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com>
References: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.122.22]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 29 Apr 2021 12:26:20 +0800
"Dai WeiBin (David Dai)" <david.dai@montage-tech.com> wrote:

> Hi Ben,
> 
> When we think of cxl mailbox background command, we met a difficult issue, how to handle switching between a background command end and another background command start?
> 
> The flow is as below:
> 1. Host/caller sends a command to cxl device.
> 2. CXL device identifies the command as a background command, then cxl device returns background command started, background Operation is set to 1.
> 3. CXL device start to handle background command.
> 4. Host/caller can send other commands to cxl device when background command is ongoing on device side.
> 5. At a special point host/caller is sending a command to device when the background command just is finished, the new command will be handled as a background command by device.
> 6. That means the old background command ends, background Operation is set to 0, immediately the new background command is started, background Operation is set to 1 again at once.
> 7. So Host driver doesn’t have a chance to check the old background command has been finished, it still see “background Operation == 1”.
> 8. Mailbox Status Register and Background Command Status Register are both read-only, that results there is not a handshake between host and device.
> 9.How to guarantee exclusion between two background commands.
> 
> Do you have any suggestion about this?

Perhaps use the CEL to identify which commands are background commands and queue them up
in software?  So don't issue another one until previous is known to have completed.

Would that work?

Jonathan

> 
> Thanks,
> David
> 
> 

