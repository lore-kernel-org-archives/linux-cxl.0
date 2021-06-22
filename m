Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C37C4743C
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Jun 2021 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88FF6102A
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Jun 2021 01:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhFVBrW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:47:22 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:56656 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBrV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 21 Jun 2021 21:47:21 -0400
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Mon, 21 Jun 2021 18:45:06 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005684222.msg; 
        Mon, 21 Jun 2021 18:45:06 -0700
X-MDArrival-Date: Mon, 21 Jun 2021 18:45:06 -0700
X-Return-Path: prvs=1807fcb8d6=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1624326303; x=1624931103;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Subject:Date:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
        thread-index:Content-Language; bh=6TGH+5JwkYiCchkyOp9GwYZCtDiy64
        99TMIQoh0cyKE=; b=dgyDimP3FLc/+pQQAx+lXzhAo+EZWDb2LTd3+ynEC9zMjr
        ftejFgnDSAHSc/r0Ms9W1zjqtFRUtAHY92Fdm5g0n5SYEBpF2r28NqptBuD3sfiV
        r29gCozT99NOML0Xdkd5nAgALcUGLpjcL5sgCbdbzNicaXCnBrQvH9p9wBLsM=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Tue, 22 Jun 2021 09:45:03 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016941499.msg; 
        Tue, 22 Jun 2021 09:45:02 +0800
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     <linux-cxl@vger.kernel.org>
Subject: CXL_ECN_MailboxReadyTime
Date:   Tue, 22 Jun 2021 09:41:12 +0800
Message-ID: <044101d76707$aec58050$0c5080f0$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
thread-index: AddnBpil1WZ8QZH0SC+gJ3W3NwsjFg==
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

When I think of CXL mailbox interface ready and timeout, an issue is =
troubling me:
From CXL_ECN_MailboxReadyTime_v5.pdf, Mailbox Ready Time could be at =
most 3 minutes, Host BIOS maybe not be able to endure such big timeout =
duration, so CXL device enumeration maybe fail during BIOS stage. CXL =
device maybe have huge memory which needs a lot of time for training, =
thus device boot-up will take a long period, for this case, a big delay =
maybe exist before mailbox ready. I think if mailbox function doesn't =
ready, BIOS should not refuse CXL device if other functions work well.

Thanks,
David




