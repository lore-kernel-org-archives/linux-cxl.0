Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564043;
	b=Wv3S0cEiGdgsIsPkM2qgsbqlENVQPtfYQzXWIHIen7cQlalXmmFkTF/X4346ph/5uj2L
	 T4VRXtRyuyBVsdIRMbx7TIJGp4nyQXgj5HeMZ4OqKtS/6jeCv/B6Tj87NNak332RyeqTB
	 giyWsfEeNifMznEVI2xhqSxTcRY1FxKMMGPefhgEomnFlJ+RsYID8Xc7BRbP0QGKktaN6
	 v4kMZxM58AiQsuOAwKKCTNjek1xJVZa6h+YDQcZKdJ9h9g7CjZcmNdDhXktZVOrf38HJ3
	 H4YaQRoC5aPTC64WVGaYWf1jfQpkAdJvpNiX0s9DsDivSbrhidXNyHN0Ehub/JPVvng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564043;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Resent-To:
	 Resent-From:Resent-Date:Resent-Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:Lines:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=dG6QdUgPpDE3LmNNjTQwdz8vTAxBziYTzulA/MP9vJ8=;
	b=ndAUB1je/mYdhHPuCJ3mdStmApqTL1GozCxNbIgFeDY/jBjl+psnUo22g9nOJ00VshiF
	 NKDuPq9VY1rO8Us5/8kYcKeNVurgw2R9Q/JGh3sM1XaYXTkBIfl71WQu9tv2KfZmbHY+/
	 3jWmWrKxoLkdC9onpT1wamDH2cP2bKVkBdLK+zImhmz3k8Wi/xQ/F4McQ4vam286ZPUIG
	 c8hoeohcjrz5gQ4t3mXgEo3WA7Kz+8zAnIlaby+KOvhAawyw0uok+KC8uTdogdEv0EzgB
	 QUpnXArGuHV1KSmUvgSGLANQYJcRRv0B94L9t5OP34Z1Wl5KG6EEWitmidySbEihtBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hbzDpoX9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78C606A324
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 20:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E78C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hbzDpoX9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793564042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=dG6QdUgPpDE3LmNNjTQwdz8vTAxBziYTzulA/MP9vJ8=;
	b=hbzDpoX9gk9nW+f+REM3FBWL/O+8LW4J4DI+cexpKMEK+mMW41dEey4vQj+HSTxXGY7cjn
	Y8oGFdV2w7ggyh8gZYQVBgDlsVIzCKE/kCsY9YOjmOlrtV/XKYM3ixGJJ/3W7dbhHW0lWh
	9+2pyJnEkKcA+6lcMkQ6CW44ajox0aw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-zUz3wxw2MFW_-TF18iVIrQ-1; Sun,
 01 Nov 2026 15:13:57 -0500
X-MC-Unique: zUz3wxw2MFW_-TF18iVIrQ-1
X-Mimecast-MFC-AGG-ID: zUz3wxw2MFW_-TF18iVIrQ_1793564033
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C6A01800364;
	Sun,  1 Nov 2026 20:13:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5BA37E0;
	Sun,  1 Nov 2026 20:13:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8867121E6A04; Sun, 01 Nov 2026 21:13:50 +0100 (CET)
Resent-To: pasic@linux.ibm.com, 17746591750@163.com, rathc@linux.ibm.com,
 alistair@alistair23.me, stefanb@linux.vnet.ibm.com, graf@amazon.com,
 xen-devel@lists.xenproject.org, FangSheng.Huang@amd.com, luc@lmichel.fr,
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
 mjrosato@linux.ibm.com, lixianglai@loongson.cn, maobibo@loongson.cn,
 pbarbuda@microsoft.com, yoshinori.sato@nifty.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, kfting@nuvoton.com, den@openvz.org,
 elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, phil@philjordan.eu,
 tangtao1634@phytium.com.cn, chao.liu@processmission.com, jiri@resnulli.us,
 sam@rfc1149.net, anisa.su@samsung.com, alex@shazbot.org, farosas@suse.de,
 mohamed@unpredictable.fr, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 alistair.francis@wdc.com, anthony@xenproject.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:13:50 +0100
Resent-Message-ID: <87wlqwz4w1.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Pierrick Bouvier
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
Subject: Re: [PATCH v7 44/65] hw/nvdimm: convert UUID property to QAPI-aware
 registration
In-Reply-To: <20261020-qom-qapi-v7-44-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 20 Oct 2026 14:46:01 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-44-431a86b02b58@redhat.com>
Date: Sun, 01 Nov 2026 18:39:55 +0100
Message-ID: <871p9478no.fsf@pond.sub.org>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: A-rTHVjvjlv-cAwjnXVtYeTRq78K77sJhfcMYhVoAHM_1793564033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a QemuUUID_type_info and use object_property_add_qapi() instead of
> object_property_add() for the nvdimm UUID property.
>
> The type info is defined manually in uuid.c rather than generated,
> since QAPI does not yet support string typedefs. An alternative would
> be to extend the QAPI schema language with a 'typedef' construct
> (e.g. { 'typedef': 'UUID', 'data': 'str' }), which would let the
> generator produce the type info, C typedef, and introspection entry
> automatically.
>
> Alternatively, the exposed type being a string, we could change the
> property to be str_type_info.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mem/nvdimm.c     | 4 ++--
>  include/qemu/uuid.h | 4 ++++
>  util/uuid.c         | 5 +++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 123ddc938546..b7ccb5c93678 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -104,8 +104,8 @@ static void nvdimm_init(Object *obj)
>                               nvdimm_get_label_size, nvdimm_set_label_siz=
e, NULL,
>                               NULL);
> =20
> -    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uu=
id,
> -                        nvdimm_set_uuid, NULL, NULL);
> +    object_property_add_qapi(obj, NVDIMM_UUID_PROP, &QemuUUID_type_info,
> +                             nvdimm_get_uuid, nvdimm_set_uuid, NULL, NUL=
L);
>  }
> =20

Let's pass &str_type_info, like the next patch does, because ...

>  static void nvdimm_finalize(Object *obj)
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 869f84af09dd..ed0c62327d4d 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -16,6 +16,8 @@
>  #ifndef QEMU_UUID_H
>  #define QEMU_UUID_H
> =20
> +#include "qapi/qapi-type-info.h"
> +
> =20
>  /* Version 4 UUID (pseudo random numbers), RFC4122 4.4. */
> =20
> @@ -99,4 +101,6 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid);
> =20
>  uint32_t qemu_uuid_hash(const void *uuid);
> =20
> +extern const QAPITypeInfo QemuUUID_type_info;
> +
>  #endif
> diff --git a/util/uuid.c b/util/uuid.c
> index 234619dd5e69..363a03051aba 100644
> --- a/util/uuid.c
> +++ b/util/uuid.c
> @@ -17,6 +17,11 @@
>  #include "qemu/uuid.h"
>  #include "qemu/bswap.h"
> =20
> +const QAPITypeInfo QemuUUID_type_info =3D {
> +    .name =3D "QemuUUID",
> +    .masked_name =3D "str",
> +};
> +

... the only difference to str_type_info is @name.

In v7, @name is used as value of ObjectPropertyInfo /
ObjectPropertyValue member @type.  Your manual QAPITypeInfo lets you
preserve the value of @type.

It isn't used that way v8 (which I'll post real soon now).  It preserves
@type values differently.  The problem discussed in the commit message
doesn't exist then, so I'll cut it some.

>  void qemu_uuid_generate(QemuUUID *uuid)
>  {
>      int i;

