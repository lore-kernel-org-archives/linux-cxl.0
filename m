Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493354;
	b=V5fanSbGyzVZDPkMn26hcqYYcXgNGTlPPZEowz7kGuOUFAghIS/QXOPFZgPE0zk/03ZT
	 8qik1rLq00qt0wNEXUYiIjvNasMhioMKkYfKx8rH3P0a2TKIZYHl4FTGgXQYViwXn592l
	 xuDv3WCgDJOOHBqYASPm1nqbXaoXK7tQCORBjmHQ9aW9FTdyWyIqOgYe6r0mKAD5B84uU
	 LzdfmQN7VsUNDwiJW3u0G/WW78xjOLX/uF/GIlvWusl6ymXmK/8L33ipUB9NCfg8RESfZ
	 aY9dKDE38KAk4k+xaW67SRm53dhIYoYScjj6YD9SLQ3pWvBp+Ye6XqLAFMK0I/kmAnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493354;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=+msWSN975JraU+AQ2pjkwTOzy6rb7VP7Sy0YWpQFyaI=;
	b=4DKvQ1kn34FndfDyBv0mocNJiRMndJp4H3k5oEZ7lkXrMGeX1dSFq235ffE/nkntYk17
	 p2HvTDvg9huRUidqjTdlprycR+feMGCKh+zpAxaQmO4LTZnjHPFnM+8+LE1mGy1pvyEqK
	 hRRf9LT1oJGqKN2VwUwl4t3yUJU9ZnqARgd9RaMZnALVSa1c1ZAe5UH74gP1at2ry7dTk
	 fOujjxJoM+GRSl3bWUuiDSzl6VnzWA1qx8UwtjznnJMC5BKE8EVl8qrMrCvdrh29srapI
	 gFtBu8jephn12t00xMHxsOP4iLhAJZQ7kw7Q41Ppwed+kGCzbYEKJGrqRlY4HWmdhvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMwxtfs9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2860A2614
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F2860A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMwxtfs9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+msWSN975JraU+AQ2pjkwTOzy6rb7VP7Sy0YWpQFyaI=;
	b=WMwxtfs9ibMlyq05dCMs8f/jwudkWoTlmXfl1l0NVnOfN7wSJBbxwr6/qjJUBZ/xGbw2qA
	v1TlWyZVW1U7XEyHrL72+xsIql93N2sNI746PaPn0mD38k9A1J2oW5u74ZUfpaX3yhDTwR
	cl2BZwh6BZcf+hrQfFTEwmT21bYpCEQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-NYqEQbiqO-eptIVh-iXBxg-1; Tue,
 20 Oct 2026 10:49:09 +0000
X-MC-Unique: NYqEQbiqO-eptIVh-iXBxg-1
X-Mimecast-MFC-AGG-ID: NYqEQbiqO-eptIVh-iXBxg_1792493346
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC9791955DC2;
	Tue, 20 Oct 2026 10:49:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB839418;
	Tue, 20 Oct 2026 10:49:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:49 +0400
Subject: [PATCH v7 32/65] whpx: convert OnOffSplit property to QAPI-aware
 registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-32-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qwLr64BOI3m44mmy9A+SITIRRpm72tGui++1suPv5QI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaQPXZ9WY6MhNw1DyiQHvUVteDQyhQLNYx9
 5hVrQKQA32JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5WR8D/9WFCaokBX+igEl9S/wj1xhyGPSG66SFfV27Dltbb57zmq4uC5jvUX5w6dWXvYhtPNHQFe
 9K66GKAgusLvRKSD+H3zGLUW8U3ETC61HN7gxl/1me7MCOgx4nP4TuXC1IGc7N04Uy5p/K7CCsv
 3m46hhOQ/zOVysQ/z+FfY9DGA3PsDFV5vpg2sI4loFLN5558gsYEPjpded2r/AVynOfpuqed2bX
 NsNJM/utLP5uFN4rESVP7aXet5+W6chof8bssQP5vH834/eDq3PJrbZ4Ot9Q1iHx9WPiPv9Rw56
 JYEYeGXqbn3zlh5nLP8rzUGp2ug5AdD4t/I9Z26eJu6bDuLCkBYk74iepLUVgX9W4DO6oiGh3et
 GKakHxnLhUun1C5Ol9NCVBaytv0BslRU/Fvw+cX2rIIZ0km5KyWtqiP7Fp65uNlItR2MeaUEDQ3
 yloZx1kGhihimd582aexp35/fKD5T1d3yhKR0VFCwxbT9halzluTupdhjEGH+0ZFsekn9ipXO7N
 AuESTeKZ/orDCQk3U9Z1+5iRkWyT+M7qnMaKqFtveqCTTqKQhVQaCO+cbv92R+RjOruwYCbOgB8
 /9W9WeMcY/EDXsuwsJ5c9Hn3lYMIZuQYd2A0dPWG2l+UDTv6P77b/e0AvpSGAfOx92YoEM7oybG
 +IQmmuEwivE+VvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: koP5ZgjWLl_u3I0mZgW4zvOE_1SBWJ4Lo1xFR_F9u-U_1792493346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the OnOffSplit property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/whpx/whpx-common.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 187938c02b51..5d4b405e56d3 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -434,18 +434,12 @@ error:
     return false;
 }
 
-static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_kernel_irqchip(Object *obj, int value,
+                                    Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffSplit mode;
 
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
+    switch (value) {
     case ON_OFF_SPLIT_ON:
         whpx->kernel_irqchip_allowed = true;
         whpx->kernel_irqchip_required = true;
@@ -463,11 +457,7 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
         break;
 
     default:
-        /*
-         * The value was checked in visit_type_OnOffSplit() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -518,11 +508,12 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
 
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, whpx_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure WHPX in-kernel irqchip");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "kernel-irqchip",
+        .qapi_type = &OnOffSplit_type_info,
+        .set = whpx_set_kernel_irqchip,
+        .description = "Configure WHPX in-kernel irqchip",
+    ));
     object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
         .name = "hyperv",
         .description = "Configure Hyper-V enlightenments",

-- 
2.56.0.116.g6de20f6092dc

