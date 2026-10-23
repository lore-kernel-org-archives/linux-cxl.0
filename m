Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749911;
	b=Ql7GbeELRwr1v0f5sJI5Il3j4CXWPOl+T1HhMfBxYUkihD6kE3NFhbhH/X9oNwte5Uv8
	 oIOa/G1zlg4kQ6J18CsXkHW70Kar6sgmU94FeKYyC+2B4T/ncCvaW7HR08sIUzLds1WAu
	 5IUcUes9kqpScS/B7SrSrP1URDpnW7MVlLjJwuhVRSqncdZ0jHzMflXf+n9wwm+bDR9Wm
	 +jatDWa1Phw4pVTBTg7OFw96hnsw3cbQ5uIEc+nlPyztL2GfQAbmq4Oe9oFCTjeWDBkBG
	 a21XsKHFyboOOOp6E53wDTYim5okBs8ziWzsX2liYvbpRx9fEQDBnbGeqrVNvlqLPzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749911;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:In-Reply-To:User-Agent:
	 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=Z1/M6fHwVdsOcXm3ypxN6/mMXkslI/t6HGQAVs7BRk8=;
	b=AJvtN7XEKtRafh9XxB/gmARSnsoLnQiIDqJPA8Isd6T9S6OnaJVX84a9PjQo8f6SiVc+
	 8VomOaOIGiEGeKVdoqWMQvFasgmH65E4Lsw2t5f4gT0PSfA1sLoQK8a2gsV9jKdGPE2QQ
	 TsR/rpVCSYNM0XWruNc7L4viEEBCTOVqcEQUAH8ujsfIzlo1rknoOLC9P4pn6pP3onfip
	 +72DKcXAx0x9vyrhx6fym2SGyEHMwqRAt9EvFp5MWAr5QUEglgKmbHVSnxjxoMe/BuG9L
	 PwTbF9IZDls6jUPVYNbmOpDCKGqE7DoOEBUIX91iWjzu0NBYdwuoDuLsZC1aFrmfu0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QngC8xHX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C505606A31E
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 10:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C505606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QngC8xHX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792749908;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1/M6fHwVdsOcXm3ypxN6/mMXkslI/t6HGQAVs7BRk8=;
	b=QngC8xHXH0OPqDivJ1ziVXbqfPysZl6EuqroX4C1Xv60D2iy54LisFw6iHKuWuY02UFdJt
	KkzbOmuyaoJSFcrN/qcETrsFise05H/oaxb+2wa9afNzphrFOidX7B6+tw65dhPZ9k75Ed
	qyN/gzwEOHKmQfumhcQi9iia8N5BhkU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-DdROSvANPzCaudLkmMT02A-1; Fri,
 23 Oct 2026 06:05:04 -0400
X-MC-Unique: DdROSvANPzCaudLkmMT02A-1
X-Mimecast-MFC-AGG-ID: DdROSvANPzCaudLkmMT02A_1792749899
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9704D1956057;
	Fri, 23 Oct 2026 10:04:56 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18FB21956088;
	Fri, 23 Oct 2026 10:04:31 +0000 (UTC)
Date: Fri, 23 Oct 2026 11:04:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
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
Message-ID: <atsxLV5YZo8dr-8G@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: eSHZzbSrxfrb46fVX-brxRL2QKBZdoQOGoMCk3qW43I_1792749899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-André Lureau wrote:
> PciDevfn is a bit special, since it accepts integer and string as
> setter, but only output integer as getter.
> 
> Unfortunately, we can't declare an alternate str|int QAPI type for it,
> since: branch 'string' can't be distinguished from 'integer'
> 
> Rather than declaring it as "str", use the common type instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 5bfdfe1ab9d9..3381de1144d6 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
>  }
>  
>  const PropertyInfo qdev_prop_pci_devfn = {
> -    .type  = "str",
> +    /* The formatted string accepted by the setter is a CLI convenience. */

IIUC, this is not limited to the CLI, it will work anywhere the JSON
syntax is permitted which is both CLI and QMP.

libvirt uses this string syntax:

  -device '{"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","bus":"pcie.0","multifunction":true,"addr":"0x1.0x1"}' \

> +    .type  = "int32",
>      .description = "Slot and optional function number, example: 06.0 or 06",


Changing the type to 'int32', where 99% of usage is input only
and string based, is pretty unpleasant. Even more so that the
description doesn't even mention encoding dev+function as an
integer.

>      .print = print_pci_devfn,
>      .get   = qdev_propinfo_get_int32,

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

