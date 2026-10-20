Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493408;
	b=4+ITsVAfmDVG+Uy9eoYKc0idcvSvKQxhVZNfvWJba8j6+FdI+s1kWBwhDC4XL/b0Radr
	 UibTWTbovm37cRdnkSbitEDXHJCxGvSiLXOnZZpej+4X6/NKtkfyDKp2ctr/mZajFF8iK
	 2NfpoyBushcg6/xGnQViYYpLfnSrXRdUQ6bCOlSJc335rBMCZLkzcBAPBCLMBXQIDI1rF
	 eQSFqwjUgmmnsMochatoYr2dVqQY/nOzXeuCEUIFvGaNjiZM1NmGgWu81wfbbelrcLGr4
	 YQvvoHIbYFNwr68AVUPe5flgXuRZbU7UfKOlE4RuQflorNfzMYkenSMm26MNOLOtX8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493408;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=GVWb5UrZ3l9OWc8z0jMYQBZzqJcQOCGKYpInKz+na1M=;
	b=3AdFwnsXCXW6YqxNdQJvnwVBnG47ljG/OlXYm3EFM9nMsBnn4GBGJsFZ6za1HizdM9Zy
	 VaFvhnSiWB/aHqyM1YdIlyImX+v14DULKHiCYsEEs9IEQGnqcTwKEs5nWsNXtAF7Mf4EO
	 urmCX9mDGGWex/rr1liGc7sNG/gd1TEittgpnx0hA56WtIQzX/AW2VdRKjhu/RU/Ihj2c
	 eecESIiR7J7ZlELi1jiyegjHpQ7YBXMCWPja5onNxkAxVhxl8ubVIPaK+JrbgthqyZx4i
	 Fu5qmaxKkGmOcze0LUZxzh8W4Z7XAsevleYgQl/Jy8RXcYA1yjFYvBQB7NIrRJA9vtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHpODoEl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70D606A338
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B70D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHpODoEl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVWb5UrZ3l9OWc8z0jMYQBZzqJcQOCGKYpInKz+na1M=;
	b=aHpODoElLVt8435sL0m4j8p0XHudzNdF95pS+jjgGr4OZrgvvEWxoMSUUaESVf8Aczc2Ij
	gcKRorF41qLrEFO+/hErGR6qrQHhanQl73eJE4SibWPW0G8I1He5ASLjGjRRjbpbp/pnDW
	+ngibas2i+qZ8ChPAcp6OL97aCoWSWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-O30bwBRGPzmDiwX1sYGXKg-1; Tue,
 20 Oct 2026 06:50:02 -0400
X-MC-Unique: O30bwBRGPzmDiwX1sYGXKg-1
X-Mimecast-MFC-AGG-ID: O30bwBRGPzmDiwX1sYGXKg_1792493398
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 726D5195606F;
	Tue, 20 Oct 2026 10:49:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6513818002B1;
	Tue, 20 Oct 2026 10:49:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:58 +0400
Subject: [PATCH v7 41/65] i386/x86: convert SgxEPCList property to
 QAPI-aware registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-41-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3ycIKkcsrbeBaqgGVPPqutgRU2x41tR3vpY71IOY4RM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10Zbm7moIDDW7GGdTGA1Ntevlz9fNWvXvLsJR
 bIPPo13KrCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWwAKCRDa6OEJdZac
 5Z6AD/9gPLakZLGtkob/1hq4vp9WcOhy+Qf2mehJtKFcowbdPBQjOD8jHexmcUoSOILep2f0ZLJ
 dZ93x7+KtpDPJ/4hOVEelty3/2kYzR1QGS2GLV1xt70MVDdKb6YGI7nv9ZhSRPqLxUf2quaFnpm
 umHDou1B6dYT/+c0icU7IlgdqRtOxyZ75sKO27Z6dmZnoqFYLIP/lXyNuIuKzlZ2yjLPAGUsLFk
 LK3zOo1vwisjf/BZLY9TIovgjVy9se5BpqWx1A7pqHpe32TwXQU1x7ixQEeFADdUg1WCkE/isdM
 krDIS7cujn4AJtgOxH6JqN07z+G7SToDICJtrtNtgw/zd3B649uK5Li/udmEyCLk1PK2QpnS/+6
 QpLTgx5m+Nobyae7jNQ7UKPCwATlex3vDyur7bvIfFNayOgpP/FZpJy2MwJzaxXsKL/juZ8h5dk
 NKpgvzPljgaORC5S+IsFoYPk7tgCHPRUF4r7b0ueCMur6MDrxaHIbMJKGergjautzcwg3hpKn8x
 Ul7p9A/g0SdO4ZaHIVOBXSGBW+ng3qndsxDvkIeH5v8SOsNZtu9D9oCnarKouLgzTUoO0aJoslY
 tDeb5MWngF3MQnylC815Zw6FQmYbBKNJCkjC0aiegP2CSTAx7etM/l6FB+NT/OktrtRZUXlUxN2
 Ai4S2aLDD28Dk1g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 6K3s-mRcz_c1Tv8KV_2d6Zkpx9svaBrPaaNJtGflU5A_1792493398
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d0c782ec8544..ed38760d798d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -25,6 +25,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
@@ -426,7 +427,7 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, X86_MACHINE_BUS_LOCK_RATELIMIT,
             "Set the ratelimit for the bus locks acquired in VMs");
 
-    object_class_property_add(oc, "sgx-epc", "SgxEPC",
+    object_class_property_add_qapi(oc, "sgx-epc", &SgxEPCList_type_info,
         machine_get_sgx_epc, machine_set_sgx_epc,
         NULL, NULL);
     object_class_property_set_description(oc, "sgx-epc",

-- 
2.56.0.116.g6de20f6092dc

