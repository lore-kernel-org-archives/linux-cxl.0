Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502754;
	b=vK9OhTO4X4ZBZiKlx7YGPrCCGdbD0cIzKpy/gGvBfJD5tVcRps7/jT9aIgJPZTP4GIGG
	 AclZCic3tyDKBXuARkfTZRr4cmg7/JFa1wha2ALDdwIvbOZjaEgNU7rshsNpf78+/wKcF
	 VAKRZ1oyCJNx1PuWHmG2oDDVGYAuFcJCokx5mmMiQOmHalOvMKZAtZkoxESSejm3LM4p4
	 QUuPghTxU1F6jwftj7v2IFA1/2bMi98Xsd1Q0Zv/yxqWG1D0h6Hrx+fo5Isbl+BawoxZb
	 BCYUx5oM4MyhVlmNM9/fiAFGJYAJ5zh9CtdwbqZzPflPqUm40R3wlmj878FjXSDSEkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502754;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=A/2pHd+aS8DA34XJvVp3LyaeljRYqqdyzYtr5T0L1kw=;
	b=FM8p/u7dv8zP6HJXxzwdOBGHECzt9xbegfPK67DtAWbtZKFLd7MIg1f+U2SNP1cLZLxM
	 WpC/7hPu6JAy5cq06+hPHeVWB35XjIysg+6d+FXP5ujRwU6Jtmrwj3SMb6+cqmnTRNBDY
	 jmcZBWqFfJOLuXIKomwSDB9TNQI+XYo4UJHBDf7vHBL8/RU6lO5xKVIi0s4Hsty8FfsB6
	 uN+o1pBRA/m4IIKKOtoYvLnvqYfYEGATZdouhyvvcSYCAXhEedM8JEUvZtasc7MPCdG27
	 MHbRWPVCpwAdmmbbL/l82b/PQgsDnTJJ2KpfhvSV6zStbi1H4B16oO9sljNKF9DPB7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fSteO5Or;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE0606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 13:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fSteO5Or
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792502752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/2pHd+aS8DA34XJvVp3LyaeljRYqqdyzYtr5T0L1kw=;
	b=fSteO5OrNQGSr1L/KcMV7UVSWlOCKoKszGwqU+UZiqTV/dJ8aHH3IeNJZCya/uimfyW3Zn
	LO4MFt2ykOaColkIh0rnZzFoYz5Ig9hL2ArkULxMrBYP4E0DjGMNi1B8Joq+Mi6LJ5sKgh
	YEjA4vhvKMQ4H8knPY1CMUcmSMGbfP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-GpgImfhOMWa0lumUFG9c1g-1; Tue,
 20 Oct 2026 13:25:47 +0000
X-MC-Unique: GpgImfhOMWa0lumUFG9c1g-1
X-Mimecast-MFC-AGG-ID: GpgImfhOMWa0lumUFG9c1g_1792502743
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D737F1800BDD;
	Tue, 20 Oct 2026 13:25:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA9B818005B3;
	Tue, 20 Oct 2026 13:25:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 71D8121E6A04; Tue, 20 Oct 2026 15:25:33 +0200 (CEST)
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
Subject: Re: [PATCH v7 43/65] qom: replace object_property_add_tm with
 StructTm QAPI type
In-Reply-To: <20261020-qom-qapi-v7-43-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 20 Oct 2026 14:46:00 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-43-431a86b02b58@redhat.com>
Date: Tue, 20 Oct 2026 15:25:33 +0200
Message-ID: <874iegpkqa.fsf@pond.sub.org>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hawp9PtkTF8m9ailPa8PeUvOde1ZAOLJFwPo0WMSIgk_1792502743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Define a StructTm QAPI struct in common.json matching the existing
> "struct tm" property wire format (tm_year, tm_mon, tm_mday, tm_hour,
> tm_min, tm_sec as int32).
>
> Convert the two callers (mc146818rtc and spapr_rtc) to use
> object_property_add_qapi() with a standard ObjectPropertyAccessor
> that populates a StructTm and calls the generated visitor.
>
> Remove object_property_add_tm(), object_class_property_add_tm(),
> the TMProperty type, and the property_get_tm() helper from
> qom/object.c, along with their declarations in object.h.
>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ppc/spapr_rtc.c   | 24 +++++++++++++++---
>  hw/rtc/mc146818rtc.c | 22 ++++++++++++++---
>  include/qom/object.h | 29 ----------------------
>  qapi/common.json     | 28 +++++++++++++++++++++
>  qapi/pragma.json     |  1 +
>  qom/object.c         | 69 ----------------------------------------------=
------
>  6 files changed, 69 insertions(+), 104 deletions(-)
>
> diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
> index 1f7d2d8f898b..5105cf538f64 100644
> --- a/hw/ppc/spapr_rtc.c
> +++ b/hw/ppc/spapr_rtc.c
> @@ -33,6 +33,9 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
> +#include "qapi/qapi-type-infos-common.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "qapi/visitor.h"
>  #include "qemu/cutils.h"
>  #include "qemu/module.h"
> =20
> @@ -131,9 +134,23 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, Sp=
aprMachineState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> -static void spapr_rtc_qom_date(Object *obj, struct tm *current_tm, Error=
 **errp)
> +static void spapr_rtc_qom_date(Object *obj, Visitor *v, const char *name=
,
> +                               void *opaque, Error **errp)
>  {
> -    spapr_rtc_read(SPAPR_RTC(obj), current_tm, NULL);
> +    struct tm value;
> +    StructTm tm, *tmp =3D &tm;
> +
> +    spapr_rtc_read(SPAPR_RTC(obj), &value, NULL);
> +
> +    tm =3D (StructTm) {
> +        .tm_year =3D value.tm_year,
> +        .tm_mon =3D value.tm_mon,
> +        .tm_mday =3D value.tm_mday,
> +        .tm_hour =3D value.tm_hour,
> +        .tm_min =3D value.tm_min,
> +        .tm_sec =3D value.tm_sec,
> +    };
> +    visit_type_StructTm(v, name, &tmp, errp);
>  }
> =20
>  static void spapr_rtc_realize(DeviceState *dev, Error **errp)
> @@ -150,7 +167,8 @@ static void spapr_rtc_realize(DeviceState *dev, Error=
 **errp)
>      rtc_ns =3D qemu_clock_get_ns(rtc_clock);
>      rtc->ns_offset =3D host_s * NANOSECONDS_PER_SECOND - rtc_ns;
> =20
> -    object_property_add_tm(OBJECT(rtc), "date", spapr_rtc_qom_date);
> +    object_property_add_qapi(OBJECT(rtc), "date", &StructTm_type_info,
> +                             spapr_rtc_qom_date, NULL, NULL, NULL);

The @type reported by qom-list & friends changes from "struct tm"
(visible at the end of this patch) to to "StuctTm".  Such changes can be
compatibility breaks.

Same "this is okay" argument as for the previous patch, and same
request: please note the change in the commit message.

>  }
> =20
>  static const VMStateDescription vmstate_spapr_rtc =3D {
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index ba396435d1af..6010f8587ce0 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -42,6 +42,8 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
> +#include "qapi/qapi-type-infos-common.h"
> +#include "qapi/qapi-visit-common.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
> =20
> @@ -854,12 +856,25 @@ static const MemoryRegionOps cmos_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -static void rtc_get_date(Object *obj, struct tm *current_tm, Error **err=
p)
> +static void rtc_get_date(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
>  {
>      MC146818RtcState *s =3D MC146818_RTC(obj);
> +    struct tm value;
> +    StructTm tm, *tmp =3D &tm;
> =20
>      rtc_update_time(s);
> -    rtc_get_time(s, current_tm);
> +    rtc_get_time(s, &value);
> +
> +    tm =3D (StructTm) {
> +        .tm_year =3D value.tm_year,
> +        .tm_mon =3D value.tm_mon,
> +        .tm_mday =3D value.tm_mday,
> +        .tm_hour =3D value.tm_hour,
> +        .tm_min =3D value.tm_min,
> +        .tm_sec =3D value.tm_sec,
> +    };
> +    visit_type_StructTm(v, name, &tmp, errp);
>  }
> =20
>  static void rtc_realizefn(DeviceState *dev, Error **errp)
> @@ -1019,7 +1034,8 @@ static void rtc_class_initfn(ObjectClass *klass, co=
nst void *data)
>      device_class_set_props(dc, mc146818rtc_properties);
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> =20
> -    object_class_property_add_tm(klass, "date", rtc_get_date);
> +    object_class_property_add_qapi(klass, "date", &StructTm_type_info,
> +                                   rtc_get_date, NULL, NULL, NULL);
>  }
> =20
>  static const TypeInfo mc146818rtc_info =3D {
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e04be4caed57..29cbd84b8d03 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2156,35 +2156,6 @@ object_class_property_add_qapi(ObjectClass *klass,
>                                 ObjectPropertyRelease *release,
>                                 void *opaque);
> =20
> -/**
> - * object_property_add_tm:
> - * @obj: the object to add a property to
> - * @name: the name of the property
> - * @get: the getter or NULL if the property is write-only.
> - *
> - * Add a read-only struct tm valued property using a getter function.
> - * This function will add a property of type 'struct tm'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_property_add_tm(Object *obj, const char *name,
> -                            void (*get)(Object *, struct tm *, Error **)=
);
> -
> -/**
> - * object_class_property_add_tm:
> - * @klass: the object class to add a property to
> - * @name: the name of the property
> - * @get: the getter or NULL if the property is write-only.
> - *
> - * Add a read-only struct tm valued property using a getter function.
> - * This function will add a property of type 'struct tm'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
> -                            const char *name,
> -                            void (*get)(Object *, struct tm *, Error **)=
);
> -
>  typedef enum {
>      /* Automatically add a getter to the property */
>      OBJ_PROP_FLAG_READ =3D 1 << 0,
> diff --git a/qapi/common.json b/qapi/common.json
> index 1352e664b23e..222037ea0b32 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -218,3 +218,31 @@
>  ##
>  { 'enum': 'EndianMode',
>    'data': [ 'unspecified', 'little', 'big' ] }
> +
> +##
> +# @StructTm:
> +#
> +# Broken-down time.  Field semantics match C ``struct tm``.

Again, please use the revised syntax for introductions.

> +#
> +# @tm_year: years since 1900
> +#
> +# @tm_mon: months since January (0-11)
> +#
> +# @tm_mday: day of the month (1-31)
> +#
> +# @tm_hour: hours since midnight (0-23)
> +#
> +# @tm_min: minutes after the hour (0-59)
> +#
> +# @tm_sec: seconds after the minute (0-59, 60-61 for leap seconds)
> +#
> +# Since: 11.2

Same "do we care?" as for the previous patch.

> +##
> +{ 'struct': 'StructTm',
> +  'data': {
> +    'tm_year': 'int32',
> +    'tm_mon': 'int32',
> +    'tm_mday': 'int32',
> +    'tm_hour': 'int32',
> +    'tm_min': 'int32',
> +    'tm_sec': 'int32' } }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 342cedc42e76..9be2819a46bd 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -109,6 +109,7 @@
       # Externally visible types whose member names may use uppercase

Not this patch's fault, but here goes anyway: the comment should be "may
use uppercase or '_'".  I'll fix it.

       'member-name-exceptions': [     # visible in:
           'ACPISlotType',             # query-acpi-ospm-status
           [...]
>          'QKeyCode',                 # send-key, input-sent-event
>          'QapiErrorClass',           # QMP error replies
>          'SshHostKeyCheckMode',      # blockdev-add, -blockdev
> +        'StructTm',                 # qom-get of RTC date property
>          'SysEmuTarget',             # query-cpu-fast, query-target
>          'UuidInfo',                 # query-uuid
>          'VncClientInfo',            # query-vnc, query-vnc-servers, ...

[...]

