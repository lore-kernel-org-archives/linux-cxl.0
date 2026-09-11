Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40144A5EB0
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144801; cv=none; b=fJQ7uQpX8FVyIlTnqEhuc3qOBfprkNaZ7VV8Ma3Kq6C9QHFXHt2IpSBE2vxc8UTYspTzLfqpxcc150Xb7y06d94tGhZ0BHklUt3cRDuy/m+aTL2EErYb9h44crqnlsYGU7+LuPOe80RQsw6Ynaekd5fVhDUvo7K/AZTbkmxeQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144801; c=relaxed/simple;
	bh=mPg1F4fKLAvQtx73sQYbUGyKE/L5S5p7sMB8QV3n394=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=fsBaOdzPBMRIuZOZMylHlxwj/4UIgWnmHZZ2a1oG8Ci4CwfrrEMm9T7K8dWlbbZrA6FkM4EtxteSAFU4cwq+31752m5wdUK3CRNkakQ60rTL8EUQtuG9Pbqo7jxG4MQ8AaIoobEyOL0XsBdRs0x75JfyShSgAb4DWngDvvotXVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJjCI6yu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJjCI6yu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789144790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7kLKMCQpmhePPANiYhWYMYAMrriWH4JjeS/cBrPX8I=;
	b=BJjCI6yuyO21bF2J9pZ4VQmVD+sbkZShVsDWs5b0peneP19tQOPglg1ZULje0ZClTJGhSa
	uLr0MdbQd2BYALqh53lzcIwOYr1OmiiR2oScO0wMupjKDjt3vl5LeuvN+XO2vU1s/OgyzN
	y/ThH2F6MdbNRuyOXuv2Y9LeiaaK2Y0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-6Hn2_42QPVCuLKvDTf8kCw-1; Fri,
 11 Sep 2026 12:39:44 -0400
X-MC-Unique: 6Hn2_42QPVCuLKvDTf8kCw-1
X-Mimecast-MFC-AGG-ID: 6Hn2_42QPVCuLKvDTf8kCw_1789144781
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C896A19539BF;
	Fri, 11 Sep 2026 16:39:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 908D4433;
	Fri, 11 Sep 2026 16:39:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:09 +0400
Subject: [PATCH v5 35/62] qom: convert scalar properties to QAPI-aware
 registration
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260911-qom-qapi-v5-35-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, Alexander Graf <graf@amazon.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Igor Mammedov <imammedo@redhat.com>, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Samuel Tardieu <sam@rfc1149.net>, Marcelo Tosatti <mtosatti@redhat.com>, 
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Jason Wang <jasowangio@gmail.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, kvm@vger.kernel.org, 
 qemu-block@nongnu.org, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 xen-devel@lists.xenproject.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=108182;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mPg1F4fKLAvQtx73sQYbUGyKE/L5S5p7sMB8QV3n394=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC260yI9VAQcQ6aEdGdAMcElEGZpokov8qFTJ
 qDkKIVXTJOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtugAKCRDa6OEJdZac
 5R7qEACr2Hv512AspLmegcehc6w1nUlRMPxvkWPfM7Ug/f06heqWe4RbGPPsz7wCZXNM6/MDIM5
 SGxBCQ7kFkOAXROlYyIyAABLuFl4Ij6jhN4CsltVLsPhaNsiTK/jQ55pdFWTtZmdTiHMyTcAChQ
 bK+8KqlNiACpj75rZFpNCuOJnqFlu2WKlTZIgNeVsKJ5sIpXd2Af1xAinycm4+fKg1xZ+M2Duuq
 CxZwnhKNhOWT4OqrrGw8tFyrR4CjAMcD2FBzDWOQjGvhjdzr0cRQf/46/35yYWQ6rdFZ42vQFc/
 aGoK4Vv2/JMVmpGbCLVXOA3jaJvOkHFFavEbrOP8vtDBSmRR7BEQKd39IEhrpMUk+VbTlGDWfi9
 slA7lL/v9ua+VMNgZ1W30jANsZ1kKXoj4ot00hdRaHaDKLpQy7WykqklUDQEhlJZ5+3d5tNFYXl
 0sMS55Rgbx7bxwO7lpa0Ge3p3E02Do0hx02/kIecwjj4Q1kpyHYGNSMnIozZmgkig5IGgtC+4w7
 qqsWB2x+cWfPHTlP7FGeh1lcl/99lOdruXWO+gqnknqlFCM6nDcTxWNZDyJWBXS+teubBPBC7B4
 071cpuEuKQSR8H1eJN8ar0Y+CVjKlfuWCQGCOx08Iz2PgjpvLbaiiRWFYdJXzobhhjgE0GYVSVl
 3B/NDidF+InlSLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: ZXkXcdW9HBxy82okybLOL_1FKtvmJdnAmlKWqUucnkc_1789144781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c                 |  5 ++-
 accel/nitro/nitro-accel.c           |  3 +-
 accel/tcg/tcg-all.c                 |  3 +-
 backends/cryptodev.c                |  7 ++--
 backends/hostmem-file.c             |  4 +-
 backends/hostmem-memfd.c            |  3 +-
 backends/hostmem.c                  |  6 +--
 block/throttle-groups.c             |  5 ++-
 crypto/secret_keyring.c             |  9 +++--
 event-loop-base.c                   |  7 ++--
 hw/acpi/ich9.c                      |  1 +
 hw/acpi/pci.c                       |  7 ++--
 hw/arm/virt.c                       |  4 +-
 hw/core/clock.c                     |  3 +-
 hw/core/machine.c                   |  2 +-
 hw/cpu/core.c                       | 10 +++--
 hw/cxl/cxl-host.c                   |  2 +-
 hw/gpio/aspeed_gpio.c               |  5 ++-
 hw/gpio/aspeed_sgpio.c              |  3 +-
 hw/gpio/stm32l4x5_gpio.c            |  5 ++-
 hw/i386/pc.c                        |  6 +--
 hw/i386/sgx-epc.c                   |  3 +-
 hw/i386/x86.c                       |  6 +--
 hw/ide/ide-dev.c                    |  3 +-
 hw/intc/apic_common.c               |  3 +-
 hw/loongarch/virt.c                 |  2 +-
 hw/mem/nvdimm.c                     |  7 ++--
 hw/mem/pc-dimm.c                    |  3 +-
 hw/misc/aspeed_lpc.c                | 73 +++++++++++++++++++++++++------------
 hw/misc/aspeed_sdmc.c               |  3 +-
 hw/misc/npcm7xx_mft.c               |  3 +-
 hw/net/ne2000-isa.c                 |  3 +-
 hw/nvme/ctrl.c                      |  3 +-
 hw/pci-bridge/pci_expander_bridge.c |  3 +-
 hw/pci-host/i440fx.c                | 29 +++++++++------
 hw/pci-host/pnv_phb3.c              |  5 ++-
 hw/pci-host/pnv_phb4.c              |  5 ++-
 hw/pci-host/q35.c                   |  9 +++--
 hw/ppc/spapr_drc.c                  |  3 +-
 hw/riscv/microchip_pfsoc.c          |  3 +-
 hw/s390x/sclpcpi.c                  |  8 ++--
 hw/s390x/virtio-ccw-mem.c           |  3 +-
 hw/sensor/adc128d818.c              | 16 +++++---
 hw/sensor/adm1266.c                 |  3 +-
 hw/sensor/adm1272.c                 |  9 +++--
 hw/sensor/emc141x.c                 |  9 +++--
 hw/sensor/isl_pmbus_vr.c            | 19 +++++-----
 hw/sensor/lsm303dlhc_mag.c          |  9 +++--
 hw/sensor/max34451.c                |  5 ++-
 hw/sensor/tmp105.c                  |  3 +-
 hw/sensor/tmp421.c                  |  9 +++--
 hw/usb/dev-storage-classic.c        |  3 +-
 hw/virtio/virtio-balloon.c          |  3 +-
 hw/virtio/virtio-mem-pci.c          |  3 +-
 hw/virtio/virtio-mem.c              | 18 +++++----
 hw/xen/xen-pvh-common.c             |  9 +++--
 iothread.c                          |  9 +++--
 net/colo-compare.c                  |  7 ++--
 net/dump.c                          |  6 ++-
 net/filter-buffer.c                 |  3 +-
 qom/object.c                        | 42 ++++++++++-----------
 system/bootdevice.c                 |  3 +-
 system/memory.c                     |  5 ++-
 target/arm/cpu64.c                  | 11 +++---
 target/arm/kvm.c                    |  3 +-
 target/arm/tcg/cpu64.c              | 11 +++---
 target/i386/cpu.c                   | 12 +++---
 target/i386/kvm/kvm.c               |  8 ++--
 target/i386/sev.c                   |  2 +-
 target/ppc/compat.c                 |  3 +-
 target/riscv/cpu.c                  | 15 ++++----
 target/riscv/kvm/kvm-cpu.c          |  7 ++--
 target/riscv/tcg/tcg-cpu.c          | 13 ++++---
 target/s390x/cpu_models.c           |  5 ++-
 tests/unit/test-qdev-global-props.c | 11 ++++--
 ui/console.c                        |  3 +-
 util/thread-context.c               |  7 ++--
 77 files changed, 343 insertions(+), 241 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e2cfbcf44046..ff9db3ca8b3d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -24,6 +24,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/s390x/adapter.h"
@@ -4278,13 +4279,13 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
         .description = "Configure KVM in-kernel irqchip",
     ));
 
-    object_class_property_add(oc, "kvm-shadow-mem", "int",
+    object_class_property_add_qapi(oc, "kvm-shadow-mem", &int_type_info,
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
         NULL, NULL);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size");
 
-    object_class_property_add(oc, "dirty-ring-size", "uint32",
+    object_class_property_add_qapi(oc, "dirty-ring-size", &uint32_type_info,
         kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
         NULL, NULL);
     object_class_property_set_description(oc, "dirty-ring-size",
diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
index a1e97a9162e9..05841c1277dc 100644
--- a/accel/nitro/nitro-accel.c
+++ b/accel/nitro/nitro-accel.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qemu/rcu.h"
@@ -238,7 +239,7 @@ static void nitro_accel_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "debug-mode",
         "Start enclave in debug mode (enables console output)");
 
-    object_class_property_add(oc, "enclave-cid", "uint64",
+    object_class_property_add_qapi(oc, "enclave-cid", &uint64_type_info,
                               nitro_get_enclave_cid,
                               nitro_set_enclave_cid,
                               NULL, NULL);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 767e8805552f..277cf0e2d012 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -29,6 +29,7 @@
 #include "exec/icount.h"
 #include "tcg/startup.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
 #include "qemu/atomic.h"
@@ -270,7 +271,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                   tcg_get_thread,
                                   tcg_set_thread);
 
-    object_class_property_add(oc, "tb-size", "uint32",
+    object_class_property_add_qapi(oc, "tb-size", &uint32_type_info,
         tcg_get_tb_size, tcg_set_tb_size,
         NULL, NULL);
     object_class_property_set_description(oc, "tb-size",
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index e8f2b18f2017..a69adb70440c 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -25,6 +25,7 @@
 #include "system/cryptodev.h"
 #include "system/stats.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-cryptodev.h"
 #include "qapi/qapi-types-stats.h"
 #include "qapi/visitor.h"
@@ -622,15 +623,15 @@ cryptodev_backend_class_init(ObjectClass *oc, const void *data)
     ucc->prepare_delete = cryptodev_backend_prepare_delete;
 
     QTAILQ_INIT(&crypto_clients);
-    object_class_property_add(oc, "queues", "uint32",
+    object_class_property_add_qapi(oc, "queues", &uint32_type_info,
                               cryptodev_backend_get_queues,
                               cryptodev_backend_set_queues,
                               NULL, NULL);
-    object_class_property_add(oc, "throttle-bps", "uint64",
+    object_class_property_add_qapi(oc, "throttle-bps", &uint64_type_info,
                               cryptodev_backend_get_bps,
                               cryptodev_backend_set_bps,
                               NULL, NULL);
-    object_class_property_add(oc, "throttle-ops", "uint64",
+    object_class_property_add_qapi(oc, "throttle-ops", &uint64_type_info,
                               cryptodev_backend_get_ops,
                               cryptodev_backend_set_ops,
                               NULL, NULL);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 9c7e0183d480..aeb6fc37858c 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -275,11 +275,11 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path);
-    object_class_property_add(oc, "align", "uint64",
+    object_class_property_add_qapi(oc, "align", &uint64_type_info,
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL);
-    object_class_property_add(oc, "offset", "int",
+    object_class_property_add_qapi(oc, "offset", &int_type_info,
         file_memory_backend_get_offset,
         file_memory_backend_set_offset,
         NULL, NULL);
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index e21c5a3f2e24..42027529ab50 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -16,6 +16,7 @@
 #include "qemu/memfd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qom/object.h"
 #include "migration/cpr.h"
 
@@ -145,7 +146,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                        memfd_backend_set_hugetlb);
         object_class_property_set_description(oc, "hugetlb",
                                               "Use huge pages");
-        object_class_property_add(oc, "hugetlbsize", "uint64",
+        object_class_property_add_qapi(oc, "hugetlbsize", &uint64_type_info,
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
                                   NULL, NULL);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index e7f9b436a459..d05ab53ab662 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -529,7 +529,7 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         host_memory_backend_set_prealloc);
     object_class_property_set_description(oc, "prealloc",
         "Preallocate memory");
-    object_class_property_add(oc, "prealloc-threads", "int",
+    object_class_property_add_qapi(oc, "prealloc-threads", &int_type_info,
         host_memory_backend_get_prealloc_threads,
         host_memory_backend_set_prealloc_threads,
         NULL, NULL);
@@ -540,13 +540,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         object_property_allow_set_link, OBJ_PROP_LINK_STRONG);
     object_class_property_set_description(oc, "prealloc-context",
         "Context to use for creating CPU threads for preallocation");
-    object_class_property_add(oc, "size", "size",
+    object_class_property_add_qapi(oc, "size", &size_type_info,
         host_memory_backend_get_size,
         host_memory_backend_set_size,
         NULL, NULL);
     object_class_property_set_description(oc, "size",
         "Size of the memory region (ex: 500M)");
-    object_class_property_add(oc, "host-nodes", "[uint16]",
+    object_class_property_add_qapi(oc, "host-nodes", &uint16List_type_info,
         host_memory_backend_get_host_nodes,
         host_memory_backend_set_host_nodes,
         NULL, NULL);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 6312157802da..851617237f80 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -31,6 +31,7 @@
 #include "qemu/thread.h"
 #include "system/qtest.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-type-infos-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
@@ -983,9 +984,9 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
 
     /* individual properties */
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
-        object_class_property_add(klass,
+        object_class_property_add_qapi(klass,
                                   properties[i].name,
-                                  "int64",
+                                  &int64_type_info,
                                   throttle_group_get,
                                   throttle_group_set,
                                   NULL, &properties[i]);
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 3b332276ef5b..6ac7cd6a232d 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <asm/unistd.h>
 #include <linux/keyctl.h>
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
@@ -107,10 +108,10 @@ qcrypto_secret_keyring_class_init(ObjectClass *oc, const void *data)
     QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
     sic->load_data = qcrypto_secret_keyring_load_data;
 
-    object_class_property_add(oc, "serial", "int32_t",
-                                  qcrypto_secret_prop_get_key,
-                                  qcrypto_secret_prop_set_key,
-                                  NULL, NULL);
+    object_class_property_add_qapi(oc, "serial", &int32_type_info,
+                                   qcrypto_secret_prop_get_key,
+                                   qcrypto_secret_prop_set_key,
+                                   NULL, NULL);
 }
 
 
diff --git a/event-loop-base.c b/event-loop-base.c
index 23f554d92ce8..c16c5366f680 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "block/thread-pool.h"
 #include "system/event-loop-base.h"
 
@@ -104,15 +105,15 @@ static void event_loop_base_class_init(ObjectClass *klass,
     ucc->complete = event_loop_base_complete;
     ucc->prepare_delete = event_loop_base_prepare_delete;
 
-    object_class_property_add(klass, "aio-max-batch", "int64",
+    object_class_property_add_qapi(klass, "aio-max-batch", &int64_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &aio_max_batch_info);
-    object_class_property_add(klass, "thread-pool-min", "int64",
+    object_class_property_add_qapi(klass, "thread-pool-min", &int64_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_min_info);
-    object_class_property_add(klass, "thread-pool-max", "int64",
+    object_class_property_add_qapi(klass, "thread-pool-max", &int64_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_max_info);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 8082eae4282a..cf503668c00a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index c82924be8620..71d01307e141 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/core/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
@@ -139,7 +140,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
         acpi_generic_initiator_set_pci_device);
     object_class_property_set_description(oc, "pci-dev",
         "PCI device to associate with the node");
-    object_class_property_add(oc, "node", "uint32", NULL,
+    object_class_property_add_qapi(oc, "node", &uint32_type_info, NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
         "NUMA node associated with the PCI device");
@@ -253,8 +254,8 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
         acpi_generic_port_set_pci_bus);
     object_class_property_set_description(oc, "pci-bus",
        "PCI Bus of the host bridge associated with this GP affinity structure");
-    object_class_property_add(oc, "node", "uint32", NULL,
-        acpi_generic_port_set_node, NULL, NULL);
+    object_class_property_add_qapi(oc, "node", &uint32_type_info, NULL,
+       acpi_generic_port_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
        "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 872920b6482b..4e5d8d9f86e3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4258,7 +4258,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
-    object_class_property_add(oc, "highmem-mmio-size", "size",
+    object_class_property_add_qapi(oc, "highmem-mmio-size", &size_type_info,
                                    virt_get_highmem_mmio_size,
                                    virt_set_highmem_mmio_size,
                                    NULL, NULL);
@@ -4266,7 +4266,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
-    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
+    object_class_property_add_qapi(oc, "virtio-mmio-transports", &uint8_type_info,
                                    virt_get_virtio_transports,
                                    virt_set_virtio_transports,
                                    NULL, NULL);
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 3fc98a0c65d5..f55cb17af77e 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
 #include "hw/core/clock.h"
@@ -185,7 +186,7 @@ static void clock_initfn(Object *obj)
     QLIST_INIT(&clk->children);
 
     if (qtest_enabled()) {
-        object_property_add(obj, "qtest-clock-period", "uint64",
+        object_property_add_qapi(obj, "qtest-clock-period", &uint64_type_info,
                             clock_period_prop_get, NULL, NULL, NULL);
     }
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 530fbaeb0b28..aa2d90a4e4df 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1133,7 +1133,7 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "smp-cache",
         "Cache properties list for SMP machine");
 
-    object_class_property_add(oc, "phandle-start", "int",
+    object_class_property_add_qapi(oc, "phandle-start", &int_type_info,
         machine_get_phandle_start, machine_set_phandle_start,
         NULL, NULL);
     object_class_property_set_description(oc, "phandle-start",
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 26e488f3d8e3..d7c89f47ab04 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "hw/cpu/core.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 
 static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
@@ -82,10 +83,11 @@ static void cpu_core_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    object_class_property_add(oc, "core-id", "int", core_prop_get_core_id,
-                              core_prop_set_core_id, NULL, NULL);
-    object_class_property_add(oc, "nr-threads", "int", core_prop_get_nr_threads,
-                              core_prop_set_nr_threads, NULL, NULL);
+    object_class_property_add_qapi(oc, "core-id", &int_type_info, core_prop_get_core_id,
+                                   core_prop_set_core_id, NULL, NULL);
+    object_class_property_add_qapi(oc, "nr-threads", &int_type_info,
+                                   core_prop_get_nr_threads, core_prop_set_nr_threads,
+                                   NULL, NULL);
 }
 
 static const TypeInfo cpu_core_type_info = {
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7592c4ac6c7b..4133398fec48 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -565,7 +565,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
 
 void cxl_machine_init(Object *obj, CXLState *state)
 {
-    object_property_add(obj, "cxl", "bool", machine_get_cxl,
+    object_property_add_qapi(obj, "cxl", &bool_type_info, machine_get_cxl,
                         machine_set_cxl, NULL, state);
     object_property_set_description(obj, "cxl",
                                     "Set on/off to enable/disable "
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 1cf6f5df5505..0c90bcd723da 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -12,6 +12,7 @@
 #include "hw/gpio/aspeed_gpio.h"
 #include "hw/misc/aspeed_scu.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
@@ -1481,7 +1482,7 @@ static void aspeed_gpio_init(Object *obj)
             int pin_idx = j % GPIOS_PER_GROUP;
             const char *group = &props->group_label[group_idx][0];
             char *name = g_strdup_printf("gpio%s%d", group, pin_idx);
-            object_property_add(obj, name, "bool", aspeed_gpio_get_pin,
+            object_property_add_qapi(obj, name, &bool_type_info, aspeed_gpio_get_pin,
                                 aspeed_gpio_set_pin, NULL, NULL);
             g_free(name);
         }
@@ -1489,7 +1490,7 @@ static void aspeed_gpio_init(Object *obj)
 
     for (int i = 0; i < agc->nr_gpio_sets; i++) {
         g_autofree char *name = g_strdup_printf("gpio-set[%d]", i);
-        object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
+        object_property_add_qapi(obj, name, &uint32_type_info, aspeed_gpio_get_set,
         aspeed_gpio_set_set, NULL, NULL);
     }
 }
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 7d2f73699520..67b0c10d79fa 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
@@ -300,7 +301,7 @@ static void aspeed_sgpio_init(Object *obj)
 {
     for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
         g_autofree char *name = g_strdup_printf("sgpio%03d", i);
-        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
+        object_property_add_qapi(obj, name, &bool_type_info, aspeed_sgpio_get_pin,
                             aspeed_sgpio_set_pin, NULL, NULL);
     }
 }
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 92fa397fbafe..d349d41e41a1 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -25,6 +25,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -409,10 +410,10 @@ static void stm32l4x5_gpio_init(Object *obj)
 
     s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
 
-    object_property_add(obj, "disconnected-pins", "uint16",
+    object_property_add_qapi(obj, "disconnected-pins", &uint16_type_info,
                         disconnected_pins_get, disconnected_pins_set,
                         NULL, &s->disconnected_pins);
-    object_property_add(obj, "clock-freq-hz", "uint32",
+    object_property_add_qapi(obj, "clock-freq-hz", &uint32_type_info,
                         clock_freq_get, NULL, NULL, NULL);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 18b5dc169ab7..24c4c589ed04 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1720,7 +1720,7 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
-    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
+    object_class_property_add_qapi(oc, PC_MACHINE_MAX_RAM_BELOW_4G, &size_type_info,
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
@@ -1758,13 +1758,13 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
         pc_machine_get_default_bus_bypass_iommu,
         pc_machine_set_default_bus_bypass_iommu);
 
-    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
+    object_class_property_add_qapi(oc, PC_MACHINE_MAX_FW_SIZE, &size_type_info,
         pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
         "Maximum combined firmware size");
 
-    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str",
+    object_class_property_add_qapi(oc, PC_MACHINE_SMBIOS_EP, &str_type_info,
         pc_machine_get_smbios_ep, pc_machine_set_smbios_ep,
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c51..d9b9ab3f7a96 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -15,6 +15,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "target/i386/cpu.h"
 #include "system/address-spaces.h"
@@ -43,7 +44,7 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
 
 static void sgx_epc_init(Object *obj)
 {
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
+    object_property_add_qapi(obj, SGX_EPC_SIZE_PROP, &uint64_type_info, sgx_epc_get_size,
                         NULL, NULL, NULL);
 }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 63f297a10532..d0c782ec8544 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -420,9 +420,9 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
-    object_class_property_add(oc, X86_MACHINE_BUS_LOCK_RATELIMIT, "uint64_t",
-                                x86_machine_get_bus_lock_ratelimit,
-                                x86_machine_set_bus_lock_ratelimit, NULL, NULL);
+    object_class_property_add_qapi(oc, X86_MACHINE_BUS_LOCK_RATELIMIT, &uint64_type_info,
+                                   x86_machine_get_bus_lock_ratelimit,
+                                   x86_machine_set_bus_lock_ratelimit, NULL, NULL);
     object_class_property_set_description(oc, X86_MACHINE_BUS_LOCK_RATELIMIT,
             "Set the ratelimit for the bus locks acquired in VMs");
 
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 5d478588c614..e2dd2439991f 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-types-block.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -174,7 +175,7 @@ out:
 
 static void ide_dev_instance_init(Object *obj)
 {
-    object_property_add(obj, "bootindex", "int32",
+    object_property_add_qapi(obj, "bootindex", &int32_type_info,
                         ide_dev_get_bootindex,
                         ide_dev_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 0f0f37d45734..dc0517ceea90 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
@@ -442,7 +443,7 @@ static void apic_common_initfn(Object *obj)
     APICCommonState *s = APIC_COMMON(obj);
 
     s->id = s->initial_apic_id = -1;
-    object_property_add(obj, "id", "uint32",
+    object_property_add_qapi(obj, "id", &uint32_type_info,
                         apic_common_get_id,
                         apic_common_set_id, NULL, NULL);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 750ce2dbe5fc..209a0feddd80 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1520,7 +1520,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "highmem-mmio",
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
-    object_class_property_add(oc, "highmem-mmio-size", "size",
+    object_class_property_add_qapi(oc, "highmem-mmio-size", &size_type_info,
                                    virt_get_highmem_mmio_size,
                                    virt_set_highmem_mmio_size,
                                    NULL, NULL);
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index cf8a4d8c5f2a..123ddc938546 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "qemu/pmem.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/core/qdev-properties.h"
@@ -99,9 +100,9 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size",
-                        nvdimm_get_label_size, nvdimm_set_label_size, NULL,
-                        NULL);
+    object_property_add_qapi(obj, NVDIMM_LABEL_SIZE_PROP, &size_type_info,
+                             nvdimm_get_label_size, nvdimm_set_label_size, NULL,
+                             NULL);
 
     object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
                         nvdimm_set_uuid, NULL, NULL);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 68862926ee2d..ee586ecc0c7d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -26,6 +26,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "system/hostmem.h"
@@ -176,7 +177,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
 
 static void pc_dimm_init(Object *obj)
 {
-    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_size,
+    object_property_add_qapi(obj, PC_DIMM_SIZE_PROP, &uint64_type_info, pc_dimm_get_size,
                         NULL, NULL, NULL);
 }
 
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 7f7e4f1a0985..e2d9b7572f27 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
@@ -417,30 +418,54 @@ static void aspeed_lpc_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_lpc_init(Object *obj)
 {
-    object_property_add(obj, "idr1", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr1", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str1", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr2", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr2", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str2", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr3", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr3", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str3", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr4", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr4", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str4", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
+    object_property_add_qapi(obj, "idr1", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr1", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str1", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "idr2", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr2", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str2", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "idr3", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr3", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str3", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "idr4", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr4", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str4", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
 }
 
 static const VMStateDescription vmstate_aspeed_lpc = {
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f8fbaebee6ab..d096cc88f5c5 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -15,6 +15,7 @@
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "trace.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
@@ -259,7 +260,7 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
 
 static void aspeed_sdmc_initfn(Object *obj)
 {
-    object_property_add(obj, "ram-size", "int",
+    object_property_add_qapi(obj, "ram-size", &int_type_info,
                         aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size,
                         NULL, NULL);
 }
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 742166c4e828..99e9e49788c0 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -23,6 +23,7 @@
 #include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -491,7 +492,7 @@ static void npcm7xx_mft_init(Object *obj)
     s->clock_2 = qdev_init_clock_out(dev, "clock2");
 
     for (int i = 0; i < NPCM7XX_PWM_PER_MODULE; ++i) {
-        object_property_add(obj, "max_rpm[*]", "uint32",
+        object_property_add_qapi(obj, "max_rpm[*]", &uint32_type_info,
                             npcm7xx_mft_get_max_rpm,
                             npcm7xx_mft_set_max_rpm,
                             NULL, &s->max_rpm[i]);
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 673c785abc94..63e0d40ee726 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -29,6 +29,7 @@
 #include "ne2000.h"
 #include "system/system.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -131,7 +132,7 @@ out:
 
 static void isa_ne2000_instance_init(Object *obj)
 {
-    object_property_add(obj, "bootindex", "int32",
+    object_property_add_qapi(obj, "bootindex", &int32_type_info,
                         isa_ne2000_get_bootindex,
                         isa_ne2000_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c662d968db1e..a72189e0a63c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -203,6 +203,7 @@
 #include "qemu/units.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/block-backend.h"
@@ -10578,7 +10579,7 @@ static void nvme_instance_init(Object *obj)
                                   "bootindex", "/namespace@1,0",
                                   DEVICE(obj));
 
-    object_property_add(obj, "smart_critical_warning", "uint8",
+    object_property_add_qapi(obj, "smart_critical_warning", &uint8_type_info,
                         nvme_get_smart_warning,
                         nvme_set_smart_warning, NULL, NULL);
 }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e0821..9bb7d3c9debe 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
@@ -103,7 +104,7 @@ static void pxb_bus_class_init(ObjectClass *class, const void *data)
     pbc->bus_num = pxb_bus_num;
     pbc->numa_node = pxb_bus_numa_node;
 
-    object_class_property_add(class, "acpi_uid", "uint32",
+    object_class_property_add_qapi(class, "acpi_uid", &uint32_type_info,
                               prop_pxb_uid_get, NULL, NULL, NULL);
     object_class_property_set_description(class, "acpi_uid",
         "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index c1982f7962a6..feafa6a72fe4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -32,6 +32,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "migration/vmstate.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
@@ -387,21 +388,25 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, const void *data)
     /* Reason: needs to be wired up by pc_init1 */
     dc->user_creatable = false;
 
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-                              i440fx_pcihost_get_pci_hole_start,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE_START,
+                                   &uint32_type_info,
+                                   i440fx_pcihost_get_pci_hole_start,
+                                   NULL, NULL, NULL);
 
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
-                              i440fx_pcihost_get_pci_hole_end,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE_END,
+                                   &uint32_type_info,
+                                   i440fx_pcihost_get_pci_hole_end,
+                                   NULL, NULL, NULL);
 
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
-                              i440fx_pcihost_get_pci_hole64_start,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE64_START,
+                                   &uint64_type_info,
+                                   i440fx_pcihost_get_pci_hole64_start,
+                                   NULL, NULL, NULL);
 
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
-                              i440fx_pcihost_get_pci_hole64_end,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE64_END,
+                                   &uint64_type_info,
+                                   i440fx_pcihost_get_pci_hole64_end,
+                                   NULL, NULL, NULL);
 }
 
 static const TypeInfo i440fx_pcihost_info = {
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index db061c134e95..667e9585ab8f 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -11,6 +11,7 @@
 #include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/pci-host/pnv_phb3_regs.h"
 #include "hw/pci-host/pnv_phb.h"
 #include "hw/pci-host/pnv_phb3.h"
@@ -1164,12 +1165,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "uint32",
+    object_class_property_add_qapi(klass, "phb-id", &uint32_type_info,
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "uint32",
+    object_class_property_add_qapi(klass, "chip-id", &uint32_type_info,
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 9acaf4c0c2f5..96c2f89f889b 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -11,6 +11,7 @@
 #include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "target/ppc/cpu.h"
 #include "hw/pci-host/pnv_phb4_regs.h"
 #include "hw/pci-host/pnv_phb4.h"
@@ -1761,12 +1762,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "uint32",
+    object_class_property_add_qapi(klass, "phb-id", &uint32_type_info,
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "uint32",
+    object_class_property_add_qapi(klass, "chip-id", &uint32_type_info,
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index f4556ad03a04..6eba30e06811 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 
@@ -226,19 +227,19 @@ static void q35_host_initfn(Object *obj)
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE_START, &uint32_type_info,
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE_END, &uint32_type_info,
                         q35_host_get_pci_hole_end,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE64_START, &uint64_type_info,
                         q35_host_get_pci_hole64_start,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE64_END, &uint64_type_info,
                         q35_host_get_pci_hole64_end,
                         NULL, NULL, NULL);
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 5c2150b71c86..64f9ca29b02e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qobject/qnull.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
@@ -584,7 +585,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
-    object_property_add(obj, "index", "uint32", prop_get_index,
+    object_property_add_qapi(obj, "index", &uint32_type_info, prop_get_index,
                         NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL);
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index edd29626fa07..e36063244bde 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -39,6 +39,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -743,7 +744,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
      */
     mc->default_ram_size = 1537 * MiB;
 
-    object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
+    object_class_property_add_qapi(oc, "clint-timebase-frequency", &uint32_type_info,
                               microchip_icicle_kit_get_clint_timebase_freq,
                               microchip_icicle_kit_set_clint_timebase_freq,
                               NULL, NULL);
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index ec4bdf23509b..97d37ae4b932 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -53,6 +53,7 @@
 #include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-events-machine-s390x.h"
 #include "migration/vmstate.h"
@@ -195,12 +196,13 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
             "name of the cluster which the VM belongs to, if any"
             " e.g. \"PLEX    \"");
 
-    object_class_property_add(klass, "system_level", "uint64", get_system_level,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, "system_level",
+                                   &uint64_type_info, get_system_level,
+                                   NULL, NULL, NULL);
     object_class_property_set_description(klass, "system_level",
             "distribution and kernel version in Linux e.g. 74872343805430528");
 
-    object_class_property_add(klass, "timestamp", "uint64", get_timestamp,
+    object_class_property_add_qapi(klass, "timestamp", &uint64_type_info, get_timestamp,
                               NULL, NULL, NULL);
     object_class_property_set_description(klass, "timestamp",
             "latest update of CPI data in nanoseconds since the UNIX EPOCH");
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index dea30aacfb32..046dfd544cf3 100644
--- a/hw/s390x/virtio-ccw-mem.c
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/module.h"
 #include "virtio-ccw-mem.h"
 #include "hw/mem/memory-device.h"
@@ -205,7 +206,7 @@ static void virtio_ccw_mem_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+    object_property_add_qapi(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, &size_type_info,
                         virtio_ccw_mem_get_requested_size,
                         virtio_ccw_mem_set_requested_size, NULL, NULL);
 }
diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
index c65508cba144..7efc48a036ec 100644
--- a/hw/sensor/adc128d818.c
+++ b/hw/sensor/adc128d818.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qom/object.h"
@@ -642,15 +643,18 @@ static void adc128d818_initfn(Object *obj)
     for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
         char *name = g_strdup_printf("ain%u", ch);
 
-        object_property_add(obj, name, "int", adc128d818_get_ain,
-                            adc128d818_set_ain, NULL, NULL);
+        object_property_add_qapi(obj, name, &int_type_info,
+                                 adc128d818_get_ain,
+                                 adc128d818_set_ain, NULL, NULL);
         g_free(name);
     }
 
-    object_property_add(obj, "temperature", "int", adc128d818_get_temperature,
-                        adc128d818_set_temperature, NULL, NULL);
-    object_property_add(obj, "ext-vref-mv", "int", adc128d818_get_ext_vref,
-                        adc128d818_set_ext_vref, NULL, NULL);
+    object_property_add_qapi(obj, "temperature", &int_type_info,
+                             adc128d818_get_temperature,
+                             adc128d818_set_temperature, NULL, NULL);
+    object_property_add_qapi(obj, "ext-vref-mv", &int_type_info,
+                             adc128d818_get_ext_vref,
+                             adc128d818_set_ext_vref, NULL, NULL);
 }
 
 static void adc128d818_realize(DeviceState *dev, Error **errp)
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 37d1cffd57a9..62f563af7a7a 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -14,6 +14,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -217,7 +218,7 @@ static void adm1266_init(Object *obj)
     for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
         pmbus_page_config(pmdev, i, flags);
 
-        object_property_add(obj, "vout[*]", "uint16",
+        object_property_add_qapi(obj, "vout[*]", &uint16_type_info,
                             adm1266_get,
                             adm1266_set, NULL, &pmdev->pages[i].read_vout);
     }
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 0aa2a8655683..e1c1bf1c54de 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -12,6 +12,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -493,19 +494,19 @@ static void adm1272_init(Object *obj)
 
     pmbus_page_config(pmdev, 0, flags);
 
-    object_property_add(obj, "vin", "uint16",
+    object_property_add_qapi(obj, "vin", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_vin);
 
-    object_property_add(obj, "vout", "uint16",
+    object_property_add_qapi(obj, "vout", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_vout);
 
-    object_property_add(obj, "iout", "uint16",
+    object_property_add_qapi(obj, "iout", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_iout);
 
-    object_property_add(obj, "pin", "uint16",
+    object_property_add_qapi(obj, "pin", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_pin);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index a51fc44395ab..5efe94643ca0 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -22,6 +22,7 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -251,16 +252,16 @@ static void emc141x_reset(DeviceState *dev)
 
 static void emc141x_initfn(Object *obj)
 {
-    object_property_add(obj, "temperature0", "int",
+    object_property_add_qapi(obj, "temperature0", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature1", "int",
+    object_property_add_qapi(obj, "temperature1", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature2", "int",
+    object_property_add_qapi(obj, "temperature2", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature3", "int",
+    object_property_add_qapi(obj, "temperature3", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 0fad04def773..8923e9e87510 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/sensor/isl_pmbus_vr.h"
 #include "hw/core/qdev-properties.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -136,63 +137,63 @@ static void isl_pmbus_vr_add_props(Object *obj, uint64_t *flags, uint8_t pages)
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
     for (int i = 0; i < pages; i++) {
         if (flags[i] & PB_HAS_VIN) {
-            object_property_add(obj, "vin[*]", "uint16",
+            object_property_add_qapi(obj, "vin[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_vin);
         }
 
         if (flags[i] & PB_HAS_VOUT) {
-            object_property_add(obj, "vout[*]", "uint16",
+            object_property_add_qapi(obj, "vout[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_vout);
         }
 
         if (flags[i] & PB_HAS_IIN) {
-            object_property_add(obj, "iin[*]", "uint16",
+            object_property_add_qapi(obj, "iin[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_iin);
         }
 
         if (flags[i] & PB_HAS_IOUT) {
-            object_property_add(obj, "iout[*]", "uint16",
+            object_property_add_qapi(obj, "iout[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_iout);
         }
 
         if (flags[i] & PB_HAS_PIN) {
-            object_property_add(obj, "pin[*]", "uint16",
+            object_property_add_qapi(obj, "pin[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_pin);
         }
 
         if (flags[i] & PB_HAS_POUT) {
-            object_property_add(obj, "pout[*]", "uint16",
+            object_property_add_qapi(obj, "pout[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_pout);
         }
 
         if (flags[i] & PB_HAS_TEMPERATURE) {
-            object_property_add(obj, "temp1[*]", "uint16",
+            object_property_add_qapi(obj, "temp1[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_1);
         }
 
         if (flags[i] & PB_HAS_TEMP2) {
-            object_property_add(obj, "temp2[*]", "uint16",
+            object_property_add_qapi(obj, "temp2[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_2);
         }
 
         if (flags[i] & PB_HAS_TEMP3) {
-            object_property_add(obj, "temp3[*]", "uint16",
+            object_property_add_qapi(obj, "temp3[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_3);
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index cd5773ae64e8..c8085739ca47 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -25,6 +25,7 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
@@ -509,19 +510,19 @@ static void lsm303dlhc_mag_reset(DeviceState *dev)
  */
 static void lsm303dlhc_mag_initfn(Object *obj)
 {
-    object_property_add(obj, "mag-x", "int",
+    object_property_add_qapi(obj, "mag-x", &int_type_info,
                 lsm303dlhc_mag_get_x,
                 lsm303dlhc_mag_set_x, NULL, NULL);
 
-    object_property_add(obj, "mag-y", "int",
+    object_property_add_qapi(obj, "mag-y", &int_type_info,
                 lsm303dlhc_mag_get_y,
                 lsm303dlhc_mag_set_y, NULL, NULL);
 
-    object_property_add(obj, "mag-z", "int",
+    object_property_add_qapi(obj, "mag-z", &int_type_info,
                 lsm303dlhc_mag_get_z,
                 lsm303dlhc_mag_set_z, NULL, NULL);
 
-    object_property_add(obj, "temperature", "int",
+    object_property_add_qapi(obj, "temperature", &int_type_info,
                 lsm303dlhc_mag_get_temperature,
                 lsm303dlhc_mag_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index 4d64434f3af4..3c8fa3d4a861 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -11,6 +11,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -727,7 +728,7 @@ static void max34451_init(Object *obj)
 
     /* get and set the voltage in millivolts, max is 32767 mV */
     for (int i = 0; i < MAX34451_NUM_PWR_DEVICES; i++) {
-        object_property_add(obj, "vout[*]", "uint16",
+        object_property_add_qapi(obj, "vout[*]", &uint16_type_info,
                             max34451_get,
                             max34451_set, NULL, &pmdev->pages[i].read_vout);
     }
@@ -737,7 +738,7 @@ static void max34451_init(Object *obj)
      * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
      */
     for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES; i++) {
-        object_property_add(obj, "temperature[*]", "uint16",
+        object_property_add_qapi(obj, "temperature[*]", &uint16_type_info,
                             max34451_get,
                             max34451_set,
                             NULL,
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index ece0650d703f..5b6cc3ba2dc5 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qom/object.h"
 #include "hw/sensor/tmp105.h"
@@ -408,7 +409,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
 
 static void tmp105_initfn(Object *obj)
 {
-    object_property_add(obj, "temperature", "int",
+    object_property_add_qapi(obj, "temperature", &int_type_info,
                         tmp105_get_temperature,
                         tmp105_set_temperature, NULL, NULL);
     object_property_set_description(obj, "temperature",
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 127edd0ba568..60844e76b21f 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -28,6 +28,7 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -350,16 +351,16 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_tmp421;
     sc->dev = (DeviceInfo *) data;
 
-    object_class_property_add(klass, "temperature0", "int",
+    object_class_property_add_qapi(klass, "temperature0", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature1", "int",
+    object_class_property_add_qapi(klass, "temperature1", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature2", "int",
+    object_class_property_add_qapi(klass, "temperature2", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature3", "int",
+    object_class_property_add_qapi(klass, "temperature3", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
 }
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 977151c4a087..06584092bcae 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/usb/usb.h"
 #include "hw/usb/desc.h"
@@ -122,7 +123,7 @@ out:
 
 static void usb_msd_instance_init(Object *obj)
 {
-    object_property_add(obj, "bootindex", "int32",
+    object_property_add_qapi(obj, "bootindex", &int32_type_info,
                         usb_msd_get_bootindex,
                         usb_msd_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba238..9e43948128f7 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-balloon.h"
 #include "system/address-spaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
@@ -1022,7 +1023,7 @@ static void virtio_balloon_instance_init(Object *obj)
     object_property_add(obj, "guest-stats", "guest statistics",
                         balloon_stats_get_all, NULL, NULL, NULL);
 
-    object_property_add(obj, "guest-stats-polling-interval", "int",
+    object_property_add_qapi(obj, "guest-stats-polling-interval", &int_type_info,
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
                         NULL, NULL);
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index f592eb1a7849..80e9bfedd9f5 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
@@ -211,7 +212,7 @@ static void virtio_mem_pci_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+    object_property_add_qapi(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, &size_type_info,
                         virtio_mem_pci_get_requested_size,
                         virtio_mem_pci_set_requested_size, NULL, NULL);
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d9c..42dc028e3bdc 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "migration/misc.h"
 #include "hw/core/boards.h"
@@ -1533,14 +1534,15 @@ static void virtio_mem_instance_init(Object *obj)
 
     notifier_list_init(&vmem->size_change_notifiers);
 
-    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
-                        NULL, NULL, NULL);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
-                        virtio_mem_get_requested_size,
-                        virtio_mem_set_requested_size, NULL, NULL);
-    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size",
-                        virtio_mem_get_block_size, virtio_mem_set_block_size,
-                        NULL, NULL);
+    object_property_add_qapi(obj, VIRTIO_MEM_SIZE_PROP, &size_type_info,
+                             virtio_mem_get_size,
+                             NULL, NULL, NULL);
+    object_property_add_qapi(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, &size_type_info,
+                             virtio_mem_get_requested_size,
+                             virtio_mem_set_requested_size, NULL, NULL);
+    object_property_add_qapi(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, &size_type_info,
+                             virtio_mem_get_block_size, virtio_mem_set_block_size,
+                             NULL, NULL);
 }
 
 static void virtio_mem_instance_finalize(Object *obj)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index cca37202ffb2..7b4fd933a8fb 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
@@ -413,7 +414,7 @@ void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
 
 #define OC_MEMMAP_PROP_BASE(c, prop_name, name)                           \
 do {                                                                      \
-    object_class_property_add(c, prop_name "-base", "uint64_t",           \
+    object_class_property_add_qapi(c, prop_name "-base", &uint64_type_info,\
                               xen_pvh_get_ ## name ## _base,              \
                               xen_pvh_set_ ## name ## _base, NULL, NULL); \
     object_class_property_set_description(oc, prop_name "-base",          \
@@ -422,7 +423,7 @@ do {                                                                      \
 
 #define OC_MEMMAP_PROP_SIZE(c, prop_name, name)                           \
 do {                                                                      \
-    object_class_property_add(c, prop_name "-size", "uint64_t",           \
+    object_class_property_add_qapi(c, prop_name "-size", &size_type_info, \
                               xen_pvh_get_ ## name ## _size,              \
                               xen_pvh_set_ ## name ## _size, NULL, NULL); \
     object_class_property_set_description(oc, prop_name "-size",          \
@@ -458,7 +459,7 @@ do {                                                                      \
         OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
         OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
 
-        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
+        object_class_property_add_qapi(oc, "pci-intx-irq-base", &uint32_type_info,
                                   xen_pvh_get_pci_intx_irq_base,
                                   xen_pvh_set_pci_intx_irq_base,
                                   NULL, NULL);
@@ -468,7 +469,7 @@ do {                                                                      \
 
 #ifdef CONFIG_TPM
     if (xpc->has_tpm) {
-        object_class_property_add(oc, "tpm-base-addr", "uint64_t",
+        object_class_property_add_qapi(oc, "tpm-base-addr", &uint64_type_info,
                                   xen_pvh_get_tpm_base,
                                   xen_pvh_set_tpm_base,
                                   NULL, NULL);
diff --git a/iothread.c b/iothread.c
index 76eea6df3861..7285135d40a8 100644
--- a/iothread.c
+++ b/iothread.c
@@ -20,6 +20,7 @@
 #include "system/event-loop-base.h"
 #include "system/iothread.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
@@ -315,19 +316,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
 
-    object_class_property_add(klass, "poll-max-ns", "int64",
+    object_class_property_add_qapi(klass, "poll-max-ns", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_max_ns_info);
-    object_class_property_add(klass, "poll-grow", "int64",
+    object_class_property_add_qapi(klass, "poll-grow", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_grow_info);
-    object_class_property_add(klass, "poll-shrink", "int64",
+    object_class_property_add_qapi(klass, "poll-shrink", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
-    object_class_property_add(klass, "poll-weight", "int64",
+    object_class_property_add_qapi(klass, "poll-weight", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_weight_info);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index a6910de869ff..4b237a59d120 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "qom/object_interfaces.h"
@@ -1373,15 +1374,15 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "notify_dev",
                             compare_get_notify_dev, compare_set_notify_dev);
 
-    object_property_add(obj, "compare_timeout", "uint64",
+    object_property_add_qapi(obj, "compare_timeout", &uint64_type_info,
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL);
 
-    object_property_add(obj, "expired_scan_cycle", "uint32",
+    object_property_add_qapi(obj, "expired_scan_cycle", &uint32_type_info,
                         compare_get_expired_scan_cycle,
                         compare_set_expired_scan_cycle, NULL, NULL);
 
-    object_property_add(obj, "max_queue_size", "uint32",
+    object_property_add_qapi(obj, "max_queue_size", &uint32_type_info,
                         get_max_queue_size,
                         set_max_queue_size, NULL, NULL);
 
diff --git a/net/dump.c b/net/dump.c
index 0c39f09892c2..3d7bb36182ec 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
@@ -238,8 +239,9 @@ static void filter_dump_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
-    object_class_property_add(oc, "maxlen", "uint32", filter_dump_get_maxlen,
-                              filter_dump_set_maxlen, NULL, NULL);
+    object_class_property_add_qapi(oc, "maxlen", &uint32_type_info,
+                                   filter_dump_get_maxlen,
+                                   filter_dump_set_maxlen, NULL, NULL);
     object_class_property_add_str(oc, "file", file_dump_get_filename,
                                   file_dump_set_filename);
 
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 427da24097f2..9d7a9f5cb2c7 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -10,6 +10,7 @@
 #include "net/filter.h"
 #include "net/queue.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "qapi/qapi-builtin-visit.h"
@@ -182,7 +183,7 @@ static void filter_buffer_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
-    object_class_property_add(oc, "interval", "uint32",
+    object_class_property_add_qapi(oc, "interval", &uint32_type_info,
                               filter_buffer_get_interval,
                               filter_buffer_set_interval, NULL, NULL);
 
diff --git a/qom/object.c b/qom/object.c
index 8e6ca25dc49d..bbaa999ae0c9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -22,9 +22,9 @@
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qobject/qdict.h"
-#include "qobject/qjson.h"
 #include "qemu/id.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
@@ -2429,7 +2429,7 @@ object_property_add_str(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, "string",
+    return object_property_add_qapi(obj, name, &str_type_info,
                                get ? property_get_str : NULL,
                                set ? property_set_str : NULL,
                                property_release_data,
@@ -2447,7 +2447,7 @@ object_class_property_add_str(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, "string",
+    return object_class_property_add_qapi(klass, name, &str_type_info,
                                      get ? property_get_str : NULL,
                                      set ? property_set_str : NULL,
                                      NULL,
@@ -2499,7 +2499,7 @@ object_property_add_bool(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, "bool",
+    return object_property_add_qapi(obj, name, &bool_type_info,
                                get ? property_get_bool : NULL,
                                set ? property_set_bool : NULL,
                                property_release_data,
@@ -2516,7 +2516,7 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, "bool",
+    return object_class_property_add_qapi(klass, name, &bool_type_info,
                                      get ? property_get_bool : NULL,
                                      set ? property_set_bool : NULL,
                                      NULL,
@@ -2856,8 +2856,8 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
         setter = property_set_uint8_ptr;
     }
 
-    return object_property_add(obj, name, "uint8",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint8_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2897,8 +2897,8 @@ object_class_static_property_add_uint8_ptr(ObjectClass *klass,
         setter = property_set_uint8_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint8",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint8_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2917,8 +2917,8 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
         setter = property_set_uint16_ptr;
     }
 
-    return object_property_add(obj, name, "uint16",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint16_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2958,8 +2958,8 @@ object_class_static_property_add_uint16_ptr(ObjectClass *klass,
         setter = property_set_uint16_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint16",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint16_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2978,8 +2978,8 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
         setter = property_set_uint32_ptr;
     }
 
-    return object_property_add(obj, name, "uint32",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint32_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -3019,8 +3019,8 @@ object_class_static_property_add_uint32_ptr(ObjectClass *klass,
         setter = property_set_uint32_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint32",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint32_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -3039,8 +3039,8 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
         setter = property_set_uint64_ptr;
     }
 
-    return object_property_add(obj, name, "uint64",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint64_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -3080,8 +3080,8 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
         setter = property_set_uint64_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint64",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint64_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 typedef struct {
diff --git a/system/bootdevice.c b/system/bootdevice.c
index 9538b08983f5..7789e464186a 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "system/system.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
@@ -336,7 +337,7 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     prop->suffix = suffix;
     prop->dev = dev;
 
-    object_property_add(obj, name, "int32",
+    object_property_add_qapi(obj, name, &int32_type_info,
                         device_get_bootindex,
                         device_set_bootindex,
                         property_release_bootindex,
diff --git a/system/memory.c b/system/memory.c
index 264dc90c0a55..72ecb3115496 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "system/memory.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
@@ -1293,11 +1294,11 @@ static void memory_region_initfn(Object *obj)
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);
-    object_property_add(OBJECT(mr), "priority", "int32",
+    object_property_add_qapi(OBJECT(mr), "priority", &int32_type_info,
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL);
-    object_property_add(OBJECT(mr), "size", "uint64",
+    object_property_add_qapi(OBJECT(mr), "size", &uint64_type_info,
                         memory_region_get_size,
                         NULL, /* memory_region_set_size, */
                         NULL, NULL);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4e8c47253086..55df765e64d1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
@@ -320,7 +321,7 @@ static void prop_bool_set_false(Object *obj, Visitor *v, const char *name,
 
 static void prop_add_stub_bool(Object *obj, const char *name)
 {
-    object_property_add(obj, name, "bool", prop_bool_get_false,
+    object_property_add_qapi(obj, name, &bool_type_info, prop_bool_get_false,
                         prop_bool_set_false, NULL, NULL);
 }
 
@@ -510,13 +511,13 @@ void aarch64_add_sve_properties(Object *obj)
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
         snprintf(name, sizeof(name), "sve%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_vq,
+        object_property_add_qapi(obj, name, &bool_type_info, cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sve_vq);
     }
 
 #ifdef CONFIG_USER_ONLY
     /* Mirror linux /proc/sys/abi/sve_default_vector_length. */
-    object_property_add(obj, "sve-default-vector-length", "int32",
+    object_property_add_qapi(obj, "sve-default-vector-length", &int32_type_info,
                         cpu_arm_get_default_vec_len,
                         cpu_arm_set_default_vec_len, NULL,
                         &cpu->sve_default_vq);
@@ -535,13 +536,13 @@ void aarch64_add_sme_properties(Object *obj)
     for (vq = 1; vq <= ARM_MAX_VQ; vq <<= 1) {
         char name[8];
         snprintf(name, sizeof(name), "sme%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_vq,
+        object_property_add_qapi(obj, name, &bool_type_info, cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sme_vq);
     }
 
 #ifdef CONFIG_USER_ONLY
     /* Mirror linux /proc/sys/abi/sme_default_vector_length. */
-    object_property_add(obj, "sme-default-vector-length", "int32",
+    object_property_add_qapi(obj, "sme-default-vector-length", &int32_type_info,
                         cpu_arm_get_default_vec_len,
                         cpu_arm_set_default_vec_len, NULL,
                         &cpu->sme_default_vq);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd80c..198b7615f4cc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -20,6 +20,7 @@
 #include "qemu/main-loop.h"
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "system/ramblock.h"
@@ -1777,7 +1778,7 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add(oc, "eager-split-size", "size",
+    object_class_property_add_qapi(oc, "eager-split-size", &size_type_info,
                               kvm_arch_get_eager_split_size,
                               kvm_arch_set_eager_split_size, NULL, NULL);
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index affd87a3ae55..da8d44f1fc61 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
@@ -1392,9 +1393,9 @@ void aarch64_max_v8_tcg_initfn(Object *obj)
     /* v8.2: FEAT_SVE */
     cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
     aarch64_add_sve_properties(OBJECT(cpu));
-    object_property_add(OBJECT(cpu), "sve-max-vq", "uint32",
-                        cpu_max_get_sve_max_vq, cpu_max_set_sve_max_vq,
-                        NULL, NULL);
+    object_property_add_qapi(OBJECT(cpu), "sve-max-vq", &uint32_type_info,
+                             cpu_max_get_sve_max_vq,
+                             cpu_max_set_sve_max_vq, NULL, NULL);
 
     /* v8.2: FEAT_PAuth2 */
     aarch64_add_pauth_properties(OBJECT(cpu));
@@ -1524,8 +1525,8 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
 
     /* v9.4: FEAT_RME_GPC2 */
-    object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
-                        cpu_max_set_l0gptsz, NULL, NULL);
+    object_property_add_qapi(obj, "x-l0gptsz", &uint32_type_info, cpu_max_get_l0gptsz,
+                             cpu_max_set_l0gptsz, NULL, NULL);
 }
 
 static const ARMCPUInfo aarch64_cpus[] = {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8650ff6caecc..ebce8e128224 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10431,7 +10431,7 @@ static void x86_cpu_register_bit_prop(X86CPUClass *xcc,
         fp = g_new0(BitProperty, 1);
         fp->w = w;
         fp->mask = mask;
-        object_class_property_add(oc, prop_name, "bool",
+        object_class_property_add_qapi(oc, prop_name, &bool_type_info,
                                   x86_cpu_get_bit_prop,
                                   x86_cpu_set_bit_prop,
                                   NULL, fp);
@@ -10950,13 +10950,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
     dc->user_creatable = true;
 
-    object_class_property_add(oc, "family", "uint64",
+    object_class_property_add_qapi(oc, "family", &uint64_type_info,
                               x86_cpuid_version_get_family,
                               x86_cpuid_version_set_family, NULL, NULL);
-    object_class_property_add(oc, "model", "uint64",
+    object_class_property_add_qapi(oc, "model", &uint64_type_info,
                               x86_cpuid_version_get_model,
                               x86_cpuid_version_set_model, NULL, NULL);
-    object_class_property_add(oc, "stepping", "uint64",
+    object_class_property_add_qapi(oc, "stepping", &uint64_type_info,
                               x86_cpuid_version_get_stepping,
                               x86_cpuid_version_set_stepping, NULL, NULL);
     object_class_property_add_str(oc, "vendor",
@@ -10965,7 +10965,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "model-id",
                                   x86_cpuid_get_model_id,
                                   x86_cpuid_set_model_id);
-    object_class_property_add(oc, "tsc-frequency", "int",
+    object_class_property_add_qapi(oc, "tsc-frequency", &int_type_info,
                               x86_cpuid_get_tsc_freq,
                               x86_cpuid_set_tsc_freq, NULL, NULL);
     /*
@@ -10978,7 +10978,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 
-    object_class_property_add(oc, "avx10-version",  "uint8",
+    object_class_property_add_qapi(oc, "avx10-version",  &uint8_type_info,
                               x86_cpuid_get_avx10_version,
                               x86_cpuid_set_avx10_version,
                               NULL, NULL);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9f65419a2c1a..aa4967adf99e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -7099,7 +7099,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         .set = kvm_arch_set_notify_vmexit,
     ));
 
-    object_class_property_add(oc, "notify-window", "uint32",
+    object_class_property_add_qapi(oc, "notify-window", &uint32_type_info,
                               kvm_arch_get_notify_window,
                               kvm_arch_set_notify_window,
                               NULL, NULL);
@@ -7107,7 +7107,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "Clock cycles without an event window "
                                           "after which a notification VM exit occurs");
 
-    object_class_property_add(oc, "xen-version", "uint32",
+    object_class_property_add_qapi(oc, "xen-version", &uint32_type_info,
                               kvm_arch_get_xen_version,
                               kvm_arch_set_xen_version,
                               NULL, NULL);
@@ -7116,14 +7116,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "(in XENVER_version form "
                                           "e.g. 0x4000a for 4.10)");
 
-    object_class_property_add(oc, "xen-gnttab-max-frames", "uint16",
+    object_class_property_add_qapi(oc, "xen-gnttab-max-frames", &uint16_type_info,
                               kvm_arch_get_xen_gnttab_max_frames,
                               kvm_arch_set_xen_gnttab_max_frames,
                               NULL, NULL);
     object_class_property_set_description(oc, "xen-gnttab-max-frames",
                                           "Maximum number of grant table frames");
 
-    object_class_property_add(oc, "xen-evtchn-max-pirq", "uint16",
+    object_class_property_add_qapi(oc, "xen-evtchn-max-pirq", &uint16_type_info,
                               kvm_arch_get_xen_evtchn_max_pirq,
                               kvm_arch_set_xen_evtchn_max_pirq,
                               NULL, NULL);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index b2c7260c80a4..3a36fa4d0b95 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3266,7 +3266,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     x86_klass->adjust_cpuid_features = sev_snp_adjust_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
-    object_class_property_add(oc, "policy", "uint64",
+    object_class_property_add_qapi(oc, "policy", &uint64_type_info,
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
     object_class_property_add_str(oc, "guest-visible-workarounds",
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 55de3bd5d5de..4d81225de37f 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -23,6 +23,7 @@
 #include "kvm_ppc.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "cpu-models.h"
@@ -335,7 +336,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
     gchar *names, *desc;
     int i;
 
-    object_property_add(obj, name, "string",
+    object_property_add_qapi(obj, name, &str_type_info,
                         ppc_compat_prop_get, ppc_compat_prop_set, NULL,
                         compat_pvr);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5fff9d745e9b..bd3fa786ee40 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -27,6 +27,7 @@
 #include "target/riscv/tcg/csr.h"
 #include "internals.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -1396,20 +1397,20 @@ void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    object_property_add(obj, "svbare", "bool", cpu_riscv_get_satp,
-                        cpu_riscv_set_satp, NULL, &cpu->satp_modes);
+    object_property_add_qapi(obj, "svbare", &bool_type_info, cpu_riscv_get_satp,
+                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
 
     if (cpu->env.misa_mxl == MXL_RV32) {
-        object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv32", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
-        object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv39", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv48", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv57", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv64", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 68e1501b21e2..d2d6cb7a4c66 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -24,6 +24,7 @@
 
 #include "qemu/timer.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/visitor.h"
@@ -532,7 +533,7 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
      * unknown to KVM and error out if the user attempts
      * to enable any of them.
      */
-    object_property_add(obj, prop_name, "bool",
+    object_property_add_qapi(obj, prop_name, &bool_type_info,
                         cpu_get_cfg_unavailable,
                         cpu_set_cfg_unavailable,
                         NULL, (void *)prop_name);
@@ -552,7 +553,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         misa_cfg->name = riscv_get_misa_ext_name(bit);
         misa_cfg->description = riscv_get_misa_ext_description(bit);
 
-        object_property_add(cpu_obj, misa_cfg->name, "bool",
+        object_property_add_qapi(cpu_obj, misa_cfg->name, &bool_type_info,
                             kvm_cpu_get_misa_ext_cfg,
                             kvm_cpu_set_misa_ext_cfg,
                             NULL, misa_cfg);
@@ -568,7 +569,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
-        object_property_add(cpu_obj, multi_cfg->name, "bool",
+        object_property_add_qapi(cpu_obj, multi_cfg->name, &bool_type_info,
                             kvm_cpu_get_multi_ext_cfg,
                             kvm_cpu_set_multi_ext_cfg,
                             NULL, multi_cfg);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b68160af8307..6f3e1e10eb04 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -26,6 +26,7 @@
 #include "pmu.h"
 #include "time_helper.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
@@ -1437,7 +1438,7 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
             continue;
         }
 
-        object_property_add(cpu_obj, name, "bool",
+        object_property_add_qapi(cpu_obj, name, &bool_type_info,
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
                             NULL, (void *)misa_cfg);
@@ -1491,7 +1492,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
         RISCVCPUProfile *profile = riscv_profiles[i];
 
-        object_property_add(cpu_obj, profile->name, "bool",
+        object_property_add_qapi(cpu_obj, profile->name, &bool_type_info,
                             cpu_get_profile, cpu_set_profile,
                             NULL, (void *)profile);
 
@@ -1567,10 +1568,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     for (edata = isa_edata_arr; edata && edata->name; edata++) {
         if (edata->prop_name) {
-            object_property_add(obj, edata->prop_name, "bool",
-                                cpu_get_multi_ext_cfg,
-                                cpu_set_multi_ext_cfg,
-                                NULL, (void *)&edata->ext_enable_offset);
+            object_property_add_qapi(obj, edata->prop_name, &bool_type_info,
+                                     cpu_get_multi_ext_cfg,
+                                     cpu_set_multi_ext_cfg,
+                                     NULL, (void *)&edata->ext_enable_offset);
         }
     }
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c41d629d6803..72bf0f48de83 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -17,6 +17,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
@@ -915,13 +916,13 @@ void s390_cpu_model_class_register_props(ObjectClass *oc)
 
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def = s390_feat_def(feat);
-        object_class_property_add(oc, def->name, "bool", get_feature,
+        object_class_property_add_qapi(oc, def->name, &bool_type_info, get_feature,
                                   set_feature, NULL, (void *) feat);
         object_class_property_set_description(oc, def->name, def->desc);
     }
     for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def = s390_feat_group_def(group);
-        object_class_property_add(oc, def->name, "bool", get_feature_group,
+        object_class_property_add_qapi(oc, def->name, &bool_type_info, get_feature_group,
                                   set_feature_group, NULL, (void *) group);
         object_class_property_set_description(oc, def->name, def->desc);
     }
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb902..204436fb7276 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -27,6 +27,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 
 
@@ -171,10 +172,12 @@ static void prop2_accessor(Object *obj, Visitor *v, const char *name,
 
 static void dynamic_instance_init(Object *obj)
 {
-    object_property_add(obj, "prop1", "uint32", prop1_accessor, prop1_accessor,
-                        NULL, NULL);
-    object_property_add(obj, "prop2", "uint32", prop2_accessor, prop2_accessor,
-                        NULL, NULL);
+    object_property_add_qapi(obj, "prop1", &uint32_type_info,
+                             prop1_accessor, prop1_accessor,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "prop2", &uint32_type_info,
+                             prop2_accessor, prop2_accessor,
+                             NULL, NULL);
 }
 
 static void dynamic_class_init(ObjectClass *oc, const void *data)
diff --git a/ui/console.c b/ui/console.c
index 14f148118e37..ee280eedf3da 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -28,6 +28,7 @@
 #include "ui/vgafont.h"
 #include "hw/core/qdev.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/visitor.h"
 #include "qemu/coroutine.h"
@@ -535,7 +536,7 @@ qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
                                    offsetof(QemuGraphicConsole, device),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
-    object_class_property_add(oc, "head", "uint32",
+    object_class_property_add_qapi(oc, "head", &uint32_type_info,
                               qemu_graphic_console_prop_get_head,
                               NULL, NULL, NULL);
 
diff --git a/util/thread-context.c b/util/thread-context.c
index 88d8f0a55a4e..7fa6840dd401 100644
--- a/util/thread-context.c
+++ b/util/thread-context.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/thread-context.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
@@ -278,13 +279,13 @@ static void thread_context_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = thread_context_instance_complete;
-    object_class_property_add(oc, "thread-id", "uint64",
+    object_class_property_add_qapi(oc, "thread-id", &uint64_type_info,
                               thread_context_get_thread_id, NULL, NULL,
                               NULL);
-    object_class_property_add(oc, "cpu-affinity", "[uint16]",
+    object_class_property_add_qapi(oc, "cpu-affinity", &uint16List_type_info,
                               thread_context_get_cpu_affinity,
                               thread_context_set_cpu_affinity, NULL, NULL);
-    object_class_property_add(oc, "node-affinity", "[uint16]", NULL,
+    object_class_property_add_qapi(oc, "node-affinity", &uint16List_type_info, NULL,
                               thread_context_set_node_affinity, NULL, NULL);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8

