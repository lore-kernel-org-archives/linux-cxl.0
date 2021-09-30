Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED59CC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Sep 2021 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8286619F8
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Sep 2021 22:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbhI3WTV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:19:21 -0400
Received: from a11-124.smtp-out.amazonses.com ([54.240.11.124]:57469 "EHLO
        a11-124.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhI3WTT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Sep 2021 18:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=lg67htegwjqeypdgehj5bz2vdyv4b22f; d=jagalactic.com; t=1633040256;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=IkyhXuXCFLieRaeR9vRFScIDG4QKEmwmnMZZRkwBtbQ=;
        b=YrPQRvvvLKWZ3TftXAmDYkpr64oSGygKKJTdIbGHqli3fJ+fVmbHVOwrKpQr9WqQ
        I2kQSnYgFZc0xNHv2ywMAvr1AHGPyLP5HbkwM7Kjypul5H9/fvXGQibtZ9U3uFaAUws
        cW4+VIbakzoVz1nGAdnVpPAM16ODKRvGTWPp1OaI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633040256;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=IkyhXuXCFLieRaeR9vRFScIDG4QKEmwmnMZZRkwBtbQ=;
        b=eS/T8fWwP+mtboEnaEcRkrcik2z34J4ayj9a6KtKFHY59jiHoF/fzFy2O84fxE2C
        dsF6RrZHeqyIqzrxRokk1ZyS4rrCdZS5DHq7ioSlzfYYze2I6X53vgCOejIKastumGf
        XzHOc0OpGrs8s0a9bSV6sA2IaxI6UPUEZMl1Fr3c=
Subject: Re: CXL 1.1 Support Plan
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>
Cc:     =?UTF-8?Q?johnny?= <johnny.li@montage-tech.com>,
        =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Ben_Widawsky?= <ben.widawsky@intel.com>,
        =?UTF-8?Q?John_Groves?= <jgroves@micron.com>
Date:   Thu, 30 Sep 2021 22:17:35 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local> 
 <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com> 
 <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com> 
 <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com> 
 <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com> 
 <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com> 
 <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com> 
 <2093cae0-ff0b-1d6d-2ff2-ba1bb41510af@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHXqK4mOngfGkR7THOhUQwNfqGkJAAJJZJjAD0XI1oAPfiiXgNmtHwE
Thread-Topic: CXL 1.1 Support Plan
X-Wm-Sent-Timestamp: 1633040255
Message-ID: <0100017c38c8cbb1-c0632347-44dd-44a4-b6c2-4e33c2ba85e8-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2021.09.30-54.240.11.124
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 9/14/21 3:20 PM, Dan Williams wrote:=0D=0A> On Tue, Sep 14, 2021 at 12=
:56 PM John Groves <john@jagalactic.com> wrote:=0D=0A>> On 9/13/21 2:08 P=
M, Dan Williams wrote:=0D=0A>>> On Mon, Sep 13, 2021 at 7:46 AM John Grov=
es <john@jagalactic.com> wrote:=0D=0A>>>> On Tue, Aug 10, 2021 at 8:21 AM=
 Dan Williams <Dan.J.Willaims@intel.com> wrote:=0D=0A>>>>> On Tue, Aug 10=
, 2021 at 5:24 AM johnny <johnny.li@montage-tech.com> wrote:=0D=0A>>>>> H=
ello,=0D=0A>>>>>> Current CXL patches [1] focus on CXL 2.0 support. While=
 in the real world,=0D=0A>>>>>> CXL 1.1 capable host and EP are the first=
 CXL components end user can use. May I=0D=0A>>>>>> ask community plan on=
 CXL 1.1 support=0D=0A>>>>> The expectation is that CXL 1.1 is BIOS / pla=
tform-firmware supported.=0D=0A>>>>> Just like the OS does not have a dri=
ver for DDR and relies on the BIOS=0D=0A>>>>> to describe DDR resources v=
ia generic ACPI tables, the same=0D=0A>>>>> expectation holds for CXL 1.1=
=2E CXL 2.0 explicitly adds features that=0D=0A>>>>> exceed what platform=
-firmware can support with static ACPI tables.=0D=0A>>>>>=0D=0A>>>>> Some=
thing is broken if the OS requires a driver for CXL 1.1 device=0D=0A>>>>>=
 operation, at least for the generic memory expander use case.=0D=0A>>>>>=
=0D=0A>>>>> Ben did have some improvements to lspci to dump the range reg=
isters of=0D=0A>>>>> a CXL 1.1 device:=0D=0A>>>>>=0D=0A>>>>> https://gith=
ub.com/pciutils/pciutils/pull/59=0D=0A>>>>>=0D=0A>>>>> ...but it does not=
 seem the pciutils project has accepted that work.=0D=0A>>>> To probe a b=
it further here... On a system with a cxl 1.1 memory device,=0D=0A>>>> we=
 see that bios maps it, but even though there is an SRAT entry=0D=0A>>>> =
describing a new NUMA node containing the cxl 1.1 memory, the memory=0D=0A=
>>>> shows up as "soft reserved" in the e820 memory map. And we observe=0D=
=0A>>>> that Linux (5.13 ATM) does not use it.=0D=0A>>>>=0D=0A>>> Looks l=
ike I need to improve the documentation here, please review the=0D=0A>>> =
attached patch and let me know if it answers your concerns.=0D=0A>>>=0D=0A=
>>> In short, Linux *does* use it. Soft-reserve memory is accessed throug=
h=0D=0A>>> a dedicated device-file interface called device-dax by default=
=2E You=0D=0A>>> should be able to run:=0D=0A>>>=0D=0A>>> cat /proc/iomem=
 | grep dax=0D=0A>>>=0D=0A>>> ...and see your address range. I.e. somethi=
ng like:=0D=0A>>>=0D=0A>>> # cat /proc/iomem | grep dax=0D=0A>>>     3400=
00000-43fffffff : dax0.0=0D=0A>>>=0D=0A>>> ...and then /dev/dax0.0 can be=
 directly accessed via mmap() (subject=0D=0A>>> to device-dax's strict ma=
pping alignment restriction (default 2MB)).=0D=0A>> Thanks Dan! This plus=
 the doc patch clears up a lot. I'm able to map=0D=0A>> via /dev/dax0.0 n=
ow.=0D=0A> Great!=0D=0A=0D=0AI don't see your doc patch yet in the ndctl =
repo, but I recommend merging it there.=0D=0A=0D=0AA related question: "d=
axctl reconfigure-device --mode=3Dsystem-ram ..." works for me,=0D=0Awith=
 --force, but going the other way (--mode=3Ddevdax) fails.=C2=A0 But a re=
boot puts it back=0D=0Ainto devdax mode regardless of the pre-boot settin=
g (i.e. --mode=3Dsystem-ram reverts=0D=0Aback to devdax on reboot).=0D=0A=
=0D=0AIs reconfigure-device capable of remaining in effect after a reboot=
 (in which case I'm curious=0D=0Ahow you persist the info if the device i=
s volatile; I believe it's the LSA on a non-volatile=0D=0Adevice).=0D=0A=0D=
=0ABack to the patch: you mention --mode=3Dsystem-ram, but it might be he=
lpful to add=0D=0Aa mention of --mode=3Ddevdax, along with a mention of w=
hether (and how) these=0D=0Achanges are persisted.=0D=0A=0D=0AAgain, than=
ks!=0D=0A=0D=0A=0D=0A>=0D=0A>> I built the cxl-2.0v3 branch of the ndctl =
repo (had to find source for=0D=0A>> kmod, which isn't packaged for rhel8=
=3F!).=0D=0A>>=0D=0A> That doesn't sound right...=0D=0A>=0D=0A> # mock -r=
 centos-stream-8-x86_64 -n --dnf-cmd whatprovides kmod-devel=0D=0A> [..]=0D=
=0A> CentOS Stream 8 - Extras=0D=0A>   19 kB/s |  15 kB     00:00=0D=0A>=0D=
=0A> kmod-devel-25-17.el8.x86_64 : Header files for kmod development=0D=0A=
> Repo        : powertools=0D=0A> Matched from:=0D=0A> Provide    : kmod-=
devel =3D 25-17.el8=0D=0A>=0D=0A> kmod-devel-25-18.el8.x86_64 : Header fi=
les for kmod development=0D=0A> Repo        : powertools=0D=0A> Matched f=
rom:=0D=0A> Provide    : kmod-devel =3D 25-18.el8=0D=0A=0D=0AI'm a failur=
e at understanding the dis-aggregated repos in modern rhel.=0D=0AI had fo=
und evidence that kmod-devel was packaged for cent8, but didn't=0D=0Aknow=
 how to ... bla bla.=C2=A0 It's a personal problem :D=0D=0A=0D=0AThanks,=0D=
=0AJohn=0D=0A=0D=0A=0D=0A
