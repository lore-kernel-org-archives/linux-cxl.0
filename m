Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563806;
	b=fxl1rU2wVminhIu373OtxDWeHS9Yj2rfGmVEWzGHpTrFh5L7PR9rcPlrlwduccCt4pXK
	 CP1FQou7Je/agzkNJE6vruDtAFYpLZqKsYy04M7/6kp7j2hXpp3+vBqMep6eUE5ff1ysz
	 Ktpde9xONy1m9mp9N957ef+9lHk/7jItBX4UfSiAJpJRx2KbhO3JokA6Y13M0LngeTXHG
	 m+9y0NIWa7haxhUA5l3pPiQClYxrEvajSG8Nejgx5zh5B1ieuMnr9d8XzJyNKaBRd9FKC
	 O55AGM1eGJ8T3SMnfEgSXRFKirBAbxbaYn+cv/0xQscym/OLYm1R+iJ3YublOt/JU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563806;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Resent-To:
	 Resent-From:Resent-Date:Resent-Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:Lines:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=qHNPbSyXJvJZt0TG2P3jFllZE/LiMl2regrSv48HBo0=;
	b=pnP7fDGTCNEcL9hIFkyAYgqY7D1wBb0rgmKWtVyPeXSyYDa8TaKZ8VBxk/7qwk9QKPN3
	 O8fejEkoRMa+TZpvhOMcrJFDait0qJTVTXBszo2NL5juDJPP0EJhKfy81bUXLBiTVEfE4
	 OoqzRXuSJN55FxCXkENSZyQs/yDyfGbl3WTkgpqD43InRlQg28acWsYTD3zZqFkMb45t6
	 6bqbZmAy53djiP7PhBfjbNJfL8oVIkAb0rMr2D4sbCfiGDyfdd/w8MKEenPLAZKf2XFPY
	 3gd8j2AQaBcbLmmZtTMaygu88ESYDadWbrvUn1Vv/01VexkT1cvyuxAuUJ+TratnN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CX6vUGrl;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884A606A324
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 20:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2884A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CX6vUGrl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793563805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=qHNPbSyXJvJZt0TG2P3jFllZE/LiMl2regrSv48HBo0=;
	b=CX6vUGrlA7vcWq8HFMbWdemg6/78vfZwykoz56WcyGXXZSjq3/dDuH69O/ga44Em3BnYI4
	ys0yKmLqZYfiDRUfAttIdQhRnFuIR1YcbQekHBqqGX6htwJzBBjn2YpjsGhjLIbaFkUNJx
	W4kaVZKMVYVQWAKLo9ygtt3EvZwKmkY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-urAbHKg2Pm61HrOGJHCLTg-1; Sun,
 01 Nov 2026 15:10:00 -0500
X-MC-Unique: urAbHKg2Pm61HrOGJHCLTg-1
X-Mimecast-MFC-AGG-ID: urAbHKg2Pm61HrOGJHCLTg_1793563796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AA941954AE2;
	Sun,  1 Nov 2026 20:09:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC5C30002CB;
	Sun,  1 Nov 2026 20:09:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 46A7D21E6A04; Sun, 01 Nov 2026 21:09:50 +0100 (CET)
Resent-To: 17746591750@163.com, alistair@alistair23.me, graf@amazon.com,
 FangSheng.Huang@amd.com, michael.roth@amd.com, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, palmer@dabbelt.com, rbolshakov@ddn.com,
 foss@defmacro.it, sebastian.huber@embedded-brains.de, fam@euphon.net,
 jiaxun.yang@flygoat.com, lizhijian@fujitsu.com, atar4qemu@gmail.com,
 edgar.iglesias@gmail.com, jasowangio@gmail.com, liwei1518@gmail.com,
 npiggin@gmail.com, zhangckid@gmail.com, titusr@google.com,
 wuhaotsh@google.com, arei.gonglei@huawei.com, berto@igalia.com,
 mark.cave-ayland@ilande.co.uk, junjie.cao@intel.com, pasic@linux.ibm.com,
 zhao1.liu@intel.com, rathc@linux.ibm.com, its@irrelevant.dk,
 stefanb@linux.vnet.ibm.com, clg@kaod.org, xen-devel@lists.xenproject.org,
 conor@kernel.org, luc@lmichel.fr, david@kernel.org,
 lixianglai@loongson.cn, maobibo@loongson.cn, pbarbuda@microsoft.com,
 yoshinori.sato@nifty.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 kfting@nuvoton.com, den@openvz.org, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 phil@philjordan.eu, tangtao1634@phytium.com.cn,
 chao.liu@processmission.com, jiri@resnulli.us, sam@rfc1149.net,
 anisa.su@samsung.com, alex@shazbot.org, farosas@suse.de,
 mohamed@unpredictable.fr, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 alistair.francis@wdc.com, anthony@xenproject.org, jic23@kernel.org,
 kbusch@kernel.org, mchehab+huawei@kernel.org, sstabellini@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, zhenwei.pi@linux.dev, adityag@linux.ibm.com,
 alifm@linux.ibm.com, amachhiw@linux.ibm.com, borntraeger@linux.ibm.com,
 brueckner@linux.ibm.com, farman@linux.ibm.com, harshpb@linux.ibm.com,
 iii@linux.ibm.com, jjherne@linux.ibm.com, milesg@linux.ibm.com,
 mjrosato@linux.ibm.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:09:50 +0100
Resent-Message-ID: <87qzh41fg1.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Kostiantyn Kostiuk <kkostiuk@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  David Hildenbrand <david@kernel.org>,  Igor Mammedov
 <imammedo@redhat.com>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
  Jason Wang <jasowangio@gmail.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto Garcia
 <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
  Zhao Liu <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,
  Junjie Cao <junjie.cao@intel.com>,  Anisa Su <anisa.su@samsung.com>,
  Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
  Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
  Matthew Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  qemu-block@nongnu.org,  linux-cxl@vger.kernel.org,
  qemu-s390x@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Sergio
 Lopez <slp@redhat.com>,  qemu-arm@nongnu.org,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
  Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
  qemu-riscv@nongnu.org,  Song Gao <17746591750@163.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Xianglai Li <lixianglai@loongson.cn>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
  Mohamed Mediouni <mohamed@unpredictable.fr>,  Nicholas Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Amit
 Machhiwal <amachhiw@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhang Chen
 <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Alistair
 Francis <alistair@alistair23.me>,  Alexander Graf <graf@amazon.com>,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Ani Sinha <anisinha@redhat.com>,  Luc Michel
 <luc@lmichel.fr>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Jamin
 Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Samuel
 Tardieu <sam@rfc1149.net>,  "Denis V. Lunev" <den@openvz.org>,  FangSheng
 Huang <FangSheng.Huang@amd.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao
 Wu <wuhaotsh@google.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Conor
 Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Halil Pasic <pasic@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  Peter Xu <peterx@redhat.com>,  Chinmay Rath
 <rathc@linux.ibm.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
  xen-devel@lists.xenproject.org,  Roman Bolshakov <rbolshakov@ddn.com>,
  Phil Dennis-Jordan <phil@philjordan.eu>,  Fam Zheng <fam@euphon.net>,
  Farhan Ali <alifm@linux.ibm.com>,  Alex Williamson <alex@shazbot.org>,
  Tao Tang <tangtao1634@phytium.com.cn>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Yoshinori Sato <yoshinori.sato@nifty.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Auger <eric.auger@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
In-Reply-To: <auNiLX-dsm8XsFG-@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
	"Thu, 29 Oct 2026 15:11:41 +0000")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
	<atsxLV5YZo8dr-8G@redhat.com>
	<CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
	<87zevz5h4k.fsf@pond.sub.org> <auC-ilqUJq27neSR@redhat.com>
	<87o6ce47rr.fsf@pond.sub.org> <auNiLX-dsm8XsFG-@redhat.com>
Date: Fri, 30 Oct 2026 10:21:05 +0100
Message-ID: <87o6cba6im.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: u3Dhh9GBQWShXTTQs9KPFPauWCUVyXfl4IRl5ia2E8g_1793563796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 28, 2026 at 08:13:44AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Oct 27, 2026 at 03:54:03PM +0100, Markus Armbruster wrote:
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> >>=20
>> >> > Hi
>> >> >
>> >> > On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <be=
rrange@redhat.com> wrote:
>> >> >>
>> >> >> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-Andr=C3=A9 Lureau w=
rote:
>> >> >> > PciDevfn is a bit special, since it accepts integer and string a=
s
>> >> >> > setter, but only output integer as getter.
>> >
>> > snip
>> >
>> >> >                                                       But I agree w=
e
>> >> > could do better.
>> >> >
>> >> > There are multiple options. We could keep declaring the property as
>> >> > str instead. In this case, the getter should probably return a stri=
ng
>> >> > for consistency and correctness. This might surprise some existing
>> >> > users though.
>> >>=20
>> >> I.e. ditch numeric suppport for numeric addresses, right?
>> >>=20
>> >> Incompatible change.  Do we care?
>> >>=20
>> >> If we don't, we should be honest about it and mark qom-get unstable.
>> >>=20
>> >> > We could introduce new properties like `devfn-str` and `devfn-int`
>> >> > that alias the same value.
>> >>=20
>> >> Compatibility break.  If breaking compatibility is okay, I'd rather u=
se
>> >> the opportunity to get rid of cleverness, and go with your first opti=
on.
>> >>=20
>> >> > We could also introduce a new structured QAPI type.
>> >>=20
>> >> What kind of type do you have in mind?
>> >
>> > IMHO the root cause design flaw here was to overload 'addr' as a
>> > way to set both the slot number and function number, as using
>> > one property for two pieces of data is a well known anti-pattern
>> > we caution against.
>> >
>> > IOW, we should have had 'slot' and 'function' as separate properties
>> > from the start.
>>=20
>> Fair.
>>=20
>> Our modeling of PCI is old and weird.
>>=20
>> What we call "pci-device" isn't a device, it's a function, where
>> function 0 sort of stands in for the device.
>
> Mmm, yes, interesting way of looking at it.
>
>> Its "addr" isn't a PCI address, it's the address of the function on its
>> PCI bus, i.e. the tail of a PCI address.
>>=20
>> > From a CLI POV, we could easily change 'addr' to mean only the slot
>> > number, since it is always parsed in string format without the
>> > magic (slot << 4) | function encoding. Then add a 'function' prop
>>=20
>> In CLI, HMP and QMP string (not integer), value "5" is shorthand for
>> "5.0", and means device 5, function 0.
>>=20
>> We could deprecate the .FN part in favor of a new property "function".
>>=20
>> Once we drop support for .FN from "addr", its name becomes even more
>> misleading than it always was.
>
> Yes.
>
>> > The challenge is the impact on QMP with strict typing, as ideally
>> > int format would soley represent the slot number, but today the
>> > int format is encoded (slot << 4) | function.  So anyone relying
>> > on int format in QMP would silently have a semantic change if we
>> > altered what 'addr' means.=20
>>=20
>> That's a no-go.
>>=20
>> > Deprecating 'addr' entirely and adding brand new 'slot' and
>> > 'function' properties would be a significant disruption to
>> > a syntax which has been documented for years (decades).
>>=20
>> What about this:
>>=20
>> * No change to PCIDevice member @devfn: encodes slot and function as an
>>   integer.
>>=20
>> * New "pci-device" properties "slot" and "function".  "slot" sets just
>>   the slot bits of @devfn, and "function" sets just the function bits.
>>   Both default to zero, so specifying just "slot" gives you
>>   PCI_DEVFN(slot, 0), which makes sense.
>>=20
>> * Deprecate "pci-device" property "addr" for QMP.  We can keep it around
>>   for longer than the required grace period if that helps.
>>=20
>> * Declare it legacy for CLI and HMP, with no intent to remove it.
>
> We can't easily keep it in CLI/HMP, while removing from QMP can we ?
> As long as the property exists on the PCIDevice object, it will be
> accessible everywhere.

You're right.  The way device_add / -device work, providing "addr" just
for CLI and HMP would require gross hacks.

> Perhaps keep it relatively simple and merely deprecate the string
> syntax of 'addr' in QMP. That's the place where it is really ugy.
> Force QMP over to only the integer syntax for 'addr', and leave
> CLI/HMP accepting the (optionally dotted) string syntax.
>
> Mgmt apps like libvirt will have to adapt. Tedious, but actually
> quite simple compared to most deprecations, as the integer syntax
> can already be used with all historical QEMU versions in QMP that
> mgmt apps ever need to deal with. They can unconditionally change
> their code to int syntax and not worry about old/new QEMUs at all.

Yes, but if management applications have to adapt anyway, why not use
the opportunity to adapt to the interface we actually want, i.e. "slot"
and "function"?

If we add "slot" and "function", then what to do about "addr"?  Options:

1. Do nothing.  We provide two interfaces for setting slot / function,
and no guidance on which to use.

2. We declare "addr" legacy, and recommend "slot" and "function".  This
tells users that using it is fine, but there's a better way.

3. We deprecate "addr" in favor of "slot and "function" without intent
to remove it.  Yes, we normally deprecate with intent to remove, but we
don't have to.

4. We deprecate "addr" with intent to remove it.  Grace period
debatable.  You argued against such a "significant disruption to a
syntax which has been documented for years (decades)."  I'm listing it
for completeness.

