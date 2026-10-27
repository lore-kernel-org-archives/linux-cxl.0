Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112865;
	b=x34+MyNTlz2UEx/4C39vzzFNw9vWm3BobjB1zNvF1RHcqEgGhKNEWz8W6Sk10mqRvOcB
	 AmLzfsnSGz3tSEODOVnRsBMYkKPaWiGxyiLeQHC9+rMermbdE/RI6Hi5Bvf1ACmtNxR8P
	 mAIxsU/5ZCpzWYonRG16lFMr+OKBvHfDLUJd2MWjYA/ZhR7VoXsqhisB9yuqb8d/jLZmX
	 x+M7a6tWbITOIPzFfQIk49cHxvBetQbSLKCk4BvpUA7cdKuDqNv4zuSh0NgViFYZCR/GF
	 fU6ZSeZE/ynC9ijc6ZoHngaN1ddskSK6itUsnNHJ/nXRoQAxp1LvvgjGkf68uc14/TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112865;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=bkID89a/6OklaXaMWn8rSBHoX2XDYtn2gJ9CrOvW2W4=;
	b=jsOF2qqvJH64pH2CZQ5EEKRWvwe1Mec8jau0RteOA0gDjW1zM4Ywu4jDCR3pyxNn77IQ
	 8Y4TWn7q6UzHwcBbdV4F1ouno+uWQ9IdB4lK6GToXAx33dJpf7j1y+mAujiHoWevmzUjj
	 HYTuXOjxqEy1VrV7vJZWSQDGm5Ec7KKl9n+P8N0/NO8sSnlLzsiNJfoPgK3C6mVKoGSVS
	 2MG2XzvZOQqLwQHqLwaoAlCAS6ut/oQtxYO1OUJvd6qPDgMJ2pHKiP8P0bFLFECOwsAee
	 Wlwm3QbL93tkiHi0PIQaXR0LSQJCA99dahgGn74k1MY2DBW1MXAswLU8JVQrZlT66RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="LQXpzB/1";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2B606A334
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C2B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQXpzB/1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793112864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkID89a/6OklaXaMWn8rSBHoX2XDYtn2gJ9CrOvW2W4=;
	b=LQXpzB/1SkjQfAU9+hIW8aK8zsEUxCgzpnkI9JZvFUwGH3Dx2+Gm35tX1H9utfHpK9mqry
	KGvudhqeqystG0BXzirwOXumYr0//IrnKEuT/xuaWwE6afnGYXQwLItrHpwciT87dK5PpP
	t1URNWk3kfbrV8L5BOSE5TQBmuYrwgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-nyqVetLPM2uBg4ZbpUvWIg-1; Tue,
 27 Oct 2026 10:54:19 -0400
X-MC-Unique: nyqVetLPM2uBg4ZbpUvWIg-1
X-Mimecast-MFC-AGG-ID: nyqVetLPM2uBg4ZbpUvWIg_1793112855
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56DB7195411B;
	Tue, 27 Oct 2026 14:54:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F9C31800495;
	Tue, 27 Oct 2026 14:54:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CEB8121E6A04; Tue, 27 Oct 2026 15:54:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
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
In-Reply-To: <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 23 Oct 2026
 15:39:22 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
	<atsxLV5YZo8dr-8G@redhat.com>
	<CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
Date: Tue, 27 Oct 2026 15:54:03 +0100
Message-ID: <87zevz5h4k.fsf@pond.sub.org>
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
X-Mimecast-MFC-PROC-ID: DVaFO-AfNLXCCyk64ZdgnEPmmFNwSCfWMHO5Vf1Fnyc_1793112855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
>>
>> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> > PciDevfn is a bit special, since it accepts integer and string as
>> > setter, but only output integer as getter.

Yes.  See below.

>> > Unfortunately, we can't declare an alternate str|int QAPI type for it,
>> > since: branch 'string' can't be distinguished from 'integer'

Yes, except with trickery; more on this below.

>> >
>> > Rather than declaring it as "str", use the common type instead.
>> >
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  hw/core/qdev-properties-system.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-propertie=
s-system.c
>> > index 5bfdfe1ab9d9..3381de1144d6 100644
>> > --- a/hw/core/qdev-properties-system.c
>> > +++ b/hw/core/qdev-properties-system.c
>> > @@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Pr=
operty *prop)
>> >  }
>> >
>> >  const PropertyInfo qdev_prop_pci_devfn =3D {
>> > -    .type  =3D "str",
>> > +    /* The formatted string accepted by the setter is a CLI convenien=
ce. */
>>
>> IIUC, this is not limited to the CLI, it will work anywhere the JSON
>> syntax is permitted which is both CLI and QMP.
>>
>> libvirt uses this string syntax:
>>
>>   -device '{"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2",=
"bus":"pcie.0","multifunction":true,"addr":"0x1.0x1"}' \
>>
>> > +    .type  =3D "int32",
>> >      .description =3D "Slot and optional function number, example: 06.=
0 or 06",
          .print =3D print_pci_devfn,
          .get   =3D qdev_propinfo_get_int32,
          .set   =3D set_pci_devfn,
          .set_default_value =3D qdev_propinfo_set_default_value_int,
      };

The property is backed by an int32_t.  In
include/hw/core/qdev-properties-system.h:

    #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
        DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)

It's only ever used for PCI device property "addr".

Its .get() simply visits it.  This is why qom-get returns an integer:

    --> {"execute":"qom-get","arguments":{"path":"/machine/unattached/devic=
e[4]/pm", "property": "type"}}
    <-- {"return": "PIIX4_PM"}
    --> {"execute":"qom-get","arguments":{"path":"/machine/unattached/devic=
e[4]/pm", "property": "addr"}}
    <-- {"return": 11}

Its .set() is a handwritten visit of an alternate of 'str' and 'int32',
where 'str' gets parsed as DEV.FN into int32.  This is why QMP
device_add accepts both JSON string and JSON number (HMP device_add and
-device only do string).  QAPI doesn't let us define such an alternate
type, as you wrote in your commit message, but handwritten visits fly
below that radar.  This is of course too clever by half.  Goes back to
commit 768a9ebe188 (qdev: accept both strings and integers for PCI
addresses) in v1.1.

Its .print() prints it like DEV.FN.  Its only user is "info qtree".

>> Changing the type to 'int32', where 99% of usage is input only
>> and string based, is pretty unpleasant. Even more so that the
>> description doesn't even mention encoding dev+function as an
>> integer.
>
> This is purely a metadata change, the setter still accepts both str &
> int,

Yes.

.type is only used as @type argument for object_class_property_add() and
object_property_add().  They store it in ObjectProperty member @type.
Visible externally in QOM introspection (ObjectPropertyInfo and
ObjectPropertyValue member type).  Also in help, but let's ignore that
for a minute.

Before the series, QOM instrospection shows type "str" for PCI device
property "addr".

For reading, that's a lie: qom-get and qom-list-get return an JSON
integer, not a JSON string.

For writing, it's merely incomplete: qom-set accepts a JSON string in
addition to a JSON integer.

Does it matter?  To make use of QOM introspection's type, you have to
hardcode so much silly stuff, what's one more case?

With this patch, it shows type "int32".  Less wrong.

Again, does it matter?  The change could conceivably break a client.  I
figure the risk is small.  Is "less wrong" worth even a small risk?

>      so I don't think this change blocks this series.

I figure it's no worse than the other type values the series changes.

Let's discuss them under my

    Subject: Property types changed in this series (was: [PATCH v7 00/65] H=
i)
    Date: Wed, 21 Oct 2026 18:29:40 +0200
    Message-ID: <87tsmfkoej.fsf@pond.sub.org>

>                                                       But I agree we
> could do better.
>
> There are multiple options. We could keep declaring the property as
> str instead. In this case, the getter should probably return a string
> for consistency and correctness. This might surprise some existing
> users though.

I.e. ditch numeric suppport for numeric addresses, right?

Incompatible change.  Do we care?

If we don't, we should be honest about it and mark qom-get unstable.

> We could introduce new properties like `devfn-str` and `devfn-int`
> that alias the same value.

Compatibility break.  If breaking compatibility is okay, I'd rather use
the opportunity to get rid of cleverness, and go with your first option.

> We could also introduce a new structured QAPI type.

What kind of type do you have in mind?

> Markus, what's your take?

From a QAPI/QMP point of view, the clean way to support "either string
or numeric address" is an alternate type.

Trouble is the generator rejects such an alternate, as you pointed out
in your commit message.  Why is that?

docs/devel/qapi-code-gen.rst:

    An alternate type is like a union type, except there is no
    discriminator on the wire.  Instead, the branch to use is inferred
    from the value.  An alternate can only express a choice between types
    represented differently on the wire.

So, we can't have two 'str' branches (both JSON string), or a 'str' and
an 'enum' branch (same).

But 'int32' and 'str' are different on the wire (JSON number and JSON
string), so what's going on?  This:

commit c0644771ebedbd8f47f3c24816445e30111d226b (tag: pull-qapi-2017-05-31)
Author: Markus Armbruster <armbru@redhat.com>
Date:   Mon May 22 18:42:15 2017 +0200

    qapi: Reject alternates that can't work with keyval_parse()
   =20
    Alternates are sum types like unions, but use the JSON type on the
    wire / QType in QObject instead of an explicit tag.  That's why we
    require alternate members to have distinct QTypes.
   =20
    The recently introduced keyval_parse() (commit d454dbe) can only
    produce string scalars.  The qobject_input_visitor_new_keyval() input
    visitor mostly hides the difference, so code using a QObject input
    visitor doesn't have to care whether its input was parsed from JSON or
    KEY=3DVALUE,...  The difference leaks for alternates, as noted in commi=
t
    0ee9ae7: a non-string, non-enum scalar alternate value can't currently
    be expressed.
   =20
    In part, this is just our insufficiently sophisticated implementation.
    Consider alternate type 'GuestFileWhence'.  It has an integer member
    and a 'QGASeek' member.  The latter is an enumeration with values
    'set', 'cur', 'end'.  The meaning of b=3Dset, b=3Dcur, b=3Dend, b=3D0, =
b=3D1 and
    so forth is perfectly obvious.  However, our current implementation
    falls apart at run time for b=3D0, b=3D1, and so forth.  Fixable, but n=
ot
    today; add a test case and a TODO comment.
   =20
    Now consider an alternate type with a string and an integer member.
    What's the meaning of a=3D42?  Is it the string "42" or the integer 42?
    Whichever meaning you pick makes the other inexpressible.  This isn't
    just an implementation problem, it's fundamental.  Our current
    implementation will pick string.
   =20
    So far, we haven't needed such alternates.  To make sure we stop and
    think before we add one that cannot sanely work with keyval_parse(),
    let's require alternate members to have sufficiently distinct
    representation in KEY=3DVALUE,... syntax:
   =20
    * A string member clashes with any other scalar member
   =20
    * An enumeration member clashes with bool members when it has value
      'on' or 'off'.
   =20
    * An enumeration member clashes with numeric members when it has a
      value that starts with '-', '+', or a decimal digit.  This is a
      rather lazy approximation of the actual number syntax accepted by
      the visitor.
   =20
      Note that enumeration values starting with '-' and '+' are rejected
      elsewhere already, but better safe than sorry.
   =20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Message-Id: <1495471335-23707-5-git-send-email-armbru@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

However, keyval_parse() + its input visitor can't express everything
QAPI even with such alternates outlawed.  From util/keyval.c:

 * Design flaw: there is no way to denote an empty array or non-root
 * object.  While interpreting "key absent" as empty seems natural
 * (removing a key-val from the input string removes the member when
 * there are more, so why not when it's the last), it doesn't work:
 * "key absent" already means "optional object/array absent", which
 * isn't the same as "empty object/array present".
 *
 * Design flaw: scalar values can only be strings; there is no way to
 * denote numbers, true, false or null.  The special QObject input
 * visitor returned by qobject_input_visitor_new_keyval() mostly hides
 * this by automatically converting strings to the type the visitor
 * expects.  Breaks down for type 'any', where the visitor's
 * expectation isn't clear.  Code visiting 'any' needs to do the
 * conversion itself, but only when using this keyval visitor.
 * Awkward.  Note that we carefully restrict alternate types to avoid
 * similar ambiguity.

We commonly use keyval syntax together with JSON: if the input starts
with '{', it's assumed to be JSON, else keyval.  See
qobject_input_visitor_new_str().  This lets you fall back to JSON when
keyval can't express what you want.

Beware, there *are* uses of keyval without a JSON fallback.

As the commit message I quoted says, we could permit alternates that are
ambiguous with keyval.  The keyval visitor could then pick a branch (you
can't express the others), or it could refuse to pick (you can't express
any of them).

In the particular case of PCI device property "addr", picking str would
be fine: same behavior as the handwritten visit in in set_pci_devfn().

But once we permit such alternates, nothing but conscientious testing
with keyval syntax will stop us from adding interfaces that don't work
or work the wrong way.  Hmm.

I need to think about this some more if we want to explore this
direction.

[...]

