Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493240;
	b=YMik1cG35ILCh8qAHgbzgAFw9EeQUsvfBfooHkdSCsZ1CVBOgflixkfRRV8UTQTj58/0
	 e9x57ZEP4Sl7PgPv4luQilZRcLBsh/z6EJ5gVgauevaGTQEIZYVMCGghUxrvUQH8cbRUQ
	 Pejc3cczLdBRDrgxsh98LHjWB5NOyzGS+X2G9HnEM5jhv26r9toHRrl7UMYt6ORJWLDBb
	 VXJNwkOQfeNhyLl/J9HpWspfeGHflNa9EM4ky9ev2ZmsaZB33xYF8jjubsOWxNpBsf0zs
	 aPEXzbJy81sywMpWNN5tGWmC18EPSaaamscEvZRCAqmGqJTsEHFUoX4PMwU4pfYhP4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493240;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=a0eKD3sUSsLDHL5Rbyj5qW1a5Bhls7mo+yQHcVi0dNs=;
	b=HEnRkj7DbDgKrfzLMfMkaJxdsxCDgpItwlnhgcvvgEHvvQBD+71DBK2yLkp0PSN/IDLN
	 QOGOAxEr41JX3Uvnz/xK8UCxOeGQGlG0rrxe8zpxJNMmRUVoFlUnUU6wGYa1LlZQSjlso
	 5JtUj5UXZf+ou4N+0hrbkO/nRlRzv5J46EdG9WwGFsnQS9bAR1CLfXRwcEbd9e6GaGWZw
	 7MvVqWNd3EFbMvYjXiQt8jS/h+rWLqIyBsB9YdFtbbQkNLLmLGaY6TDcV5Kx/Uy6Xr1+7
	 wQJ4vnv+F3ZAYNJaP9edOFLJU7FD0daWKlFVgeBMoIXQUPrLo8d5c0OUUWLRaToRmxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AYdl3l8R;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CC606A31E
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57CC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AYdl3l8R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0eKD3sUSsLDHL5Rbyj5qW1a5Bhls7mo+yQHcVi0dNs=;
	b=AYdl3l8RLD37G7jx/BwUj6+pKwO7zu/m1RXEAP+U2u4HHOJz/fXTaBEkfjsq66gRIT4Rj3
	OYGocoXcEMgdhUQSm0aQ8Rj1ONRQLmA3FwPSiYQYDpa0BdXMuIh3iMLQLphPrJGnPjLCsc
	P8yaF8rsl1kWdpl1aXt7aJj8kBmeQ3A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-PGvBjJmAP4aH1aJU5oYqmw-1; Tue,
 20 Oct 2026 06:47:14 -0400
X-MC-Unique: PGvBjJmAP4aH1aJU5oYqmw-1
X-Mimecast-MFC-AGG-ID: PGvBjJmAP4aH1aJU5oYqmw_1792493230
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5803E1800476;
	Tue, 20 Oct 2026 10:47:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B80D41956095;
	Tue, 20 Oct 2026 10:47:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:27 +0400
Subject: [PATCH v7 10/65] meson: add qapi-type-infos-*.c/h to build
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-10-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eVJytPz3KQHyW0Eei+IlbvI0CrYX88Ak+jznKk8pYYM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYJt0ke19J4ltackOupI0pq7CK76MV5JKhu
 L19h61q7CSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5bh7D/9o800Zx8Ea1Xfpr7ACGgnyzV8jkcBlp8Hzb7ozpogEKFcTat3oDoryJJsQxlgzgJHhAf4
 xQT98v3zkCaoHRIbB6dR0HYZBqyvICSDEA2z6dydBWQCfbIPdcVhiGF29ilFln4WSCVMEnObaFP
 jSBeBazjRdH0T5xfyjCgJrBQSq2TnF577fRbor2DDFXhnjiRkuCteCnjdCRACcbp4bKOu/8aTqC
 zvMFT7nTq00cMgLWk7O7y/3V/o+NEYmNBrudDZxN2ovKLglKgbEKGZt1CpNg1Us3yGbmp7C/ued
 6j8TVzxJBorlnnqcRONbN8vEXcK6fO6P9qZR7nTYal7lYdU6r9TCQoY4kvvQW+uDqXgQEAWmhOi
 jZqDTnpIgJdgITBb5cP1iuDx4m8zCGYgw4FDJSEPYQuWHaFdqeNvNBw0pdC2xUr2TTibV+OLWUp
 XXsHgCRssrvOLRavHKOKXE7Escb305j2bbdur64seJPONvFdSWLWSuLMcyK8cwxzTEA9j2xa2Hg
 HoJL3z3i0vH4SqDy9prxpuF+J3j1IYnps0k+MK+mTLYI4e8iqke/uSs4PUmCOpQMq5J4Otq6DcH
 MJqQiQREJhxMnpMKZBd9vBvDhmvts3IVzg3hJvzD52nk7JW3EAtQdIwCfqF4JndhviB2CIPR+OA
 lCJIJFcJtrFbXpg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: oYIdhKQb_Hm63vmQ7IgXDoy-DvwtqZEsSl8RX62iz68_1792493230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add the per-module type-infos output files so they are compiled into
the build.

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/meson.build              | 4 ++++
 qga/meson.build               | 2 ++
 tests/include/meson.build     | 2 ++
 tests/meson.build             | 6 ++++++
 tests/qapi-schema/meson.build | 1 +
 5 files changed, 15 insertions(+)

diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0c9..7477953492ad 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -79,6 +79,7 @@ endif
 
 qapi_nonmodule_outputs = [
   'qapi-introspect.c', 'qapi-introspect.h',
+  'qapi-type-infos.c', 'qapi-type-infos.h',
   'qapi-types.c', 'qapi-types.h',
   'qapi-visit.h', 'qapi-visit.c',
   'qapi-commands.h', 'qapi-commands.c',
@@ -88,6 +89,7 @@ qapi_nonmodule_outputs = [
 ]
 
 qapi_outputs = qapi_nonmodule_outputs + [
+  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -96,6 +98,8 @@ qapi_inputs = []
 foreach module : qapi_all_modules
   qapi_inputs += [ files(module + '.json') ]
   qapi_module_outputs = [
+    'qapi-type-infos-@0@.c'.format(module),
+    'qapi-type-infos-@0@.h'.format(module),
     'qapi-types-@0@.c'.format(module),
     'qapi-types-@0@.h'.format(module),
     'qapi-visit-@0@.c'.format(module),
diff --git a/qga/meson.build b/qga/meson.build
index cfa2157efb23..79163b7d8e93 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -39,6 +39,8 @@ qga_qapi_outputs = [
   'qga-qapi-init-commands.h',
   'qga-qapi-introspect.c',
   'qga-qapi-introspect.h',
+  'qga-qapi-type-infos.c',
+  'qga-qapi-type-infos.h',
   'qga-qapi-types.c',
   'qga-qapi-types.h',
   'qga-qapi-visit.c',
diff --git a/tests/include/meson.build b/tests/include/meson.build
index 8e8d1ec4e692..026480d96851 100644
--- a/tests/include/meson.build
+++ b/tests/include/meson.build
@@ -4,6 +4,8 @@ test_qapi_outputs_extra = [
   'test-qapi-commands-sub-module.h',
   'test-qapi-events-sub-module.c',
   'test-qapi-events-sub-module.h',
+  'test-qapi-type-infos-sub-module.c',
+  'test-qapi-type-infos-sub-module.h',
   'test-qapi-types-sub-module.c',
   'test-qapi-types-sub-module.h',
   'test-qapi-visit-sub-module.c',
diff --git a/tests/meson.build b/tests/meson.build
index 5877d2f60b12..6769a1e7812f 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -2,6 +2,8 @@ subdir('bench')
 subdir('qemu-iotests')
 
 test_qapi_outputs = [
+  'qapi-builtin-type-infos.c',
+  'qapi-builtin-type-infos.h',
   'qapi-builtin-types.c',
   'qapi-builtin-types.h',
   'qapi-builtin-visit.c',
@@ -22,6 +24,10 @@ test_qapi_outputs = [
   'test-qapi-init-commands.h',
   'test-qapi-introspect.c',
   'test-qapi-introspect.h',
+  'test-qapi-type-infos-sub-sub-module.c',
+  'test-qapi-type-infos-sub-sub-module.h',
+  'test-qapi-type-infos.c',
+  'test-qapi-type-infos.h',
   'test-qapi-types-sub-sub-module.c',
   'test-qapi-types-sub-sub-module.h',
   'test-qapi-types.c',
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index debff633ac17..392b59d8dccd 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -231,6 +231,7 @@ custom_target('QAPI doc',
                        'doc-good-qapi-events.c', 'doc-good-qapi-events.h',
                        'doc-good-qapi-init-commands.c', 'doc-good-qapi-init-commands.h',
                        'doc-good-qapi-introspect.c', 'doc-good-qapi-introspect.h',
+                       'doc-good-qapi-type-infos.c', 'doc-good-qapi-type-infos.h',
                        'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
                        'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h' ],
               input: files('doc-good.json'),

-- 
2.56.0.116.g6de20f6092dc

