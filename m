Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B53282F3C
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988047; cv=none; b=YW78zxiZ3Fc+Tvj/PCsstL9KGK1zp6iJOsp2N+rLYI6s8A9LvrM++EQB1ZjVfz3HPtyErJQxteLgEHa2jISUQBRZC2CBl3QokCAfqbjx92wvwnOR4KUX0GWUuFc8oKogpyDLXyJJQUST0H0qSMOo6FHNlRBNurAmn4BGVhZxMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988047; c=relaxed/simple;
	bh=sHbc1QFubXFvCqldzNTjZD5Y3aSuMfriFlxuneTvSTA=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=PjPojxgStrvck0QFfqqvMauR1bS1keHLJ2k2ReRfi26VLJ/x13q7xnYB6DVhhLiwDU7U7j2cmDLpdDYyop1IN8i7ovSbzk/clCed7EEGPElIAp0utOsUEWK+XwjqMQMg4Xf1ItB1klFdXehT5qRp0oLOOdYKZ1ndLk2NQ0gXha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPyNI+Sp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPyNI+Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wYVe5coY+/gP5ZW+DnrDyDBSPmW8qWvLqlbb+wP5hE=;
	b=cPyNI+SpMGya517d5b8lx+s91z3K81ShZT8LnFKo5vHHWe9+m0TQP5QifQLwg0+L7oNu1E
	L/dLQ6SsSoGA3wcjtovoJtrQr6yfrVvBL2kNJFuAS8VsgIKSak/loKkXtpzX4w67Oj0LS6
	PdCznC05E98aMehEGaK4uPF6vyb/thY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-HSljVq6cNuityrvDnuqJnw-1; Sat,
 25 Jul 2026 10:00:41 -0400
X-MC-Unique: HSljVq6cNuityrvDnuqJnw-1
X-Mimecast-MFC-AGG-ID: HSljVq6cNuityrvDnuqJnw_1784988038
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2631195608E;
	Sat, 25 Jul 2026 14:00:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B4F3190BAD8;
	Sat, 25 Jul 2026 14:00:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:05 +0400
Subject: [PATCH 4/7] hw/hexagon: fix machine->fdt leak in qom-test
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sHbc1QFubXFvCqldzNTjZD5Y3aSuMfriFlxuneTvSTA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmccR1sOhKJLjubdgeqiWoOQhkY4UNOtveg
 jPMRqeZwE6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5YaZD/0RpfmrTuzTydjwDRCPi61LJoY4ZXv9qHeMGA4RKwU57PH/dDnYoYLk/n7TuGOLNCOweT9
 P1GOBp4WxUp8P9N1eigROTqHwWqbawa7o8OHbMi1RXkUOkR3IVJ/VY/EbjvTw433iTR6ibsuhK0
 42hUVCgzCyv988GNwlKsh3xKAB5FvWN2bsq34XYZW8Drev+lgF37VsxqvCJZVHntUL6vL7TcSrZ
 JH1l9jpMT0F8gRYXX/HMKv7VSqiupP6MAxwm7Z6tusmHsZrh4oRC2JME79fDaTCXO5AEi+i/A31
 Nxr7a6eSmnWdYHON5DcmzLR8VkL2GXxtq7n9EyKHpRajp8+pLL50ZcgFx7pe0YsEZOmV+GLSSy4
 W3ytHVKnxpy7exY/iQpLW2GR4FZQC5DE5JsduCVXxqvCoaPNzCLm4alsocU/4DEciWmVMcKEQVg
 D01+2k3Cb9GUv5ED37Zq68KVOlmoxEB5MSP5E2YiNoSml5sCA+uma3hnZcDnXXe3DEBHvP+g5Ww
 c2Be4LvG7EY4iHaZoPppaZpDUkPPMAS0jMLSga8Qm/NIrhi014iYVUtdYu/XyVat7w3bDliLTUV
 rTvSjo0i8g5zDi2kReYPTOE/u6nWLYGhd5mij3FPqsqH6Z42NpZh5uN2LU8XAVVpDQP3GTZcAxT
 NMIfYli77pmQn/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: QOcuY21avAqklBqFwuSWgEVe6KDagGL0_0dUxXPUpdU_1784988038
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

virt_instance_init() built the FDT unconditionally at QOM
instance-init time, so simply instantiating the object (e.g. via
qom-test's introspection, without ever realizing the machine) leaked
the 1MB FDT blob: machine_finalize() does not free machine->fdt.

Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
their MachineClass::init callback, which only runs when the machine
is actually selected to boot. Do the same here by moving create_fdt()
into virt_init().

Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/hexagon/virt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index a3638998b873..b75047250260 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -175,13 +175,6 @@ static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
 
 
 
-static void virt_instance_init(Object *obj)
-{
-    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
-
-    create_fdt(vms);
-}
-
 void hexagon_load_fdt(const HexagonVirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -242,6 +235,7 @@ static void virt_init(MachineState *ms)
     DeviceState *cpu0;
     int32_t clk_phandle;
 
+    create_fdt(vms);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
 
     vms->sys = get_system_memory();
@@ -341,7 +335,6 @@ static const TypeInfo virt_machine_types[] = { {
     .parent = TYPE_HEXAGON_COMMON_MACHINE,
     .instance_size = sizeof(HexagonVirtMachineState),
     .class_init = virt_class_init,
-    .instance_init = virt_instance_init,
 } };
 
 DEFINE_TYPES(virt_machine_types)

-- 
2.55.0

