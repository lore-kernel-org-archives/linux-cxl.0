Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493487;
	b=hCZhoJWZ2wcqoNyUa9tqxsU97G1JVa8o49ngkXmN/V31k0kBdL3utso2x7fJjUlEWC3G
	 6NXxca5B2vco28xQev+8aB2VGaXS5pecfUeKBgTCnbo/qUSnTQtUwmi8MyW3NxRg72d9c
	 sif4mOj8iq8AW+IsERRwpp4JDoV4wyqdm5xTNpp6cEqkDON9v/CS8SrI+z4/+2Y0MmbdD
	 14XtDFzvZuGBrxzHbMGOCdxWAaL3kefnk1kPdDavpEqWo+66wQBJfCGImRkOL1sXFoiWa
	 fORoJE6wDQRxWVANbiFUXIOEZFbUP15smWrNHNWnpxFDjL8mQfHKvAWaxUhtf3+fFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493487;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=1eBYCbo62pybnrvd2zJR+X4E8rHf2MlZgP3d6Su31eo=;
	b=srcYiFen8hIXo0gMuw212TZ4oRCCc3dGcWqeKipxEKJjrcbe5pwlT/SO62oRFXqYEBwQ
	 A3umWBhS0zZ0rzKA367EjWpDA9hg2EjPEJoYrODQc4fq3jf0/JwcXaT0Yh7hkDJh7mMNv
	 12KBfsRHuvD39af6UjQXPBd/iCMwnmJB8EOghl3O5m/gHvlHC5AP5X0EGrrULr6cykeNI
	 mO+GRBTsu/QyyxrUlIt+cxiJx5Cd2ERyThJFdddxzUnzWgLnUYfBt09HTzq1VH1uQuTLF
	 M5Kwwpo2R3RJuhdggWTxdHCizrkUbAAKhuqYYGvaxYNmyWNWAB0xB7zjNV2iCtEUK1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5BTHB2z;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7D606A327
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E7D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5BTHB2z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eBYCbo62pybnrvd2zJR+X4E8rHf2MlZgP3d6Su31eo=;
	b=B5BTHB2zdGsiYb36C/7V5s1tj6j776NLHQIAysWTvKqVwxHdmR2nE2rq/6jrMaFjqTtR0I
	hePnLysUxSFu7/Mh0lIzoylI8cAef7lYjHk/EvxAY9Cfp339NA2fWb0vp7zougiOAdJ8RB
	nGCrXqNa6ENmH2AYVYgTeXQ1DOCKEHo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-LD3Q4rjXMEKqjPFqN7WD9w-1; Tue,
 20 Oct 2026 10:51:21 +0000
X-MC-Unique: LD3Q4rjXMEKqjPFqN7WD9w-1
X-Mimecast-MFC-AGG-ID: LD3Q4rjXMEKqjPFqN7WD9w_1792493477
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D8291955BD4;
	Tue, 20 Oct 2026 10:51:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABCAE1956089;
	Tue, 20 Oct 2026 10:51:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:13 +0400
Subject: [PATCH v7 56/65] hw: convert device-local PropertyInfo definitions
 to use qapi_type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-56-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8815;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IuCBdKGBPF8OB+y7s4jio7rdRTdD0humb0BIR918jzY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcQxqX6eOMSpfYs+pLT9Ow0Na9hEzQjJ0+w
 S7czDd2tmOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5Ss8D/9u4K3F7gThG/+rssznoV4GJ740Eb7vM34SO7kM+CMcAz0SmichYUKsY043yCHop4AuZHC
 LCq264K5jqI6bLVK5pUhsy42PlJ5ABe9K2vKHMUqJp8pSnncy2C74LHZmXSwl/61sE/J3BLrH7h
 nYIupz1f2RXz2Kseg4wCVaJb/12YUegn0C4BbAn1osYrlQC1CpAPskw/O4gjHHg19dANxc0iuOl
 kP/04E9U9V5/Qv3sg7Gma0B2LGOdkqB3UDFV+ya/UgRaGAzYW/FGRfCX3zHJjg/sFdqnVmmeQST
 Bd1Tu7ZeRf5mznPPYqaQXSiRpnQZWF8j/f9MZkFOJprVi9JKsVO0NzFxbG0wPemso49Okgkzmq0
 tdFxFZlrsEPQ2lI/7l83w3+2xaA2aV+uqDCdxukgn+J2CNR9CNo80p75nJpZDjhncVjJGd1M8Yo
 msm+r+wrIQSoNQ9OrNQYvJ9I2AH5VOpdkqnrBqH+/c0d1BcIg+M/xYRpFfF6xcNX/t2hVaRZjjX
 5tEZTIjyloiOSYCAqN2wriWOfN+tmlUocDn/0o53+Th53eTDQl6slDt39kqP+VURUXmsyer4GF8
 Mic7qD4Dg11IPqUhCiVLNiuH+iTqs3LsM0IQqHPrhsl2ZPqybHUGY2vDA565zimKYuU3A1kLKNc
 4eR+F+9z6aMxDww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 2TJ1MN_oHwhZCmuXsNGnCsveS4nWB2itwaUIHkvJSW0_1792493477
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Mechanical conversion of PropertyInfo definitions in device-specific
files, replacing .type string with .qapi_type pointer to the
corresponding QAPITypeInfo. Except "display_mode" for apple-gfx, which
is a string of a specific format.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/block/xen-block.c       | 3 ++-
 hw/display/apple-gfx.m     | 3 ++-
 hw/misc/xlnx-versal-trng.c | 3 ++-
 hw/nvme/nguid.c            | 3 ++-
 hw/nvram/xlnx-bbram.c      | 3 ++-
 hw/nvram/xlnx-efuse.c      | 3 ++-
 hw/pci/pci.c               | 3 ++-
 hw/s390x/ccw-device.c      | 3 ++-
 hw/s390x/css.c             | 5 +++--
 hw/s390x/s390-pci-bus.c    | 3 ++-
 hw/vfio/pci-quirks.c       | 3 ++-
 11 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 474c12fe4ac8..d9721c565c5f 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -29,6 +29,7 @@
 #include "dataplane/xen-block.h"
 #include "hw/xen/interface/io/xs_wire.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #define XVDA_MAJOR 202
 #define XVDQ_MAJOR (1 << 20)
@@ -663,7 +664,7 @@ invalid:
  * https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
  */
 static const PropertyInfo xen_block_prop_vdev = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Virtual Disk specifier (d*p*/xvd*/hd*/sd*)",
     .get = xen_block_get_vdev,
     .set = xen_block_set_vdev,
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index be0061b9db25..77c420b30006 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -15,6 +15,7 @@
 #include "qemu/lockable.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "qemu/aio-wait.h"
@@ -871,7 +872,7 @@ static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_apple_gfx_display_mode = {
-    .type  = "display_mode",
+    .qapi_type = &str_type_info,
     .description =
         "Display mode in pixels and Hertz, as <width>x<height>@<refresh-rate> "
         "Example: 3840x2160@60",
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 0584ee089e3c..97bd3c3f8475 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -36,6 +36,7 @@
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #ifndef XLNX_VERSAL_TRNG_ERR_DEBUG
 #define XLNX_VERSAL_TRNG_ERR_DEBUG 0
@@ -662,7 +663,7 @@ static void trng_prop_fault_event_get(Object *obj, Visitor *v,
 }
 
 static const PropertyInfo trng_prop_fault_events = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
     .get = trng_prop_fault_event_get,
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 4cd6fad6ac9b..6eaf90fca88e 100644
--- a/hw/nvme/nguid.c
+++ b/hw/nvme/nguid.c
@@ -18,6 +18,7 @@
 #include "qapi/visitor.h"
 #include "qemu/ctype.h"
 #include "nvme.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #define NGUID_SEPARATOR '-'
 
@@ -179,7 +180,7 @@ static void set_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_nguid = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description =
         "NGUID or \"" NGUID_VALUE_AUTO "\" for random value",
     .get   = get_nguid,
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index e336874bdef4..eb032ab8b9c8 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -34,6 +34,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/nvram/xlnx-efuse.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #ifndef XLNX_BBRAM_ERR_DEBUG
 #define XLNX_BBRAM_ERR_DEBUG 0
@@ -486,7 +487,7 @@ static void bbram_prop_release_drive(Object *obj, const char *name,
 }
 
 static const PropertyInfo bbram_prop_drive = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as BBRAM backend",
     .realized_set_allowed = true,
     .get = bbram_prop_get_drive,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 03c9fbc0d076..b1c9ee4980a0 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -34,6 +34,7 @@
 #include "system/blockdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #define TBIT0_OFFSET     28
 #define TBIT1_OFFSET     29
@@ -251,7 +252,7 @@ static void efuse_prop_release_drive(Object *obj, const char *name,
 }
 
 static const PropertyInfo efuse_prop_drive = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as eFUSE backend",
     .realized_set_allowed = true,
     .get = efuse_prop_get_drive,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6edc702776ab..1b22c8d112f3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
@@ -80,7 +81,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .get = prop_pci_busnr_get,
 };
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 25c427327957..fd21a4346522 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -17,6 +17,7 @@
 #include "qapi/visitor.h"
 #include "qemu/ctype.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 static void ccw_device_refill_ids(CcwDevice *dev)
 {
@@ -74,7 +75,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
 }
 
 const PropertyInfo ccw_loadparm = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Up to 8 chars in set of [A-Za-z0-9. ] to select"
             " a guest kernel",
     .get = ccw_device_get_loadparm,
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 65341c68c3bf..50d14ab855f7 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -24,6 +24,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 #include "exec/cpu-common.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -2530,7 +2531,7 @@ out:
 }
 
 const PropertyInfo css_devid_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
@@ -2538,7 +2539,7 @@ const PropertyInfo css_devid_propinfo = {
 };
 
 const PropertyInfo css_devid_ro_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Read-only identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2a1..96603bfdb8a9 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -35,6 +35,7 @@
 #include "system/runstate.h"
 
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 S390pciState *s390_get_phb(void)
 {
@@ -1843,7 +1844,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo s390_pci_fid_propinfo = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c5b4f9091d49..4a3fd374a211 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -26,6 +26,7 @@
 #include "pci.h"
 #include "pci-quirks.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 /*
  * List of device ids/vendor ids for which to disable
@@ -1436,7 +1437,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_nv_gpudirect_clique = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "NVIDIA GPUDirect Clique ID (0 - 15)",
     .get = get_nv_gpudirect_clique_id,
     .set = set_nv_gpudirect_clique_id,

-- 
2.56.0.116.g6de20f6092dc

