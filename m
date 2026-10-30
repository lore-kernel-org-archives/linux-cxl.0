Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362289;
	b=ezpw/xU12hw2aImpnQArum+pMFNHEsJLK5TSkMECZXVGYOo8H7qbUzikLwTo1xg9iEFY
	 aomPI7xw4VupcorRv0cFb1bgqrxhuWxSF22izEpgoT0s9WwwY8gUf+4kI79aHkhCjTnTA
	 hIvLrlyNiuTahppc8zcoLVgVC+RBlT9sNiFEWiRKx0vtsAQx3/Ig3M09ol3TV/6HYxnog
	 CH0ZPBOBle4MwieBS9KL/Drp+WE5//ANrSwqKX0WW8hV12BplHtl+GBXCC8neMOz2EKCq
	 h3xMSILvx0EelqqEPlRdYIeCjq06rAw5ufM0v7EZErdpoDawMz+VLGoTjTxe/eLUfeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362289;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
	b=cQlw2+z9SY51U5R5zhebYg556b9dnGQQGJRPEMKdd3y0zAFTmjBxLMccktWRuxS1YX0U
	 RsFFTNgiapX3rymsNVI4VzsNAFvPLmtTh3dsegORfv11QuErvbNG19xdb9BoaVJJonZ+Q
	 DWYUibEuE3+vhBPl5o1pzZ5A+b5FZzxUw4G4foVWe//ZrGnS7YkxCDGu13wW2NnJkwZ7D
	 t3VH2ZiTas0ybHLr0K+l1mTVrXQIumtRTFkR99PMrriObIjHCCeKSMluqM6DbozqdpRtU
	 f4v5W+DxjDR3OlKmli2IgOkhiLshIAaRCtVpRxrrVqsBNmhvCsYV6YZs7erw3REdGyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQOa9Uir;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24164606A31D
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 12:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24164606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQOa9Uir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793362288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
	b=DQOa9UirA6se8ZCtd6+NTOnhD+doNcFc0nnF7SrxG0Z5hU6s9serkhqSYEbgiXgwZw06OF
	hZgx5XaA3oeXgcATPEpShBrCsyeOnFA/WaOQiZUlSliLje0nVI6mY7COfw+SoFzZpyXpMB
	6EFPzdJC+ekBxnQl7+b8bjR/3OIUOMI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-MRchj5beP2CRKRE4Ki5cSg-1; Fri, 30 Oct 2026 08:11:27 -0400
X-MC-Unique: MRchj5beP2CRKRE4Ki5cSg-1
X-Mimecast-MFC-AGG-ID: MRchj5beP2CRKRE4Ki5cSg_1793362286
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so723105a91.2
        for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 05:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362286; x=1793967086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huheSnuaAH41QXuP+wJKnnRPWFroH2JWTjHVE5i6hXA=;
        b=Mxa7NGqCV0PFaglL3jCyF6EPxod8HMXOSvu7kUC53+a9P/hAAf2OrcYlbBOK2y69J1
         aKfIbBOZt1QDjEs/rROSfUVb/zpIvzZobZcEoDpSvT1XeCaHaRtc4R/l9IEpH0DXQqBu
         YYrHU633TzH9eLzmPdy8iizTSgMpuJ/gBGNyqIJ4YJ0ucOvaJoPk/STYIFpZ/8Kxsuw8
         1XZXSRL0Fu0iYvqdRQzax82EvcB1wSsR+fZoJKCdq4jP8M2MQp/CMbQgC92G/s7g9LXZ
         BBdbE2HQPqhfCJwZB56lUWJB6Kf6JKRAY5N6/Nn3IeHRrmNHBW1IPy26bGV3SL2/0/vX
         M/Vg==
X-Forwarded-Encrypted: i=1; AKwUvBxxhU8RdzHH1wMbPxhnYd2rgpIozUHmhwoVvzUytJrUYARy2N4EZbkvx5OAoBU5DRYfXHccKOkjbUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQWQj9qty+QkWnW6pTAPTZOsL7DEt3hwIRVftx3suMt4CUrFbM
	tSRBqfBx4w3yGfqVQVrtQK4m6f+ZVF9B4AkY8A0YhhjAua8b3OEj/mG+1cxVoJkH5Fy2U8RHOO/
	ZfciE/CpZKtV/gOnQiUjjTDXBuHgH4q0Ra9X4WLMNcLZ6RcNFJNt/1f94e7sLJuUFwRy8VpnrwD
	NXtoS4xFZBIcdXIg8XE1JFsAT2JJhr+ETQMcw7
X-Gm-Gg: AYBFou3I6eLr6Sw5oxGqpZPgStlMhdkQC9c85hXpfUY3peECzGpHhL4YdD0jPqygqYN
	pzJGUfSG+1gGLMBglIIM6437eSyGAxnYx4OuUqOqbQYQ8KtTrBPPiAsK7yAa2JiNeWUQ+hqFpws
	kBZ263uZgkjR42vvHy7rJJxQIxijx/VBOCeL539DqypBdpijF5OW+QDPYKAQ8p4QknCauus7LJE
	sQxw2f98VdpZE/bqgcRi0+pDsSnqGX3xIMutG7HXmVeAsmRMAQSgQKYjgCy22j1R5WEO27jHULT
	cQ==
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ae8980bd04mr1669715a91.50.1793362285589;
        Fri, 30 Oct 2026 05:11:25 -0700 (PDT)
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id
 98e67ed59e1d1-3ae8980bd04mr1669589a91.50.1793362284955; Fri, 30 Oct 2026
 05:11:24 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-17-431a86b02b58@redhat.com> <871p97a4mf.fsf@pond.sub.org>
In-Reply-To: <871p97a4mf.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 30 Oct 2026 16:11:12 +0400
X-Gm-Features: AclHuK9SdcKVottvuTeAWY4qSYFB8MXW7mNBnZIWRbyUXQq4NjRMq0jo7wIcSr4
Message-ID: <CAMxuvayHXMftaQP6X_14pAf63bjX8mXxsW4TsXnLf_wbOq6eUA@mail.gmail.com>
Subject: Re: [PATCH v7 17/65] qom: add object_{class_}property_add_qapi_enum
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
	John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
	Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jagannathan Raman <jag.raman@oracle.com>, 
	John Levon <john.levon@nutanix.com>, Thanos Makatos <thanos.makatos@nutanix.com>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, linux-cxl@vger.kernel.org, 
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
	Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
	Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
	Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
	Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
	"Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
	Ani Sinha <anisinha@redhat.com>, Luc Michel <luc@lmichel.fr>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
	Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
	FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
	Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
	Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
	Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Conor Dooley <conor@kernel.org>, Sebastian Huber <sebastian.huber@embedded-brains.de>, 
	Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony@xenproject.org>, 
	Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
	Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
	Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
	Tao Tang <tangtao1634@phytium.com.cn>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	Fabiano Rosas <farosas@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
	Artyom Tarasenko <atar4qemu@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
	Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yyGFfTbj_lRpuBB8kRRVq0lbAdWx3YbxofJlGMNxObc_1793362286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 30, 2026 at 2:02=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++++++++
> >  qom/object.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  2 files changed, 159 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index eb61d8842b80..e04be4caed57 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -2027,6 +2027,80 @@ ObjectProperty *object_class_property_add_enum(O=
bjectClass *klass,
> >                                      int (*get)(Object *, Error **),
> >                                      void (*set)(Object *, int, Error *=
*));
> >
> > +/**
> > + * struct QapiEnumProp: Descriptor for a property backed by a QAPI enu=
m type
> > + *
> > + * Binds a QOM object property to a QAPI enum, providing automatic
> > + * string<->int conversion through QAPI visitors and optional
> > + * default-value initialization during object instance init.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> > + *
> > + * @name: property name exposed on the QOM object
> > + * @description: human-readable description (shown in ``-device help``=
, etc.)
> > + * @default_value: initial enum value applied via @set during instance=
 init,
> > + *                 or -1 (the QAPI_ENUM_PROP default) to skip initiali=
zation
> > + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> > + *             (provides the string<->int lookup table)
> > + * @get: getter that returns the current enum value as int, or -1 on e=
rror
> > + * @set: setter that receives the enum value as int; %NULL for read-on=
ly props
> > + */
> > +typedef struct QapiEnumProp {
> > +    const char *name;
> > +    const char *description;
> > +    const int default_value;
> > +    const QAPITypeInfo *qapi_type;
> > +    int (*get)(Object *, Error **);
> > +    void (*set)(Object *, int, Error **);
> > +} QapiEnumProp;
> > +
> > +#define QAPI_ENUM_PROP(...) ({                                        =
   \
> > +    static const QapiEnumProp _prop =3D {                             =
     \
> > +        .default_value =3D -1, __VA_ARGS__                            =
     \
> > +    };                                                                =
   \
> > +    &_prop; })
>
> This is a cute and reasonably well-known macro trick for optional
> keyword arguments in C.
>
> The example [*] below specifies all arguments.  What happens when we
> omit any?  They default to zero via default initializaion, except for
> .default_value, which defaults to -1.
>
> Trap for developers: some arguments aren't actually optional!  If you
> forget to specify @name or @qapi_type, the code compiles, but crashes at
> run time.
>
> Not a fan.

Agree (not a fan of C either). We could probably add more
static/runtime checks. Or clearly state that there is room for
improvements, or just drop it altogether - either as follow up or with
the series. I leave that up to you since you are going to respin it.
thanks!



>
> > +
> > +/**
> > + * object_property_add_qapi_enum:
> > + * @obj: the object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> > +
> > +/**
> > + * object_class_property_add_qapi_enum:
> > + * @klass: the class object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> > + * inline. If .default_value is not set, the property is not initializ=
ed
> > + * (default_value is -1). Otherwise, the setter is called with
> > + * default_value during object instance init.
> > + *
> > + * Example::
>
> [*]
>
> > + *
> > + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> > + *       .name =3D "policy",
> > + *       .description =3D "Set the NUMA policy",
> > + *       .default_value =3D HOST_MEM_POLICY_DEFAULT,
> > + *       .qapi_type =3D &HostMemPolicy_type_info,
> > + *       .get =3D my_get_policy,
> > + *       .set =3D my_set_policy,
> > + *   ));
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_class_property_add_qapi_enum(ObjectClass *klass,
> > +                                    const QapiEnumProp *prop);
> > +
> >  /**
> >   * object_property_add_qapi:
> >   * @obj: the object to add a property to
>
> [...]
>

