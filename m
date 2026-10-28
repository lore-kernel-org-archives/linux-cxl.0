Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171648;
	b=Kgz1WkLEqm3c3hsQ308UBP/ubkr/tDYicKrkSImk4DqhJrAVCba5+YRk9IgQizhSkw6h
	 BMDKalUhQRsmDX9w0Sv6UDNkPozJRfOWpRoZfH/i4we5DrhfnXaE9ySD3WRc78EG1DFHn
	 AXWca8c758H4czJXx8C0/PF6MfzjOkAmF8xkTpZwqLHyOvfap0O4Fow1EO4NRSLUh56YM
	 1eYJx5gDBoPLKVGY5s6GKf1uP7IRvj8fyKyu8z0p4vKWW5zekXl16h//3Dy6MDYFKYune
	 8fliGd7KbT8l4H7VCS3t2TN2nDk80MRzbFcGYbrQfTgEDGwHxRnt6sVXwsOejAH5T9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171648;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=QxmQ5AxN89rC1HiyefFy0FHMMxtlG6Y/Map2WM9XKmw=;
	b=QH60F88HZW6wr/Teredq2v/bXgCofswjvOtiytXdu1o6PfkVemUmPYygiCVgVHlRLlar
	 o0cbr8WYH6MXzx8lOPTP5HWohoohN8XgFOTDPMazj1thDjxPy86aq7uSqkLTYl+c5aCoF
	 +idS9o+Du2HWUO3wM6tfpcczPU89xLDCk6e47Jiw3Y/fOsRV6eiT4EXaK3q409IsQyreK
	 hYNVTL15IgRgcm3mo+t1SbgsITQmBygzCV/q7SEKyfB7Ttw6taUqyb4TyhmQT+CGBmukT
	 SODdTglQlY2DRjtgWR0qplx72lHAnmwkpGVBYBAWCXizooHTOPhkbOmEcNnZFB3WNYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dy8k/xJU";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20B606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 07:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC20B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dy8k/xJU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793171647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxmQ5AxN89rC1HiyefFy0FHMMxtlG6Y/Map2WM9XKmw=;
	b=dy8k/xJURz95XdTtf8rce6fX9LFB5m+PWYMIKP1suV0MG1Jxtru77BYZrIXMQPISIfZyg/
	OPNG1CF9ojLCpFlM/qeGEws8XR6T7k74Y8COW3T7SUtHuBNrXd8P69YVBmtCuQT8sn8JcW
	2Z7WChPnEqfmauwZAxlyOiLzbdOx+QE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-aPtTQLUAOnmRkcQac9q43w-1; Wed,
 28 Oct 2026 03:14:01 -0400
X-MC-Unique: aPtTQLUAOnmRkcQac9q43w-1
X-Mimecast-MFC-AGG-ID: aPtTQLUAOnmRkcQac9q43w_1793171635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EEAC1955EA3;
	Wed, 28 Oct 2026 07:13:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11B5A1800257;
	Wed, 28 Oct 2026 07:13:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8C76D21E6A04; Wed, 28 Oct 2026 08:13:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
  qemu-devel@nongnu.org,
  Michael Roth <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>,
  Peter Maydell <peter.maydell@linaro.org>,  Mauro Carvalho Chehab
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
In-Reply-To: <auC-ilqUJq27neSR@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
	"Tue, 27 Oct 2026 15:08:58 +0000")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
	<atsxLV5YZo8dr-8G@redhat.com>
	<CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
	<87zevz5h4k.fsf@pond.sub.org> <auC-ilqUJq27neSR@redhat.com>
Date: Wed, 28 Oct 2026 08:13:44 +0100
Message-ID: <87o6ce47rr.fsf@pond.sub.org>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: WMuEpMqQ7HqdMp7jDT0Hb4KgIUs9bX9qWUqZ-dfRQXI_1793171635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 27, 2026 at 03:54:03PM +0100, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > Hi
>> >
>> > On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
>> >>
>> >> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
>> >> > PciDevfn is a bit special, since it accepts integer and string as
>> >> > setter, but only output integer as getter.
>
> snip
>
>> >                                                       But I agree we
>> > could do better.
>> >
>> > There are multiple options. We could keep declaring the property as
>> > str instead. In this case, the getter should probably return a string
>> > for consistency and correctness. This might surprise some existing
>> > users though.
>>=20
>> I.e. ditch numeric suppport for numeric addresses, right?
>>=20
>> Incompatible change.  Do we care?
>>=20
>> If we don't, we should be honest about it and mark qom-get unstable.
>>=20
>> > We could introduce new properties like `devfn-str` and `devfn-int`
>> > that alias the same value.
>>=20
>> Compatibility break.  If breaking compatibility is okay, I'd rather use
>> the opportunity to get rid of cleverness, and go with your first option.
>>=20
>> > We could also introduce a new structured QAPI type.
>>=20
>> What kind of type do you have in mind?
>
> IMHO the root cause design flaw here was to overload 'addr' as a
> way to set both the slot number and function number, as using
> one property for two pieces of data is a well known anti-pattern
> we caution against.
>
> IOW, we should have had 'slot' and 'function' as separate properties
> from the start.

Fair.

Our modeling of PCI is old and weird.

What we call "pci-device" isn't a device, it's a function, where
function 0 sort of stands in for the device.

Its "addr" isn't a PCI address, it's the address of the function on its
PCI bus, i.e. the tail of a PCI address.

> From a CLI POV, we could easily change 'addr' to mean only the slot
> number, since it is always parsed in string format without the
> magic (slot << 4) | function encoding. Then add a 'function' prop

In CLI, HMP and QMP string (not integer), value "5" is shorthand for
"5.0", and means device 5, function 0.

We could deprecate the .FN part in favor of a new property "function".

Once we drop support for .FN from "addr", its name becomes even more
misleading than it always was.

> The challenge is the impact on QMP with strict typing, as ideally
> int format would soley represent the slot number, but today the
> int format is encoded (slot << 4) | function.  So anyone relying
> on int format in QMP would silently have a semantic change if we
> altered what 'addr' means.=20

That's a no-go.

> Deprecating 'addr' entirely and adding brand new 'slot' and
> 'function' properties would be a significant disruption to
> a syntax which has been documented for years (decades).

What about this:

* No change to PCIDevice member @devfn: encodes slot and function as an
  integer.

* New "pci-device" properties "slot" and "function".  "slot" sets just
  the slot bits of @devfn, and "function" sets just the function bits.
  Both default to zero, so specifying just "slot" gives you
  PCI_DEVFN(slot, 0), which makes sense.

* Deprecate "pci-device" property "addr" for QMP.  We can keep it around
  for longer than the required grace period if that helps.

* Declare it legacy for CLI and HMP, with no intent to remove it.

