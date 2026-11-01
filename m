Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563984;
	b=b5W6mhegujFAHMpHWTrnsJ479pug9azSRSQzpPAcm2P0pO+2fXHUOhWnsKqSG+13HasD
	 d/4RBQnQCdT8YbaI5W0hgM+trseAXMgoDoRKaHjkHRN0iD+HBSvmbN6gQoBqD0Tg1NdeJ
	 0bJYkIPLTci929Q9qP44nFU1RUryaA85vbnT1qe0pAW+B6SAAzhytSfUDAej9ALXJhztQ
	 E/YxGetwAsr5NRClFWWLfvj8FA/Qryt/kmD9SIAmiimlhV6Iq0YHEflIeuTWiKoPQJam1
	 SFQSh3EihMsaXDqhhyCD4pb5Xy5WV2oqkSbF4B3c/uHp9YYhNaTzwPH1UxCOFm/l//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563984;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Resent-To:
	 Resent-From:Resent-Date:Resent-Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:Lines:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=GTF9/Bs8O74QIWLz9nNcAwYctE+VbuxRb66ECG/NONE=;
	b=Y8d0SUKHtFrezYxVa8re3aOmUHLqTWymWKI5oesnmFyoe5VffvAylF+LphiaFvwTNXxv
	 O8nms4AK5bNNIfIwQCjT9IJZ/vgfSSJc6b09A4tmSpyR1TRC+26HLf95IynoMZomNItkS
	 15Gw/8c+Cjx6QcGnl3Pnd6Oeiya6E8YxjBWyCDqDhaPuRneYI5Ka8yGdq7VnbeBbotHWd
	 nq9EHQe/o+z5MwVT/funJpiX+VQGR0loEnbqaO2syXGrvTVIilwqRtCydhznD2aIfkd0H
	 sJrR4k+tgPif5gBEpSNWArhnfltnRLH3RpQBOt7hkIa/mOfJ4tf23b51lcPeqLarH8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QWxnPL2F;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1638606A325
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 20:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1638606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QWxnPL2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793563982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=GTF9/Bs8O74QIWLz9nNcAwYctE+VbuxRb66ECG/NONE=;
	b=QWxnPL2FYED2KoCZHo8cnHMUa2BCmOdmjOrSOD3CslLvy6gCHphgaKFlzxLIP0ZMP+B6Ps
	pCik7wJ+lWgYID8fCUE02SN8p9fX8wA7QwQiXhvWvxuPiJq4Unt8jKToGd5TLhD8L8Gi0x
	tK9seC0YWJpKwf5q9cbRltjFAzRCYRY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-NHSE1nS8MaKM2Lkt4h6T7g-1; Sun,
 01 Nov 2026 15:12:59 -0500
X-MC-Unique: NHSE1nS8MaKM2Lkt4h6T7g-1
X-Mimecast-MFC-AGG-ID: NHSE1nS8MaKM2Lkt4h6T7g_1793563975
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C6351954B0B;
	Sun,  1 Nov 2026 20:12:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 369CF1800446;
	Sun,  1 Nov 2026 20:12:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D8DE121E6A04; Sun, 01 Nov 2026 21:12:48 +0100 (CET)
Resent-To: 17746591750@163.com, alistair@alistair23.me, graf@amazon.com,
 FangSheng.Huang@amd.com, michael.roth@amd.com, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, palmer@dabbelt.com, rbolshakov@ddn.com,
 foss@defmacro.it, sebastian.huber@embedded-brains.de, fam@euphon.net,
 jiaxun.yang@flygoat.com, lizhijian@fujitsu.com, atar4qemu@gmail.com,
 edgar.iglesias@gmail.com, jasowangio@gmail.com, liwei1518@gmail.com,
 npiggin@gmail.com, zhangckid@gmail.com, titusr@google.com,
 wuhaotsh@google.com, arei.gonglei@huawei.com, berto@igalia.com,
 mark.cave-ayland@ilande.co.uk, junjie.cao@intel.com, zhao1.liu@intel.com,
 pasic@linux.ibm.com, its@irrelevant.dk, rathc@linux.ibm.com, clg@kaod.org,
 stefanb@linux.vnet.ibm.com, conor@kernel.org,
 xen-devel@lists.xenproject.org, david@kernel.org, luc@lmichel.fr,
 jic23@kernel.org, lixianglai@loongson.cn, maobibo@loongson.cn,
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
 alistair.francis@wdc.com, anthony@xenproject.org, kbusch@kernel.org,
 mchehab+huawei@kernel.org, sstabellini@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, zhenwei.pi@linux.dev, adityag@linux.ibm.com,
 alifm@linux.ibm.com, amachhiw@linux.ibm.com, borntraeger@linux.ibm.com,
 brueckner@linux.ibm.com, farman@linux.ibm.com, harshpb@linux.ibm.com,
 iii@linux.ibm.com, jjherne@linux.ibm.com, milesg@linux.ibm.com,
 mjrosato@linux.ibm.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:12:48 +0100
Resent-Message-ID: <875wyg1fb3.fsf@pond.sub.org>
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
Subject: Re: [PATCH v7 07/65] qapi: add QAPITypeInfo struct definition
In-Reply-To: <20261020-qom-qapi-v7-7-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 20 Oct 2026 14:45:24 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-7-431a86b02b58@redhat.com>
Date: Sun, 01 Nov 2026 17:19:49 +0100
Message-ID: <87ik2g7cd6.fsf@pond.sub.org>
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
X-Mimecast-MFC-PROC-ID: 81i32ubXFNZG8g8DdnboqICvyAmdMmMho3i2N65HMtA_1793563975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Introduce a minimal struct that pairs a QAPI type's internal name with
> its "masked" introspection name. Generated constants of this type will
> let QOM property registration carry a reliable reference to the QAPI
> schema and possibly other associated data.
>
> The fields are populated in following commits.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qapi-type-info.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.=
h
> new file mode 100644
> index 000000000000..6a6355568325
> --- /dev/null
> +++ b/include/qapi/qapi-type-info.h
> @@ -0,0 +1,31 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QAPI_TYPE_INFO_H
> +#define QAPI_TYPE_INFO_H
> +
> +#include "qapi/util.h"
> +
> +/**
> + * QAPITypeInfo - QAPI type metadata
> + *
> + * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
> + *        QOM uses this as the property type string.
> + * @masked_name: Name of the type in the QAPI introspection schema, assi=
gned by
> + *        scripts/qapi code generator (e.g. "368").
> + * @lookup: QEnumLookup for this type, or NULL for non-enum types.
> + *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
> + *        all rely on it.
> + * @list: The list-type counterpart, or NULL if none exists.
> + *        str_type_info.list points to strList_type_info.  qdev array
> + *        properties follow this to find the list type for their element=
.
> + */
> +typedef struct QAPITypeInfo {
> +    const char *name;
> +    const char *masked_name;
> +    const QEnumLookup *lookup;
> +    const struct QAPITypeInfo *list;
> +} QAPITypeInfo;
> +
> +#endif /* QAPI_TYPE_INFO_H */

As far as I can tell, @name is used outside tests only for an error
message in object_property_get_enum(), and I'm not sure that error makes
sense.  Observation, not a demand.

