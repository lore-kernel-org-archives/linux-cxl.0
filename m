Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C29C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 14:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577926AbiAYOLh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbiAYOJY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 09:09:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CC6C06173D
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 06:09:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j23so57954600edp.5
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FTALgA/7M/2BeIR53QsUkODjcYOiiFsbOIKZ4dRsJ2w=;
        b=HAsx8a57DND75Ote8X8Ijh+czs0TWwa1uHGP54Sx2ao7rUfFjExpT7SEhvJd0mT9DM
         YOaUmOvkH3/8b5vfAEAMzO+H9Ds+5YjfciLk+qNSXAnGMlT+jU3ITkWQSed0dlnIwLXi
         sGHFkB3G2MVbpTdV3/xCg7ye19PRvNJOVr02w9V+PA75OTJkp0ALbKpmQ6GQXovq4ETs
         PdCsMYJHfKBSFDPRRLaFr39iJsQEWFg0V0nuc/YvECpN3ykEnQufxqTGsFwJeKizg/b3
         28t7K1oSMAaw6tfcDfJ3vz5OgNslRM0Pkwdqx7H+albwtcaNV/bVjnIa6IUB3ckO5DqH
         x5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FTALgA/7M/2BeIR53QsUkODjcYOiiFsbOIKZ4dRsJ2w=;
        b=pJAmHC2DFZ9r956Z1Xv3IHlaBJmZjsRgGM5dU0BdXg043zUce9cXuH9RtYy/7EQO+r
         uOspra8oS56hMAVjHoM7IIXIf+/TqC94WdcxjAT9wF+JdM/etEb9goF4CRyST5IlPz38
         q455Ixa1K5Qt6oyhhlgTxlidJ9+q7ooh5CAOoTzfLbC98qiFb6DJvlSRSj4tiS0rc5K9
         DuvelXhUdZaODDMtsodE2ZMed7KvPk67akFJ+ze3OHpWyT13cXuxYdOwPimEUhYqCx8Q
         U73alOvsanXlbS1kfif8Nq9TNEJHMKWUCyBp5b2aTJqhQALM+0hSkt/DE6/My8VcBJL7
         Khag==
X-Gm-Message-State: AOAM530gL7aan1W3i+7dxOwPIH9wnrzN3mT7T8I59a+TwdRNCVcY/p5X
        XztVQl7N+4naZGjWCC7QQW4D5A==
X-Google-Smtp-Source: ABdhPJzMCqchXFqGvijik8DCc69N/3+Q/E1Ja0wvMwSjBtO/eCuHT2LjQbOKBtm1dkByzEs8O999tg==
X-Received: by 2002:a17:907:6290:: with SMTP id nd16mr15970607ejc.244.1643119761461;
        Tue, 25 Jan 2022 06:09:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id lf16sm6149942ejc.25.2022.01.25.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:09:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id C72191FFB7;
        Tue, 25 Jan 2022 14:09:19 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 00/42] CXl 2.0 emulation Support
Date:   Tue, 25 Jan 2022 13:55:29 +0000
In-reply-to: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
Message-ID: <871r0vewkw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Previous version was RFC v3: CXL 2.0 Support.
> No longer an RFC as I would consider the vast majority of this
> to be ready for detailed review. There are still questions called
> out in some patches however.
>
> Looking in particular for:
> * Review of the PCI interactions
> * x86 and ARM machine interactions (particularly the memory maps)
> * Review of the interleaving approach - is the basic idea
>   acceptable?
> * Review of the command line interface.
> * CXL related review welcome but much of that got reviewed
>   in earlier versions and hasn't changed substantially.
>
<snip>
>
> Why do we want QEMU emulation of CXL?
>
> As Ben stated in V3, QEMU support has been critical to getting OS
> software written given lack of availability of hardware supporting the
> latest CXL features (coupled with very high demand for support being
> ready in a timely fashion). What has become clear since Ben's v3
> is that situation is a continuous one.  Whilst we can't talk about
> them yet, CXL 3.0 features and OS support have been prototyped on
> top of this support and a lot of the ongoing kernel work is being
> tested against these patches.

Is the core CXL support already in the upstream kernel or do you need a
patched one?

> Other features on the qemu-list that build on these include PCI-DOE
> /CDAT support from the Avery Design team further showing how this
> code is useful.  Whilst not directly related this is also the test
> platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
> utilizes and extends those technologies and is likely to be an early
> adopter.
> Refs:
> CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan=
.Cameron@huawei.com/
> CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-e=
mail-cbrowy@avery-design.com/
> DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-=
email-cbrowy@avery-design.com/
>
>
> As can be seen there is non trivial interaction with other areas of
> Qemu, particularly PCI and keeping this set up to date is proving
> a burden we'd rather do without :)
>
> Ben mentioned a few other good reasons in v3:
> https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@i=
ntel.com/
>
> The evolution of this series perhaps leave it in a less than
> entirely obvious order and that may get tidied up in future postings.
> I'm also open to this being considered in bite sized chunks.  What
> we have here is about what you need for it to be useful for testing
> currently kernel code.

Ah right...

> All comments welcome.
>
> Ben - I lifted one patch from your git tree that didn't have a
> Sign-off.   hw/cxl/component Add a dumb HDM decoder handler
> Could you confirm you are happy for one to be added?
>
> Example of new command line (with virt ITS patches ;)

One thing I think is missing in this series is some documentation. We've
been historically bad at adding it for new devices but given the
complexity of CXL I think we should certainly try to improve. I think a
reasonable stab could be made from the commit messages in the series. I
would suggest:

  docs/system/devices/cxl.rst

And include:

  - an brief overview of CXL
  - kernel config options

and an some example command lines, like bellow:

>
> qemu-system-aarch64 -M virt,gic-version=3D3,cxl=3Don \
>  -m 4g,maxmem=3D8G,slots=3D8 \
>  ...
>  -object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxl=
test.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cxl=
test2.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-mem3,share=3Don,mem-path=3D/tmp/cxl=
test3.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-mem4,share=3Don,mem-path=3D/tmp/cxl=
test4.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa=
.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-lsa2,share=3Don,mem-path=3D/tmp/lsa=
2.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-lsa3,share=3Don,mem-path=3D/tmp/lsa=
3.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dcxl-lsa4,share=3Don,mem-path=3D/tmp/lsa=
4.raw,size=3D256M,align=3D256M \
>  -object memory-backend-file,id=3Dtt,share=3Don,mem-path=3D/tmp/tt.raw,si=
ze=3D1g \
>  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
>  -device pxb-cxl,bus_nr=3D222,bus=3Dpcie.0,id=3Dcxl.2 \
>  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D=
2 \
>  -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,id=
=3Dcxl-pmem0,size=3D256M \
>  -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port14,chassis=3D0,slot=3D=
3 \
>  -device cxl-type3,bus=3Droot_port14,memdev=3Dcxl-mem2,lsa=3Dcxl-lsa2,id=
=3Dcxl-pmem1,size=3D256M \
>  -device cxl-rp,port=3D0,bus=3Dcxl.2,id=3Droot_port15,chassis=3D0,slot=3D=
5 \
>  -device cxl-type3,bus=3Droot_port15,memdev=3Dcxl-mem3,lsa=3Dcxl-lsa3,id=
=3Dcxl-pmem2,size=3D256M \
>  -device cxl-rp,port=3D1,bus=3Dcxl.2,id=3Droot_port16,chassis=3D0,slot=3D=
6 \
>  -device cxl-type3,bus=3Droot_port16,memdev=3Dcxl-mem4,lsa=3Dcxl-lsa4,id=
=3Dcxl-pmem3,size=3D256M \
>  -cxl-fixed-memory-window targets=3Dcxl.1,size=3D4G,interleave-granularit=
y=3D8k \
>  -cxl-fixed-memory-window
> targets=3Dcxl.1,targets=3Dcxl.2,size=3D4G,interleave-granularity=3D8k

So AIUI the above creates some CXL pmem devices that are part of the CXL
root bus which itself is on the PCIe bus? Is the intention that
reads/writes into the pmem by the guest end up visible in various forms
in the memory backend files? Are memory backends required or can the
address space be treated as volatile RAM that doesn't persist beyond a
reset/reboot?

Maybe a simple diagram will help make things clearer?

>
> First CFMWS suitable for 2 way interleave, the second for 4 way (2 way
> at host level and 2 way at the host bridge).
> targets=3D<range of pxb-cxl uids> , multiple entries if range is disjoint.
>
<snip>

--=20
Alex Benn=C3=A9e
