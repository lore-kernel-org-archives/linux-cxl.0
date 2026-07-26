Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3120E023
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098670; cv=none; b=UcdwRqmnibOlrqf96aoKC8pR76EqPTZSV2TS74axH17ZwQHe+GDp8IyHAAiToR05gB73HSqzhcZ1H2IlEha0xi8wy6t7fVootOjXwULN0SdCJbaS6U/3pNbfxvqa8S9X1k0qR1r2zPgTpYpB0u2poatKi0F82Qn+5VLFquvcaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098670; c=relaxed/simple;
	bh=81XNAl0jGOvgHJBEZNtBgZcA7BxMGvlceRyUY4G25BU=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=MlMgeVIkmJ96aBwYWt3DJ6Lr+gCRKWxnNgi1a7N1nvj5wx6ZSh5EKJYEv2xg/lYM23W1rnTTdd/8kVum75MhwJrgoOlKMGK8UmUCxAXn6K+iJsLV5Mubh35V7DV5qkROJ136nazlr6Vi2PfD5MIE2P+cqiBBUuOp3oocUpZUH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWRkonJp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWRkonJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9VGR6qC2/lcwNbneDZFXtH9Y/dg0TeIf8HpB0dX/lL8=;
	b=XWRkonJpWIipURmTDtPxhigxxVhYr+93C5Ekj+U3nv7zvOH1BJJhR98Fxk/UtS8RWu2Pvy
	LOjinkzANYOzKDTCdY7t+ZWRcJLsZfIKAtxYR+qE7MyhjXFlN97Skzh//LIQ2EUj3u33QQ
	K/Y/Zpjp6JrN3v8bnxhw4ryBiLHwgE4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-b7kZzEVIP4-jfjjeXPhszw-1; Sun,
 26 Jul 2026 16:44:22 -0400
X-MC-Unique: b7kZzEVIP4-jfjjeXPhszw-1
X-Mimecast-MFC-AGG-ID: b7kZzEVIP4-jfjjeXPhszw_1785098659
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10B88195605F;
	Sun, 26 Jul 2026 20:44:18 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5AAF424;
	Sun, 26 Jul 2026 20:44:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/12] Fixes for 11.1
Date: Mon, 27 Jul 2026 00:43:59 +0400
Message-Id: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw7CIBREf6W5azEFBYIr/8N0weNqr4nFADaah
 n+X1p3LMzkzs0DGRJjh1C2QcKZMcWogdh340U43ZBQag+iF6rWQ7EpvwRRKHsSBa3N00NRnwpZ
 vM5fhx/nl7ujL2l2NkXKJ6bP9zHz1/iZnznomvbHKo3ZG2XPCMNqy9/EBQ631C+egivurAAAA
X-Change-ID: 20260725-fix2-6e51d231794b
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=81XNAl0jGOvgHJBEZNtBgZcA7BxMGvlceRyUY4G25BU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGW/T0EIhd4oRY5ZiWQ2xRzskvNLXAVUwAxf
 c4J6Zk10S6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlgAKCRDa6OEJdZac
 5WTiEACFaQUoMGXX+XPUIq8TH938iokMjYobWwUVZd2vVOYsPkFAJAwji2sS8wyIdcKYBFu1xOL
 MhUUoogBKiguHuGDTEEo4iVAVd7TXGseSbcaHKCMrlpNhLq4XEQbZ9Slr2IR/bol0GAd+JcRFD1
 SLj7B2PCDORx0gJQ5YXjYPIafMwk887Jnxskb7HUqjZcZ624pcFZEFr2c5HErZu7f97CWJFIHfp
 yTyKYPPYy/UZ2zlF5F7SntV74yrLvUfCt1D5qyki0Ry5VPc7CVoSyBrHUxF9IRxLIjdr8U6jzVD
 ZvqZMkPUG/z1Jp2tWheBWMG1cAlH9ori5kpmeA4vF2u5PfoiaB9zDGayuH+EJqPDj3B/FJPOP6L
 hZ9tKcQwZigLFredm+hqtdz0TIcaJpSe813clsOAIe+HaUUiloziOEh4wZJiFXjwS5kBh8QBMt5
 osUEMTsGZiLQFeZvWaTFCCrYISv3/jaMTiLzmh5cyJij8cxuB/2nvHT2aj3GdgdujPFB0tw1hTX
 tdXaT39K1rAf0aLsaajuzLRwjJFRy+DsINiz2P6E2nm4zYmgggocxemIeX6KzzMYYKXXn/CxR9Y
 HJbv5YzUo5Wx5n5jxiBk7m6hztE9Gdjv5DpbraRd2Z0+4sI8WyPivWaePNi8a83XHpEcBL8H5uB
 4aC3nj1YXfb522w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: QrmoExVA1__g-1v7Ea5LC1hiCslhPiABGxNr7pd2jnM_1785098659
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi

Here are some assorted patches worth considering for the 11.1 freeze
bug-fix period.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2, after Akihiko comments:
- split the "Fix many -Werror=maybe-uninitialized" patch
- qdev-monitor: add drain_rcu parameter to avoid deadlock from virtio-net
- rewrite WITH_QEMU_LOCK_GUARD/WITH_RCU_READ_LOCK_GUARD macros to suppress
  GCC false-positive warnings (new patch)
- block/blkio: use QEMU_LOCK_GUARD instead of WITH_QEMU_LOCK_GUARD in
  getlength() to avoid false-positive (new patch)
- hw/cxl: split invalid-free fix into its own patch
- hw/i3c: fix default return value of d2_i3c_send() (new patch)
- hw/ppc: fix dangling machine->fdt reference after spapr fdt updates (new patch)
- Link to v1: https://lore.kernel.org/qemu-devel/20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com

---
Marc-André Lureau (12):
      hw/display/virtio-gpu-rutabaga: zero-init capset info response
      block/blkio: fix error return value on getlength()
      block/blkio: fix compiler false-positive warning
      include/qemu: adjust LOCK_GUARD macros to avoid potential warning
      hw/cxl: fix invalid free on early return
      hw/i3c: fix default return value of d2_i3c_send()
      Fix some -Werror=maybe-uninitialized
      hw/hexagon: fix machine->fdt leak in qom-test
      hw/ppc: fix dangling fdt reference
      hw/core/machine: free machine->fdt in machine_finalize()
      migration/multifd: fix Error leak in multifd_recv_terminate_threads()
      qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict

 include/monitor/qdev.h           |  3 ++-
 include/qemu/lockable.h          | 19 +++++++++++-------
 include/qemu/rcu.h               | 17 ++++++++++------
 block/blkio.c                    |  7 +++----
 hw/audio/intel-hda.c             |  2 +-
 hw/core/machine.c                |  1 +
 hw/cxl/cxl-host.c                |  2 +-
 hw/display/virtio-gpu-rutabaga.c |  2 ++
 hw/hexagon/virt.c                |  9 +--------
 hw/i3c/dw-i3c.c                  |  2 +-
 hw/net/virtio-net.c              |  2 +-
 hw/ppc/spapr.c                   |  1 +
 hw/ppc/spapr_hcall.c             |  1 +
 migration/multifd.c              |  1 +
 system/qdev-monitor.c            | 42 +++++++++++++++-------------------------
 target/i386/cpu.c                |  3 ++-
 target/i386/emulate/x86_mmu.c    |  4 ++--
 17 files changed, 59 insertions(+), 59 deletions(-)
---
base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
change-id: 20260725-fix2-6e51d231794b

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

