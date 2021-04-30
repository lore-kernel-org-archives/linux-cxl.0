Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E157C43460
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Apr 2021 01:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0217261412
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Apr 2021 01:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhD3B3t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Apr 2021 21:29:49 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:55585 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3B3t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Apr 2021 21:29:49 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 21:29:49 EDT
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Thu, 29 Apr 2021 18:22:06 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005617074.msg; 
        Thu, 29 Apr 2021 18:22:06 -0700
X-MDArrival-Date: Thu, 29 Apr 2021 18:22:06 -0700
X-Return-Path: prvs=1754c0ab02=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1619745718; x=1620350518;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Cc:References:
        In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=MQ+7
        wxI9IdOzVrBTyebkwbJ9ymGfFad/AMu91Z/dkiM=; b=es2yMFd1MFxcucaYBIm/
        4zclt1Mk3NbqpheSCDsrtkaCn7RQn1WyCpjErXvdEmqU/33jVvz3PIPQx9fFrKQd
        lRxBQTIpKGAO+JvLIlbeazf+fdXF613wHW3yZeKhaCo6rfMU0E5iYkYeri5VUwBP
        EwZw7jqEaVtVjTdWnMSitmo=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Fri, 30 Apr 2021 09:21:58 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016703092.msg; 
        Fri, 30 Apr 2021 09:21:55 +0800
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     "'Jonathan Cameron'" <Jonathan.Cameron@Huawei.com>
Cc:     <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "'Jin LiZhi \(Lynn Jin\)'" <lynn.jin@montage-tech.com>
References: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com> <20210429101857.00002f3d@Huawei.com>
In-Reply-To: <20210429101857.00002f3d@Huawei.com>
Subject: RE: CXL mailbox background command
Date:   Fri, 30 Apr 2021 09:18:30 +0800
Message-ID: <00f501d73d5e$bb164ce0$3142e6a0$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIl+IPQuLfFEZey8GueOHwBb+5YewKpYSGoqhl/aSA=
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks, Jonathan,
I agree that your suggestion is reasonable solution for my problem, =
mailbox driver knows which command is background command, so it can make =
sure background commands sequence.  =20


Thanks,
David

-----Original Message-----
From: Jonathan Cameron (Jonathan.Cameron@Huawei.com) =
[mailto:Jonathan.Cameron@Huawei.com]=20
Sent: 2021=E5=B9=B44=E6=9C=8829=E6=97=A5 17:19
To: Dai WeiBin (David Dai)
Cc: ben.widawsky@intel.com; linux-cxl@vger.kernel.org; 'Jin LiZhi (Lynn =
Jin)'
Subject: Re: CXL mailbox background command


CAUTION: This email=20
originated from outside of the organization. Do not click links or open =
attachments unless you recognize the sender and know the content is =
safe.


On Thu, 29 Apr 2021 12:26:20 +0800
"Dai WeiBin (David Dai)" <david.dai@montage-tech.com> wrote:

> Hi Ben,
>=20
> When we think of cxl mailbox background command, we met a difficult =
issue, how to handle switching between a background command end and =
another background command start?
>=20
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
>=20
> Do you have any suggestion about this?

Perhaps use the CEL to identify which commands are background commands =
and queue them up
in software?  So don't issue another one until previous is known to have =
completed.

Would that work?

Jonathan

>=20
> Thanks,
> David
>=20
>=20





