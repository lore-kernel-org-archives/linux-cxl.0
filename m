Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF537C115
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098715; cv=none; b=OrTp3elBT0bRJm2IEfZEr0n7DKQIQYhQQRpUH3oRcaQ+evOC6+NjWJFu5dL0mqGxdfjysyfSdZy/UX/QE1yOyTIGPSEUjmn4e2a1tYtq1Y3bMaF17cCgw6IVnftnkzUCRItz7lekl0vVqwkwbFdtruPzbP/M6LzN+1KcxnzqOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098715; c=relaxed/simple;
	bh=sHbc1QFubXFvCqldzNTjZD5Y3aSuMfriFlxuneTvSTA=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=jt/nCY8T97PAVOiLgOKDEJqvvb7/rAgDNswKrw86FQI4zUOl7bGbzJe/QEbVjxFo9ky++eHlbdOcuLJWkSzjX9u9/CuxiHxqk/ejbxE5rrHJFunLPQam1zm8gp8Fkvw37Zx0pQ6lP37OanWhLI1ntbXUVn6Amf1DURtiPNpwhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FU5rfdB2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU5rfdB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wYVe5coY+/gP5ZW+DnrDyDBSPmW8qWvLqlbb+wP5hE=;
	b=FU5rfdB24f+2pyQBdcro7LlHmm3MSiYV6nARlc6VaeliD3TCorrgfvUTGoKrKcx++v14xh
	q7YQfbVRHl+z+UYF2C7LgguXy0QH9OkNzd4AeRKJOV4fFzuwhD6YLPv0t9d+1wXyB7ga0U
	P4Wb6ozn1dtcwAjBalADzz1RBNABo68=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-oNRUeo_LOfSNNKM-VRXetg-1; Sun,
 26 Jul 2026 16:45:10 -0400
X-MC-Unique: oNRUeo_LOfSNNKM-VRXetg-1
X-Mimecast-MFC-AGG-ID: oNRUeo_LOfSNNKM-VRXetg_1785098708
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7C5F1954B35;
	Sun, 26 Jul 2026 20:45:07 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76D5619560AB;
	Sun, 26 Jul 2026 20:45:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:07 +0400
Subject: [PATCH v2 08/12] hw/hexagon: fix machine->fdt leak in qom-test
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-8-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXGk6SvtrQGOkQAChwsOc7oRmQrtBARLsPr
 glA40doeoSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5ctCEACiiHpn1U1s4n1r6sQSG5lKVEW8A5zMYdjwsHzdcY6oanhHI3iemp+JK0Bhb6Qd7I6HNpi
 TUX2sP5efuZCZw9DR0nHwsUitVvOu/i4IyrGGzaA8vJqEQtx2bKZS+TC2KFzsDFTQXwe/bUWxND
 F1Q69uIyHc4NpC58Bv3lnq1Nzau4pYxrnxfTxNc2HD2GmegXATZoMLukSQQ4C9FzizP4nWHtZbk
 tWBrvCt7+pTAoE7rdSCgnpppGibWM6G1k2hMU0jwNq48AXYZrVtbxD/MpbpZ9iTpCUpqBVQ1cUc
 jsAxwRDK/keseA3ETQO4BvlbNsmaHAVx5oqsqGWk78zS5cj5hGzsE55V2ivRFzxJYzDKXHZ3KrL
 CxVouIUnQhifCpNzDUxa5paf3dv9LGczsgnrgHw+DnrhAOl1WPTxUlKO2A2liFmwebF2gphm07q
 TXaaLPFLCF9XS81I8/zBB4vd2RzKezENRHYPpfw74J9zAVg6ogd9dxJspNwcOAZ/C2NcXtu21oJ
 6BIMwwMWpcomLYqxtM9PtqidOcVCtbsBKUyZSRjskgKDYUBYIqgYp674nRwq+cXX9kyh1gFSe3l
 yLeFthtAjP80MNea+FwR+MGlufwtxTgNPZfRCJp36nmgveu6yqtdWDubgJtGJPfhc9KbIUaqPcd
 qRuBofHkfP3CCbQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 9pFrgKpWXFOLnmw2a0ULM8-stnczcYbI6qnIyA8R_Us_1785098708
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

