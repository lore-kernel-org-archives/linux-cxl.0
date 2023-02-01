Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62045C05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBAUFm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAUFm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 15:05:42 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A261854
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 12:05:13 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g7so2448092qto.11
        for <linux-cxl@vger.kernel.org>; Wed, 01 Feb 2023 12:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHV/icvPfY1z87W3W1IfU3kDGkXwgJusq1AsVWbG+lA=;
        b=cS27BKHj3RadMinpIo9/1LSF4WUOksHfy9gDkZzJ5wQ4i4vwnIJD1jKQnXtGMkZQWH
         i82d1SlXerC1Tt+5BVLlWcL4IP0pgEWqUNM6dWDihcA6KNnwiBUtdKxHCITsdoP4fMT0
         Pr+amvK8cc7YZPEN9ua57w6q8wX89+606Vl/adUX3erODgWvOecWZpjzbUXE1XMh0CEg
         +O6vKu+Pl0zzm0yv5N0nSKWXtcZN9dcwcQ5DzyWZzo+vaPFJqngAGuAWjao7xrncaHvl
         S4yUxxFtVXTladlNYja0QEeCbSFLAzHcjkN9z2cd3PZK1ev88T1lVaxe7PqAAOXtAW6a
         ORYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHV/icvPfY1z87W3W1IfU3kDGkXwgJusq1AsVWbG+lA=;
        b=hERCAmqOeALfXAnxO0+SgEuu1nIVZX4VTUle4KE+GikJ7Xt7Ccy6o2kFZqok4Zfp4E
         3wxgqZiTpBpwws1Y/hSDLDo/o+JgvJib1K11CLDHDO4mykbEIIj+4oMNYX2Z4Ad8kazt
         0+Dqb27cMD/AImTnDcjz4wy/GOWRd37Lg7SIKel6gYKI8KePYbNh7BTXShVtq2cFxKup
         tCa0Fqalg8+HIEkd0mxVHpwNILXhztwR+L8KhUTAbqbuD5NTB5RxGklX1t8ISuq8SXnq
         vpoRChig1plA/Bnske7p3m7RaV8wPUsiiBVwW4GCky0/SnHAx6d/Tc92QFCGh2DbE2v7
         CJmw==
X-Gm-Message-State: AO0yUKVHS4zi7MAwy9V1PGMKCFuMCYlvpq/J/j56t4fnF62swkOJk0KR
        D0Ql9UkPMJVGbto4yjNbbfJxnQ==
X-Google-Smtp-Source: AK7set9IFtclT8jvOgxnFh4s18X3S0+aqJWD96WCl/JLn2mX287jif+Si/9YI/2UIsimcOwWWv9+uw==
X-Received: by 2002:ac8:7d94:0:b0:3b9:ba7a:dd89 with SMTP id c20-20020ac87d94000000b003b9ba7add89mr56980qtd.58.1675281912579;
        Wed, 01 Feb 2023 12:05:12 -0800 (PST)
Received: from smtpclient.apple (ec2-13-57-97-131.us-west-1.compute.amazonaws.com. [13.57.97.131])
        by smtp.gmail.com with ESMTPSA id ei24-20020a05622a4f1800b003b2957fb45bsm4588030qtb.8.2023.02.01.12.05.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 12:05:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF TOPIC] CXL Fabric Manager (FM)
 architecture
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230131174115.00007493@Huawei.com>
Date:   Wed, 1 Feb 2023 12:04:56 -0800
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5671D3B3-83B3-49FF-A662-509648E6D297@bytedance.com>
References: <7F001EAF-C512-436A-A9DD-E08730C91214@bytedance.com>
 <20230131174115.00007493@Huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

> On Jan 31, 2023, at 9:41 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Mon, 30 Jan 2023 11:11:23 -0800
> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>=20
>> Hello,
>=20
> Hi Slava,
>=20
> I'll throw some opinions at this :)
>=20
>>=20
>> I would like to suggest Fabric Manager (FM) architecture discussion. =
As far as I can see,
>> FM architecture requires: (1) FM configuration tool, (2) FM daemon, =
(3) QEMU emulation
>> of CXL hardware features. FM daemon receives requests from =
configuration tool and
>> executes commands by means of interaction with kernel-space subsystem =
and CXL switch
>> (that can be emulated by QEMU). So, the key questions for discussion:
>=20
> Worth describing operating modes to be supported: You kind of cover =
this later
> but I think pulling it out make it clearer that we want one bit of =
software to
> do several different things.
>=20
> 1) FM separate from hosts and talked to by higher level orchestration =
software
>   but using a Switch CCI or MHD mailbox (over PCI)
>   This one is fairly easy because any security / shooting self in foot =
problems
>   are an issue for higher level software.=20
> 2) FM on host.  Probably mostly going be relevant for debug but may =
use
>   the same mailbox as is being used by the existing CXL drivers (for =
Multi
>   Head Device it might be the end point mailbox, for Multi Logical =
Device
>   behind a switch it might be the switch mailbox).
> 3) All out of band (MCTP or similar - want some shared code, but no
>   need for anything in kernel as far as I can tell).
>=20

Most probably, we will have multiple FM implementations in firmware.
Yes, FM on host could be important for debug and to verify correctness
firmware-based implementations. But FM daemon on host could be important
to receive notifications and react somehow on these events. Also, =
journalling
of events/messages/events could be important responsibility of FM daemon
on host.=20

>=20
>> (1) How to distribute functionality between user-space and =
kernel-space?
>=20
> Kernel for transport if mailbox based (switch or MHD).
> Possibly help in kernel with the host to Multiheaded device FM LD =
tunneling
> and host to switch to Multi Logical Device - Logical Device tunneling
> but that could also be left to userspace.
>=20

People loves to move everything in user-space now. But I believe we =
could have
as kernel-space as user-space solutions. I think we ned to check what =
way could be
more efficient and elegant solution.

> If MCTP use the existing MCTP framework which is underlying transport =
independent.
> I posted a PoC for how this might work a while ago (hack on top of =
MCTP-I2C
> and some emulation) In the cover letter of the emulation PoC
>=20

Sounds interesting. Let me check it. But I believe it could not be not =
the first task
in this implementation. :)

>=20
> I think everything else belongs in userspace. I believe there are =
redfish APIs
> etc that would then be used to query and drive the userspace program =
from an
> orchestrator or similar level software.
>=20

I need to check the redfish API. It sounds reasonable to employ some =
existing
framework.

>> (2) Which functionality kernel-space needs to provide for =
implementation FM features?
>>      Which kernel-space functionality do we need to implement yet?
>=20
> Very little needed if we just expose the transport via PCI mailboxes.
> There is a possible concern that FM-API commands are frequently
> destructive and currently we don't let userspace poke destructive
> commands. That may just need a specific opt in to say we know we
> can shoot ourselves in the foot.
>=20

I think this is why we need kernel. It sounds for me that we have to =
have user-space
and kernel-space collaboration here.

>> (3) Do we need MCTP (Management Component Transport Protocol) or some =
other
>>      protocol can be used for interaction between configuration tool, =
FM daemon, and
>>      CXL switch?
>=20
> Yes MCTP is needed.
> I don't think we want the actual management code to be different
> depending on transport / protocol.  However we might layer it so that =
there
> is an interface program that sits between the management library / =
program and
> the FM-API transport.
>=20
> Note I was struggling to find a suitable MCTP interface to emulate - =
so would
> welcome suggestions on that.  I hacked the above PoC using an aspeed =
i2c
> controller that supported the right magic combination of features =
needed
> for MCTP over I2C but it doesn't have ACPI support which rather limits
> usage (and I doubt anyone will be keen on adding ACPI support just to
> test CXL related code :)  If anyone knows of a suitable MCTP host we
> could use for this that would be great (MCTP over PCI VDM might be =
nice for
> example)
>=20

Let us start some command/feature implementation and we will figure it =
out.
But, I assume we need to start from something like CXL devices discovery =
at first.

>> (4) What architecture FM implementation requires?
>> (5) Does it make sense to use Rust as implementation language?
>=20
> Take your pick ;) First person to write a lot of code gets to pick the =
language.
>=20

Yeah, I see the point. Rust can provide some benefits (memory safety =
model, for example).
But it could introduce some issue with collaboration and makes =
implementation more
slow. Everybody develops in C language. But switching on Rust could be =
not so easy
target.

<skipped>

>>=20
>>=20
>> FM configuration tool requires such commands:
>=20
> A command line tool is fine, but like the 'real' FM configuration =
interface will be via
> a protocol (e.g. redfish).
> There is a WIP for CXL, though not sure on latest status on this =
(document on there is from
> 2021)
>=20
> So ultimately I'd expect fm_cli to be a wrapper around libredfish / =
redfishtoo
>  that just makes it a bit easier to poke
> with common commands.
>=20
> I'm far from an expert of redfish so may have this all wrong.
>=20

Sounds reasonable to me. Let me check how good it could be for this =
project.

>>=20
>> Discover - discover available agents
>> Subcommands:
>>    - fm_cli discover fm - discover FM instances
>=20
> If we are allowing more than one FM then I'd expect all the
> other commands to be directed at that by some sort of FM specific
> ID. If only one, what does this command do that isn't better
> done with fm get_info
>=20

Yes, we need to identify every object somehow. And it=E2=80=99s =
interesting point.
=46rom point of view, some human-friendly names could be good.
But firmware-based FM implementation needs to follow the same rules.
And it sounds for me that CXL specification should define how CXL FM or
CXL device identify itself. Anyway, we need to ask CXL device and it =
should
return to us some ID. Probably, it will be some GUID or likewise number.

>=20
>>    - fm_cli discover cxl_devices - discover CXL devices
>>    - fm_cli discover logical_devices - discover logical devices
>=20
> Discover switches as well.
>=20

I assumed that CXL switch is a subclass of CXL devices. Do you mean that
it is independent case?

>>=20
>> FM - manage Fabric Manager
>> Subcommands:
>>    - fm_cli fm get_info - get FM status/info
>>    - fm_cli fm start - start FM instance
>>    - fm_cli fm restart - restart FM instance
>>    - fm_cli fm stop - stop FM instance
>>    - fm_cli fm get_config - get FM configuration
>>    - fm_cli fm set_config - set FM configuration
>=20
> I'd keep this slim for now.  No idea what FM config we might want to
> set so don't bother listing command yet.
>=20

Yeah, it=E2=80=99s not completely clear yet. But I assume we can =
consider such
configuration options like:
(1) register to receive event notifications
(2) logging of events
(3) errors handling

>>    - fm_cli fm get_events - get event records
> Not sure what FM would have in the way of events (as opposed to
> things it is talking to).
>=20

I think FM can log events. If we consider FM daemon on host, then it
could issue messages to end user as reaction to some events.

>>=20
>> Switch - manage CXL switch
>> Subcommands:
>>    - fm_cli switch get_info - get CXL switch info/status
>=20
> These all need an ID field of some type to identify which switch.
>=20

Yeah, it is exactly what we need for every command. We need to identify
an object for a request.

>>    - fm_cli switch get_config - get switch configuraiton
>>    - fm_cli switch set_config - set switch configuration

<skipped>

>>=20
>> DCD (Dynamic Capacity Device) - manage Dynamic Capacity Device
>> Subcommands:
>>    - fm_cli dcd get_info - Get DCD Info (retrieves the number of =
supported hosts,
>>         total Dynamic Capacity of the device, and supported region =
configurations)
>>    - fm_cli dcd get_capacity_config - Get Host Dynamic Capacity =
Region Configuration
>>         (retrieves the Dynamic Capacity configuration for a specified =
host)
>>    - fm_cli dcd set_capacity_config - Set Dynamic Capacity Region =
Configuration
>>         (sets the configuration of a DC Region)
>>    - fm_cli dcd get_extent_list - Get DCD Extent Lists (retrieves the =
Dynamic Capacity
>>         Extent List for a specified host)
>>    - fm_cli dcd add_capacity - Initiate Dynamic Capacity Add =
(initiates the addition of
>>         Dynamic Capacity to the specified region on a host)
>=20
> That one is complex ;) Probably needs a whole man page to itself.
>=20

Currently, it=E2=80=99s only declaration of command set. Yeah, =
implementation will be complex. :)

>>    - fm_cli dcd release_capacity - Initiate Dynamic Capacity Release =
(initiates the release of
>>         Dynamic Capacity from a host)
>>=20
>> FM daemon receives requests from configuration tool and executes =
commands by means of
>> interaction with kernel-space subsystems. The responsibility of FM =
daemon could be:
>>    - Execute configuration tool commands
>>    - Manage hot-add and hot-removal of devices
>=20
> In what sense?  I'd expect it to notify some higher level entity
> (orchestrator or similar) but not sure I see what management the
> FM would do. =20
>=20

I assume that if FM manages some metadata, then hot-add or hot-removal =
could
require some metadata corrections. Also, hot-add and hot-removal can =
generate some
events that FM can receive and process somehow. For example, it is =
possible to log
event messages into some journal.

>>    - Manage surprise removal of devices
>=20
> Likewise, beyond reporting I wouldn't expect the FM daemon to have any =
idea
> what to do in the way of managing this.  Scream loudly?
>=20

Maybe, it could require application(s) notification. Let=E2=80=99s =
imagine that application
uses some resources from removed device. Maybe, FM can manage =
kernel-space
metadata correction and helping to manage application requests to not =
existing
entities.

>>    - Receive and handle even notifications from the CXL switch
>>    - Logging events
>>    - Memory allocation and QoS Telemetry management
>>    - Error/Failure handling
>=20
> I'm not sure on separation of role between this component and
> higher level policy / admin driven software.
>=20
> For memory allocation it might take a 'give host A this much
> memory with this characteristic set' command and own the
> allocations across all present devices, or it might just
> act as an interface layer to higher level software that does
> the fine detail of figuring out which device to allocate memory
> from to satisfy such a request.
>=20
> Whilst I agree having a broad vision for an interface is good
> there are a lot of subtle details in some of these commands
> so I'd not spend too long refining the whole lot. Probably better
> to look at them one at a time and then just have whoever ends
> up maintaining / reviewing this thing responsible for making sure the
> parameter format etc is consistent across commands.
>=20

Yes, I agree. Let=E2=80=99s do it step by step. I believe we need to =
start from
implementation the application that process commands and do nothing
at first. And first command that needs to be implemented is a discovery
of CXL devices, switches, and FM instances because we need to identify
CXL object somehow for any other command.

Thanks,
Slava.

