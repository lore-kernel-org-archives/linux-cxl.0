Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795350023;
	b=QJJxLENh/BnmjkarbqfO+y+2dqvuavgsDiUA0yS0/f0hf4SNVZgL5wBDGMklzgHz90sY
	 xWsPHXwlyngPf9HrNWj421gWagQ54XeWpyZxzbpUqvvsuLsBqIP56kgyxa6htanHz1pcv
	 yCnhEi//nuv6PXAf5YaFFaQUuIECrL61FoV/LOJIzwC0y/65+kGXdpNzGrTp5GnoamZd7
	 Hee57s55YEye1PQSflhcInFy3Jw48JrgW43SYGDg8gGKR6hfSe6x6sRfTVJvd/QUh6rK0
	 BxlZDVdIh8v3znisybIueFKYCtRRxf92Jr5zC3LFB18pCTxXpu7METsuQOa4gJ79lWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HBuf3DEB5ZqlJpvGsQMe7eJ7vutfXuN9J2TgjKjXyjY=;
	b=mHUYFnsGeNZwzhIS5qqKPTzVyX1NxgR8xeAMjQINF3/Rnzt0coT5kOUJZbxjkJXb8nfR
	 HJEOVu28MGQ97DUSydXGkqSc33i2sZdNIuc+Vh/tGRHktIuZGUH0iAugDQdNJwSIi+oYf
	 ZE7wVDGkQNkwbOzwm85UIJOXdxFAo8+Ys36vne2/M7M629LpqgoAzmIrhiKSoejTARqTn
	 gzVsVvMmTw9lyVtiIGukxF9j4t8WR/jwF0o25+PK49sINAlmuG7rHAHGvPYGGdPux7hb7
	 wMr+WkgyfkLRqp5F2rZXfM4JWTKsDcPcsciXp+sza8ntyT8hEXN6BmZtZtaiv8LrOIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uf90EpJA;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D871606A32A
	for <linux-cxl@vger.kernel.org>; Sun, 22 Nov 2026 12:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D871606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uf90EpJA
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-55650fe1f0dso1420470b6e.2
        for <linux-cxl@vger.kernel.org>; Sun, 22 Nov 2026 04:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795350021; x=1795954821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HBuf3DEB5ZqlJpvGsQMe7eJ7vutfXuN9J2TgjKjXyjY=;
        b=uf90EpJAVSpFRpRE5y7+9rDwPqPb5Z0mfYHI5ulJumfzGF+f4CzcJBY/iKu29fmAYd
         UzFmdgG09XFVXEf95GCeOBfPb3L3LXOBG1jN2s8uAnj9Oro4r+8fVUOV3LR5hy7uZVxW
         0Bv1oR0Ahmv8AkBbOrsADBOKhYGSBC1TrH9WWIfc4cR1hSaj3iEqcfOYc5yfrvjZtRYI
         1MDwWwn29HdCcWLOp0EgmJEFdRuAaVWD6gBaLdxN4dB7kNDtKL5aWxnVnFxEEItnahr+
         liy1sgoP2IXMG8UEDXeFXHm5ONhZ29R+1D7P4vO4xzUcX1Y4uwCOyv255cOwXZmYGK0d
         BW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795350021; x=1795954821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBuf3DEB5ZqlJpvGsQMe7eJ7vutfXuN9J2TgjKjXyjY=;
        b=yy18mm6Ck9SHc+3BrjrvmzgTX+21EzynQ0bAF1P7ojZz46HqVNKYu8YitMzde6t5R9
         ZhiNRrV2J9QF81RVvolUxszC8Rg2pMXIbK6AiBrps5UDIrvAerLQvWOvl/S5nIW3nIZH
         RZAOOeIXD2wOwMy9NRr8lv+smi2za8DtHswF5Skmpj78DcHmj6A/HaZkoN7nbrbfn/ks
         +dFW82tY6WYuTtJPqhTLF6G0sxUipftNuX6pjWIHKAJ7wcn4gIgUhnAX3lovnUs+6PKl
         OHQJ4kTKCabDyu2jUL/ndiWao8n4eG1nSZ0wDmAEMhhZxYql2RyietXPhw5t9M4Yf/4E
         h17A==
X-Gm-Message-State: APuU4Z8c99j78vUi2ut0YE94wYoUFQFBJV2nIdvzf+3DzI1zMBdpQY6h
	c+7ykhZWceGz9aYdNU3csvGMPrXs/uSAYu31EEO2uvQELj9nLf7YC9F3quoVtpvd
X-Gm-Gg: AZFdTZfLNcZsj/nfUlJfP64ulkm1MNz+fL4zXk74iW2pn4b1X/uW4y666i2ReEosyj4
	mPg3FAwhx6CGctwfe8Rpa6UYbtFEmm8+BsOfUm7FAxQueDJRr/qIa/oMEmrHiPIqajgfOgucxZ0
	j0kQRGcbD8AppA1wTym33IA20IM1B+cZ7vdge9ukVG/g209HtZXaLDUd/GtdPps01SyWoPsXe7K
	Szi28tisOycR9/Y3HdQD29tboVaRHhtFeTMJ5gFr2RaBLXtbUBH1pksQ2ZfhN4lcMqJqwKRokBr
	/4n9PmK1aSV2tEkKuidkB1ct7YTVBOKlHBlJ1EpRw7wYD3FMDxkQTm8+XH5WW7tS5qKeM1y6oif
	6YkztSePUPGHDhLCZlwkyZILKUsaBgi13k4BZn0PHZaou5XBrpyHUPa3wntiiFoaypdLHqtx2A0
	JerksbEhiPORfnvUHsju4rTmcSS2lkYuO6Ljr2ERXH077l+BYIPSDu94rVpABKb14YBDTH6O5qF
	QMQ+qdxlcEtPctJup5txWbsVRZ1dzwv7o/Vn6beJOVUa+w7bAvutY26obAv5fIB2crd/I5SHdEY
	zxOLZCohIjKmMPuhyOFMp1OZn3lYaKFZIqa3VMkLoHA=
X-Received: by 2002:a05:6808:1305:b0:4c4:d8a0:2773 with SMTP id 5614622812f47-57a0a9142cfmr9672467b6e.32.1795350021271;
        Sun, 22 Nov 2026 04:20:21 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35655a5bsm6734024b6e.13.2026.11.22.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:20:20 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH] cxl/port: Do not queue a memdev detach when the memdev unbinds itself
Date: Sun, 22 Nov 2026 21:20:14 +0900
Message-Id: <20261122122014.2194208-1-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Binding a memdev to cxl_mem right after unbinding it often fails: the
probe returns -EBUSY, or the bind succeeds and the memdev is unbound
again a few milliseconds later. In the second case the bind write
returns success, so nothing tells userspace that the device ended up
unbound.

cxl_endpoint_port_probe() registers schedule_detach() as a devm action
of the endpoint port, so that a memdev whose endpoint port, or a port
above it, goes away is detached. Unbinding cxl_mem deletes the endpoint
port itself (delete_endpoint()), which runs that action too and queues
cxlmd->detach_work although the memdev is already going away.
detach_memdev() later calls device_release_driver(&cxlmd->dev), which
takes the device lock and releases whatever driver is bound at that
point. A bind that runs before the work makes cxl_mem_probe() fail its
work_pending(&cxlmd->detach_work) check with -EBUSY. A bind that is in
progress when the work runs is released by it as soon as it completes:

  bash     echo mem0 > unbind: cxl_mem removes endpoint2 and its decoders
  kworker  detach_memdev(): device_release_driver(mem0) waits for the lock
  bash     echo mem0 > bind: cxl_mem_probe() returns 0
  kworker  releases mem0 again, endpoint2 and its decoders go away

Mark the memdev while delete_endpoint() removes the endpoint port and
skip the detach in schedule_detach() then, dropping the reference the
work would have dropped. A memdev with ->attach still gets the detach,
since there it releases the parent device, which depends on the
memdev being attached. Losing the endpoint port or a port above it
otherwise still detaches the memdev as before.

The problem was found by an automated test harness driven by an LLM
coding assistant. The analysis and the fix are my own.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
Question: is the detach meant to be queued on a cxl_mem unbind too? For
memdevs with ->attach the patch keeps it, as there it releases the
parent; I have no such device to test.

Reproducer, as root in a QEMU guest with one type3 device
(-M q35,cxl=on,cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=8G
 -object memory-backend-ram,id=vmem0,share=on,size=8G
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1
 -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2
 -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0):

  M=mem0; D=/sys/bus/cxl/drivers/cxl_mem
  for i in $(seq 40); do
          [ -e /sys/bus/cxl/devices/$M/driver ] || { echo $M > $D/bind; sleep 1; }
          echo $M > $D/unbind
          echo $M > $D/bind 2>/dev/null; rc=$?
          sleep 1
          [ -e /sys/bus/cxl/devices/$M/driver ] && s=bound || s=unbound
          echo "bind rc=$rc $s"
  done | sort | uniq -c

Without the patch 7/40 and 11/40 fail on cxl/next 32af781935 (2 of
the 11 with the bind returning 0 and mem0 unbound after), 14/40 on
v7.3.1.

With the patch on cxl/next (release and KASAN/lockdep builds) and on
v7.3.1 (KASAN/lockdep): 120/120 stay bound on each kernel, unbinding
the endpoint or host bridge port still unbinds the memdev, and 3
minutes of racing memdev and port unbind/bind gave no warnings.

Not tested: memdevs with ->attach, switches, real hardware. Regions were
only checked on v7.3.1: cxl/next creates no root decoder for QEMU's
CFMWS (restrictions 0x2f, "cannot have both HDM-H and HDM-DB").

 drivers/cxl/core/port.c |  3 +++
 drivers/cxl/cxlmem.h    |  2 ++
 drivers/cxl/port.c      | 14 +++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fffcb9954d..4960a288a1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1514,9 +1514,12 @@ static void delete_endpoint(void *data)
 
 	scoped_guard(device, host) {
 		if (host->driver && !endpoint->dead) {
+			/* @cxlmd is going away, see schedule_detach() */
+			WRITE_ONCE(cxlmd->unbinding, true);
 			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
 			devm_release_action(host, cxl_unlink_uport, endpoint);
 			devm_release_action(host, unregister_port, endpoint);
+			WRITE_ONCE(cxlmd->unbinding, false);
 		}
 		cxlmd->endpoint = NULL;
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4cf8a0f6cf..0d566b8e32 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -41,6 +41,7 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
  * @detach_work: active memdev lost a port in its ancestry
+ * @unbinding: the endpoint goes away because this memdev is being unbound
  * @cxl_nvb: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @endpoint: connection to the CXL port topology for this memory device
@@ -58,6 +59,7 @@ struct cxl_memdev {
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
 	struct work_struct detach_work;
+	bool unbinding;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 96fade0299..092b138827 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -26,8 +26,20 @@
  * PCIe topology.
  */
 
-static void schedule_detach(void *cxlmd)
+static void schedule_detach(void *data)
 {
+	struct cxl_memdev *cxlmd = data;
+
+	/*
+	 * A detach queued while @cxlmd unbinds itself would run after it
+	 * and could release the next binding instead. With ->attach the
+	 * detach releases the parent, which still has to happen. Read
+	 * without the host lock when the endpoint port is unbound directly.
+	 */
+	if (READ_ONCE(cxlmd->unbinding) && !cxlmd->attach) {
+		put_device(&cxlmd->dev);
+		return;
+	}
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
-- 
2.34.1

