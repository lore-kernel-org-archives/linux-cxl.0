Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84DC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 19:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956066112D
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhINT5J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:57:09 -0400
Received: from a11-131.smtp-out.amazonses.com ([54.240.11.131]:41051 "EHLO
        a11-131.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhINT5I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 15:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=lg67htegwjqeypdgehj5bz2vdyv4b22f; d=jagalactic.com; t=1631649350;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=+NPGdN9ZEAl0SsIuW9THRxGhdwjsZ7tZX1xkamcG7YQ=;
        b=T7+NmXa2nQdqOCvO1/3FArMH9BmHDwhjyhqqyBAF2BiLUNc7ccyHPsQNlum7ZKQw
        OxcSGvEmyPPoohP2p9pk4vFceQM5bbHc4TxITPOvSMKmJB1pjAQGZK0Qxma6AoMRsjS
        5+YjgmvNDKz7aZwImWqKzHJ+h1fvrFZVcXy3SNo4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631649350;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=+NPGdN9ZEAl0SsIuW9THRxGhdwjsZ7tZX1xkamcG7YQ=;
        b=ALFdEnfdVOLZUXFpT/00RfZFBTduo14goD3J8mcaBfCyr7nggdvIFpYqxCpeDvDZ
        A7TVnvfM6I6RS9uTMcyEQ6vAIlETRhEPVfkvin5sX4lx+p5lSydgJTyw08nT0PB6+kg
        JXVNTXRghyrNtk/XA350FjwtnutkWMBYSb89pq4A=
Subject: Re: CXL 1.1 Support Plan
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>
Cc:     =?UTF-8?Q?johnny?= <johnny.li@montage-tech.com>,
        =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Ben_Widawsky?= <ben.widawsky@intel.com>,
        =?UTF-8?Q?John_Groves?= <jgroves@micron.com>
Date:   Tue, 14 Sep 2021 19:55:49 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local> 
 <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com> 
 <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com> 
 <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com> 
 <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHXqK4mOngfGkR7THOhUQwNfqGkJAAJJZJjAD0XI1o=
Thread-Topic: CXL 1.1 Support Plan
X-Wm-Sent-Timestamp: 1631649347
Message-ID: <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2021.09.14-54.240.11.131
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 9/13/21 2:08 PM, Dan Williams wrote:=0D=0A> On Mon, Sep 13, 2021 at 7:=
46 AM John Groves <john@jagalactic.com> wrote:=0D=0A>> On Tue, Aug 10, 20=
21 at 8:21 AM Dan Williams <Dan.J.Willaims@intel.com> wrote:=0D=0A>>> On =
Tue, Aug 10, 2021 at 5:24 AM johnny <johnny.li@montage-tech.com> wrote:=0D=
=0A>>> Hello,=0D=0A>>>> Current CXL patches [1] focus on CXL 2.0 support.=
 While in the real world,=0D=0A>>>> CXL 1.1 capable host and EP are the f=
irst CXL components end user can use. May I=0D=0A>>>> ask community plan =
on CXL 1.1 support=0D=0A>>> The expectation is that CXL 1.1 is BIOS / pla=
tform-firmware supported.=0D=0A>>> Just like the OS does not have a drive=
r for DDR and relies on the BIOS=0D=0A>>> to describe DDR resources via g=
eneric ACPI tables, the same=0D=0A>>> expectation holds for CXL 1.1. CXL =
2.0 explicitly adds features that=0D=0A>>> exceed what platform-firmware =
can support with static ACPI tables.=0D=0A>>>=0D=0A>>> Something is broke=
n if the OS requires a driver for CXL 1.1 device=0D=0A>>> operation, at l=
east for the generic memory expander use case.=0D=0A>>>=0D=0A>>> Ben did =
have some improvements to lspci to dump the range registers of=0D=0A>>> a=
 CXL 1.1 device:=0D=0A>>>=0D=0A>>> https://github.com/pciutils/pciutils/p=
ull/59=0D=0A>>>=0D=0A>>> ...but it does not seem the pciutils project has=
 accepted that work.=0D=0A>> To probe a bit further here... On a system w=
ith a cxl 1.1 memory device,=0D=0A>> we see that bios maps it, but even t=
hough there is an SRAT entry=0D=0A>> describing a new NUMA node containin=
g the cxl 1.1 memory, the memory=0D=0A>> shows up as "soft reserved" in t=
he e820 memory map. And we observe=0D=0A>> that Linux (5.13 ATM) does not=
 use it.=0D=0A>>=0D=0A> Looks like I need to improve the documentation he=
re, please review the=0D=0A> attached patch and let me know if it answers=
 your concerns.=0D=0A>=0D=0A> In short, Linux *does* use it. Soft-reserve=
 memory is accessed through=0D=0A> a dedicated device-file interface call=
ed device-dax by default. You=0D=0A> should be able to run:=0D=0A>=0D=0A>=
 cat /proc/iomem | grep dax=0D=0A>=0D=0A> ...and see your address range. =
I.e. something like:=0D=0A>=0D=0A> # cat /proc/iomem | grep dax=0D=0A>   =
  340000000-43fffffff : dax0.0=0D=0A>=0D=0A> ...and then /dev/dax0.0 can =
be directly accessed via mmap() (subject=0D=0A> to device-dax's strict ma=
pping alignment restriction (default 2MB)).=0D=0A=0D=0AThanks Dan! This p=
lus the doc patch clears up a lot. I'm able to map=0D=0Avia /dev/dax0.0 n=
ow.=0D=0A=0D=0AI built the cxl-2.0v3 branch of the ndctl repo (had to fin=
d source for=0D=0Akmod, which isn't packaged for rhel8=3F!).=0D=0A=0D=0AT=
hanks,=0D=0AJohn=0D=0A=0D=0A<snip>=0D=0A=0D=0A
