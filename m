Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECDC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F59604D1
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 14:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbhIMOv1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 10:51:27 -0400
Received: from a8-21.smtp-out.amazonses.com ([54.240.8.21]:46701 "EHLO
        a8-21.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244004AbhIMOrx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Sep 2021 10:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=lg67htegwjqeypdgehj5bz2vdyv4b22f; d=jagalactic.com; t=1631544397;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=83VMRbMCQmRsLNccNZVgziGUO+y41giWxSbDMLxCmFk=;
        b=LSU9t7tsR/7/04kDu2LGE6dENVFUVKrQRTHDiuZmHZv/BnutFoAo7FqtyNuaYgAK
        NBgXPIPzhOtQOVSQP9zdH001vk2JezAzQGApXb0b+bbSSSeaDC7nWgsdXs0teK8/u52
        RAhOVnC/rzzRbzoga7vdeQ/hEGPKIl2upVBsHkC8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631544397;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=83VMRbMCQmRsLNccNZVgziGUO+y41giWxSbDMLxCmFk=;
        b=GJM41fBPBb07sQ9X2b83+VA11cosqcU0J5sApeJnWXtUM4tQZqTgDjbqbp9VfaJq
        ztqeLzI8MPFnVs1nU8KTPUVk1S/dMZWya2Fy0r6RQ9Jmoti2OOD4ybjtxfWOCmuUiTq
        /8estifeYDfPHtrkRp5wF+oXRNbkR5vMnqVob82I=
Subject: Re: CXL 1.1 Support Plan
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>
Cc:     =?UTF-8?Q?johnny?= <johnny.li@montage-tech.com>,
        =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Ben_Widawsky?= <ben.widawsky@intel.com>,
        =?UTF-8?Q?John_Groves?= <jgroves@micron.com>
Date:   Mon, 13 Sep 2021 14:46:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local>
X-Mailer: Amazon WorkMail
Thread-Index: AQHXqK4mOngfGkR7THOhUQwNfqGkJA==
Thread-Topic: CXL 1.1 Support Plan
X-Wm-Sent-Timestamp: 1631544396
Message-ID: <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2021.09.13-54.240.8.21
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 10, 2021 at 8:21 AM Dan Williams <Dan.J.Willaims@intel.com> w=
rote:=0D=0A> On Tue, Aug 10, 2021 at 5:24 AM johnny <johnny.li@montage-te=
ch.com> wrote:=0D=0A> >=0D=0A> Hello,=0D=0A> >=0D=0A> > Current CXL patch=
es [1] focus on CXL 2.0 support. While in the real world,=0D=0A> > CXL 1.=
1 capable host and EP are the first CXL components end user can use. May =
I=0D=0A> > ask community plan on CXL 1.1 support=0D=0A>=20=0D=0A> The exp=
ectation is that CXL 1.1 is BIOS / platform-firmware supported.=0D=0A> Ju=
st like the OS does not have a driver for DDR and relies on the BIOS=0D=0A=
> to describe DDR resources via generic ACPI tables, the same=0D=0A> expe=
ctation holds for CXL 1.1. CXL 2.0 explicitly adds features that=0D=0A> e=
xceed what platform-firmware can support with static ACPI tables.=0D=0A>=20=
=0D=0A> Something is broken if the OS requires a driver for CXL 1.1 devic=
e=0D=0A> operation, at least for the generic memory expander use case.=0D=
=0A>=20=0D=0A> Ben did have some improvements to lspci to dump the range =
registers of=0D=0A> a CXL 1.1 device:=0D=0A>=20=0D=0A> https://github.com=
/pciutils/pciutils/pull/59=0D=0A>=20=0D=0A> ...but it does not seem the p=
ciutils project has accepted that work.=0D=0A=0D=0ATo probe a bit further=
 here... On a system with a cxl 1.1 memory device,=0D=0Awe see that bios =
maps it, but even though there is an SRAT entry=0D=0Adescribing a new NUM=
A node containing the cxl 1.1 memory, the memory=20=0D=0Ashows up as "sof=
t reserved" in the e820 memory map. And we observe=0D=0Athat Linux (5.13 =
ATM) does not use it.=0D=0A=0D=0AWe can map the memory via /dev/mem (with=
 CONFIG_STRICT_DEVMEM off), so=0D=0Awe are able to hack tests & benchmark=
s to use the memory - but clearly=0D=0Athis is not the correct or "intend=
ed" way to use cxl 1.1 memory.=0D=0A=0D=0AWe could certainly add memmap=3D=
offset!size to the kernel command line to=0D=0Aget it treated like simula=
ted nvdimm - which is great if 1) the memory=0D=0Ais non-volatile, and 2)=
 it's reliably always at the same address (which=0D=0Ait appears to be, b=
ut that feels like a bit of a squirrely outright=0D=0Aassumption).=0D=0A=0D=
=0AHow are people thinking we'll map and use cxl 1.1 pmem=3F  And what ab=
out=0D=0Acxl 1.1 dram=3F Is the current Linux behavior considered adequat=
e=0D=0A(ignoring the memory unless you use memmap, or efi_fake_mem)=3F=0D=
=0A=0D=0A...or am I missing something=3F=0D=0A=0D=0AThanks,=0D=0AJohn=0D=0A=
=0D=0A=0D=0A
