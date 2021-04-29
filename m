Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DABC433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268E061440
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 01:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhD2BeY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Apr 2021 21:34:24 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:61540 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhD2BeY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Apr 2021 21:34:24 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 21:34:24 EDT
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Wed, 28 Apr 2021 18:27:32 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005615454.msg; 
        Wed, 28 Apr 2021 18:27:30 -0700
X-MDArrival-Date: Wed, 28 Apr 2021 18:27:30 -0700
X-Return-Path: prvs=1753779f30=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1619659646; x=1620264446;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Cc:Subject:
        Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=nTt+
        0Nes1oe4fNIZo5F3qh8XODveBYnLWTujyjm6cUI=; b=XFvC7FmuPFW84i0yRScz
        xGNnYB2GfaECwLrksQqp81r0x3egq8uVxNuv4CqVYNNIBZdr8B8XnoIuCz+A8Ef9
        8mNWM++wpu2oWHXf3E2wQ8/ElbnXMBml7NOX81FCkhoatfTiOIUcsRpJMjxYn3G1
        itFaqGttesH4KaoDDZalHZc=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Thu, 29 Apr 2021 09:27:26 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016698054.msg; 
        Thu, 29 Apr 2021 09:27:24 +0800
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     <ben.widawsky@intel.com>
Cc:     <linux-cxl@vger.kernel.org>
Subject: CXL mailbox background command
Date:   Thu, 29 Apr 2021 09:24:14 +0800
Message-ID: <008401d73c96$5dea8310$19bf8930$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Adc8lkqY+3bhiTbiTNWv0kupjI0brQ==
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Ben,

When we think of cxl mailbox background command, we met a difficult =
issue, how to handle switching between a background command end and =
another background command start?
The flow is as below:
1. Host/caller sends a command to cxl device.
2. CXL device identifies the command as a background command, then cxl =
device returns background command started.
3. CXL device start to handle background command
4. Host/caller can send other commands to cxl device when background =
command is ongoing on device side
5. At a special point host/caller is sending a command to device when =
the background command just is finished, the new command will be handled =
as a background command by device
6. That means the old background command ends, background Operation is =
set to 0, immediately the new background command is started, background =
Operation is set to 1 again at once.
7. So Host driver doesn=E2=80=99t have a chance to check the old =
background command has been finished, it still see =E2=80=9Cbackground =
Operation =3D=3D 1=E2=80=9D
8. Mailbox Status Register and Background Command Status Register are =
both read-only, that results there is not a handshake between host and =
device

Do you have any suggestion about this?

Thanks,
David



