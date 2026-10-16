Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D735212564
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186979; cv=none; b=obZipYzpF6HTWcLev/mmwnNEK7kCUaM3nEJ783jo8Ct5swAzWuATjHBUbBxzCH9p8s2jmzICK/e/YazzTTGQ1PkjO9Vk7tEjnBX5BCAK5CtFJXW04JNEYkjvsecT25fDs4KZ8WVF96Khi/GqGHrJVFrkXL2k5d/D0vKyQeldtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186979; c=relaxed/simple;
	bh=epZ+Tv4twj9omcUdqFjy3579cWwXC1i6LoOmmF+11f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhCqG6QvpLo4BMu/hQg+EugvzIKzLL2Hx3mgTSc71r4+llUkGsee2Z+qoPj2qkC/7UR+jQ8nrOWLhzt1WNJVNpPyqFj+Fu86OEmOEoZCY26la7Is6lHY6XfeyMCtj+5Z636q4Pydo1L7X+vL6lf6/x7p41QYXsqReQPOv+BuFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CakjjopG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CakjjopG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f1e5d7450so33422085a.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186977; x=1792791777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzNpaewaJctA3/hnc9N3XOje4ftRWEwGxLiESyBnTyo=;
        b=CakjjopGe11ivlsEaUDgM5fCzw0e8dcui9gtNeBw3XUnim8cbItlJaGAAgfWJHwpRo
         jKlgcPeFgOY/+MN9+EDPJMFpFm9b10UBYFtUhG67eEhcIR6Jv+gVXRimH6ch+PKrZyad
         G1qlj2INu2NkhGKLfT2VEfJFhV9bySUxTWln2S84MmyIRVgkMeke2vyWg2kv1kMOx3z8
         GnX7x3cnl7Vm6+jOnoaFaxKOMGNER8qkyBUZhidOEtQbW9/1Y821fAb/W7Klnpju7Ebq
         Zif2A/Z3giigZp8l12iSXFZMfUZDQoAJY8NBkI5Uiux+TIawDs5YTDzcCZtAljsjcGSS
         p8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186977; x=1792791777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uzNpaewaJctA3/hnc9N3XOje4ftRWEwGxLiESyBnTyo=;
        b=W8Ud2kZ6wMnsHiDG19dE+ZP5DAJQeYGhGDO3OovGkYv03d1wgkKrCvzDrzUnY0Nhig
         eUeaPLA+mg/UAKVTKH6+UpIhkl78I7MmAWXOKFrCVV0HTgpi2MdCBKS7rQD3tj8tj8wc
         KxDhuFUD8lhAJkzcuiBwj/YZ/gZUGnKiYlFxGAXN29Qc7B6M4yGfHJZH2ifywdaYmBgF
         8Stoe2kALKR4WycN+evGi9BDmFUJnE6ugwxzh9z2Mp3WJ8DyPVk7LCFggqpnLq5VSUKZ
         UB+7/w42iVk6muBpQpBAwHLeU5cRIXkIuUpUAiHenQ3QXed6v8SUSJyMxyHkWUqPH+9Y
         rkHw==
X-Forwarded-Encrypted: i=1; AKwUvBzLEP+CR2ipeglOycaAtDHntc71RfLbfCPjsL+SBMqNzCk+ARV5wLlAkTi6HuXAfF7ZqqLAZaXtlxM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpPU6bbUHFP4Win2tcdvbzTLX90pxYjyGnWnGXXjDyw4JnqmY4
	CmsVg9JnrMvAjjl6tvlykd5oNX4o2LFmoL1cSpkF0xXaVK6xwICb9pFP6Pl3v3C1sVUaoSff1oY
	2jlEsCGE=
X-Gm-Gg: AYBFou0FexytK87bVzVlhEky6n0z9UNkPdbBWo3SqxuMDqBsXymJwVHGVTezJK3qCPt
	ERHzS2YZxinXONqZvrwI5J47+hTG4soXm8nKMYbmglddgeBss/kaVI0bAFAAt7I2sbV+7mcQxjE
	rIdY6cyVUkJBbqvU2hFqHJBc8XsJe+2tDcXJpLGpOvuHRbtjfHNzoEWSPa1+8cQZpF+Rbp+SMS0
	tMI+E7AHLpvKpW4Ne/XdXdW5CLf86fLwlqY7rBd5TtNe36fAqFtE6ARY1KDutu2J7807j/icMWf
	b7Q0BEwPCuVKf/CmSjE+pzPW/Z7GJVH3jBvf8GsWEup43OSOvTv1ITOaZhca0QBeJTH+GnzscfS
	ZPN4RTml3GIMP7Lo7Y2m7Nw5kDbWHR1myd1r6M+2fdrXBY0wec+42DBoqgiotcEt0I5mB8vst42
	59f0OAOj7zlqLy9/jbNpBnEEs9WaID+GBx3h4ZSGIyA+2v46qvK4g8DQ2ngxZab1Xk9bWL8Yrtk
	BsBZvvpu+HFiZpJvtxGx2d3PypwITArvLGVA2S/MsXBcn0yYnLCVqGfHzqb
X-Received: by 2002:a05:620a:2715:b0:93e:62a4:be72 with SMTP id af79cd13be357-93f29cc952cmr209031185a.24.1792186977019;
        Fri, 16 Oct 2026 14:42:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:42:56 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH 2/6] daxctl: online whole-device memory atomically when available
Date: Fri, 16 Oct 2026 17:42:44 -0400
Message-ID: <20261016214248.443247-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016214248.443247-1-gourry@gourry.net>
References: <20261016214248.443247-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry@gourry.net>

When the kernel provides daxX.Y/state, online a fully offline device
by writing the online policy to it rather than onlining each block.
This avoids racing other agents (udev, auto-online) that online blocks
as they appear. The kernel only onlines from 'unplugged', so a device
in 'offline' is unplugged first; if that fails (e.g. no memory
hotremove support), the device is unchanged and is onlined per-block.

Memory onlined by another agent is left alone: the 'offline' case
re-checks that no block is online before unplugging, and losing a
racing online falls back to the per-block path. A small window remains
between that check and the unplug.

The per-block path now fails when the device has no memory blocks,
rather than reporting zero sections already online.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 daxctl/device.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/daxctl/device.c b/daxctl/device.c
index 47942f1..fd84799 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -510,10 +510,99 @@ static const char *parse_device_options(int argc, const char **argv,
 	return device;
 }
 
+static int dev_online_memory_atomic(struct daxctl_dev *dev,
+		struct daxctl_memory *mem, enum daxctl_kmem_state state)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	enum daxctl_kmem_state target;
+	int num_sections, num_on, rc;
+
+	if (param.no_movable)
+		target = DAXCTL_KMEM_ONLINE;
+	else
+		target = DAXCTL_KMEM_ONLINE_MOVABLE;
+
+	if (state == DAXCTL_KMEM_OFFLINE) {
+		/*
+		 * Onlining requires 'unplugged'. Don't unplug memory another
+		 * agent onlined meanwhile (a small window remains).
+		 */
+		num_on = daxctl_memory_is_online(mem);
+		if (num_on < 0) {
+			fprintf(stderr, "%s: failed to determine online state: %s\n",
+				devname, strerror(-num_on));
+			return num_on;
+		}
+		if (num_on > 0)
+			return -EAGAIN;
+		rc = daxctl_dev_set_kmem_state(dev, DAXCTL_KMEM_UNPLUGGED);
+		if (rc < 0) {
+			/* unchanged (e.g. no hotremove support); go per-block */
+			if (param.verbose)
+				fprintf(stderr, "%s: unplug failed: %s\n",
+					devname, strerror(-rc));
+			return -EAGAIN;
+		}
+	}
+
+	rc = daxctl_dev_set_kmem_state(dev, target);
+	if (rc == -EBUSY) {
+		/* back off only if another writer onlined it */
+		switch (daxctl_dev_get_kmem_state(dev)) {
+		case DAXCTL_KMEM_ONLINE:
+		case DAXCTL_KMEM_ONLINE_KERNEL:
+		case DAXCTL_KMEM_ONLINE_MOVABLE:
+			return -EAGAIN;
+		default:
+			break;
+		}
+	}
+	if (rc < 0) {
+		fprintf(stderr, "%s: failed to online memory: %s\n",
+			devname, strerror(-rc));
+		if (state == DAXCTL_KMEM_OFFLINE)
+			fprintf(stderr,
+				"%s: device left unplugged; retry to recover\n",
+				devname);
+		return rc;
+	}
+
+	/* all sections should now be online */
+	num_sections = daxctl_memory_num_sections(mem);
+	if (num_sections < 0) {
+		fprintf(stderr, "%s: failed to get number of memory sections\n",
+			devname);
+		return num_sections;
+	}
+	if (num_sections == 0) {
+		fprintf(stderr, "%s: no memory sections present after online\n",
+			devname);
+		return -ENXIO;
+	}
+
+	num_on = daxctl_memory_is_online(mem);
+	if (num_on < 0) {
+		fprintf(stderr, "%s: failed to determine online state: %s\n",
+			devname, strerror(-num_on));
+		return num_on;
+	}
+	if (num_on < num_sections) {
+		fprintf(stderr, "%s: failed to online %d memory sections\n",
+			devname, num_sections - num_on);
+		return -ENXIO;
+	}
+	if (param.verbose)
+		fprintf(stderr, "%s: %d memory section%s onlined\n", devname,
+			num_on, num_on == 1 ? "" : "s");
+
+	return 0;
+}
+
 static int dev_online_memory(struct daxctl_dev *dev)
 {
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
+	enum daxctl_kmem_state state;
 	int num_sections, num_on, rc;
 
 	if (!mem) {
@@ -522,6 +611,18 @@ static int dev_online_memory(struct daxctl_dev *dev)
 		return -ENXIO;
 	}
 
+	/*
+	 * Online a fully offline device atomically where supported.
+	 * -EAGAIN means another agent onlined memory, or the device
+	 * could not be unplugged first; go per-block.
+	 */
+	state = daxctl_dev_get_kmem_state(dev);
+	if (state == DAXCTL_KMEM_UNPLUGGED || state == DAXCTL_KMEM_OFFLINE) {
+		rc = dev_online_memory_atomic(dev, mem, state);
+		if (rc != -EAGAIN)
+			return rc;
+	}
+
 	/* get total number of sections and sections already online */
 	num_sections = daxctl_memory_num_sections(mem);
 	if (num_sections < 0) {
@@ -529,6 +630,10 @@ static int dev_online_memory(struct daxctl_dev *dev)
 			devname);
 		return num_sections;
 	}
+	if (num_sections == 0) {
+		fprintf(stderr, "%s: no memory sections present\n", devname);
+		return -ENXIO;
+	}
 
 	num_on = daxctl_memory_is_online(mem);
 	if (num_on < 0) {
-- 
2.53.0-Meta

