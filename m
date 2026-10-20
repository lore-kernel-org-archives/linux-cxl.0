Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493440;
	b=rvVUfk7fVGTaUTfZMVxFEOxvGi53VkvXQOYNz4uss2BZY/He0FxgS0qzSUpLBgZdevcY
	 +xSLOTD1JIrvwRvblcer7oUvHMkj4ociTXhVzknsQoDbkUs4aKDsk4rkqa2H+//11Fh8Z
	 JssPEtxW223VERah0U+K+e1wiBOTgtLebjJK+pwYXSQ0ahJaCkCwxDKbg034XQ+1w6NHu
	 8YbTQgnP40UibZXGsnsx5eo4Cvu35CKk/rb6CfrVo+767lKLGTvpmOC47FHXvWh/krp4y
	 2H2OyB56H2R3dbO6ae1yvve05dT1NRKBSl7NDvwvgL6obmIXqMkNzKOmIAKyCe+fzNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493440;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=wDKqI9lxsJYOWv5oXkIIVMolronNVooZmn3jjB1NaoM=;
	b=xY751VBlWx6C4rv7/ayYPeTnS+3gfR4OqYrzNKdS0CpqoEuTDuOJunVOAW2qMoqUJcn+
	 qGfhc9KMf1J5BqKbRMk9eOaHMnpFY+Rb8+ZIS5eFs0YB2W0XaOEDkJih9PAWSg7kNzm7L
	 4m5nyGis7YaYfSJ5qx9FmyBwA9NRLZ2+rKGRneQIkyLM7p7p4ywJq7Jdlh7VWTctQLp7v
	 Nxy101amVtOVYhehfWbS8HPlVnvi/MvYziyUuFulHGINhe1CG/C42xBQh+u15vFxNod/j
	 JoRZZmDgR2yyk24EIMwGrit1KjfhdLywk+BYH0mHCByVYRukMiP3bv4U5iuQ29iPfhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBGC8D2F;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A860A2604
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 909A860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBGC8D2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDKqI9lxsJYOWv5oXkIIVMolronNVooZmn3jjB1NaoM=;
	b=FBGC8D2F/nuBnjo516KjQp0lZ/Y2GSslLu2UWgfYYLluhW/o46vYUQga2v1tMZbd8kcVjX
	m1Br9rdtO0rJtlOvX0IndgITkcN/NX5NPkCMUK0GGR/EdQ1pjwGS78b/FwZ7CT26MWjjZI
	5gIq/hgW7kvXBMoxjM+0icEmV+N6JvA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-nPrkmqWhMXen_3R1vU7oZw-1; Tue,
 20 Oct 2026 10:50:34 +0000
X-MC-Unique: nPrkmqWhMXen_3R1vU7oZw-1
X-Mimecast-MFC-AGG-ID: nPrkmqWhMXen_3R1vU7oZw_1792493430
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06E3A1805A18;
	Tue, 20 Oct 2026 10:50:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D157218005B8;
	Tue, 20 Oct 2026 10:50:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:04 +0400
Subject: [PATCH v7 47/65] hw/s390x: convert BootCertificatesList to
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
Message-Id: <20261020-qom-qapi-v7-47-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wdbhYWD/vf672j0phUbR1cOU3kwkLl3/cupZ0YaTznU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZbDkYgPj0HDzsA3Y34WzGHrPrDPeDHvzd0l
 wPaLOFmX3WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWwAKCRDa6OEJdZac
 5QyFD/0b7xA4ChrYMo5WcQsrtlQZqCXFanjHmndWojPNq6E6DJrh7yNweRlM5B8GO8az5oyA75h
 sUttRiBWYNvMnlgXQtH/nE8T96ywsGyTT9ZInHttlzN9P5Fh5Kr/SqOcHkuYj6mXh4Qo8l9kpkX
 5Ls7K8Ke23byTyibodkbaedkpfdM3EpJ3hzQ5r3Cbp68RrQqxPRAGGe+DEVXyTzCaUIrg/oKuKl
 ee+1owd49sj/oDWlsbQ8JKwkl9rM61yJQqCHZ/8bYXLsQ8Sy+lP6fJkHm9Ng4C2rM7dDW0wPeZJ
 /AnxrnFDz+SaS70Z+Q7qSIRHxareyWZJA0rnKOl82n26hwJ2mAFFTibkJxJPdnojLqX+mWBzWUU
 61jumL2L/vI6Hbuh3iO7YnsdjYk+RAjIYNyc/LVGHWFYLkgevtNRkvL4bo4c8ILFq/kfEbpOOX9
 IJctXj/7n79Sx62wNtTjV3Wmenr+zMkYIemOn14uqf9VuXdkB0ih5iiJgO031WJpDUGUW/l3UO0
 Nt1goAs8YdyzC1w+yD/OBemcsUJMxG2IKhcXMBoyjQtwO1hYYX+0qqyxosT72NLiOrgKTvIWx/C
 AamF9QKFFgHdWVkuKlqIBCfed1sEkedvwsLa07Bik/rEdPJdSrKHrHCPDZ9x/Q5r3QVwD+zyVVq
 V10wnjLfSGUrDTg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 1dAcScATc4RRyjYgG76s6UPNgSx6WCLBo-5lPj1d3mc_1792493430
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3ed425b16c3e..8bc09c179552 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -44,6 +44,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-machine-s390x.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
@@ -918,8 +919,10 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
 
-    object_class_property_add(oc, "boot-certs", "BootCertificatesList",
-                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
+    object_class_property_add_qapi(oc, "boot-certs",
+                                   &BootCertificatesList_type_info,
+                                   machine_get_boot_certs,
+                                   machine_set_boot_certs, NULL, NULL);
     object_class_property_set_description(oc, "boot-certs",
             "provide paths to a directory and/or a certificate file for secure boot");
 

-- 
2.56.0.116.g6de20f6092dc

