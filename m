Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755581;
	b=hEzy/PKkB8RYP/Z6d34xuIACyQD303ocDToSX4pAKdQEY+/oD7Yb87IlzZR5643K+pFt
	 ZMvq0RH7cDKzXgBt7RdEvj33ElkmdAL3T20J5qrvrmQlggERZ+w7TZVrXwtRLIYvwmBeW
	 aVwXZbuLJ/oJoFrIT57blRG6CyRydv02MpcGbvdEYpKLuYqv9sLX5kRmV5c/lU1h8Xf8h
	 lgdTXOgYbonpDGdFXxeoNZweeJUxtdzh+7Pzl738C93iE+51VBPaaNKLeFCfDMBaAQDWw
	 US7DmL4cGHETFs52N5zIZXTRLF5MuS9tDh9MIA2NVdqGWdRrdn7GwZmtTvK5VR7ruNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755581;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
	b=sEhpf3W9tyvSQhj8vIxVr0i3Jl7uTN1+K+dCEFDO5RrZKJcpHwdlcuGZuhOgFA19IBZy
	 xdekFeSlckfsnRctXo9bP/G0PaCArcKb7CSFprUA0JNWglYCC8M6s9ipWYMZPRQ+sOm2V
	 kBe6tQncLNZIv4NU0rVgQwnvSgzWfS4yBF7PCVuJceJn2W805s1xZgqSGyo5VKqP8PnCh
	 dQSl36w9lZYdXBCTRLV5Cfni8K3SNejJzIdu+aYhXzuF6kND3rgXta+OMyUgr6MbD0C02
	 3Vu+6uWOcluS70jecTyvfwr+0H2DcPftG2b1Yfc1Vp/828VakgCVaiTvXzWuf/hJdGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Whi4fzZ+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0F606A31F
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 11:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C0F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Whi4fzZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792755579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
	b=Whi4fzZ+cyviZzxv71juAgjpVJitS5XjsyO+QV55cNi7GCOyWpm6ayYmRYj3SP/+YCCjiF
	k4o++yz6275qr0i2J2IHIRTQOomZys5gzBjeiq+AWHErXYQXWea5QMBLsBnY4tsU8pnEvG
	rZbJUguFqqCk7l7gSOHxCM8kLuO8Ats=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-cCQsb_IpOTGXBAsCChVYvg-1; Fri, 23 Oct 2026 07:39:36 -0400
X-MC-Unique: cCQsb_IpOTGXBAsCChVYvg-1
X-Mimecast-MFC-AGG-ID: cCQsb_IpOTGXBAsCChVYvg_1792755576
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab868fe362so1354351a91.2
        for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 04:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755576; x=1793360376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BwZKJ1y9GJGdttliesnC6UNJffqn1NZdo/yH29SzxfQ=;
        b=JPoLpfmcM5GW7RtYxri59K/2U3P6tneyH/nnz76LDBqHacWylmmcRD5ahbGIMsH0i1
         8EdU6lD1PiNboOpbx8tc5zWh8CwcgRtmXi1nCz+ztJEW7KGF9gKpoU8wEWSFMxbNvmun
         KD6QB1SL9OK8SlTF1zbA6QehfsGXcbHMMtK/XZ1ajHCeOJh2RrZf1dZzknaI6pL4hUcb
         RiHoNhNN5xzN88KtLz4hfkZ6bvZ8eUuY5OL4FlJ836Z4EC5MOO3n1/Em3/pp/Hvzni3D
         H3SfbFmNtnQGAIYdGsAL4OHU0J/y05yN59DuX6wE98BXafktUo8eYO7JZpyKOkW9iEi/
         J99Q==
X-Forwarded-Encrypted: i=1; AKwUvBxaMaJhhHMZIVbmi6PVbt6V/4MOxbYquPLjNtcdMXKysxMfqGO3IQVxh6p1g8aVjxno8Je9rGi0ZPA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoa4ShUkGU0rbmVrdxX/lL4sXoa1LPTq8B775CGkQcDUTP6xwF
	Gt1dAEEBJh+XwhnJ0lqTQmvBNhgpUbl0hX4XSs/kmgKR+whTU52e/CTEpzJLtXipyod4tQIg2pC
	fbsl4OJ+zrskXhPa/gRnf7KIablSxuhrzDdCJ6iY9w7wEbEm4Z/OCdBlPkVb+OyxcQRmRBZix8A
	cGJoNTXgDyIau8tuXdw9Pdv5AS1UujAG6nrkB+
X-Gm-Gg: AYBFou17K0vqXm3PurNd2o7oMKbnyGCJkO9gnZ2nm4nlvtgb7QvwhD5+mWuada6FYRh
	BNlo9saaaeq9vGCZ0lFsMR2zcRsmmVnf9i50yfM1yVmfcd+PXF7OXyEA3Ep0Zzn4CG9gA/wLFxF
	t6KA3p8Z0aVy3mMKa9wbaTsy+K+NUT/pIUMl3vHaCUSHZ/J30hwqAMPKjlYIBRr8dfHGaTCfjFt
	fW63kgY8HeUjmUkZmFbiDW7fJ1BGBwPQCX3rwpb/0qkzV74GoGo4HhAoVpEIH9mGN5TwC0qxWMn
	1A==
X-Received: by 2002:a17:90b:4d06:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3adce45dd72mr1525583a91.39.1792755575399;
        Fri, 23 Oct 2026 04:39:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:3ac:ffb8:1809 with SMTP id
 98e67ed59e1d1-3adce45dd72mr1525520a91.39.1792755574796; Fri, 23 Oct 2026
 04:39:34 -0700 (PDT)
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
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com> <atsxLV5YZo8dr-8G@redhat.com>
In-Reply-To: <atsxLV5YZo8dr-8G@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Oct 2026 15:39:22 +0400
X-Gm-Features: AclHuK9JciU6rOmPmxGP7LAL0cKom9fJOgwoGNnQZ4aTaCAv64YMDSwyPsEK5ck
Message-ID: <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
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
X-Mimecast-MFC-PROC-ID: 5oVQ3Goc40YChyKneQ0ViWMO4IWlfGnNkP8GwlJCwdg_1792755576
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > PciDevfn is a bit special, since it accepts integer and string as
> > setter, but only output integer as getter.
> >
> > Unfortunately, we can't declare an alternate str|int QAPI type for it,
> > since: branch 'string' can't be distinguished from 'integer'
> >
> > Rather than declaring it as "str", use the common type instead.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties-system.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-system.c
> > index 5bfdfe1ab9d9..3381de1144d6 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Pro=
perty *prop)
> >  }
> >
> >  const PropertyInfo qdev_prop_pci_devfn =3D {
> > -    .type  =3D "str",
> > +    /* The formatted string accepted by the setter is a CLI convenienc=
e. */
>
> IIUC, this is not limited to the CLI, it will work anywhere the JSON
> syntax is permitted which is both CLI and QMP.
>
> libvirt uses this string syntax:
>
>   -device '{"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","=
bus":"pcie.0","multifunction":true,"addr":"0x1.0x1"}' \
>
> > +    .type  =3D "int32",
> >      .description =3D "Slot and optional function number, example: 06.0=
 or 06",
>
>
> Changing the type to 'int32', where 99% of usage is input only
> and string based, is pretty unpleasant. Even more so that the
> description doesn't even mention encoding dev+function as an
> integer.

This is purely a metadata change, the setter still accepts both str &
int, so I don't think this change blocks this series. But I agree we
could do better.

There are multiple options. We could keep declaring the property as
str instead. In this case, the getter should probably return a string
for consistency and correctness. This might surprise some existing
users though.

We could introduce new properties like `devfn-str` and `devfn-int`
that alias the same value.

We could also introduce a new structured QAPI type.

Markus, what's your take?

thanks

>
> >      .print =3D print_pci_devfn,
> >      .get   =3D qdev_propinfo_get_int32,
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

