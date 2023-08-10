Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F9BC001E0
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 16:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHJQd1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjHJQd0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 12:33:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D63090
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1691685188; x=1692289988; i=fan.ni@gmx.us;
 bh=Ic34E1rhStu5oBJ08gz/o3kbUbXuZnUVTlGULk/Q6ks=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dytzl3366sQQ9n/9D6wuVdYhzCHBBE6CgQB7eD4Y/nUiObxr1PUaDaQpySEFhSpZvVPcEU0
 jEy1eAdRZ6Cv5Jv60gcp5+AyC67dpL4fY3RfHMBFDRzi3dbW3O5QJCLjqzghzSHj/8kta+6DP
 SrdAogyL45Na7k1w5NEbD5g2ORqiCSbCvL0dXV4H/3b7kC6W+6+iKFTw+HbmK7ZJrre461/79
 gsyg12b7bkP0+lBYifqtJ/NXxbqYbAIs0bMHJipXGnst61rMeW5GNLREqyQJLBl1tE9vyeSAA
 ddRBux/5didM9hM9qUdX+O92dsg5KIRyn/4KjcZ316SA8RWi/wVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1qF5ke1eB9-00KiTo; Thu, 10
 Aug 2023 18:33:08 +0200
Date:   Thu, 10 Aug 2023 09:32:55 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Maverickk 78 <maverickk1778@gmail.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: CXL volatile memory is not listed
Message-ID: <ZNURN6Zzf2hJfmt/@debian>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
X-Provags-ID: V03:K1:34c3h0X1GoGb6w3tlWtZc4NsiTaDJ4S1HgxAVUBpatoGVB55JX3
 HtRJskZ0coaxwKVJgE/MarNgvBazmvKfa9j+CAKPLqDLiGFPVf/PbmbZJZa87sbIQxeZ0ja
 CZ92rV2XS5APrNxQHJVoPawZRuajTM4+5n4PO1zgCaHMky9aqPACczDan5rDVdHPAJ5Vaal
 uq5d7tsa4/WL9gfTd1Q5w==
UI-OutboundReport: notjunk:1;M01:P0:0gRq4+nxu1k=;XzOB6oQ5IH2ZLKstESxah76vVh5
 +Ful1GMetCckoAsTwzWweA2e3f/Qi7H0EuHZhv52+lmtIuO+GVSNZ1Q4lTdEbX/UFREfnCL+Z
 /EuKMy3zDxxDQJ07qeLHhOX956OBg/aaE5V13ty273E2qHEZgfAO+j55PTa2XFT5yf2ma5MaU
 Ixu1e8/vwkPfLTtkeWHbndUTNeiBywWI65D/r9tZQIhQLIKmY6K3+oKXHh2PMrd7gMAjV1Mef
 drInTjZTd6rP7CIkqvYn/s/LHBj63eMOhs8PMpmNPvu6Q6NzatpJgqSbm2yXfqDi00Z+ZP3uX
 N3Mw+GgszJEXmyMj4pXkMooGXnW2nk2VPJzzJit+eIF+paZeLl8T7ZLii60Xr+XOBhxO10l4K
 Pe4x4mLBrq3HXNalVNrCTL+0oAwZWZ4Z/CUSrO28CbGvLrcADrDdWYuyG8tFedhq9pUsIcbEO
 KNFfWWMmRnQQSAgsm1JHGy9Y0wrGBR34X90HgPwMvknGGlluVfFeef4CE1OTG3AkC9xv3bk+l
 KR+ORV2kbomimA2ufg8Ah+/YPUhceavk3sLlxIEBCj9tc1ntbHRkhi81gN09scY0PVgg4Ldvi
 K0PVaNml9SUruFdTw6w8t+EPqcrx30hneD9tUphve+QtnLIqhD/LrVyZLvHBkVUvq97KmyKP6
 kpI29IhN9B2TLxWZFk7QU+OQSv7zACxpyJf2QOYZHeYbSHdRHiE+K1l0u8UBYuDBzjAQAn2XT
 KB+03R+NpX6ot4dM87vd5PnDrkT7CLf9oLMIFjN1j4Ke9li8nlKZtQchO2VhoC8wDeBpAYGIb
 J+z4RcjbUz9CUzjIsLsIcPiG0UCyC8EE2wxIjTGh23I7CmD5Aiz6fAPwWxeAQSE/4L4qkiBmv
 pB7vr4ANlQOzNshcdFAIySzo7AhGzdCFZa2wLX84Pe9pGXt/8EnZiZ5dCeIYYxAUYjzCn0v2u
 2f+mxzXte2tqmlUIcYL2da6I2SM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> Hello,
>
> I am running qemu-system-x86_64
>
> qemu-system-x86_64 --version
> QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
>
> qemu-system-x86_64 \
> -m 2G,slots=3D4,maxmem=3D4G \
> -smp 4 \
> -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \
> -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,port=3D0,slot=3D0 \
> -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D1G,sha=
re=3Dtrue \
> -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0 \
> -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D1G
>
>
> I was expecting the CXL memory to be listed in "System Ram", the lsmem
> shows only 2G memory which is System RAM, it's not listing the CXL
> memory.
>
> Do I need to pass any particular parameter in the kernel command line?
>
> Is there any documentation available? I followed the inputs provided in
>
> https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
>
> Is there any documentation/blog listed?

If I remember it correctly, for volatile cxl memory, we need to create a
region and then it will be discovered as system memory and shows up.

Try to create a region with "cxl create-region".

Fan
>
