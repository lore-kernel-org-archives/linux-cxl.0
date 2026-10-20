Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493477;
	b=ls18V1y/xvUkriBI5750Q76hiaYDxU3sVuGFtu0Ml7UrsVy2XXF22zaQeoYE23S9sgvr
	 IrAuCKvxjdUnrzG+6Wg1epU9yCDa9J/UczK9H611D5MeDgaoUtxJpGQPXdMszpiRI2Wpg
	 CLR4leSq8Kra5QYM+wx0sGHpxqEpCUmBTNwFudQMYk5yFAulMb0LFMFn3IBbEtuPtSFtK
	 f4g0NVnEjwiusrKekTnXAWUlVWPv1537GrOABcYDS49Fm3AMKdX1DiAyHqxrpbXYfSUGC
	 LlT/OxZruLfLc/QO/9Ahu9eHK+RULh+5KgC0R7HkR2tFdPZiuueZOuj/+RUc/rHs+oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493477;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=AzOqWKFaDt1dcUvSh5TH4ogfAdXt1H3DxJt5OXlYfGQ=;
	b=YKNCnFsa/HIE/Gmu83HYsuyI5b/UCc+/Pe/UnYv8s+4vAo/vwbEenUbCu5S02G9VISYV
	 WX7MWi2JpqWMOJkYtmS3+oadchO3qc2F8Q6iqt6DMdocJJOlotFXb2owL58UphsBwp6tx
	 +gaeO+jjiUp9N1YhhvGyokoCrilIsfU2PLKKAiCT5te6mMoYZCqNwIR0U1aEJj7tjKy+3
	 aWd50nn5VQhcmLbi7RFY/Y84p2GQYcXe+lLWtIMjc1k6lK22BcqMOjhP7EW5cT+ohR5yH
	 8pTfYzePb9YM2sQ9fnsbk94PC8WBw8evchOh4/UYQjY/okvgNVZo7aPkfc41zTtfaOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HFuZItCj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122D606A320
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F122D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HFuZItCj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzOqWKFaDt1dcUvSh5TH4ogfAdXt1H3DxJt5OXlYfGQ=;
	b=HFuZItCjPMvWDVAA2LRECwoTBqQ2YclwZwTnLUaV/HO96sBrU6Hs4xzTwwbKRTUEWmIhwr
	MuhW0C7mu0kqJk/cQSSsgsblCZX3NmgfrPHMshpIz4maIzJEhky/j94J4zrP/5UU2DtXyQ
	XwvXn1YrRPQ5L6oYDQcVU3Bb8VZwQk0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-D7y_ed00OAaymLbt3bjJCQ-1; Tue,
 20 Oct 2026 10:51:11 +0000
X-MC-Unique: D7y_ed00OAaymLbt3bjJCQ-1
X-Mimecast-MFC-AGG-ID: D7y_ed00OAaymLbt3bjJCQ_1792493466
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC19B18011FD;
	Tue, 20 Oct 2026 10:51:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D664E30002CD;
	Tue, 20 Oct 2026 10:51:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:11 +0400
Subject: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Rc9Kn1ykFR1030A/T3Qsw/MLRtZoT0IcFryuHUpEgHo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcBKB9OckTgPDc5ceinUI9Ks8T8mQpbSHjR
 wt32qduSASJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5UlxD/0aesvLeJMhDPNK4VKMeyOaPPsCQtFR4qFG7KlCXynT1T2vJymf0cc0GzQxvMuqQi7QkP3
 Nq+vx1h0wS8aWYock4+0cMRoNcvRyjdcEIEaz+hY9fYszOClGXo+WgnVvXIP/ymzT6wOrtEm8zi
 KyTeNOPlbml9T8xE5XCRMCuRDYgQQ/C50LkGOdvWZPi4/QPg61NcRcEdwgwyKWGA//4KF53Etv9
 YF57/ckC+h0DIpVltVP7DozmL6yMRAQhvvbN/k7Wvocf991FXI4FBBQjx3DjWlI02TWx1ZbTHj7
 Ul0nCa4y4Trxncc4kvuErZYreWkXTb3OM10IrtqT0Cxjebhspuf6b49Tpbr3s/b8iiX9czsUwXA
 p89Q53jzV6hkwxaqFNslKASETfvPDs+MhV9lykZnoFlxSdUnXT9X0E7aN2lUv3YRzxnc6Jff11W
 T3pb97gVWEOi/Odv9Mpm+kqrjqMdiRufTDS9y2rm+bzyC4oRVO5awihl+6ojLB1OJGVVwkwc7rQ
 Zbl0T+Ercm3AhwHa5/RMvPncaAuJqvWSIsEqW1vouhls8x0QJ+F7U8ndzLr4k1Xw79jazen5h9J
 arXpcL+C7MupGvk2Kx7ddRWgG+DbBn8bd6xO139DIRMT2by8ApQ+rFpyVEq/Uj7YjDAk1NxdvS0
 GHFEBLCP2lMK0Ow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: XVggNKIVd3IAXCAHU_XRmL1NSFAZeiKYsNjgPaX4VLA_1792493466
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

PciDevfn is a bit special, since it accepts integer and string as
setter, but only output integer as getter.

Unfortunately, we can't declare an alternate str|int QAPI type for it,
since: branch 'string' can't be distinguished from 'integer'

Rather than declaring it as "str", use the common type instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties-system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 5bfdfe1ab9d9..3381de1144d6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .type  = "str",
+    /* The formatted string accepted by the setter is a CLI convenience. */
+    .type  = "int32",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,

-- 
2.56.0.116.g6de20f6092dc

