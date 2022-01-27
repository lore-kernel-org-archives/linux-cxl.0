Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380BC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 16:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiA0QSf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:18:35 -0500
Received: from a48-181.smtp-out.amazonses.com ([54.240.48.181]:41341 "EHLO
        a48-181.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238237AbiA0QSd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 11:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=lg67htegwjqeypdgehj5bz2vdyv4b22f; d=jagalactic.com; t=1643300313;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
        bh=g+0f7EdawFV7W/qHk1Rf2JnD1FVFi81v8aneWbFosu8=;
        b=GD69RQOSORk/BRZcAqX9A6dlh/lt8PhgE8cQnefR/udp4gtfs8uVZlTI0cgl0mVO
        rozv0cBqB5f0NO16vf3Gpk0ioB6sKVJ50d1+30u+3sbPltvsQheILto5SW5RCyvk0yg
        ONpxhoo8KA0oCcukxc9oA2k13sTgc+5B9XApHXIQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1643300313;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
        bh=g+0f7EdawFV7W/qHk1Rf2JnD1FVFi81v8aneWbFosu8=;
        b=K2LvaYYG6CTpMEQRdHZC3fldFf3XeA4TCyF2ZWWbI5PjUGw01d3S3/8XaxjqJCwn
        My3n+SIzECyxa4BAKzDulzpg7gJsgzjuSNf0HOpM/YmFTrs6DANvRYuAy1jLy04Blzp
        qjBpVQ0Wuxit9/c/UhSyD0kB0O9rf2HJTMDiF+vA=
Subject: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>,
        =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>
Cc:     =?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Ben_Widawsky?= <ben.widawsky@intel.com>,
        =?UTF-8?Q?John_Groves?= <JGroves@micron.com>
Date:   Thu, 27 Jan 2022 16:18:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <07cedbe6-00ab-52fc-9475-c8d7120f5a95@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHYE5mFNqJbUA/rRgi1cYZi0jt7wA==
Thread-Topic: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
X-Wm-Sent-Timestamp: 1643300311
Message-ID: <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2022.01.27-54.240.48.181
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I=E2=80=99d like to seek some feedback and see whether a consensus exists=
 or can be developed regarding how system firmware (bios/efi/etc) should =
present CXL DRAM to a system in a pre-fabric world (CXL 1.1/2.0).=0D=0A=0D=
=0A=C2=A0=0D=0A=0D=0AThe CXL spec, along with the Intel documentation are=
 pretty specific and useful, but one open issue seems not to be outright =
specified: should the system mark CXL-attached DRAM as =E2=80=9Cspecific =
purpose=E2=80=9D (EFI_MEMORY_SP)=3F Consistency across platforms is certa=
inly desirable. If this behavior is not prescribed, we could end up with =
inconsistent behavior across server and bios vendors.=0D=0A=0D=0A=C2=A0=0D=
=0A=0D=0AIf this is already specified, no need to read on (but please poi=
nt me to where it=E2=80=99s specified).=0D=0A=0D=0A=C2=A0=0D=0A=0D=0AObje=
ctive: I think everyone will likely agree that it should be possible to u=
se CXL DRAM as either general-purpose memory, or via DAX, or a mix.=0D=0A=
=0D=0A=C2=A0=0D=0A=0D=0AWhat=E2=80=99s the difference=3F=0D=0A=0D=0A=C2=A0=
=0D=0A=0D=0AMemory marked as EFI_MEMORY_SP:=0D=0A=0D=0A=C2=A0=0D=0A=0D=0A=
=C2=B7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mappable via DAX=0D=0A=0D=0A=C2=B7=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Can be online-converted to general purpose me=
mory via daxctl=0D=0A=0D=0A=C2=B7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Can be bo=
ot-converted to general-purpose with efi=3Dnosoftreserve on Linux command=
 line=0D=0A=0D=0A=C2=A0=0D=0A=0D=0AMemory NOT marked as EFI_MEMORY_SP:=0D=
=0A=0D=0A=C2=A0=0D=0A=0D=0A=C2=B7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CXL is ge=
neral-purpose memory (NUMA node with no local CPU cores)=0D=0A=0D=0A=C2=B7=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some of the contents appear to be used for=
 in-memory metadata (presumably buddy lists, etc.)=0D=0A=0D=0A=C2=B7=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Can be boot-converted to DAX with an efi_fake_me=
m=3D argument on the Linux command line=0D=0A=0D=0A=C2=B7=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Currently cannot be online-converted to DAX-managed (can thi=
s work=3F Is it intended to be working=3F)=0D=0A=0D=0A=C2=A0=0D=0A=0D=0AI=
f online conversion from general-purpose to DAX is not going to work, it =
seems that the default should preserve the ability to use it either way: =
mark the memory as EFI_MEMORY_SP.=0D=0A=0D=0A=C2=A0=0D=0A=0D=0AIs there a=
 right and wrong answer re:EFI_MEMORY_SP=3F How important is it to have c=
onsistency across platforms=3F=0D=0A=0D=0A=C2=A0=0D=0A=0D=0AIf there is a=
 consensus, the next question is who should express it. Perhaps the CXL c=
onsortium. I=E2=80=99m a part of that, but it seemed like the Linux dev c=
ommunity was the right place to start.=0D=0A=0D=0A=C2=A0=0D=0A=0D=0AThank=
s for any thoughts.=0D=0A=0D=0A=0D=0AJohn Groves=0D=0A=0D=0AMicron=0D=0A=0D=
=0A=0D=0A
