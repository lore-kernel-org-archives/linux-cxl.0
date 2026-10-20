Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493210;
	b=3RgFidGI8VB0fI1Gg57DNnqRo1bvHiqPM/l6dF+wpK1HMWnBCepqflpTB3M9fptEWh0Q
	 tA78UFxzHtjTdMlfLjzYNJOhLsE+8LLScq/ztbko6qsHbTACLWOrKXhq6jzoAfQHIdycU
	 8xItwRH7DT03PwdWMda46ATlmmRzl0YOHX9SWJhil1DByxHfPihShW+4w6lsjDLaaEHnX
	 4lmgSdXGUASuVKVby0oYImp2ahQk9eJ9Wh88XLPLoupFTJUCDau83eFlcbyMEm+KplGqv
	 K3Amh6rkryQkMjLEdukMg2XqswRMztN29iNyLBB7T0CrDwKpGHX64pESpl2yaVZnbcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493210;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=xG2OGo4lx2YCSH10YJfMac8tHdMtlMp6mBUYGSWviZ4=;
	b=gfSgZpt3rwIPymRRm7jVDGwcg9YW/SW4hwpcQkHeiNn4EGGmERzgIDfWgzcFnOWhfBPV
	 I/lMZgGpBpVb4Bdj2/vN5NwMAbIeZEP8/beZA8fSQ+DiDTvNdetSJWmzZc4sAotNI51/E
	 gCWOv488Fdd+LUpxdgL8nZjWm7AimxmcKUW9Re+Gl6o1qP7U1TX24csogWIpWVnSVz9LE
	 la9j/9JGUHoLTnvrUKHZvSHx6PUHEa6RfENlMH+QSLRoIYPjxTN/4wA1ydIrqG1uvK70G
	 lG0B3C98hqWDlsPTXUtPgJEhmSDQn+B9rkQ9VBKcF9s8SJtZE2eahN7mEvnkZH2kP0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Wi/LmWHg";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4961606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4961606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wi/LmWHg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xG2OGo4lx2YCSH10YJfMac8tHdMtlMp6mBUYGSWviZ4=;
	b=Wi/LmWHgVQr37I7HM3dRB37hrGFBOQn+POAjUGkCspzb/xs7B/45HyRdqnnjjAqGsoculR
	Fm0PDKk0n7c/JKrKi9uVpx6BgkLIqXQ90msn/Cyu4HP2SsrypUrJhjFP4XISBKYm9L7B+z
	ErL74X8unniWmR4TO8fyEFMpBsEj8f8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-dv92ItMdM9G_nQvMyXZAiA-1; Tue,
 20 Oct 2026 10:46:44 +0000
X-MC-Unique: dv92ItMdM9G_nQvMyXZAiA-1
X-Mimecast-MFC-AGG-ID: dv92ItMdM9G_nQvMyXZAiA_1792493201
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CCE818005B9;
	Tue, 20 Oct 2026 10:46:40 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26AF11800643;
	Tue, 20 Oct 2026 10:46:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Tue, 20 Oct 2026 14:45:22 +0400
Subject: [PATCH v7 05/65] qapi: QAPISchemaVisitor.visit_needed() is now
 unused, drop
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-5-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yBAs+PsGI+mRRHuSXNI42xoWI9p0TSDsh65vQW8BRrc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZX3wnVoTG1DT7PkibN0fixZC+3g4HczKxre
 WlR6XwfjdSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGVwAKCRDa6OEJdZac
 5XW2D/45KfzoQQ844pW9wPBstfoA4zhpxgYbXZdFhd1B3tDYs+gd0ydHZpM8roMnIC6sUz2UZVw
 IXLD2jiHt7yLZuphP/QVxipCVGpGWDePAo2x1ibRtN36V7QF2kYhmxqri0MMwpjy6AJMTGCUuMB
 xpRJlv+RypwgdJZTss3IDeLAh6amwIn5KwnKxa+VhAa1TweG97haA2x1DkLDE1BBaEBWerNMIhY
 XkU4aw+JMmBUEmqAu5AXPH7DXgINM5RHn/JzyiI3T7yLfmL0zAUjrq4eWRwG1HVPMGONTO7JfNE
 0o0E+ULXqwLnQTgbGmZcyCHeOER/LovvzMIKrdz4xytDwyhERlt04lMyYKta/VQamfyHHL2eqte
 BmWKR4GrxysyQvF6+XvxLYIUbvcW/GEmZ2K3JOVgeh6yRY/mnANaUpqMzl5nZ1WZij3x49QanrG
 auTI+YKu1G7+pXQipQNg7LGtWo8+sBXCM44evsO6d6zedjLoJkpGbTJ2q1EbcCLvk12mjFkkh4A
 KdfC5MVpqO+KN0XR8txFvJs/K3UkRZlxM97ff+6aW7nGxBCmH5iL8yB/dAH2yravcO9bYYO+LQC
 Gs61agHa3hpCya2FC5c0KTXMLzmROHlqfLGqWdmgsZLg8hrozGFp5ahu+m+OGcL5QZ746vJi74E
 ghKphqYO93tyqXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 0JI8C5PWsyMt5IjLqBS9LwKon-6XlC5_br4nrVjBaCA_1792493201
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/schema.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 11f3accec873..9e2152fa419b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -179,11 +179,6 @@ def visit_end(self) -> None:
     def visit_module(self, name: str) -> None:
         pass
 
-    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # pylint: disable=unused-argument
-        # Default to visiting everything
-        return True
-
     def visit_include(self, name: str, info: Optional[QAPISourceInfo]) -> None:
         pass
 
@@ -315,8 +310,7 @@ def add_entity(self, ent: QAPISchemaEntity) -> None:
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_module(self.name)
         for entity in self._entity_list:
-            if visitor.visit_needed(entity):
-                entity.visit(visitor)
+            entity.visit(visitor)
 
 
 class QAPISchemaInclude(QAPISchemaEntity):

-- 
2.56.0.116.g6de20f6092dc

