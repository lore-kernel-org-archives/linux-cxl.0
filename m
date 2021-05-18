Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDAC433ED
	for <linux-cxl@archiver.kernel.org>; Tue, 18 May 2021 02:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D74D61285
	for <linux-cxl@archiver.kernel.org>; Tue, 18 May 2021 02:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhERCC4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 May 2021 22:02:56 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:58809 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhERCC4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 May 2021 22:02:56 -0400
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Mon, 17 May 2021 19:01:39 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005639292.msg; 
        Mon, 17 May 2021 19:01:39 -0700
X-MDArrival-Date: Mon, 17 May 2021 19:01:39 -0700
X-Return-Path: prvs=17729c469f=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1621303290; x=1621908090;
        i=david.dai@montage-tech.com; q=dns/txt; h=From:To:Cc:References:
        In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=ZLsN
        IUp7WQWCdbBnbi8qbt6dHt6d8vfucZ57AGyN2DY=; b=d4ImL+2LmWJUp8I5EGlQ
        z0UPBUJ19ABqRHYBuiIXIJT+NoVhE8nn5SAJkaaHd+CmYEdplYbBysQRiYf4NSVa
        lsT1PcrNJ0saj37vs1tWYZttHh7Y+heoWnP6+r72hRBj6tjcxe1RGIOH+rJ4Ky6l
        B7Ol64NlL/kUQEv9LB9frkA=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Tue, 18 May 2021 10:01:30 +0800
Received: from cn021pc868 by shmail.montage-tech.com with ESMTPSA id pp5001016762260.msg; 
        Tue, 18 May 2021 10:01:28 +0800
From:   "Dai WeiBin \(David Dai\)" <david.dai@montage-tech.com>
To:     "'Dengcheng Zhu'" <dengcheng.zhu@gmail.com>,
        <ben.widawsky@intel.com>, <dan.j.williams@intel.com>
Cc:     <linux-cxl@vger.kernel.org>
References: <CAOfQC9_aEmNKO2AmmX7JKwpZcj-HtMdoJBv+bH8qvbw0siTGOA@mail.gmail.com>
In-Reply-To: <CAOfQC9_aEmNKO2AmmX7JKwpZcj-HtMdoJBv+bH8qvbw0siTGOA@mail.gmail.com>
Subject: RE: Access to CXL memory
Date:   Tue, 18 May 2021 09:57:31 +0800
Message-ID: <00b301d74b89$29f67760$7de36620$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIW7dMfvJLD5Ied5rKw5ck77qHeN6ppLJxw
Content-Language: zh-cn
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I understand BIOS will allocate system physical region for your CXL =
device when system enumeration.
Afterward BIOS writes the SPA to CXL base address register, meanwhile it =
also creates SRAT to Linux OS.
After OS handoff, OS sees a SRAT and a PCIe device, the PCIe device has =
CXL function.
So Linux kernel can parse SRAT table to get memory information and put =
it into Linux mem block as system RAM.
if the SRAT set the memory reserved, that means Linux buddy system =
doesn't manage it, so CXL device driver may read cxl base address =
register to get HPA and size, then map it as private managed memory.

Anyway, you must ensure only one master manages the memory, as well as =
only CXL type2/type3 has volatile memory which can be managed by host =
system or driver.

Thanks,
David =20

-----Original Message-----
From: Dengcheng Zhu (dengcheng.zhu@gmail.com) =
[mailto:dengcheng.zhu@gmail.com]=20
Sent: 2021=E5=B9=B45=E6=9C=8818=E6=97=A5 2:51
To: ben.widawsky@intel.com; dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Access to CXL memory


Hi,

I learned that CXL memory could be exposed to the system as a NUMA
node as well as an mmap()able device.

Two questions are:

- Can these 2 forms coexist at the same time?
- If yes, how does memory management work between these 2 interfaces?

Please shed some light upon this issue.

Thanks,
Dengcheng




