Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493517;
	b=wrkDRDGKIuY9DZ7gUts+nb6Qlpt0WIAvQzYAVtbkt2g2o/5L7Rfo/pIzcLf86DbrY8Og
	 33Y0cs0EWY3k43Bamnn1nX8YErBdITOLrgE5awNvQZI7IUh91L1pFt9JrRz8mePXbda7d
	 s0QZcZutdmdGEK/6OwrGRk24/goAghR2mqptCZSAoSwB/61V3whVCuJbayRnqnn7cjc3y
	 YR6EIgOfbe0fEXNlrsgrMZ3ihdbfD2P6LgwG4px55MfzuBBRFb8EK0wMIBYGIDY5MPk29
	 LZVmjaMI7sJOk5XSZRbWNzqVsaT6j5aDY+yrrYJTOqovjmVULkoeHDE+1arRgxoSRLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493517;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=th1JKpfzAzi8+0DyZvMgIumhc4CFEiTeW47qkGiYHs4=;
	b=TsLDPTeyU6ECFFJi0P7LnaC76nxAsEeFPrmmRaplSQOHB9vs7Pgzg5kRVsOfQyeizBlr
	 PgMoryRxSvZy9B39S6p9bVwVT21oSib2M/I98WFbvJ5HyeL3lWNfoeCgUFVU65fx0Unbd
	 5EKstiFqGf1SBxz29osQVDqZR0Zn7rKctD3cDs/PrKswPTFg8fl56j4w9KfU1twayLxiQ
	 QDMOjrCtTA8DEVtUA2G7Jo14uvSHNKfwplVEIR4F7abhO/Akyg/Og7wZlBW7wN6/BNhpt
	 O4rcYiljpA/qK1lTKbP9g/UJTs8xu0e6ZWNTh3+t0adpLAE0Zjwio0+9JcwCvGgdzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="EsuFvIr/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B260A381A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20B260A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EsuFvIr/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th1JKpfzAzi8+0DyZvMgIumhc4CFEiTeW47qkGiYHs4=;
	b=EsuFvIr/Opo2dpcrc92u4DQgS/+C9k3yD9tfXf7sXD5fCVOUI96+5ochFzdcbM/CWCUHuc
	MmyoNxtDKTJbk0+Cn510+GFzt8qiLaDmw44nuRVmKLCituWLRy4c/f3f/iSSdPc4wxS5n2
	lPgNOjuco4s0d7NbAiKg9x207QCFZH8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-MDo8sez-NcyGAOl5_G0YjQ-1; Tue,
 20 Oct 2026 10:51:52 +0000
X-MC-Unique: MDo8sez-NcyGAOl5_G0YjQ-1
X-Mimecast-MFC-AGG-ID: MDo8sez-NcyGAOl5_G0YjQ_1792493508
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E077E1955DD1;
	Tue, 20 Oct 2026 10:51:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E9F31800677;
	Tue, 20 Oct 2026 10:51:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:19 +0400
Subject: [PATCH v7 62/65] hw/i386: convert PCSouthBridgeOption to QAPI enum
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-62-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6526;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jr+R1XEAXGqEfl6dzBqQchDTHMoMaEnbkkCJTWPjK7M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZdHAMFgnhAvWl4qCaozSGC8ZoljjEYi6VBP
 70IoZTx452JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXQAKCRDa6OEJdZac
 5bQgEACXrVy4PI0RHLf3EYbpFdgeh/G/qw9Szqqn90QJFXbDyFtQmp3c6wFtAFWSP3ffrhRIGOr
 RcUHeYkCVoyizAcDDgjI8OyPrmHVEnG3PwXeWRtGK0kH1my0bbmCJx/osVW8rApSvdzvYpi9s0Y
 6bnxKKjw0JzliwdtFqTmFt0nn1S7YQOKfUDqhPgAWAHg8bwDPi1N1201GaF9lvKcJLYtaT4uNPx
 duB+KEvf23TePBMMCkwNlGjW5qm6S0gf5Ryxjb7UDLk0DAMDD6sOLYbUwrlEcS2bJu7T+7pz3Pk
 KIUx9WJmwNr8hA510xbEUM7U+qI4jtLtBszuvBioYQI3kVmqBqcaNtqPICXlIwOy+0b4xnL1Gkk
 eA26OvbARkhRxfm9CnY4bEgdMJQoeQnDOu1qzkbjiH5164V7Vey/w6iyXw5kqW/vm1Sq08RW2k9
 ICd329fnCbR+neChTSaunOu2wlSsKfBfb8AHGJDPC9l+G08VUaWeDhOHfuAgrke7NLVPatk+RPO
 Idq2+9q621/0Y/k95lzrzNRBGYp6P2uo1GlxLYcHglKAYZo/Cej2Jt8gBe7Gw+Qz351rWqwXcvm
 8YX+kB6Z2Q3knEFy4SolR3NudeuK7WGfrFsryom7DUjqSDf2dGK5/LD4kxH5aflGMGZmB0moZnG
 LnhWzV1mrbEwmtw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: __HC9uTxv6-85_yFIBHBNqsM7aghQZaUGS7fqYy0tqM_1792493508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move PCSouthBridgeOption from a hand-rolled C enum to a proper QAPI
enum in qapi/machine.json.

This gives the x-south-bridge property a generated type_info with a
valid masked_name, so it appears in query-qmp-schema introspection and
the qapi-type field of qom-list-properties output.

The south_bridge/default_south_bridge fields change from const char *
to PCSouthBridgeOption, with an explicit mapping table from enum value
to QOM device type name.

Enum values are changed: "PIIX3"->"ppix3", "piix4-isa"->"piix4", this
is under a x-property, so shouldn't be a breaking change.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc_piix.c    | 61 ++++++++++++++++------------------------------------
 include/hw/i386/pc.h |  4 ++--
 qapi/machine.json    | 14 ++++++++++++
 3 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 63c4667ea372..5a94a34166d8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -47,6 +47,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/vfio/types.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qemu/error-report.h"
 #include "system/xen.h"
 #ifdef CONFIG_XEN
@@ -75,6 +76,11 @@ static GlobalProperty pc_piix_compat_defaults[] = {
 static const size_t pc_piix_compat_defaults_len =
     G_N_ELEMENTS(pc_piix_compat_defaults);
 
+static const char *pc_south_bridge_type[] = {
+    [PC_SOUTH_BRIDGE_OPTION_PIIX3] = TYPE_PIIX3_DEVICE,
+    [PC_SOUTH_BRIDGE_OPTION_PIIX4] = TYPE_PIIX4_PCI_DEVICE,
+};
+
 /*
  * Return the global irq number corresponding to a given device irq
  * pin. We could also use the bus number to have a more precise mapping.
@@ -236,7 +242,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
-    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    pci_dev = pci_new_multifunction(-1,
+                                    pc_south_bridge_type[pcms->south_bridge]);
     object_property_set_bool(OBJECT(pci_dev), "has-usb",
                              machine_usb(machine), &error_abort);
     object_property_set_bool(OBJECT(pci_dev), "has-acpi",
@@ -317,51 +324,18 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 }
 
-typedef enum PCSouthBridgeOption {
-    PC_SOUTH_BRIDGE_OPTION_PIIX3,
-    PC_SOUTH_BRIDGE_OPTION_PIIX4,
-    PC_SOUTH_BRIDGE_OPTION_MAX,
-} PCSouthBridgeOption;
-
-static const QEnumLookup PCSouthBridgeOption_lookup = {
-    .array = (const char *const[]) {
-        [PC_SOUTH_BRIDGE_OPTION_PIIX3] = TYPE_PIIX3_DEVICE,
-        [PC_SOUTH_BRIDGE_OPTION_PIIX4] = TYPE_PIIX4_PCI_DEVICE,
-    },
-    .size = PC_SOUTH_BRIDGE_OPTION_MAX
-};
-
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    int i;
 
-    for (i = 0; i < PCSouthBridgeOption_lookup.size; i++) {
-        if (g_strcmp0(PCSouthBridgeOption_lookup.array[i],
-                      pcms->south_bridge) == 0) {
-            return i;
-        }
-    }
-
-    error_setg(errp, "Invalid south bridge value set");
-    return 0;
+    return pcms->south_bridge;
 }
 
 static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    if (value < 0) {
-        error_setg(errp, "Value can't be negative");
-        return;
-    }
-
-    if (value >= PCSouthBridgeOption_lookup.size) {
-        error_setg(errp, "Value too big");
-        return;
-    }
-
-    pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
+    pcms->south_bridge = value;
 }
 
 #ifdef CONFIG_XEN
@@ -398,7 +372,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     ObjectClass *oc = OBJECT_CLASS(m);
-    pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
+    pcmc->default_south_bridge = PC_SOUTH_BRIDGE_OPTION_PIIX3;
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -413,12 +387,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
-    object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
-                                   &PCSouthBridgeOption_lookup,
-                                   pc_get_south_bridge,
-                                   pc_set_south_bridge);
-    object_class_property_set_description(oc, "x-south-bridge",
-                                     "Use a different south bridge than PIIX3");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "x-south-bridge",
+        .description = "Use a different south bridge than PIIX3",
+        .qapi_type = &PCSouthBridgeOption_type_info,
+        .get = pc_get_south_bridge,
+        .set = pc_set_south_bridge,
+    ));
     compat_props_add(m->compat_props,
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8edec62a1af2..3afd376116b1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -47,7 +47,7 @@ typedef struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     SmbiosEntryPointType smbios_entry_point_type;
-    const char *south_bridge;
+    PCSouthBridgeOption south_bridge;
 
     bool acpi_build_enabled;
     bool wdat_enabled;
@@ -94,7 +94,7 @@ struct PCMachineClass {
 
     /* Device configuration: */
     bool pci_enabled;
-    const char *default_south_bridge;
+    PCSouthBridgeOption default_south_bridge;
 
     /* Compat options: */
 
diff --git a/qapi/machine.json b/qapi/machine.json
index 46b6935ab0b8..cc028e890ae5 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -462,6 +462,20 @@
 { 'enum': 'Pca9554PinState',
   'data': ['low', 'high'] }
 
+##
+# @PCSouthBridgeOption:
+#
+# South bridge chipset option for PC i440FX machines.
+#
+# @piix3: Intel PIIX3 (default)
+#
+# @piix4: Intel PIIX4
+#
+# Since: 11.2
+##
+{ 'enum': 'PCSouthBridgeOption',
+  'data': ['piix3', 'piix4'] }
+
 ##
 # @inject-nmi:
 #     Injects a Non-Maskable Interrupt (machine specific: for example

-- 
2.56.0.116.g6de20f6092dc

