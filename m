Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563921;
	b=ZacX6153FLGQuUQTtXQ2DPG3ohsftQsfeSmtWLk28EkKxZVJdRD3j7hqWmW4A8LandD9
	 /lewSQ6ikwadd9S1nElNAwhNq7scVP/4pbGae6FSiLI49zQA0Wh6eM8OX4mnKfosaJGOE
	 vTRLQNZuh7DNniXBZ5assP70i2LBGSJNW1NctcXLIqSvIv3auk9Ol7eVTNxmhovnK9wfn
	 XBcMnrgI70SxeXZBlXV/cBRlH3atqZrz0H5IgaSAUlkzn7R5cbVssfFIqivRgnaECe1Xx
	 g+MVk0B1YxitXcuDCbxJ9oj8xAnHM23D7g+xxXc+Kvd9tec0qjzZmbGr04vg+pUM9HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563921;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Resent-To:
	 Resent-From:Resent-Date:Resent-Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:Lines:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=pn06HY/bU7f4uyfbIipnbJnjf3nU/iS9+J50VskAMwg=;
	b=R3+lDea+z+OdcQJrvlqnbPAsIxmTFQrwEDXItSFxxMOImS4QkySN05/Dg2SU80HUoUhO
	 R+1rJ5mjWOcZqMw4BrNM877mGDW0mby+rfXcidEntVSkoHlFydb+E5svvQwI8c4FGnrT1
	 wt1RQX5D7DMa6RFsqWrZ8elG96z7kxJWezbSF33x1+1t9peDs9x3AIAa9lmyz5HVYuyuw
	 P5flhlHUmNHu5TvY9KF915IaF0I//KR2Rvtxyi9Aannh+qaLJC+Gkyd2f6cOAOWPkQLcR
	 UqfHQC+lmywN4uxlanlZXKzc7uotwyo0vyGchRkiWyGueNAa6usIi/uTOelXGa60OrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCi6JIG7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA18606A324
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 20:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA18606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCi6JIG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793563920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=pn06HY/bU7f4uyfbIipnbJnjf3nU/iS9+J50VskAMwg=;
	b=cCi6JIG7mFfFWJGtR0cRHE6gkHJh3M1raKKSanYFk58SQPBm8R/+P05wpJQ4aUirrvWMqj
	zqnyHDOHbLca0FIPo6OJHWbXo8l5W2GeJAjDsVhWMUYpACwVdvGuCe8ExMTySAwXYdEldj
	Siyvxf2hZ/T1fHvOoyizWMZCJDXl8Uo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-4TFtM2YWOHWzydJNIPJiaQ-1; Sun,
 01 Nov 2026 15:11:53 -0500
X-MC-Unique: 4TFtM2YWOHWzydJNIPJiaQ-1
X-Mimecast-MFC-AGG-ID: 4TFtM2YWOHWzydJNIPJiaQ_1793563909
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B4FC1955F45;
	Sun,  1 Nov 2026 20:11:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C405C1956088;
	Sun,  1 Nov 2026 20:11:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6A55721E6A04; Sun, 01 Nov 2026 21:11:45 +0100 (CET)
Resent-To: 17746591750@163.com, pasic@linux.ibm.com, alistair@alistair23.me,
 rathc@linux.ibm.com, graf@amazon.com, stefanb@linux.vnet.ibm.com,
 FangSheng.Huang@amd.com, xen-devel@lists.xenproject.org,
 michael.roth@amd.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 palmer@dabbelt.com, rbolshakov@ddn.com, foss@defmacro.it,
 sebastian.huber@embedded-brains.de, fam@euphon.net,
 jiaxun.yang@flygoat.com, lizhijian@fujitsu.com, atar4qemu@gmail.com,
 edgar.iglesias@gmail.com, jasowangio@gmail.com, liwei1518@gmail.com,
 npiggin@gmail.com, zhangckid@gmail.com, titusr@google.com,
 wuhaotsh@google.com, arei.gonglei@huawei.com, berto@igalia.com,
 mark.cave-ayland@ilande.co.uk, junjie.cao@intel.com, zhao1.liu@intel.com,
 its@irrelevant.dk, clg@kaod.org, conor@kernel.org, david@kernel.org,
 jic23@kernel.org, kbusch@kernel.org, mchehab+huawei@kernel.org,
 sstabellini@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 zhenwei.pi@linux.dev, adityag@linux.ibm.com, alifm@linux.ibm.com,
 amachhiw@linux.ibm.com, borntraeger@linux.ibm.com,
 brueckner@linux.ibm.com, farman@linux.ibm.com, harshpb@linux.ibm.com,
 iii@linux.ibm.com, jjherne@linux.ibm.com, milesg@linux.ibm.com,
 mjrosato@linux.ibm.com, luc@lmichel.fr, lixianglai@loongson.cn,
 maobibo@loongson.cn, pbarbuda@microsoft.com, yoshinori.sato@nifty.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 john.levon@nutanix.com, thanos.makatos@nutanix.com, kfting@nuvoton.com,
 den@openvz.org, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, phil@philjordan.eu,
 tangtao1634@phytium.com.cn, chao.liu@processmission.com, jiri@resnulli.us,
 sam@rfc1149.net, anisa.su@samsung.com, alex@shazbot.org, farosas@suse.de,
 mohamed@unpredictable.fr, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 alistair.francis@wdc.com, anthony@xenproject.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:11:45 +0100
Resent-Message-ID: <87ecd41fcu.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  John Snow
 <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kostiantyn
 Kostiuk
 <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
  Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto
 Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
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
Subject: Re: [PATCH v7 17/65] qom: add object_{class_}property_add_qapi_enum
In-Reply-To: <CAMxuvayHXMftaQP6X_14pAf63bjX8mXxsW4TsXnLf_wbOq6eUA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 30 Oct 2026
 16:11:12 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-17-431a86b02b58@redhat.com>
	<871p97a4mf.fsf@pond.sub.org>
	<CAMxuvayHXMftaQP6X_14pAf63bjX8mXxsW4TsXnLf_wbOq6eUA@mail.gmail.com>
Date: Sun, 01 Nov 2026 12:18:09 +0100
Message-ID: <87se1k7qby.fsf@pond.sub.org>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: VFl7P9t2lDXk9GDX_IClDaEejQvliuqKkytPQZEpB88_1793563909
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, Oct 30, 2026 at 2:02=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++++++++
>> >  qom/object.c         | 90 +++++++++++++++++++++++++++++++++++++++++++=
++++++---
>> >  2 files changed, 159 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/include/qom/object.h b/include/qom/object.h
>> > index eb61d8842b80..e04be4caed57 100644
>> > --- a/include/qom/object.h
>> > +++ b/include/qom/object.h
>> > @@ -2027,6 +2027,80 @@ ObjectProperty *object_class_property_add_enum(=
ObjectClass *klass,
>> >                                      int (*get)(Object *, Error **),
>> >                                      void (*set)(Object *, int, Error =
**));
>> >
>> > +/**
>> > + * struct QapiEnumProp: Descriptor for a property backed by a QAPI en=
um type
>> > + *
>> > + * Binds a QOM object property to a QAPI enum, providing automatic
>> > + * string<->int conversion through QAPI visitors and optional
>> > + * default-value initialization during object instance init.
>> > + *
>> > + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
>> > + *
>> > + * @name: property name exposed on the QOM object
>> > + * @description: human-readable description (shown in ``-device help`=
`, etc.)
>> > + * @default_value: initial enum value applied via @set during instanc=
e init,
>> > + *                 or -1 (the QAPI_ENUM_PROP default) to skip initial=
ization
>> > + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
>> > + *             (provides the string<->int lookup table)
>> > + * @get: getter that returns the current enum value as int, or -1 on =
error
>> > + * @set: setter that receives the enum value as int; %NULL for read-o=
nly props
>> > + */
>> > +typedef struct QapiEnumProp {
>> > +    const char *name;
>> > +    const char *description;
>> > +    const int default_value;
>> > +    const QAPITypeInfo *qapi_type;
>> > +    int (*get)(Object *, Error **);
>> > +    void (*set)(Object *, int, Error **);
>> > +} QapiEnumProp;
>> > +
>> > +#define QAPI_ENUM_PROP(...) ({                                       =
    \
>> > +    static const QapiEnumProp _prop =3D {                            =
      \
>> > +        .default_value =3D -1, __VA_ARGS__                           =
      \
>> > +    };                                                               =
    \
>> > +    &_prop; })
>>
>> This is a cute and reasonably well-known macro trick for optional
>> keyword arguments in C.
>>
>> The example [*] below specifies all arguments.  What happens when we
>> omit any?  They default to zero via default initializaion, except for
>> .default_value, which defaults to -1.
>>
>> Trap for developers: some arguments aren't actually optional!  If you
>> forget to specify @name or @qapi_type, the code compiles, but crashes at
>> run time.
>>
>> Not a fan.
>
> Agree (not a fan of C either). We could probably add more
> static/runtime checks. Or clearly state that there is room for
> improvements, or just drop it altogether - either as follow up or with
> the series. I leave that up to you since you are going to respin it.
> thanks!

I dropped it for v8.  Was a bit of a pain, but the patches became
simpler.

[...]

