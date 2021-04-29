Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E10C433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 04:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C803661453
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 04:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhD2Ea6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:30:58 -0400
Received: from shmail.montage-tech.com ([180.167.85.125]:63258 "EHLO
        shmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhD2Ea6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Apr 2021 00:30:58 -0400
X-Greylist: delayed 10959 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 00:30:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1619670602; x=1620275402;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Cc:Subject:
        Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=j+qZ
        qwP2KCJxMv662zfRfd++iqqdz36gacsOBHsT25w=; b=Kd+plky65VcmYZGv5OI5
        sqV01hAFDIiwFEg4rA44h8DL4I/qNAkf5gQGCXNPM/fbtnv99+gekunZmlZGHp/P
        wrZOQxnzZ4eyOTuEJbSgdkzwFmqigVDM9dJIhbP/2K0ou2POm1roMtFaN9K9VzwI
        ZxXxbGsF7xGoSJ55g/cqj1c=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Thu, 29 Apr 2021 12:30:02 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016699151.msg; 
        Thu, 29 Apr 2021 12:30:00 +0800
X-MDArrival-Date: Thu, 29 Apr 2021 12:30:00 +0800
X-Authenticated-Sender: david.dai@montage-tech.com
X-Return-Path: prvs=1753f383da=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     <ben.widawsky@intel.com>
Cc:     <linux-cxl@vger.kernel.org>,
        "'Jin LiZhi \(Lynn Jin\)'" <lynn.jin@montage-tech.com>
Subject: CXL mailbox background command
Date:   Thu, 29 Apr 2021 12:26:20 +0800
Message-ID: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Adc8r70/jtTjQzfzQZOAOqRdmwo5eQ==
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
device returns background command started, background Operation is set =
to 1.
3. CXL device start to handle background command.
4. Host/caller can send other commands to cxl device when background =
command is ongoing on device side.
5. At a special point host/caller is sending a command to device when =
the background command just is finished, the new command will be handled =
as a background command by device.
6. That means the old background command ends, background Operation is =
set to 0, immediately the new background command is started, background =
Operation is set to 1 again at once.
7. So Host driver doesn=E2=80=99t have a chance to check the old =
background command has been finished, it still see =E2=80=9Cbackground =
Operation =3D=3D 1=E2=80=9D.
8. Mailbox Status Register and Background Command Status Register are =
both read-only, that results there is not a handshake between host and =
device.
9.How to guarantee exclusion between two background commands.

Do you have any suggestion about this?

Thanks,
David


