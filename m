Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E784C48BE8
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 02:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F057D61357
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 02:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFLC3D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 22:29:03 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:33342 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLC3D (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 22:29:03 -0400
Received: by mail-pg1-f175.google.com with SMTP id e20so3937759pgg.0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mX/Yzhrg2KE+SG7BlPe+0Rps/0Yu0dOpOjGCHfI6UWE=;
        b=YORn5chXfMoNTYOmBlcj9Qkz66GzgYzVK6CUh/dNY4jk+FgCGqOJ8p2C2OBjeSLydT
         8Zbea2vtEwR0iD/cWK9QsbkkhCUH0NJv7j9DyHcywrYqdNtQgHKYhm79nJTTBo4CbRQy
         fAy46Yo1fUoufCjf7+3zBmgCJVFEnYu6YMpDBeDQoIQWQ08mdULdD2sQvO9gKJoN5dMH
         +Nfkw5cwz/UtwLl47X6a/vruSBPTzbUta6l4d7nC3rt7EsLMGTA5hW2zzBLDmUdP7XxU
         oT3IAqI5YuH/jL//8g8rWiXfrsG2G6yN2BpcR2ksGk30p9E/LRZxNNwEQwl92dXhc6fK
         5Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mX/Yzhrg2KE+SG7BlPe+0Rps/0Yu0dOpOjGCHfI6UWE=;
        b=Ahi3WbswPKoZovihMCsbAhf4Cb+fm5DSPSdqVujdHZi/FEkdCOnHfHIVtjbSeZaNFS
         t+p8s0tz6ZgzsNo1jY1f2rYr+DcSqzxdxrdEyIWkTG5VHoVJjv5ZpMRjgPGU0DnzK0DV
         veh3dmv/pRG09BkgDYQrpgGtIflvJ/7sPqP/U8r1gzOpdtzC7UD9vl0puji7TDqG/Ns8
         MPqKnoMkwV1FjteglyL/+o63u1CtZfU88pInZGoqvNjwfuX2jlzyfhHA1vJjUH5b/U23
         PRKYwAKHj1A8mt7NvQPIVig0+7YVDi6yfsW+wCM1W8+wJUkJAaSsVfcPW54OB3fpNofG
         0fLA==
X-Gm-Message-State: AOAM533G779XQE13+lD/BzDth/X3f3vBrB2OxJc2vvBFlQIEj1ax9Qtw
        3MMCpMDoZLP6CasJrB5DU3ABvvPelpKpMYCnqa73QQ==
X-Google-Smtp-Source: ABdhPJz5eMS+lGBvMbBVc1WdI+KIp/GsqOHTDFOxw/AlJmXGXufLLMIYRYy54ZyRwl2JJ5un+UHi1zcPPBCk/H9NXIw=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr6549714pgm.279.1623464764443;
 Fri, 11 Jun 2021 19:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR11MB36459D88FEB3BB66E5844DE7882B9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <YKYxmpzIHdc3yI5X@infradead.org> <MN2PR11MB3645E75023DC9C3478194CFF882A9@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB3645E75023DC9C3478194CFF882A9@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 19:25:53 -0700
Message-ID: <CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com>
Subject: Re: CXL Vendor Specific Capabilities
To:     Ariel.Sibley@microchip.com
Cc:     linux-cxl@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ahmad.Danesh@microchip.com, Chris Petersen <cpetersen@fb.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Vincent.Hache@microchip.com, Sanjay.Goyal@microchip.com,
        Scott Lee <scolee@microsoft.com>, jhinkle@lenovo.com,
        guru.anbalagane@microsoft.com, kevin.marks@dell.com,
        bhirano@micron.com, Chet R Douglas <chet.r.douglas@intel.com>,
        dcaracci@micron.com, "John Groves (jgroves)" <jgroves@micron.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Vineeth.Pillai@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Ariel, thanks for being patient as I worked my way back to this question=
.

Responses below are with my Linux kernel developer hat on, but they
are my own. I.e. Linux distribution representatives might have
concurring [1], or differing opinions. Other kernel developers may
have different or concurring opinions. It is after all a consensus
based community.

[1]: http://lore.kernel.org/r/YBi9nkiu3DvMZhrs@Konrads-MacBook-Pro.local

On Thu, May 20, 2021 at 4:55 AM <Ariel.Sibley@microchip.com> wrote:
>
> Re-posting with 80 char line wrap.
>
> Background:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The default/recommended value of the CONFIG_CXL_MEM_RAW_COMMANDS Kconfig =
knob
> will block passthrough of vendor defined mailbox commands.  If this Kconf=
ig
> knob is enabled, passthrough of vendor defined commands will still taint =
the
> kernel.

Right, it's similar to the warning message that spews at the beginning
of time when trace_printk() is found to be in active use. It's an
indication that you are using a debug / special purpose kernel that is
allowing access to unvetted vendor specific functionality.

> There is a consensus among device and system manufacturers that vendor-sp=
ecific
> capabilities are a necessary component of specifications and we need a so=
lution
> to support these capabilities. Within reason, these capabilities need to =
be
> enabled without tainting the kernel.
>
> Key points to consider regarding handling of vendor-specific capabilities=
:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> * Tainting the kernel during harmless operations is not desirable. While =
some
> users have full control over the kernel and could patch this behavior, th=
ose
> users would prefer to use upstreamed kernel vs. carrying patches.

The dev_WARN_ONCE() was the easiest way to record the presence of
non-standard CXL operation in crash logs for reports sent to the
'linux-cxl' mailing list for help. That can be replaced with a simple
dev_warn_once() (lowercase version does not taint), but adds the
expectation to receive the full kernel log since boot for reported
problems with the driver stack.

> * There is agreement that some capabilities are candidates for standardiz=
ation,
> but a path for enabling that class of functionality until it makes its wa=
y into
> the spec is needed.  It takes a long time to get anything through the ful=
l
> process of acceptance into the spec and upstreamed. This will slow adopti=
on and
> stifle innovation.

One of the useful mechanisms that has sped up Linux and Tianocore
adoption of new EFI/ACPI features is the "Code First" process of the
UEFI and ACPI Standards Working Groups. In general, if the feature is
a candidate to be adopted in the standard and the time to publish
impacts the feature release in Linux that seems like a problem with
solving in its own right, even if it is not exactly "Code First".

> * The reality is that we can=E2=80=99t put everything into the spec. The =
primary
> cases are vendor-specific implementations which are not suited for
> standardization, and proprietary/differentiating features.
>

The common generic driver is not the place to land proprietary
differentiating features. The generic driver has a responsibility to
assert its best effort interpretation of what capabilities may impact
the confidentiality and integrity of the kernel. For example see "enum
lockdown_reason" [2] for the types of interfaces that the kernel shuts
down to protect the platform against root. This concept of not
trusting root is relatively new compared to past drivers that did not
give a second thought to allowing unfettered vendor passthrough
tunnels. Vendor defined functionality is unauditable so it requires an
opt-in.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/linux/security.h#n82

> * Limiting the usefulness of the path for vendor capabilities through the
> driver will likely result in undesirable side-effects as suppliers and ot=
hers
> won=E2=80=99t accept this, forcing vendors to develop workarounds that by=
pass the
> driver. If the driver provides a usable pathway that does not taint the k=
ernel,
> vendors are less likely to implement such approaches. The driver will the=
n be
> able to perform some policing, for instance based on CEL contents, and CX=
L
> device providers can be considered good citizens of the Linux community.

Unfortunately the driver can not trust the Command Effect Log. The
authors of the CEL are not OS practitioners. One example is the topic
of runtime firmware update. This document [3], for example, defines a
runtime firmware update interface with a command effect log that
indicates when the OS is responsible for quiescing I/O. The firmware
activation claims no quiesce needed in cases where the activation time
is "small". Rather than trust the vendor's definition of "small" and
the CEL claims of what is safe the driver ignores CEL and sets its own
policy.

[3]: https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf

>
> Recommendation:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Allow root to issue vendor defined passthrough commands by default and us=
e the
> CEL to determine whether a given command should taint the kernel.  Comman=
ds
> that have no effects, or harmless effects, should not taint the kernel.
> Commands that have potentially harmful effects should taint the kernel.
>
> Examples:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Case 1: Vendor defined is needed, and the operations do not impact the no=
rmal
> operation of the device. The CEL contents could be used to determine ther=
e is
> no impact and thereby permit these commands without tainting the kernel.
>
> * Example 1.1: Interfacing with common diagnostic features which may have
> wide-ranging implementations and capabilities across different vendors. E=
.g.
> Signal integrity diagnostics, debug counters.

Signal integrity and debug counters seem to be in the realm of pre
production environments where a debug kernel is expected.

>
> * Example 1.2: Retrieve diagnostics data from proprietary value-add featu=
res.

The Vendor Debug Log is an example of allowing for vendor defined
payload to travel within open transports. It's easier to say, yes it's
likely safe to allow opaque blobs to be dumped to the kernel vs an
open transport.

>
> Case 2: Vendor defined is needed, but the operations impact the normal
> operation of the device. CEL contents can be used to determine the impact=
 and
> taint the kernel.
>
> * Example 2.1: Vendor-specific diagnostics features that are intended to =
stress
> the device or memory for qualification and validation purposes.

Qualification and validation seem to be places where the special
kernel build requirement can be satisfied.

>
> Q & A:
> =3D=3D=3D=3D=3D=3D
>
> Q: Why is it a problem to have CONFIG_CXL_MEM_RAW_COMMANDS disabled by de=
fault?
> A: This pushes the problem to the distros. Distros are likely to follow t=
he
> Kconfig recommendation by default, so industry will need to have this
> discussion with each major distro maintainer.

Have a look at something like this directory:

https://kojipkgs.fedoraproject.org/packages/kernel/5.13.0/0.rc5.38.eln111/x=
86_64/

...and notice that kernel-debug is built by default. I expect it would
be relatively straightforward to ask distros to turn on
CONFIG_CXL_MEM_RAW_COMMANDS in their equivalent of the kernel-debug
package:

https://kojipkgs.fedoraproject.org/packages/kernel/5.13.0/0.rc5.38.eln111/x=
86_64/kernel-debug-5.13.0-0.rc5.38.eln111.x86_64.rpm

> If we can reach a consensus in
> this forum that we can default this knob to enabled, distros are more lik=
ely to
> also enable the functionality.

This seems to misunderstand how the trust relationship flows in the
Linux community. The distros are co-equal members of the Linux
community and they also depend on subject matter experts to vet the
functionality that they enable. Like you saw in the example from
Konrad above there is already discomfort in the community at even
allowing CONFIG_CXL_MEM_RAW_COMMANDS to be enabled at all. So, I am
advocating for a compromise position that allows for vendor defined
functionality, while also constraining its deployment to what the
linux-cxl community can review and develop native kernel interfaces.

>
> Q: Why is it a problem to taint the kernel for all passthrough commands w=
hen
> CONFIG_CXL_MEM_RAW_COMMANDS is enabled?
> A: Some functionality is harmless. If the kernel is tainted when executin=
g
> basic read-only diagnostics, it may be harder to get support for real iss=
ues as
> the state of the system will be suspect. The driver should be able to use=
 the
> CEL to determine when to taint.

If a problem comes to the list with vendor specific functionality in
the log the linux-cxl community is unlikely to engage.

>
> Q: Why can't we use Vendor Log for this?
> A: Several reasons:
> * There is no ability to control functionality. Many diagnostic features
> require input to configure what is being read.
> * The device may require time to collect the diagnostic information, but =
must
> respond to Get Log in under 2 seconds (preferably much faster).
> * It is a single blob, which can be accessed at arbitrary offsets. The li=
mited
> set of use cases that could be covered by this model would require driver
> changes to enable the Vendor Log to be dumped with finer granularity. But=
 even
> then, the fact that the host could potentially read anywhere in the Vendo=
r Log
> at any time makes robustly encoding a set of debug forensics that are pop=
ulated
> on demand (in response to Get Log) from underlying hardware into vendor d=
efined
> offsets in the Vendor Log difficult.
>
> Q: What about security?
> A: While vendor commands have the potential to be a security risk, it sho=
uld
> not be the driver=E2=80=99s responsibility to solve that problem. The in-=
band path
> through the driver is just one path into the device. For a device to be s=
ecure,
> vendors and their partner customers need to lock out anything that is a
> security risk at the device level for production. Given that this device =
level
> lockout is necessary, the catch all lockout at the driver level is redund=
ant
> from a device security point of view.
>

In an environment where kernel functionality is being audited against
an untrusted root the driver must not abdicate responsibility for the
portions of security it can control, but there's a maintainability
aspect as well. Open collaboration yields benefits for maintainability
and deployability of system software.

> Q: How about we add commands to UAPI instead?
> A: Vendors should not be adding hooks into a class driver which is suppos=
ed to
> be generic. The details of anything that goes in UAPI would need to be fu=
lly
> public. Any proposed additions would need to be fully explained as to why=
 they
> are not able to be added to the spec. This limits the viability of UAPI a=
s a
> method for unlocking value-add functionality.

I'm not sure I understand the premise of this question?

I will say that I am fully in favor of innovations that solve problems
for CXL Linux users, but it needs to be done in a way that does not
compromise maintainability (unrestricted vendor differentiation) or
security (confidentiality, integrity, or stability).

> Conclusion:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I look forward to a healthy discussion on how we can move this forward, a=
nd
> hope that we can reach an answer that is acceptable for the kernel mainta=
iners,
> CXL device vendors, and end users.

Ariel, thank you for putting this together.
