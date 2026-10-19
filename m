Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322148DB3A
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397344; cv=none; b=BO/5qE8Q7UJQrsgOleaUTsmSY0GxFNKCj9hhU0ZBfKHCbb3/M6Shdp2zSiphJCEkVOEvlbsaKhovhRbYGWVM+pLyKdyGVTpOYmRI5y2ZrPmuNXlbEPNQ0BxSYPXPbVtu436LGmYdy3aGOBMz9KT6P6AFjgMx6E8kPMahTUGHVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397344; c=relaxed/simple;
	bh=yTNLjI6t4sGtGGdV8xOavbv8Dqr3RZ+nxd5LCXSnQa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XbisIxs0Udqiq4ifc2WtrLzgxipTG39uWGKCtx1jDiowl5n8KN5OrOUHZi92sPLDtXakMPS82fzl9CG2w6rgtYghEnwi4fPT33Fl1mLnCL4KKKPPMSJFZHwZYFRMjsdaNvNC97y1HsOUIvHzFHDSzzzV78mLc3p/mKmnQNNUVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM5YqcOq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM5YqcOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792397341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=ZapaecIeMcbF8m3IzNayfIxAgM/GC5btRJ9Thst8mm4=;
	b=FM5YqcOqh2ZTeEybS6iPN55IL/PYPFLEWqSwxlKoHk5XI3Ijor3L+tKBn2VGrk8BbfiHbd
	mRyRLIiM96EmQWGb/2vIQxWYdXQ/ceCoQGTxxQDvRmInOdY/Q+74mfjdPt9HDNdVOcJ6J9
	0No35DGthZ6FwwHarYM7bb32t1pS4e8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-n_tiRJwNNgazkRIzb2Z2Gw-1; Mon,
 19 Oct 2026 08:08:56 +0000
X-MC-Unique: n_tiRJwNNgazkRIzb2Z2Gw-1
X-Mimecast-MFC-AGG-ID: n_tiRJwNNgazkRIzb2Z2Gw_1792397333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95FF018001E6;
	Mon, 19 Oct 2026 08:08:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B10471955E70;
	Mon, 19 Oct 2026 08:08:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DC3D421E6A04; Mon, 19 Oct 2026 10:08:47 +0200 (CEST)
Resent-To: 17746591750@163.com, graf@amazon.com, FangSheng.Huang@amd.com,
 michael.roth@amd.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 steven_lee@aspeedtech.com, andrew@codeconstruct.com.au,
 palmer@dabbelt.com, foss@defmacro.it, sebastian.huber@embedded-brains.de,
 jiaxun.yang@flygoat.com, lizhijian@fujitsu.com, edgar.iglesias@gmail.com,
 jasowangio@gmail.com, leetroy@gmail.com, liwei1518@gmail.com,
 npiggin@gmail.com, zhangckid@gmail.com, titusr@google.com,
 wuhaotsh@google.com, arei.gonglei@huawei.com, berto@igalia.com,
 zhao1.liu@intel.com, its@irrelevant.dk, joel@jms.id.au, clg@kaod.org,
 conor@kernel.org, david@kernel.org, jic23@kernel.org, kbusch@kernel.org,
 sstabellini@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, lixianglai@loongson.cn,
 zhiwei_liu@linux.alibaba.com, maobibo@loongson.cn, zhenwei.pi@linux.dev,
 qemu-arm@nongnu.org, adityag@linux.ibm.com, qemu-block@nongnu.org,
 amachhiw@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, kfting@nuvoton.com,
 den@openvz.org, daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, chao.liu@processmission.com,
 sam@rfc1149.net, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 alistair.francis@wdc.com, anthony@xenproject.org,
 borntraeger@linux.ibm.com, brueckner@linux.ibm.com, farman@linux.ibm.com,
 harshpb@linux.ibm.com, iii@linux.ibm.com, jjherne@linux.ibm.com,
 milesg@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 rathc@linux.ibm.com, xen-devel@lists.xenproject.org, luc@lmichel.fr
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 19 Oct 2026 10:08:47 +0200
Resent-Message-ID: <87v76y159s.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Amit Machhiwal <amachhiw@linux.ibm.com>,
  Alexander Graf <graf@amazon.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  zhenwei pi <zhenwei.pi@linux.dev>,  David
 Hildenbrand <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,
  Alberto Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
  Luc Michel <luc@lmichel.fr>,  Zhao Liu <zhao1.liu@intel.com>,  Jonathan
 Cameron <jic23@kernel.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
  Samuel Tardieu <sam@rfc1149.net>,  Marcelo Tosatti <mtosatti@redhat.com>,
  John Snow <jsnow@redhat.com>,  "Denis V. Lunev" <den@openvz.org>,  Song
 Gao <17746591750@163.com>,  Bibo Mao <maobibo@loongson.cn>,  Xianglai Li
 <lixianglai@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
  FangSheng Huang <FangSheng.Huang@amd.com>,  Tyrone Ting
 <kfting@nuvoton.com>,  Hao Wu <wuhaotsh@google.com>,  Jason Wang
 <jasowangio@gmail.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Nicholas
 Piggin <npiggin@gmail.com>,  Aditya Gupta <adityag@linux.ibm.com>,  Glenn
 Miles <milesg@linux.ibm.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
  Conor Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
  Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
  Halil Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,
  Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
  Matthew Rosato <mjrosato@linux.ibm.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
  Zhang Chen <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,
  Peter Xu <peterx@redhat.com>,  Chinmay Rath <rathc@linux.ibm.com>,
  Hendrik Brueckner <brueckner@linux.ibm.com>,  kvm@vger.kernel.org,
  qemu-block@nongnu.org,  qemu-arm@nongnu.org,  linux-cxl@vger.kernel.org,
  qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org,
  xen-devel@lists.xenproject.org
Subject: Re: [PATCH v5 35/62] qom: convert scalar properties to QAPI-aware
 registration
In-Reply-To: <20260911-qom-qapi-v5-35-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 11 Sep 2026 20:35:09 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
	<20260911-qom-qapi-v5-35-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 09:41:59 +0200
Message-ID: <87jyne2l2w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: vOI1NvMcp56WF1k6_JjTh7ueE5_5K-kVoZvcyiftrSU_1792397333
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 872920b6482b..4e5d8d9f86e3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4258,7 +4258,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, const void *data)
>                                            "Set on/off to enable/disable =
high "
>                                            "memory region for PCI MMIO");
> =20
> -    object_class_property_add(oc, "highmem-mmio-size", "size",
> +    object_class_property_add_qapi(oc, "highmem-mmio-size", &size_type_i=
nfo,
>                                     virt_get_highmem_mmio_size,
>                                     virt_set_highmem_mmio_size,
>                                     NULL, NULL);
> @@ -4266,7 +4266,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, const void *data)
>                                            "Set the high memory region si=
ze "
>                                            "for PCI MMIO");
> =20
> -    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
> +    object_class_property_add_qapi(oc, "virtio-mmio-transports", &uint8_=
type_info,

scripts/checkpatch.pl gripes

    WARNING: line over 80 characters

Easy enough to avoid.

Many more below.

>                                     virt_get_virtio_transports,
>                                     virt_set_virtio_transports,
>                                     NULL, NULL);

[...]

