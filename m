Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493499;
	b=aGOB1teei9IOPzK/bPyMFPPG9/Mn5ORgw6aH3HaQfU0UErqy0GEHQ9PJIAzdT2KwXWQY
	 TZg4PBN1SbvlVHOJnSBz+sjRRX94TGu5KPIvW0SWlg1NQ1+qAsxaMYCw0WbmrJbwfnToa
	 TuuikTD5Mb0tWD8fJZNncZ8+TLKIrJRzcX7810QzorfybShIQnxAyQYB2OuqnR2SMDaB6
	 LImL/+FhJs7reV+NFQ4j+lDYmFG5Q4hCbI0a2lSXMZL5lcp37eAFyBYEs/TAZEuyvGfnq
	 MnEQUb0bk2FAhFKYDNc53YCxpX/BEROmUDD+Hg5jnERAGWNvp2b810N3C08GjtWnyWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493499;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=VTmJNa8VT5lexLUKxdzeLthZimg97eONPVFzq6wZuao=;
	b=HrDmk7NvlcbS4cgR+qlYzZkrwozWvlXv8xDGKe7mF/1R8QwmGIOgQQtMXnGk4PKeqYK1
	 qT2pI6dNlDgZkMxO2YTF1VG2GqNKUBlfbDTkrPubI66AimI0wUXlBWeRbAaw+ZGP91Jev
	 dlvDetYAaWnwYTqXbYGx1bqV16IqIYqeSeO4642H1bFBQjqgnOPHQC6Ogy77oWQ+uR+HL
	 6EUGH8cDJv59uaXlxpausTPjAyYtd+JYv/LlXYDPui4sqtR7Jrzm0c5rpNZOpMX5SNJOY
	 GDpWCM+MjozNpQuaxNl1VsFXG6OuCzD0oc8T0ZBnF2ZXykyQCmPujURnig19xlzFN8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FXe8w243;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39D606A331
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E39D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FXe8w243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTmJNa8VT5lexLUKxdzeLthZimg97eONPVFzq6wZuao=;
	b=FXe8w243Q9D8I7uBTFic2Aq5FrnS9ZN+oY2tlLEZwfs5K57eXA4EAVylFgND5hMjiBSmCF
	LZMJYYPijyVUdT5Y0gnIRVMd/bTVptf3AeuULr80NEUOEzOlV92NP0haUIf6cVYgp74Oum
	WJP7BH3PeUYBu8BD8EuaE6fUt1q/Jm0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-JRWtrvsmMnafOZ4pe9-J1A-1; Tue,
 20 Oct 2026 06:51:33 -0400
X-MC-Unique: JRWtrvsmMnafOZ4pe9-J1A-1
X-Mimecast-MFC-AGG-ID: JRWtrvsmMnafOZ4pe9-J1A_1792493487
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4C2E1800BDD;
	Tue, 20 Oct 2026 10:51:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA95D1800677;
	Tue, 20 Oct 2026 10:51:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:15 +0400
Subject: [PATCH v7 58/65] qdev: convert PropertyInfo definitions to use
 qapi_type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-58-431a86b02b58@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LIT19w6YWiCW19RYxdZdXGqpA2yVHBE+/WdhPO2w+KQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcuI+2h8ZVKhhoVFi3OkRbLhN7DQhHpw2e8
 ZI+IW/5ZPeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5d+rD/94HsUuS+bA630XGAf6+mNBdx3g5ggb5XrVvKXw9Au65Kows5jbGNX5ExMKeDtXzXsYPQZ
 7bawMDy/OvYIm6c0sRa+DQhSHoKTRGyrflTzi3akNDBX1iTFKTE4ApPz982Yb2V1+zjv7S6JoKL
 s9x+m0L+aJhxXlji2Ne4h/2GqI65xptxwVMDeF5hdFhM1b/GVOLPZQYUgjk16EE7HtDzi9XcRpU
 qLzkGt0xA8pztXbBxv9kfTMNJvnlKFhUM2FhczGoJMlwLYyrRx/K4ZHzoaT6XiuPZUK7YMxmpkr
 6kU46qGrWbK2PfH+q/Y8JKYadL6yh8v3kSS3na9fd5DaDkQX0p+Bnx8iLycn9BNcAfY/w7UNwsU
 1syWcvdD3Zjx91KEjMZBf6XQOUp3zeontuSGuATb4jhC/tPGcmnOMzCZilju6MMinaNxT3lY42y
 HXItgz39UYWffKdBjfxJX3O1XuqYxbblcTGZmheVuso724KYPKlpfJKMUI+l8dYZwzkB21LBjpD
 CypHEsnuhmR2vRevpDVirDYKTs59vv51cttaKCBf0mOGodSLdbRKt66uM3ORmazmTeb/HPU+/oD
 vW8fnePj8pQJmxXFS18zBsuuz75rzcslLcOf/SWSu8i8o5lSfTxYhOhED+/Lizl23J6M6lVvKko
 +KUM9I7WMK1AoZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: EBW68_4fCxuMjE5pLoA1A_m_7b4js9ESbJBGvspU_8I_1792493487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the remaining PropertyInfo definitions outside hw/

After this patch, all PropertyInfo definitions have .qapi_type set,
except qdev_prop_link (uses .create) and qdev_prop_array (refactored
in the next patches).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/spdm-socket.c  | 4 ++--
 backends/tpm/tpm_util.c | 3 ++-
 migration/options.c     | 4 +++-
 target/sparc/cpu.c      | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 826efc276dcd..4a4307975965 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -17,6 +17,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/core/qdev-prop-internal.h"
+#include "qapi/qapi-type-infos-sockets.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
                        size_t number_of_bytes)
@@ -253,9 +254,8 @@ void spdm_socket_close(const int socket, SpdmTransportType transport_type)
 }
 
 const PropertyInfo qdev_prop_spdm_trans = {
-    .type = "SpdmTransportType",
+    .qapi_type = &SpdmTransportType_type_info,
     .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
-    .enum_table = &SpdmTransportType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 7019f7fd3eb9..dc6d4b211567 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -30,6 +30,7 @@
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 /* tpm backend property */
 
@@ -77,7 +78,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_tpm = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a tpm to use as a backend",
     .get   = get_tpm,
     .set   = set_tpm,
diff --git a/migration/options.c b/migration/options.c
index 46d040fc3f25..029282a1605c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,8 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-common.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -294,7 +296,7 @@ static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
  * TYPE_MIGRATION's TLS options.
  */
 const PropertyInfo qdev_prop_StrOrNull = {
-    .type  = "StrOrNull",
+    .qapi_type = &StrOrNull_type_info,
     .get = get_StrOrNull,
     .set = set_StrOrNull,
     .release = release_StrOrNull,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df82..d0354a4d02af 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "target/sparc/translate.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 //#define DEBUG_FEATURES
 
@@ -948,7 +949,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo qdev_prop_nwindows = {
-    .type  = "int",
+    .qapi_type = &int_type_info,
     .description = "Number of register windows",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,

-- 
2.56.0.116.g6de20f6092dc

