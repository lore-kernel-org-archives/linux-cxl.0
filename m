Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286741;
	b=HanE3/U+f5m04T4gBAi1J6An0gDYVJqBqvDxsyAJOXFJ0/7UuPDH1em8wdUdd1VfgzLw
	 1n+oLmyruE2lJo0cJfWzIUz6oGJV1fdx1+rLBj1E09ii2xfMYSXjC0KGGSeiEkKrD4wHM
	 7hVzwkf3sM7mFXnGKkRpVxws9ogP7Lp9/bWXYerMA9ZRdf8gjyNFCtqmPYSGB629Hbarc
	 2l1btKuxIeqthmbqkQ4uXsKMYwDeAOH3plI/KAdJcJiSoCDFUc0s51+dmBmaDDda9n0nI
	 m6H0H5ddgkTihocaKDby2JWcfQlJ/JAO/eh82ubM9+J0lZFLEJ97TL3yd8AtPEn2FwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286741;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:In-Reply-To:User-Agent:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=sy6RcJq7kWnzNPatcCz5vMju7T26X8KtMwEXCbitl90=;
	b=zWCR6KkYnX66UG3/L3UsimqKNmJsOxZZQg2b7C09rJ9XR7XL5Xmt7REFnF9XECjjQLR1
	 oPhmhsG7bfCFYz4rAjTILGE8lBX71Zedv/7NWPm47QlB+JF7nzK1Hk/3De6tX/GIJzfhC
	 xdbTs89xHeHOTAkmjX3fI16rMvzQ9S9rAd+/wOw0EVn7s47aT6XZxAovC9Pri7RTBX+5k
	 x2XsXEcJJwGiMwX1T40npvSRGxDcBUcPASAqJkT2Bp9xTQkLV40NBzbA+JLi6bMA0Dkg4
	 zFQi7HfHhwOsQOgaN1Ur/Ygsf4gFLTnBFh/tJkUMtyf06QWcAgunpwoaG/4pjC+spWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xm56vkH9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942D606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 15:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A942D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xm56vkH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793286739;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sy6RcJq7kWnzNPatcCz5vMju7T26X8KtMwEXCbitl90=;
	b=Xm56vkH9ATMJMygfPZSg+6GK3F6dQs7YPsYUO98Xep2m+NG+NICizkX3sSRQ6aFxum1tFS
	2r5qzweZVvntR9s1vJ+llUI80AT507RpAf8Wam+f6LXJQP6VwleF7JeNpCHZ3Pdfknrstd
	mi7fwEqZHv79SYuWjlc8dXp0RGQs8wo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-lR4E_uxDPxGRis0Bj7u-cg-1; Thu,
 29 Oct 2026 11:12:15 -0400
X-MC-Unique: lR4E_uxDPxGRis0Bj7u-cg-1
X-Mimecast-MFC-AGG-ID: lR4E_uxDPxGRis0Bj7u-cg_1793286731
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CA951956043;
	Thu, 29 Oct 2026 15:12:09 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11F131955F08;
	Thu, 29 Oct 2026 15:11:43 +0000 (UTC)
Date: Thu, 29 Oct 2026 15:11:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
	John Snow <jsnow@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kostiantyn Kostiuk <kkostiuk@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>,
	Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	Jagannathan Raman <jag.raman@oracle.com>,
	John Levon <john.levon@nutanix.com>,
	Thanos Makatos <thanos.makatos@nutanix.com>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
	linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sergio Lopez <slp@redhat.com>, qemu-arm@nongnu.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
	Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
	Zhang Chen <zhangckid@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Alistair Francis <alistair@alistair23.me>,
	Alexander Graf <graf@amazon.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>,
	Luc Michel <luc@lmichel.fr>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>,
	FangSheng Huang <FangSheng.Huang@amd.com>,
	Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
	Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
	Jesper Devantier <foss@defmacro.it>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>, Conor Dooley <conor@kernel.org>,
	Sebastian Huber <sebastian.huber@embedded-brains.de>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Titus Rwantare <titusr@google.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	xen-devel@lists.xenproject.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>,
	Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Tao Tang <tangtao1634@phytium.com.cn>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
Message-ID: <auNiLX-dsm8XsFG-@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
 <atsxLV5YZo8dr-8G@redhat.com>
 <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
 <87zevz5h4k.fsf@pond.sub.org>
 <auC-ilqUJq27neSR@redhat.com>
 <87o6ce47rr.fsf@pond.sub.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <87o6ce47rr.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: X6T666IozjUiXGV9Z-ZT56n7d3wxvq9dAZn0yyGTM_4_1793286731
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 28, 2026 at 08:13:44AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Oct 27, 2026 at 03:54:03PM +0100, Markus Armbruster wrote:
> >> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> >> 
> >> > Hi
> >> >
> >> > On Fri, Oct 23, 2026 at 2:04 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> >>
> >> >> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-André Lureau wrote:
> >> >> > PciDevfn is a bit special, since it accepts integer and string as
> >> >> > setter, but only output integer as getter.
> >
> > snip
> >
> >> >                                                       But I agree we
> >> > could do better.
> >> >
> >> > There are multiple options. We could keep declaring the property as
> >> > str instead. In this case, the getter should probably return a string
> >> > for consistency and correctness. This might surprise some existing
> >> > users though.
> >> 
> >> I.e. ditch numeric suppport for numeric addresses, right?
> >> 
> >> Incompatible change.  Do we care?
> >> 
> >> If we don't, we should be honest about it and mark qom-get unstable.
> >> 
> >> > We could introduce new properties like `devfn-str` and `devfn-int`
> >> > that alias the same value.
> >> 
> >> Compatibility break.  If breaking compatibility is okay, I'd rather use
> >> the opportunity to get rid of cleverness, and go with your first option.
> >> 
> >> > We could also introduce a new structured QAPI type.
> >> 
> >> What kind of type do you have in mind?
> >
> > IMHO the root cause design flaw here was to overload 'addr' as a
> > way to set both the slot number and function number, as using
> > one property for two pieces of data is a well known anti-pattern
> > we caution against.
> >
> > IOW, we should have had 'slot' and 'function' as separate properties
> > from the start.
> 
> Fair.
> 
> Our modeling of PCI is old and weird.
> 
> What we call "pci-device" isn't a device, it's a function, where
> function 0 sort of stands in for the device.

Mmm, yes, interesting way of looking at it.

> Its "addr" isn't a PCI address, it's the address of the function on its
> PCI bus, i.e. the tail of a PCI address.
> 
> > From a CLI POV, we could easily change 'addr' to mean only the slot
> > number, since it is always parsed in string format without the
> > magic (slot << 4) | function encoding. Then add a 'function' prop
> 
> In CLI, HMP and QMP string (not integer), value "5" is shorthand for
> "5.0", and means device 5, function 0.
> 
> We could deprecate the .FN part in favor of a new property "function".
> 
> Once we drop support for .FN from "addr", its name becomes even more
> misleading than it always was.

Yes.

> > The challenge is the impact on QMP with strict typing, as ideally
> > int format would soley represent the slot number, but today the
> > int format is encoded (slot << 4) | function.  So anyone relying
> > on int format in QMP would silently have a semantic change if we
> > altered what 'addr' means. 
> 
> That's a no-go.
> 
> > Deprecating 'addr' entirely and adding brand new 'slot' and
> > 'function' properties would be a significant disruption to
> > a syntax which has been documented for years (decades).
> 
> What about this:
> 
> * No change to PCIDevice member @devfn: encodes slot and function as an
>   integer.
> 
> * New "pci-device" properties "slot" and "function".  "slot" sets just
>   the slot bits of @devfn, and "function" sets just the function bits.
>   Both default to zero, so specifying just "slot" gives you
>   PCI_DEVFN(slot, 0), which makes sense.
> 
> * Deprecate "pci-device" property "addr" for QMP.  We can keep it around
>   for longer than the required grace period if that helps.
> 
> * Declare it legacy for CLI and HMP, with no intent to remove it.

We can't easily keep it in CLI/HMP, while removing from QMP can we ?
As long as the property exists on the PCIDevice object, it will be
accessible everywhere.


Perhaps keep it relatively simple and merely deprecate the string
syntax of 'addr' in QMP. That's the place where it is really ugy.
Force QMP over to only the integer syntax for 'addr', and leave
CLI/HMP accepting the (optionally dotted) string syntax.

Mgmt apps like libvirt will have to adapt. Tedious, but actually
quite simple compared to most deprecations, as the integer syntax
can already be used with all historical QEMU versions in QMP that
mgmt apps ever need to deal with. They can unconditionally change
their code to int syntax and not worry about old/new QEMUs at all.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

