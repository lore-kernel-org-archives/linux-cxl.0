Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493283;
	b=xtuKukkk2GjjO4oEBaE22NOys5PwTDtORpke/LIrA10NB53XdoDTb1Uh4meOLJgpPuCZ
	 lP2h0/vDa65p0n8owqZf12eSyaoJEpbjSPwTBrj2Wr/Phf52Cd3VMknHgPyTG6e8urUNf
	 CuT7NeD8mHz7jiHb2btwAUVky9k1O5Li1rcU9N7+ATHLImuH06ZLghWPYLPGJV/nTEpYv
	 iGA4wo2q8QHCg2GpW2fM5k4z7S0Gf5c7abkUtdO32DCMwkySJTv1cCrhiCTR2NJUVYoN+
	 //87RarVT+V03zOK3GUHcCxrg9qdghN5jDQkeap0iU331DuA3ZDK3qsseaULyV4cwbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493283;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=QCsJ6kicmUEQxvaxmAE24eNtz/CdTOeeNBSuCmDZMU8=;
	b=nHuoZlZrfXks2EAu2wHjarIKrB993XvtQwZ28hgFq2xfYvdqlDnpaTtiaK8OU73Ta81T
	 wmIqdhn/uroH1OnsAa4U+j+Xsu+QjKzs5QBb7qavbEcFZ+GJylHzz5uMI9pbWwgX/MgO6
	 RCcTWN2daCpAFS0RZUEydjHMSIb/U+ociiiEsVRHhUWzqspmZtbO3Kx0WzBhjVnYH1yyY
	 fkTC3szXyHvskAgrMM2B0Ew6MusZIRNp8aBOUpMraFwj6oc9Q3WP24zQ1otE0/ws13jLx
	 dzwPTmIBR6nuc3gxVXWwibUSjy7fM2ia3UkDASnk5QZb1If8ba9r/ijFGJv9DeNIgfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRnFS5+m;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95C606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A95C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRnFS5+m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCsJ6kicmUEQxvaxmAE24eNtz/CdTOeeNBSuCmDZMU8=;
	b=FRnFS5+mMpfAa5h+Ky/2Ig9z6W4JQKW/c8vOfqJV7SHaaJa6MCTDVDw8wNU6TNgv48J//Y
	/mnA9HrMIr+lp8NkFsfburrw6fcOj4rr51GPlLhtrn2cTwSp3IwcRH7GET+M8W+NLElR26
	ZhIWj2AWpE/nheQJndq7M6Zj118gnqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Yh3hFIQYORWMSyn7dgfYTg-1; Tue,
 20 Oct 2026 10:47:56 +0000
X-MC-Unique: Yh3hFIQYORWMSyn7dgfYTg-1
X-Mimecast-MFC-AGG-ID: Yh3hFIQYORWMSyn7dgfYTg_1792493272
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64C7A1955EBF;
	Tue, 20 Oct 2026 10:47:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DD3F1803A59;
	Tue, 20 Oct 2026 10:47:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:35 +0400
Subject: [PATCH v7 18/65] tests: update check-qom-proplist for QAPI-aware
 property registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-18-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5424;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PG77OxkKQyF3UcxTgSF0ItIIQR9h6IXM0cn9v6bEm2s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZx0j1p4X5AH6xbN8P7cVXiebxN4/NouqlD
 Bs0dZkcTS6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5btyD/sEpsN54WFVkoxy/MA7ND5ExbGYknt3DZedYvvU6rJFWigzxdRqfgu17q4W5zjE+AamjfL
 BupH4gTHx7+2HfkN3D1gTx/xFdM5Kl6ToEoiDKjNOo862W3jNyyg4ovmX4tTnGNMAz88AfPwhL+
 2ZWNFNzjipqIGY0qQX4Bx66aa2+YE4fY3hQ9iiu+WjFc6AbgnPg4TF4XhUyHF70who98clFVOMD
 yjczx/5tD0aUOR4P15K6+ixi33/auB4tE1Iwmnx/jgl1p3xCy28fffjfyI9wgZwkX2u2stbYLIn
 lDbgxSH1ReWWj7z4XdgyxwniV2xbBYeYJEkOtCV/y7/dK6+AM+a7Qnq3kI/dzYhJuvhq5wU+HGR
 RiM76TgllhaUHS8VdrKmAFY/LmMaDcf5u+dyeDe3ragYCi0YRneV87Q3JrrFqhWtzDyLlEBLQBg
 R2RYEWwbUq91SYc+sy3M2s1dxK/Auw8r9jDxBr9VPRZeaKJzAr1tPm6hnSzp+dkR4vgyuSdKfW2
 xgnVBc5i1OBtTZMbay85wjtkAfGfPH5jqgFBr3+8p6u1r9UH55oNAmVqy1ev7FnV/EBA4FlmSyX
 4Ic6VS1CTDmF2CzubrTp3nVMwtdHRxtTKiFnV+tWJm6wxUGQS0/zDlqzL+ypt2gHRnuRwgDXqHU
 doz9mjn/aUw3+xw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: U_93jYBSQXUc-biq1Ii3yl6SXdI4kBKdk_2274ANtZg_1792493272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Migrate the dummy object's string and enum properties from the legacy
object_class_property_add_str/enum() helpers to the new QAPI-aware
object_class_property_add_qapi/qapi_enum() registration.

Add test cases verifying that the qapi_type metadata is correctly
populated on properties registered through the new API, and that it
remains NULL for properties using the old-style registration.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/unit/check-qom-proplist.c | 93 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 89de92b7d91f..69155e720751 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -108,22 +108,21 @@ static int dummy_get_av(Object *obj,
 }
 
 
-static void dummy_set_sv(Object *obj,
-                         const char *value,
-                         Error **errp)
+static void dummy_set_sv(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
 {
     DummyObject *dobj = DUMMY_OBJECT(obj);
 
-    g_free(dobj->sv);
-    dobj->sv = g_strdup(value);
+    g_clear_pointer(&dobj->sv, g_free);
+    visit_type_str(v, name, &dobj->sv, errp);
 }
 
-static char *dummy_get_sv(Object *obj,
-                          Error **errp)
+static void dummy_get_sv(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
 {
     DummyObject *dobj = DUMMY_OBJECT(obj);
 
-    return g_strdup(dobj->sv);
+    visit_type_str(v, name, &dobj->sv, errp);
 }
 
 
@@ -135,16 +134,28 @@ static void dummy_init(Object *obj)
 }
 
 
+static const QAPITypeInfo dummy_animal_qapi_type_info = {
+    .name = "DummyAnimal",
+    .masked_name = "DummyAnimalSchema",
+    .lookup = &dummy_animal_map,
+};
+
+static const QAPITypeInfo dummy_str_qapi_type_info = {
+    .name = "str",
+    .masked_name = "StrSchema",
+};
+
 static void dummy_class_init(ObjectClass *cls, const void *data)
 {
-    object_class_property_add_str(cls, "sv",
-                                  dummy_get_sv,
-                                  dummy_set_sv);
-    object_class_property_add_enum(cls, "av",
-                                   "DummyAnimal",
-                                   &dummy_animal_map,
-                                   dummy_get_av,
-                                   dummy_set_av);
+    object_class_property_add_qapi(cls, "sv", &dummy_str_qapi_type_info,
+                                   dummy_get_sv, dummy_set_sv,
+                                   NULL, NULL);
+    object_class_property_add_qapi_enum(cls, QAPI_ENUM_PROP(
+        .name = "av",
+        .qapi_type = &dummy_animal_qapi_type_info,
+        .get = dummy_get_av,
+        .set = dummy_set_av,
+    ));
 }
 
 
@@ -703,6 +714,54 @@ static void test_qom_partial_path(void)
     object_unparent(cont1);
 }
 
+static void test_dummy_qapi_enum(void)
+{
+    ObjectProperty *prop;
+    Object *parent = object_get_objects_root();
+    DummyObject *dobj = DUMMY_OBJECT(
+        object_new_with_props(TYPE_DUMMY,
+                              parent,
+                              "dummy0",
+                              &error_abort,
+                              "av", "platypus",
+                              NULL));
+
+    g_assert(dobj->av == DUMMY_PLATYPUS);
+
+    prop = object_property_find(OBJECT(dobj), "av");
+    g_assert(prop);
+    g_assert(prop->qapi_type == &dummy_animal_qapi_type_info);
+    g_assert_cmpstr(prop->qapi_type->name, ==, "DummyAnimal");
+    g_assert_cmpstr(prop->qapi_type->masked_name, ==, "DummyAnimalSchema");
+    g_assert(prop->qapi_type->lookup == &dummy_animal_map);
+
+    object_unparent(OBJECT(dobj));
+}
+
+static void test_dummy_qapi_prop(void)
+{
+    ObjectProperty *prop;
+    Object *parent = object_get_objects_root();
+    DummyObject *dobj = DUMMY_OBJECT(
+        object_new_with_props(TYPE_DUMMY,
+                              parent,
+                              "dummy0",
+                              &error_abort,
+                              "sv", "hello",
+                              NULL));
+
+    g_assert_cmpstr(dobj->sv, ==, "hello");
+
+    prop = object_property_find(OBJECT(dobj), "sv");
+    g_assert(prop);
+    g_assert(prop->qapi_type == &dummy_str_qapi_type_info);
+    g_assert_cmpstr(prop->qapi_type->name, ==, "str");
+    g_assert_cmpstr(prop->qapi_type->masked_name, ==, "StrSchema");
+    g_assert(prop->qapi_type->lookup == NULL);
+
+    object_unparent(OBJECT(dobj));
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -727,6 +786,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
     g_test_add_func("/qom/proplist/class_iterator", test_dummy_class_iterator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
+    g_test_add_func("/qom/proplist/qapi_enum", test_dummy_qapi_enum);
+    g_test_add_func("/qom/proplist/qapi_prop", test_dummy_qapi_prop);
     g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
 
     return g_test_run();

-- 
2.56.0.116.g6de20f6092dc

