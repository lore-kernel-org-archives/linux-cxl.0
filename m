Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354331063B
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434660; cv=none; b=MhQzNYhauP1cE1WhmOaF5hVXr3ktfR34fFmKIsdwFto6goELThzazZu5byYDXjvkkt/pRTdtOjRNu6UAJKOjiQ1MgShuclKAfutOUr44uh1UGyIgUnqTcc3ggWd0P1ikRmm0Fdzynxi9/oYzIrOWQGHONTf/diAA/DVKzdANInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434660; c=relaxed/simple;
	bh=PsXVKNSP2IV5lNxkAtsT/bNWk13Co+2vRu/D64cg554=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJ7/K1a4kyBAAlMMEClN3SLelxC60rIVK9OeCCf0wR0VFq4ZbbpDSDwdZxMiKU8yDfSFAJ1dbsAf/TRCqfAg4La0k1HWsmZU1MBLg38uTaLMwueMQX+88qNUpInsdq2t4MEXRst9Ni7l7uuQiStyy7VWE+WUNDfWurqEO4Bjrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fWUbOKR4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fWUbOKR4"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88ffcb14e11so3562286d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434657; x=1769039457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjrrFW0XqdppZNNWqIznZXzloYpv+TypGhEeLOQrMhw=;
        b=fWUbOKR4B4vpCaTjmlkotG73eHR6pajDeQn0UWmAG7IVApuxRZYsMl2HJvTf9vnOCJ
         B2nvcdH80aqTOP/kjug6tlX9/vgS0Ph79rhvQGqMITnkM0r6/1nqiShl40XExTJP6Ikl
         ep8EsuOOvYqXSweQjniBqNPTJ+Njy1BWlO6ylo4ltRKzr70QnP0QfDdtS2AeWWuO++hD
         yTapKEAXl7yMNUc3P0BpdIewlrvn1GWdLGpKvJV/kCZAFTG9GnFWnXrZnqn9dDT3aErH
         CpRPavofaXJdbQYgFr8l/1K8/vFPn8cifioD5ANxsgZJq0z+D6jzuqrWPO51pKjp2po3
         cNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434657; x=1769039457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjrrFW0XqdppZNNWqIznZXzloYpv+TypGhEeLOQrMhw=;
        b=hg3YL6MvoMhsX062B4hxNptGSQPDHSWvjQ3uNzUI9r7VBLRwe2benqY2WeeQLph0t9
         7RBQxhYWiwYH2d1U8ywua9P7DoTgTDBufEnhJR9RgN8D8qoGfX6FnMFejtiwIsBhHB+m
         CHE6SPaKUeU3Yrbh0nGHBBx+UWgHPqugHiQk0iDe+FX/tL8QajRp5/dKCNIGy6VWuTT9
         YvqdksFYDbpXWMEbFsvVysViqNPmaVV+8QyLSEVGi2MpoFVCw7ECj+mhwVwMPLyhoAjt
         eGv49FoobuaF9tK5ZszsGpNjYyPntgn3CoDteU5SKsXjHhRIG/0mxn3ryAC9QCkyOb5O
         KNVw==
X-Gm-Message-State: AOJu0Yw1aImaR70VGatJSi0ImgxTaKbDsxwvoIL5Xh3v1evPWGFH61bw
	Vgf33cKFulT4BonmcoTx+buFCRsGOkfC9mlVARrapcAfg5vr2kunCF9ejwBCECcwd8U=
X-Gm-Gg: AY/fxX7RaCziS+29i6shfXACyFPWONFHKRta2oTddWNXLVhQvOuwzSS/9IW6SzIwYyq
	wAl2yCd4bz08Xcv/i5KxcMzNdXYUeSh0NdLE9Y6CSsBOGeTAx+xlB0YEXu3IerYrNOXKsoqnr3Y
	NNBsURw3L6ZJhXG7vLI4yKGH1dCmH74WgR0gMAlJVotz4za+v/BRJA1WY1lGZPdHg3T212zRxIP
	Rq0OgXVA7q/HQDISw+XNt2yBQVUN2Ulph4i5/KEPGaViSAW7VPKos870ARC3ZRavV10ltC6oGlr
	W2O1+PFi0hj6papTtItLCRFCRTGzs2QSbPav1sM0DjB92z+NfCLLqFGZzVvUuJWR722FmWxo3cD
	h6zVstOqmU/uac0v4wZe1kX9RQ+SqT2uOmCJlBbVTHLQ5eS6NkSj06IL1OEDTJMD/MJMm9AnUBL
	E72joPUmfnLosmGkBT55oDPBfeOGCB0Ys4HhqdPrWuXPUWFe2zkwA7Z9n30TvPSwsRXOPfYRy6M
	nc=
X-Received: by 2002:a05:6214:401:b0:890:6603:f258 with SMTP id 6a1803df08f44-89274373da6mr61800136d6.12.1768434657410;
        Wed, 14 Jan 2026 15:50:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:50:56 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH v2 0/5] add runtime hotplug state control
Date: Wed, 14 Jan 2026 18:50:16 -0500
Message-ID: <20260114235022.3437787-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dax kmem driver currently onlines memory automatically during
probe using the system's default online policy but provides no way
to control or query the entire region state at runtime.

This series adds a sysfs interface to control DAX kmem memory
hotplug state, and refactors the memory_hotplug paths to make it
possible for drivers to request an online type at hotplug time.

Problem
=======

Once dax_kmem onlines memory during probe, there's no mechanism in
the dax driver to:

- Query the current state of the memory region
- Offline and hot-remove memory blocks atomically
- Control online type (ZONE_NORMAL vs ZONE_MOVABLE)
- Prevent external interference with driver-managed memory state

This forces users (such as ndctl) to toggle individual memory blocks
prior to unbinding the dax device, and has lead to some race conditions
between competing hotplug policies.

Solution
========

This series introduces a 'hotplug' sysfs attribute for dax_kmem devices
that allows userspace to control and query memory region state:

/sys/bus/dax/devices/daxN.M/hotplug

Supported states:
- "unplug": memory is offline and blocks are not present
- "online": memory is online as normal system RAM
- "online_movable": memory is online in ZONE_MOVABLE

A memory notifier prevents external operations (auto-online policies,
direct sysfs manipulation) from changing memory state, ensuring the
driver maintains consistent state tracking.

Patches
=======

Patches 1-2 prepare mm/memory_hotplug to allow callers to specify an
explicit online type rather than implicitly using the system default.

Patch 3 refactors dax_kmem to extract hotplug/hotremove helpers,
preparing for the sysfs interface.

Patch 4 adds the 'hotplug' sysfs interface for runtime state control.

Patch 5 adds a memory notifier to prevent external state changes and
maintain consistency between the sysfs interface and actual memory
block state.

Gregory Price (5):
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: add 'online_type' argument to
    add_memory_driver_managed
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add sysfs interface for runtime hotplug state control
  dax/kmem: add memory notifier to block external state changes

 Documentation/ABI/testing/sysfs-bus-dax |  17 +
 drivers/dax/kmem.c                      | 577 ++++++++++++++++++++----
 drivers/virtio/virtio_mem.c             |   3 +-
 include/linux/memory_hotplug.h          |   2 +-
 mm/memory_hotplug.c                     |  35 +-
 5 files changed, 528 insertions(+), 106 deletions(-)

-- 
2.52.0

