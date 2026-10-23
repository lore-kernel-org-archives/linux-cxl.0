Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757091;
	b=on0PqeyZGSCmK3P/JWFdtnWZ9FDgjy9bPW1nJMpMOLtTcRYS5AGqR3EklZdS4feHMgd4
	 /Xw4doe/CXX0H6aTHZ0ybM5aykrpVVGGru0qsv6uBAX4D7BZDWS1IRxK1VDNF826V/qKs
	 YViyiCflbobXOqMSZSaun7y5vWyNTnMlC3RezmtKk8hNXjytpysRjFTsEX/Hi7puX+pVS
	 Ber4Fw5LBGkZkMkLvrZPMkKnhp7nYQoGoxTG5NeYcGsKB+oiTRATi6l4xAqPLdKJAQnEC
	 WtZbbA2WQ7ZtMQdtMhcAel2w2xe+rfyEEvoad01viBOomva2tYcWT12EjJGgxa0DH3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757091;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=ktFG9S7cIu86S66z6woz0uEJeRaYlQD7UfoTSNONZWI=;
	b=L0szaZ4sFQs0yaRetI/mLAi36NC2rKmucHeZSnXVeuAmUth+jrVs3BitObSviWrtUaG/
	 XS+NLUM1z01UrhmhEZ5DQSYZ7U7gkgMTi5uCmGhWCv3b6VePDU/0o4oq88MLNLqg9VzSf
	 qP2+4AyjFeoAmGBV8et21NSbhqzB/lWLhIIQdZemKX9FRJsEEXRn/DGii9zLmko8YZt4E
	 QG6gMoUbVrfKQSwXwMDQBrXM/GdGjSZxY8BoNge1JHegZ0FXKnO1o2dG8kGwIfFBM7ivp
	 WxF20tzYYzHSyuoGCWlm3dT9klqze5Ls7Xo/FIpyCtwUx08bFMHQwMuAGcnDqIMAhNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S2kPSjLf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3015606A320
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 12:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3015606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S2kPSjLf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792757090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktFG9S7cIu86S66z6woz0uEJeRaYlQD7UfoTSNONZWI=;
	b=S2kPSjLfswkW3Ui3xIO+tGRdKjde7UuboyKe4nd9SiW3pwvCp+DmA+bPsGEQxQvMX+lXgm
	51hDMNY3Sw0Ikl2ujEMg3cosUeHuTxlVRo8XrNvYPSDbRd04ZQ6qHxRItUFTQXCRx/nd9a
	3lw1bbqGLdOu4BHQgojdUARnmCRmZzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Whbz8MVfM3q9d4_kfv2eNQ-1; Fri, 23 Oct 2026 08:04:48 -0400
X-MC-Unique: Whbz8MVfM3q9d4_kfv2eNQ-1
X-Mimecast-MFC-AGG-ID: Whbz8MVfM3q9d4_kfv2eNQ_1792757087
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso680638f8f.0
        for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 05:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757087; x=1793361887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ktFG9S7cIu86S66z6woz0uEJeRaYlQD7UfoTSNONZWI=;
        b=Kc6GeZLp6eGQ/xqeCa/dyTB1cQ1Ajdkc/2VBasWp/y3HHXnG4x1VPZtVT8OUFZUE7D
         RxLK/kvl60853iB5VcDkuZvDhecM1ymnJniBegOWNDSIIVRJEUpsN1Ix9iypxKk4B0dz
         6aMB1WEoQgG4OBxpmYsbthNEcsaVHkB9e9j5ClxzLCv92rISaLcrvDzK+R+FkfwUggr3
         z+EAeUPpGCUWynTdY21WfODK5acZhwM0Cp8xgMxeVo56gvKfw+StCS6/FgQnaSatGxne
         a0bk1UZlDe7dqE19KDDMl+LDU5rVJYDTBlIeen351+csg+DYBIKLFiHUtlvjXILPY7CO
         OjxQ==
X-Forwarded-Encrypted: i=1; AKwUvByKXUoh8fox0Y+p4rz+UqTaRpHvQ344BKjEXpe1yOc7Gy36BDgqLTICD5t+AamM5hLhAEEpqSLvPV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKM7bm7Lz7i3D4fwFj0FArAI8jRLR/2d3tFoAzWTnpKo9118eNf
	dNyi7RdjwlhI21D83JyjxBxFvDEX+OxyZteKC3705fmm7ywANzj/SSE0oh3xKMM5nEo6hRCdAxw
	r86QloSWExMJmaE2HMzv9PBff5Bihj59IEr21HnVSFBeXtUeB126B3az4r3g6ew==
X-Gm-Gg: AYBFou1YMmmbZp9n7Wr6RRsiQB+vFju+LMyOOQVGzQh0l2eVg6Gtr0xxryd+ckTypeW
	4EXHKXXlH8kkSbhnHsc36iH8ryXW1ctasz1D1+kHTqS5yVZ4rrZHt5R06BnEC+RKjGDQv4etpfh
	OZnwaDVtgNYSS4s08KekqcoJ0Day9wrpPVOgAkfvzbK5atBc9sVTjTuF9b6148ppPGTgrAbZAzz
	NlETX7ZJugMKte6G/mVFKSN8HSXlLdAXAhbLeYvsro1xKN1BQeYtGJkvKXv0rgZujohkTtNgs0e
	r/hLzS84tR3jc0CNjHs2i8BRNH7Ml2y85fy2ZoirX+8HL9RgmlyzujHS33JV+I8oCHm7AJ8=
X-Received: by 2002:a05:6000:4a0a:b0:48e:1299:663f with SMTP id ffacd0b85a97d-48e385b0d95mr3400660f8f.56.1792757086690;
        Fri, 23 Oct 2026 05:04:46 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0a:b0:48e:1299:663f with SMTP id ffacd0b85a97d-48e385b0d95mr3400583f8f.56.1792757085931;
        Fri, 23 Oct 2026 05:04:45 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edce4fsm5022761f8f.6.2026.10.23.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:04:45 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:04:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>,
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
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>,
	Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	Jagannathan Raman <jag.raman@oracle.com>,
	John Levon <john.levon@nutanix.com>,
	Thanos Makatos <thanos.makatos@nutanix.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
	linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org,
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
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
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
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
Message-ID: <20261023072206-mutt-send-email-mst@kernel.org>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
 <atsxLV5YZo8dr-8G@redhat.com>
 <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: arCbQqE8lRG_GSFz4m6Ep9kUDumaUHg-wlSSemfOpuM_1792757087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 03:39:22PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Oct 23, 2026 at 2:04 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-André Lureau wrote:
> > > PciDevfn is a bit special, since it accepts integer and string as
> > > setter, but only output integer as getter.
> > >
> > > Unfortunately, we can't declare an alternate str|int QAPI type for it,
> > > since: branch 'string' can't be distinguished from 'integer'
> > >
> > > Rather than declaring it as "str", use the common type instead.
> > >
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/core/qdev-properties-system.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> > > index 5bfdfe1ab9d9..3381de1144d6 100644
> > > --- a/hw/core/qdev-properties-system.c
> > > +++ b/hw/core/qdev-properties-system.c
> > > @@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
> > >  }
> > >
> > >  const PropertyInfo qdev_prop_pci_devfn = {
> > > -    .type  = "str",
> > > +    /* The formatted string accepted by the setter is a CLI convenience. */
> >
> > IIUC, this is not limited to the CLI, it will work anywhere the JSON
> > syntax is permitted which is both CLI and QMP.
> >
> > libvirt uses this string syntax:
> >
> >   -device '{"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","bus":"pcie.0","multifunction":true,"addr":"0x1.0x1"}' \
> >
> > > +    .type  = "int32",
> > >      .description = "Slot and optional function number, example: 06.0 or 06",
> >
> >
> > Changing the type to 'int32', where 99% of usage is input only
> > and string based, is pretty unpleasant. Even more so that the
> > description doesn't even mention encoding dev+function as an
> > integer.
> 
> This is purely a metadata change, the setter still accepts both str &
> int, so I don't think this change blocks this series. But I agree we
> could do better.
> 
> There are multiple options. We could keep declaring the property as
> str instead. In this case, the getter should probably return a string
> for consistency and correctness. This might surprise some existing
> users though.
> 
> We could introduce new properties like `devfn-str` and `devfn-int`
> that alias the same value.
> 
> We could also introduce a new structured QAPI type.
> 
> Markus, what's your take?
> 
> thanks

I like the idea of a structured type. Will be handy for other things.

> >
> > >      .print = print_pci_devfn,
> > >      .get   = qdev_propinfo_get_int32,
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> > |: https://libvirt.org          ~~          https://entangle-photo.org :|
> > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> >

