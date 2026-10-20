Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493430;
	b=QJ7kbRqv+MeQKObkp7gpgKs0/nprK+gwUr3HiWXaW0t7dcCeT334FBds/Nf+7yuUGSoq
	 WU/txzuq9ZGMuIbKWEePIbRXrBDsk1etIDuORvVbR4ts9JEkz7vTV6Ecywdp4P5xoed4W
	 gnZNzivWcOFKW1L8pR7XuA2LWnwBZYDM9ZZRapY1qVzI+pjzFupeH+hlAqQ+nPRSGeiqc
	 AvTsc5DBnnBhEsgU+DLb0da5OKTa0idoV7MAz32kk6i41R/vui81Kv2oYJBUA5v5WDQkU
	 COQoJoTBK+hlamry0FFS5mx3a32Qz8DIff3Cv5h17oHqdxMp+UN9idbEHZZG/KkJvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493430;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=cjstbMWmXOAnQJ0vRg4/TV0UxKxkDAMv9/7iDMdvYXk=;
	b=ZPojh+yOHSL/XDW3My14iWqd8N4jCTmDRrztnMl3R1BqgF27D1x0t9VTHV3dqiiwCH1/
	 RhU2SITP2gk9+kIXBk+2pWVNbCbxYi+VzF7UqsbFree3VjQTO0B9+pHmr8J19fdKfLXrJ
	 l+/O6UN3ElIx8Y8Ge+irrt5MAxmGFR2mm2FvHqpq3wW+gD82Dcd5SMj8NvZrV7jdAU8WA
	 W6l7a98o+2qptpeCmFceXSOyMiEf9w7T12ax9JWUY65wH6Rfr3yl57v+XdDwQTIPGPZTl
	 lcfwHIKQxWIwJXkUtYNRZcYzy3v3/QMGT2d5nsr9YOKVzgzH8V+eJtOv1r1jdOYheWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSffY2IV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3660A2607
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD3660A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSffY2IV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjstbMWmXOAnQJ0vRg4/TV0UxKxkDAMv9/7iDMdvYXk=;
	b=XSffY2IVRgKgqakC6JFT2BMyHFj54TJXSMa5xU8QBEIRxg5dsbGsaWvi+/pHaj3+eRokW0
	qn1zCMaRbLDwnuJ94IPUwSpWYP8YhZiu1/RaIzLsTmOvRrL0Qjj7FQBlojsaIcts423yVY
	cE9YQQJd2SiIeiKrPZB49vwaau/9VhQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-LEtBYtaXNhep3HOST1h5pg-1; Tue,
 20 Oct 2026 06:50:24 -0400
X-MC-Unique: LEtBYtaXNhep3HOST1h5pg-1
X-Mimecast-MFC-AGG-ID: LEtBYtaXNhep3HOST1h5pg_1792493420
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C61F61955DA5;
	Tue, 20 Oct 2026 10:50:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 854725BC;
	Tue, 20 Oct 2026 10:50:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:02 +0400
Subject: [PATCH v7 45/65] hw/s390-virtio-ccw: convert loadparm property to
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
Message-Id: <20261020-qom-qapi-v7-45-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kUpPGFy4418k+1NoT02grj7G7ylnBF+ugRFLSNuQ/I8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZbZ381/sBWM1azZ53D7cfjK2vNDIyCM5jiw
 Xz8ukfeXYKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWwAKCRDa6OEJdZac
 5WE7EACcNb6WUPAXGp4swEqKgOrI7mRkcimuGMJxDQptX6voqKSzXDGgbjpNbOpCSvTsAUBzqkf
 VmQ+u1XXdOcMUFOXV12h+uVIagNkH/FDk+vj6EhW+7Kv+xUWHQwihzevCBsOe5YRu7AoC5JFL7e
 0gnAXgwlHoUc7rofc1b2A696Xi73B0BOxB5zdDwbfJPmC+zNLT3hs1Td4Kz/nHF5mI2tkY38zor
 J9Gu+Zngb8i7tCVWNN4rxMRTflUnEleoTBaZ/MzpgKLm6BMGvNB/RklxuTW9RaHm5c7Hn2tOkUX
 BjBeCAlN8BDg+4cPXlsrKBOZG04cS8ma9QO+ZFcTJJ0v6YXzwA+GsHW4fPIoGszFa+UyJOoyFyZ
 JjxorHFP+v58GJcIr421M6yCPKqLa70RxTrPsVBPMAHrP0TejWLeOs0hIrNkRiE5+2601BD6apI
 rZkqEk8rXGc2YmuOolkjrs6b6PIw2R6sibjUwbIPFEHNu7HbC/WLZG6sxGdbaHB5xKhjg7Yo0Hf
 sljEdE+S9n89L1t8za9aF28F5ivQkNlw/vJ2npjoxGF9L6HCdk+EiYF61ps7MRQR9ViFVustynh
 PdOoORH0IHDSPitjUdZoIvZb6i6CW8KZCeXn1ZUTNMv/w8f9vbbxVroo3zzRSKiilj8k+2MxLjs
 N6G+newXEeukaug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: OJZ2iqDgCuUKZQvvnXqfhyZLc2BH3MxJzf-3doQcvlY_1792493420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The QAPI type is actually a string. Here also, if we had typedef support
we could expose a more specific type.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fda5ecc9ad3c..3ed425b16c3e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -43,6 +43,7 @@
 #include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
@@ -908,7 +909,8 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key");
 
-    object_class_property_add(oc, "loadparm", "loadparm",
+    /* if QAPI learns to typedef str, we could expose a more specific type */
+    object_class_property_add_qapi(oc, "loadparm", &str_type_info,
                               machine_get_loadparm, machine_set_loadparm,
                               NULL, NULL);
     object_class_property_set_description(oc, "loadparm",

-- 
2.56.0.116.g6de20f6092dc

