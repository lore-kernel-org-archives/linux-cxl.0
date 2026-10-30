Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364265;
	b=WPqoHRnSsziPnf+Igqt4JvpZGQboXqgX5zIl4UqhJe0RJ/lR9OevRvPuCH+FCP9pjQ4v
	 fcu4gSNIbtXeq9+Q2GIVjN5JLF/MPdZrtECzCfiIcOYReRAg6MHGmPUzh9cWjQ36m8HUX
	 IK5uyG5b5Q9HgJUv5qyDPY9XLqLzDVz1yWozt8pml94DW/Z2yqy42PnDYC8WbU4Ugjr5a
	 uNyTrtE1SaCMn5jnMg8Ovj2yMGYgv23ZqjcoZr1kFvwgYM/rKfd44iu7iZNGVyOIXiTaB
	 vuJA12LX4tZmk2QUt54PUOeOc1QyzKaZJIzEtDMBCPc1YSM1ACgoE2Zb9EK/VqlJukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364265;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VSPz+L6W93An9Mm6mOGoGNqrdBphByjhj8UXXIBhUuw=;
	b=fGhQ/iuTsPODKb6ufj0+8+AFtCO7GZHLPvKhut48BBTC55EpKYT+wZ16DDg0Xuw9y6oO
	 NU5oR766VXo/ylYs+s/XV3Q12qbDhdCEW7+1ITooX6Xqa+me+9YMOkbNNcfgL78gARi4l
	 zaMk1QSIPlq2y1ec/oYuDSHbCbTBmkPhATWOd86SO1YLAfXFC8CL/jLXE8GAxL/OZWe4u
	 dbpsfFx82WoFPBQiNECGoNppF26UD34LtvhlM1+8+H0zVDI5N/RDJGoIs1v7SSRWGmQPm
	 jH0PMMXAtm4igVbIoVR3lZcqBo8hZQ1fduwhkTTJUjtNSshWm89z69cPKbJgsqxMvSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mLm6MotU;
	arc=none smtp.remote-ip=91.218.175.5
Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E0606A31A
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 12:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F22E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mLm6MotU
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JQxFpb1w6oonfIYf6ktt9ZoYfLKevZVXLt9ujZm4CoA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793364261; v=1; x=1793969061;
 b=mLm6MotUj4i5hMseaHIy4Uuq0pZ0QqaKYIpn8yUesOSddj6Kz0qcALAwKkVxPy6/djK3i8WR
 duXCM6YhEzx4+8YmJCgnAPL5THyXhz7h8Jtm5bQSvHm+o4rgRGmVbHzpjunZfmcTLddS79KNHwD
 ergrwBYhY5mZoPFP18dN+OnY=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dccdfc7b858c4d25;
	Fri, 30 Oct 2026 12:44:21 +0000
X-Mizu-Trace-ID: dccdfc7b858c4d25
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	mjt@tls.msk.ru,
	jic23@kernel.org,
	anisa.su@samsung.com,
	mst@redhat.com,
	philmd@oss.qualcomm.com,
	linux-cxl@vger.kernel.org,
	junjie.cao@linux.dev
Subject: [PATCH stable-10.0] hw/cxl: free the CCI background timer on Type-3 reset and exit
Date: Fri, 30 Oct 2026 07:44:17 -0500
Message-ID: <20261030124417.1066423-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ct3d_reset() re-runs cxl_init_cci() on all three CCIs, and each run
allocates a fresh background timer without freeing the old one, so
every reset leaks three QEMUTimers.  ct3_exit() doesn't free them
either.

Upstream fixed this in 259b877eac36 ("hw/cxl: fix timer leak in
cxl_destroy_cci()") and a004df0be51f ("hw/cxl: destroy primary CCI
before re-initialization on reset"), but both rely on
cxl_destroy_cci() and the .initialized flag from 98cbac128f1c, which
only went in for 10.1.  Add a minimal cxl_destroy_cci() here and call
it before each re-init and from ct3_exit().  timer_free() takes NULL,
so the first reset needs no guard.

ASan on v10.0.15, 5x system_reset on a paused guest with one
cxl-type3: 720 bytes in 15 allocations from cxl_init_cci ->
timer_new_ms before, none after.  cxl-test passes.

Fixes: 221d2cfbdb53 ("hw/cxl/mbox: Add support for background operations")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 hw/cxl/cxl-mailbox-utils.c  | 6 ++++++
 hw/mem/cxl_type3.c          | 6 ++++++
 include/hw/cxl/cxl_device.h | 1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 516c01d840..6cbc649367 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2986,6 +2986,12 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->fw.slot[cci->fw.active_slot - 1] = true;
 }
 
+void cxl_destroy_cci(CXLCCI *cci)
+{
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
+}
+
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
 {
     for (int set = 0; set < 256; set++) {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1606aa3279..df9c70973e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -973,6 +973,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
+    cxl_destroy_cci(&ct3d->cci);
+    cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    cxl_destroy_cci(&ct3d->ld0_cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1222,15 +1225,18 @@ static void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
+    cxl_destroy_cci(&ct3d->cci);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
      * This device is emulating an MLD with single LD for now.
      */
+    cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
     cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->vdm_fm_owned_ld_mctp_cci,
                                           DEVICE(ct3d), DEVICE(ct3d),
                                           512); /* Max payload made up */
+    cxl_destroy_cci(&ct3d->ld0_cci);
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3a0ee7e8e7..d9238c903e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -316,6 +316,7 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_destroy_cci(CXLCCI *cci);
 void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
                           size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,

base-commit: c2cfbc6c121b4875ac509da605968ff4289b6aef
-- 
2.43.0

