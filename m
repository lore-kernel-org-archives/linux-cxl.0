Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E43C2798
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590975; cv=none; b=J7E5eSFpwH7AFbQmTtOQHir5cT+W8anmmPJL4OkH12sUPuJDpa611yRLh8bJE/bwJmNsfC1H/nLvPKyxlaquavV1IuIP4/s1k6MDbsq3BW7ltGzUSbyV/4hbaZ/Gv0lBeEbGC/wYMoTyDrQ5a0WCauLL2G2XrGQfgIQznm9QuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590975; c=relaxed/simple;
	bh=YCNaKQoQroBYpeSGV4n98VpS4o9pAwX4nsmdDk50zmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ds7gV4LFLziiq8KjhH9LpT5qRBeY15Y/u8mJBpDkIeyXPOYvGKtpMddxNTcV+TByYf69SbDDucz6NZnz2RjEPZTBMaFfUyO0bZMG2Ac3wJXkL7gh2gweKO4tfgNoBOI6vl1jcJyqdAU+e+1hKpCevw2MieZeP02JCEJsdNT60Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IBvmN7Vy; arc=none smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IBvmN7Vy"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BEF4D4014BA;
	Mon, 20 Jul 2026 23:33:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.103.92.160])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 70169400F61;
	Mon, 20 Jul 2026 23:33:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Fearful: 0a1c7e6066406f08_1784590389702_758826701
X-MC-Loop-Signature: 1784590389702:1016739499
X-MC-Ingress-Time: 1784590389702
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.92.160 (trex/8.0.2);
	Mon, 20 Jul 2026 23:33:09 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdx00fSz1P9;
	Mon, 20 Jul 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590389;
	bh=iZqxenwoIt6yu+IkNTihBz891cvUJGF++ChizIyZjAk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=IBvmN7VylmNt50oIZ1RwmEGGarPNxbbsk94Ci+zUz2WiHJGXuBYDHYCQkU5LcWaXh
	 OoNkOZPkbF2uGGAZB1KUhz/gnO+RBqmRblNCqwvsGT/CPgQCIzE8l2sWZCYmu6d/01
	 PXOc+e2iUCMVo12sJ5enJjyvmSNgj9Y4wjJbX7fS8qukujrUy/4fyTnddiIwuLP23z
	 s4G6VHywSWEZWImH6QktPbhx7y/VzMV/6ddSrVzoudTM9HMxZn74vo1T8cAiQ+kTtm
	 wVxJ3TqCfVVCVE6/LKX29Zj1pkZqmLXdfX9x5sLnhd11TkD3awWt6JML9h3ulWHGdR
	 m0F5u2gUCyhZQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 5/5] tests/qtest/cxl: Add CXL Fixed Memory Window restriction flag tests
Date: Mon, 20 Jul 2026 16:32:42 -0700
Message-Id: <20260720233242.901544-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a /pci/cxl/cfmw group exercising the configurable CFMWS Window
Restrictions.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/qtest/cxl-test.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 8fb7e58d4f17..49d820cde16f 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -81,6 +81,13 @@
     "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
+/* Single pxb + volatile type3 + one window; base for the CFMW tests. */
+#define QEMU_CFMW \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    QEMU_RP QEMU_T3D_VMEM \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G"
+
 static void cxl_basic_hb(void)
 {
     qtest_start("-machine q35,cxl=on");
@@ -117,6 +124,81 @@ static void cxl_2root_port(void)
     qtest_end();
 }
 
+/*
+ * CFMWS "Window Restrictions" (CXL r4.0 9.18.1.3) are configurable per
+ * window; check that valid restriction sets are accepted.
+ */
+static void cxl_cfmw_default(void)
+{
+    /* No coherency flag advertises both HDM-D and HDM-H. */
+    qtest_start(QEMU_CFMW);
+    qtest_end();
+}
+
+static void cxl_cfmw_host_only_off(void)
+{
+    /* Disabling host-only leaves device-coherent (HDM-D). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.host-only=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_device_coherent_off(void)
+{
+    /* Disabling device-coherent leaves host-only (HDM-H). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.device-coherent=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_back_invalidate(void)
+{
+    /* Back-Invalidate implies device-coherent (HDM-DB). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.back-invalidate=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_fixed_config(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.fixed-config=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_device_and_host(void)
+{
+    /*
+     * device-coherent and host-only may both be advertised (the spec
+     * permits multiple bits set); this must be accepted -- a regression
+     * guard against reinstating a device/host-only mutual exclusion.
+     */
+    qtest_start(QEMU_CFMW
+                ",cxl-fmw.0.device-coherent=on,cxl-fmw.0.host-only=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_volatile_only(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.persistent=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_persistent_only(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.volatile=off");
+    qtest_end();
+}
+
+/* Two windows in one VM: a Back-Invalidate window and a host-only window. */
+static void cxl_cfmw_two_windows(void)
+{
+    qtest_start("-machine q35,cxl=on "
+                "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "
+                "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "
+                QEMU_RP QEMU_T3D_VMEM
+                "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,"
+                "cxl-fmw.0.back-invalidate=on,"
+                "cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G");
+    qtest_end();
+}
+
 #ifdef CONFIG_POSIX
 static void cxl_t3d_deprecated(void)
 {
@@ -233,6 +315,19 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
         qtest_add_func("/pci/cxl/rp", cxl_root_port);
         qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+        qtest_add_func("/pci/cxl/cfmw/default", cxl_cfmw_default);
+        qtest_add_func("/pci/cxl/cfmw/host_only_off", cxl_cfmw_host_only_off);
+        qtest_add_func("/pci/cxl/cfmw/device_coherent_off",
+                       cxl_cfmw_device_coherent_off);
+        qtest_add_func("/pci/cxl/cfmw/back_invalidate",
+                       cxl_cfmw_back_invalidate);
+        qtest_add_func("/pci/cxl/cfmw/fixed_config", cxl_cfmw_fixed_config);
+        qtest_add_func("/pci/cxl/cfmw/device_and_host",
+                       cxl_cfmw_device_and_host);
+        qtest_add_func("/pci/cxl/cfmw/volatile_only", cxl_cfmw_volatile_only);
+        qtest_add_func("/pci/cxl/cfmw/persistent_only",
+                       cxl_cfmw_persistent_only);
+        qtest_add_func("/pci/cxl/cfmw/two_windows", cxl_cfmw_two_windows);
 #ifdef CONFIG_POSIX
         qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
         qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
-- 
2.39.5

