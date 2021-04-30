Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC35C433B4
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Apr 2021 01:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EE86121E
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Apr 2021 01:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD3Bq5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Apr 2021 21:46:57 -0400
Received: from shmail.montage-tech.com ([180.167.85.125]:64705 "EHLO
        shmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3Bq5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Apr 2021 21:46:57 -0400
X-Greylist: delayed 1447 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 21:46:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1619747161; x=1620351961;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Cc:References:
        In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=fMuk
        erIvNu46ky13aE8pitAr8mxwXx5a4vZD2+azmD4=; b=btWPILHXSFi2pO/CWRuC
        yqMns5FODstw5VWpDa9syQafW39jfkNGcGdOitJx9HJu/1h1tmB/iALK/QCJDpMH
        Sr0foTrOGzO0p1rXNhuJCFAvD02yirzq/N3VbGSSSF07SvcUDyTjB85XXZguPKIQ
        ZY0F9Z7PqxCxCq+WkfCBUNc=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Fri, 30 Apr 2021 09:46:01 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016703238.msg; 
        Fri, 30 Apr 2021 09:45:59 +0800
X-MDArrival-Date: Fri, 30 Apr 2021 09:45:59 +0800
X-Authenticated-Sender: david.dai@montage-tech.com
X-Return-Path: prvs=1754b92113=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     "'Dan Williams'" <dan.j.williams@intel.com>
Cc:     "'Ben Widawsky'" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>,
        "'Jin LiZhi \(Lynn Jin\)'" <lynn.jin@montage-tech.com>
References: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com> <CAPcyv4gTyj=PAEUdKdMUyLz1hP8Wg+HyabkO11kJ9C0Vx2wkQw@mail.gmail.com>
In-Reply-To: <CAPcyv4gTyj=PAEUdKdMUyLz1hP8Wg+HyabkO11kJ9C0Vx2wkQw@mail.gmail.com>
Subject: RE: CXL mailbox background command
Date:   Fri, 30 Apr 2021 09:42:49 +0800
Message-ID: <00f601d73d62$20de06f0$629a14d0$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIl+IPQuLfFEZey8GueOHwBb+5YewI5e8exqh0BDyA=
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks, Dan, your direction is important for us, this will help our =
software/hardware design.

David


-----Original Message-----
From: Dan Williams (dan.j.williams@intel.com) =
[mailto:dan.j.williams@intel.com]=20
Sent: 2021=E5=B9=B44=E6=9C=8830=E6=97=A5 4:32
To: Dai WeiBin (David Dai)
Cc: Ben Widawsky; linux-cxl@vger.kernel.org; Jin LiZhi (Lynn Jin)
Subject: Re: CXL mailbox background command


CAUTION: This email=20
originated from outside of the organization. Do not click links or open =
attachments unless you recognize the sender and know the content is =
safe.


On Wed, Apr 28, 2021 at 9:30 PM Dai WeiBin (David Dai)
<david.dai@montage-tech.com> wrote:
>
> Hi Ben,
>
> When we think of cxl mailbox background command, we met a difficult =
issue, how to handle switching between a background command end and =
another background command start?
>
> The flow is as below:
> 1. Host/caller sends a command to cxl device.
> 2. CXL device identifies the command as a background command, then cxl =
device returns background command started, background Operation is set =
to 1.
> 3. CXL device start to handle background command.
> 4. Host/caller can send other commands to cxl device when background =
command is ongoing on device side.
> 5. At a special point host/caller is sending a command to device when =
the background command just is finished, the new command will be handled =
as a background command by device.
> 6. That means the old background command ends, background Operation is =
set to 0, immediately the new background command is started, background =
Operation is set to 1 again at once.
> 7. So Host driver doesn=E2=80=99t have a chance to check the old =
background command has been finished, it still see =E2=80=9Cbackground =
Operation =3D=3D 1=E2=80=9D.
> 8. Mailbox Status Register and Background Command Status Register are =
both read-only, that results there is not a handshake between host and =
device.
> 9.How to guarantee exclusion between two background commands.
>
> Do you have any suggestion about this?

Background commands are not suitable to be exposed directly to
userspace, they can lockout critical driver access. They need to be
mediated by the kernel, so they each need a kernel managed state
machine and those state machines need to cooperate with each other.
Userspace can not be trusted to get this right on its own, so
userspace should be disallowed from issuing such commands by default.
Luckily Linux distributions can get this safety policy with minimal
effort by leaving CONFIG_CXL_MEM_RAW_COMMANDS default disabled.



