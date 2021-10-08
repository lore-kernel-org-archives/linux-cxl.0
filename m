Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF66C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF6C60EC0
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 18:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJHSpU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:45:20 -0400
Received: from a11-73.smtp-out.amazonses.com ([54.240.11.73]:37765 "EHLO
        a11-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhJHSpT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Oct 2021 14:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=lg67htegwjqeypdgehj5bz2vdyv4b22f; d=jagalactic.com; t=1633718603;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=Q+VAtdFlzOdkwd3YSlzdZ+sT10GHWFwyorksQ1N/o8c=;
        b=QGrN4E6KMSppBHb70KasMyB+Bz0I5wOwVvS4HR8TZ11qNiA2oxmvCYPN2rxChcof
        LFy3wHMdAUPg20JHJjPVloZH8RM9VzaNZDYQeyq7LxDpAVVrsa3GDJM6vQkd1w0mk/d
        8LGpL/pUmSzXnvNygsbWEUuLHGLfT/KuQWLrqHa4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633718603;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=Q+VAtdFlzOdkwd3YSlzdZ+sT10GHWFwyorksQ1N/o8c=;
        b=RRmSE1IsPxpB6Os+ueXt2yNXdOvUqexWtkvDysQSGRnOEGNqlPWiKBPecmg/4OIF
        UrMszY1hVZNH4Po1lRrhJYyBq7L7mPWXiYc1xsallSRq823Tkdh0LGh5qceayLJYvnb
        yffXj2GRrJmaO3JFpbsh/Wdeo0gIPjt4eNBwVUsA=
Subject: Re: CXL 1.1 Support Plan
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Verma=2C_Vishal_L?= <vishal.l.verma@intel.com>,
        =?UTF-8?Q?Williams=2C_Dan_J?= <dan.j.williams@intel.com>
Cc:     =?UTF-8?Q?johnny=2Eli=40montage-tech=2Ecom?= 
        <johnny.li@montage-tech.com>,
        =?UTF-8?Q?Widawsky=2C_Ben?= <ben.widawsky@intel.com>,
        =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?Jonathan=2ECameron=40huawei=2Ecom?= 
        <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?jgroves=40micron=2Ecom?= <jgroves@micron.com>
Date:   Fri, 8 Oct 2021 18:43:23 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8a9b94becf407e218a544d3d0d9286ec4c698099.camel@intel.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local> 
 <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com> 
 <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com> 
 <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com> 
 <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com> 
 <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com> 
 <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com> 
 <2093cae0-ff0b-1d6d-2ff2-ba1bb41510af@jagalactic.com> 
 <0100017c38c8cbb1-c0632347-44dd-44a4-b6c2-4e33c2ba85e8-000000@email.amazonses.com> 
 <8a9b94becf407e218a544d3d0d9286ec4c698099.camel@intel.com> 
 <945a5996-961e-a159-2168-8da355b6d945@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: =?us-ascii?Q?AQHXjeOyDbo/H0Y69E21FQB9XsVm96ts2ugAgDVln4CAAEk?=
 =?us-ascii?Q?WAIABn6OAgAAG9ICAGUX1gIAK8xOAC6QrG2s=3D?=
Thread-Topic: CXL 1.1 Support Plan
X-Wm-Sent-Timestamp: 1633718602
Message-ID: <0100017c61378e14-5efea3be-ca28-476b-bc64-4512c44dba50-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2021.10.08-54.240.11.73
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 10/7/21 4:30 PM, Verma, Vishal L wrote:=0D=0A> On Thu, 2021-09-30 at 2=
2:17 +0000, John Groves wrote:=0D=0A>> I don't see your doc patch yet in =
the ndctl repo, but I recommend merging it there.=0D=0A>>=0D=0A>> A relat=
ed question: "daxctl reconfigure-device --mode=3Dsystem-ram ..." works fo=
r me,=0D=0A>> with --force, but going the other way (--mode=3Ddevdax) fai=
ls.=C2=A0 But a reboot puts it back=0D=0A>> into devdax mode regardless o=
f the pre-boot setting (i.e. --mode=3Dsystem-ram reverts=0D=0A>> back to =
devdax on reboot).=0D=0A> Oh, I'm a bit confused. --force only applies wh=
en going from system-ram=0D=0A> to devdax -- it offlines the memory for y=
ou. Without force, you're=0D=0A> responsible for a prior 'daxctl offline-=
memory daxX.Y' step.=0D=0A>=0D=0A> Going from devdax to system-ram should=
 not need --force, and I don't=0D=0A> think force actually does anything =
there.=0D=0A=0D=0AHoping I've successfully de-mangled this message...=0D=0A=
=0D=0AI definitely might be doing something wrong.=C2=A0 Here is a "types=
cript".=0D=0A=0D=0A# grep dax /proc/iomem=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A08=
80000000-107fffffff :=C2=A0*dax*0.0=0D=0A=0D=0A=0D=0A# ls -al /dev/dax0.0=
=0D=0A=0D=0Acrw------- 1 root root 252, 2 Oct=C2=A0=C2=A08 13:14 /dev/dax=
0.0=0D=0A=0D=0A=0D=0A# numastat=0D=0A=0D=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0n=
ode0=0D=0A=0D=0Anuma_hit=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A02698949=0D=0A=0D=0Anuma_miss=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0Anuma_fore=
ign=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A00=0D=0A=0D=0Ainterleave_hit=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A014565=0D=0A=0D=0Alocal_node=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A02698949=0D=0A=0D=0Aother_node=C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0A=0D=
=0A# daxctl reconfigure-device --mode=3Dsystem-ram --region=3D0 dax0.0=0D=
=0A=0D=0Adax0.0: error: kernel policy will auto-online memory, aborting=0D=
=0A=0D=0Aerror reconfiguring devices: Device or resource busy=0D=0A=0D=0A=
reconfigured 0 devices=0D=0A=0D=0A=0D=0A# daxctl reconfigure-device --mod=
e=3Dsystem-ram --region=3D0 --force dax0.0=0D=0A=0D=0Adax0.0:=0D=0A=0D=0A=
=C2=A0=C2=A0WARNING: detected a race while onlining memory=0D=0A=0D=0A=C2=
=A0=C2=A0Some memory may not be in the expected zone. It is=0D=0A=0D=0A=C2=
=A0=C2=A0recommended to disable any other onlining mechanisms,=0D=0A=0D=0A=
=C2=A0=C2=A0and retry. If onlining is to be left to other agents,=0D=0A=0D=
=0A=C2=A0=C2=A0use the --no-online option to suppress this warning=0D=0A=0D=
=0Adax0.0: all memory sections (256) already online=0D=0A=0D=0A[=0D=0A=0D=
=0A=C2=A0=C2=A0{=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A0"chardev":"dax0.0",=0D=0A=0D=
=0A=C2=A0 =C2=A0=C2=A0"size":34359738368,=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A0"=
target_node":1,=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A0"align":2097152,=0D=0A=0D=0A=
=C2=A0 =C2=A0=C2=A0"mode":"system-ram",=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A0"on=
line_memblocks":256,=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A0"total_memblocks":256,=
=0D=0A=0D=0A=C2=A0 =C2=A0=C2=A0"movable":false=0D=0A=0D=0A=C2=A0=C2=A0}=0D=
=0A=0D=0A]=0D=0A=0D=0Areconfigured 1 device=0D=0A=0D=0A=0D=0A# numastat=0D=
=0A=0D=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0node0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0node1=0D=0A=0D=0Anuma_hit=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A02878872=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0Anuma_miss=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=C2=A0=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0Anuma_foreign=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0Ainterleav=
e_hit=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A014565=C2=A0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0Alocal_node=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A02878872=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=0A=0D=0Aother_nod=
e=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A00=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A00=0D=
=0A=0D=0A=C2=A0=0D=0A=0D=0AI tried offlining the device and memory before=
 reconfigure-device, but those failed.=0D=0AAm I doing something wrong or=
 missing a step here=3F=0D=0A=0D=0A=0D=0A>=0D=0A>> Is reconfigure-device =
capable of remaining in effect after a reboot (in which case I'm curious=0D=
=0A>> how you persist the info if the device is volatile; I believe it's =
the LSA on a non-volatile=0D=0A>> device).=0D=0A> The beginnings of this =
automation are in progress, at least for=0D=0A> converting pmem devices:=0D=
=0A>=0D=0A>   https://lore.kernel.org/nvdimm/20210831090459.2306727-1-vis=
hal.l.verma@intel.com/=0D=0A>=0D=0A> This is yet to be extended to volati=
le dax devices after figuring out=0D=0A> what property we can key off of =
- one idea is the 'target_node' from=0D=0A> ACPI.=0D=0AThank you!=0D=0A>=0D=
=0A>> Back to the patch: you mention --mode=3Dsystem-ram, but it might be=
 helpful to add=0D=0A>> a mention of --mode=3Ddevdax, along with a mentio=
n of whether (and how) these=0D=0A>> changes are persisted.=0D=0A> The re=
st of the man page talks a little bit about the modes:=0D=0A>=0D=0A>   ht=
tps://pmem.io/ndctl/daxctl-reconfigure-device.html=0D=0A>=0D=0A> Dan - yo=
u haven't posted the patch you attached to the list yet have=0D=0A> you=3F=
 /me couldn't find it on lore - wasn't sure if I'd just missed it.=0D=0A>=
=0D=0A=0D=0AI'm pretty sure that's where I found --mode=3Ddevdax, though =
I couldn't figure out how to get=0D=0Aconversion back to devdax to work. =
I'm sure there is something I'm missing.=0D=0A=0D=0AStarting in the state=
 where I left off above:=0D=0A=0D=0A=0D=0A# daxctl reconfigure-device --m=
ode=3Ddevdax dax0.0=0D=0Aerror reconfiguring devices: Device or resource =
busy=0D=0Areconfigured 0 devices=0D=0A=0D=0A=0D=0A# daxctl reconfigure-de=
vice --mode=3Ddevdax --force dax0.0=0D=0Alibdaxctl: offline_one_memblock:=
 dax0.0: Failed to offline /sys/devices/system/node/node1/memory272/state=
: Device or resource busy=0D=0Adax0.0: failed to offline memory: Device o=
r resource busy=0D=0A=0D=0Aerror reconfiguring devices: Device or resourc=
e busy=0D=0Areconfigured 0 devices=0D=0A=0D=0A=0D=0A# daxctl offline-memo=
ry dax0.0=0D=0Adax0.0: 4 memory sections already offline=0D=0Alibdaxctl: =
offline_one_memblock: dax0.0: Failed to offline /sys/devices/system/node/=
node1/memory272/state: Device or resource busy=0D=0Adax0.0: failed to off=
line memory: Device or resource busy=0D=0Aerror offlining memory: Device =
or resource busy=0D=0Aofflined memory for 0 devices=0D=0A=0D=0A# daxctl o=
ffline-memory --force dax0.0=0D=0A=C2=A0 Error: unknown option `force'=0D=
=0A=C2=A0usage: daxctl offline-memory <device> [<options>]=0D=0A=0D=0A=C2=
=A0 =C2=A0 -r, --region <region-id>=0D=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filter by region=
=0D=0A=C2=A0 =C2=A0 -u, --human=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0use human friendly number formats=0D=0A=C2=A0 =C2=A0 -v, --verbose=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0emit more debug messages=0D=0A=0D=0A=C2=A0=
=0D=0A=0D=0AI have to reboot to get back to dax memory, though it's very =
possible that my=0D=0A[questionable] doc reading skills are at fault.=0D=0A=
=0D=0AThanks,=0D=0AJohn=0D=0A=0D=0A=0D=0A=0D=0A=0D=0A=0D=0A
