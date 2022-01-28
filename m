Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1667EC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 04:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbiA1ESe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:18:34 -0500
Received: from usmail.montage-tech.com ([12.176.92.53]:52961 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiA1ESd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 23:18:33 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 23:18:33 EST
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Thu, 27 Jan 2022 20:11:57 -0800
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005974352.msg; 
        Thu, 27 Jan 2022 20:11:56 -0800
X-MDArrival-Date: Thu, 27 Jan 2022 20:11:56 -0800
X-Return-Path: prvs=1027a5c8e8=johnny.li@montage-tech.com
X-Envelope-From: johnny.li@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1643343109; x=1643947909;
        i=johnny.li@montage-tech.com; q=dns/txt; h=From:To:Cc:References:
        In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Thread-Index:Content-Language; bh=nwn6
        TDTF+NHroqUiZsSagP1SmwBJn+9Lsvf7I5UPJkk=; b=ctYy1Z6HoUGfo8UEAral
        BGZZDLqk7ktyf1wbMPnvkOEPdNmszHsDd+uQyCrN8Y0z3EUErRWxw/L9q97LuxsJ
        gxM4vBzSUOPeeTnq9WhtRBZDOr0UkYWEs0xX8lt+6/RnoO9zNRDyNSGk0ivwtO1f
        sAiHMBYrPSXTD05Zuu6OqUI=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Fri, 28 Jan 2022 12:11:49 +0800
Received: from cn021laptop311 by shmail.montage-tech.com with ESMTPSA id pp5001018214410.msg; 
        Fri, 28 Jan 2022 12:11:49 +0800
From:   "Li Qiang \(Johnny Li\)" <johnny.li@montage-tech.com>
To:     "'John Groves'" <john@jagalactic.com>,
        "'Dan Williams'" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Cc:     "'Jonathan Cameron'" <Jonathan.Cameron@huawei.com>,
        "'Ben Widawsky'" <ben.widawsky@intel.com>,
        "'John Groves'" <JGroves@micron.com>
References: <07cedbe6-00ab-52fc-9475-c8d7120f5a95@jagalactic.com> <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
In-Reply-To: <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
Subject: RE: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
Date:   Fri, 28 Jan 2022 12:08:08 +0800
Message-ID: <02c601d813fc$a8744c70$f95ce550$@montage-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQLhlT/Yx4nKgnSTf5HYxrvx6zm+qAKNBoHUqlBlNAA=
Content-Language: en-us
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I think BIOS should follow CDAT spec v1.01 Device Scoped EFI Memory Type =
Structure (DSEMTS) structure

In Table 8 Device Scoped EFI Memory Type Structure, field EFI Memory =
Type and Attribute has below definition
  0 =E2=80=93 EfiConventionalMemory
  1 - EfiConventionalMemory Type with EFI_MEMORY_SP Attribute
  2 =E2=80=93 EfiReservedMemoryType
  3-255 =E2=80=93 Reserved encoding
  The memory attribute EFI_MEMORY_NV may be inferred from NonVolatile =
flag in DSMAS.
  Memory types other than EfiConventionalMemory and =
EfiReservedMemoryType are not permitted.

Thanks
Johnny
-----Original Message-----
From: John Groves (john@jagalactic.com) [mailto:john@jagalactic.com]=20
Sent: Friday, January 28, 2022 12:19 AM
To: Dan Williams; linux-cxl@vger.kernel.org
Cc: Jonathan Cameron; Ben Widawsky; John Groves
Subject: Should bios always mark CXL DRAM as EFI_MEMORY_SP?

I=E2=80=99d like to seek some feedback and see whether a consensus =
exists or can be developed regarding how system firmware (bios/efi/etc) =
should present CXL DRAM to a system in a pre-fabric world (CXL 1.1/2.0).

=20

The CXL spec, along with the Intel documentation are pretty specific and =
useful, but one open issue seems not to be outright specified: should =
the system mark CXL-attached DRAM as =E2=80=9Cspecific purpose=E2=80=9D =
(EFI_MEMORY_SP)? Consistency across platforms is certainly desirable. If =
this behavior is not prescribed, we could end up with inconsistent =
behavior across server and bios vendors.

=20

If this is already specified, no need to read on (but please point me to =
where it=E2=80=99s specified).

=20

Objective: I think everyone will likely agree that it should be possible =
to use CXL DRAM as either general-purpose memory, or via DAX, or a mix.

=20

What=E2=80=99s the difference?

=20

Memory marked as EFI_MEMORY_SP:

=20

=C2=B7      Mappable via DAX

=C2=B7      Can be online-converted to general purpose memory via daxctl

=C2=B7      Can be boot-converted to general-purpose with =
efi=3Dnosoftreserve on Linux command line

=20

Memory NOT marked as EFI_MEMORY_SP:

=20

=C2=B7      CXL is general-purpose memory (NUMA node with no local CPU =
cores)

=C2=B7      Some of the contents appear to be used for in-memory =
metadata (presumably buddy lists, etc.)

=C2=B7      Can be boot-converted to DAX with an efi_fake_mem=3D =
argument on the Linux command line

=C2=B7      Currently cannot be online-converted to DAX-managed (can =
this work? Is it intended to be working?)

=20

If online conversion from general-purpose to DAX is not going to work, =
it seems that the default should preserve the ability to use it either =
way: mark the memory as EFI_MEMORY_SP.

=20

Is there a right and wrong answer re:EFI_MEMORY_SP? How important is it =
to have consistency across platforms?

=20

If there is a consensus, the next question is who should express it. =
Perhaps the CXL consortium. I=E2=80=99m a part of that, but it seemed =
like the Linux dev community was the right place to start.

=20

Thanks for any thoughts.


John Groves

Micron







