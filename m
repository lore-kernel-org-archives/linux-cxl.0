Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C0450402
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186985; cv=none; b=PERkrZs27pRH8rsUNYmGyJahMXhS4I10dn/HcUYSY/aKqA8x9tWZ17TGSeP8YcwKin/OCEvPWNEJgBd0lQBwd3q1/iOVZBIf39wtCtYeEWeSFy+lt0GcZTpmllUanKYIDnSUBb7k3hiCV6+0kW3trDIeEBaVlRnh4a0Ei/+KRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186985; c=relaxed/simple;
	bh=F/WfM57U0q+ZDXPsww2a9GAL1EnewK+UCthzDsiLWGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVYiSoiEbumL1WsBVqbP0RnVlMmEZzUZ7rKZBO6wK21cy0+wce3OaxR1Od6WQKfQxzGA2LjVWF2NpHYH5MHzbPSCyl3Mts4yadCjtIjZh5RaoS7qAKMWW6fAsZJird2suXhW2i8kbuqxlVhKDep1IWjVp0SpiIwh55U923FGpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K5dKYbE0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K5dKYbE0"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2049ea7aso26440285a.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186981; x=1792791781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+8JzaREQmzObVLMrQUhDLgZ0SUm0BdY4m5gZbFeHUk=;
        b=K5dKYbE0e0b2XbzRV/8q9InSaQYNGwKgiytG4JS0engqAfpiximr2OaGOCKgRO3Rha
         3r40fwztoxm5UwIkRTqtmaD2FbLU7QUPXezlt+UktpSE8sgRfqydzeFpRU77ia72mtZG
         /q7kqUZNccdhavbRqqkwl0LSc4QBJWyabB//l2iTsgMrsEhlUpGgYJtusUK6lJkLNbfX
         SfT2iQJ6m/sCm/bS4TBmzCAgaTuvNYlG89STdXY5E70VKGm/Si6Hk1NBDeV7kXr1O7H9
         nIsK4nBfyo+FkH8cwXm6ZSTVr8YbcT9eSu8PKt7eIB2bROkMEEOITU72sCZoPXhHG4Wz
         mdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186981; x=1792791781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+8JzaREQmzObVLMrQUhDLgZ0SUm0BdY4m5gZbFeHUk=;
        b=AsSjgNVdnaFsce+r1CbdynRmFTdKrPKyJiFMLu5RBfXbJehQI5+rOt+lSUkjReKKRZ
         gzatVoD1w0arTGgCNlJLwTaxvh0H243Na0N68FfP8Nv44iy1jSeyOhV+IBSh1Lg/QRwq
         CfjKEh2QE+uVNB2SphRP6p2voULx+t+sFglK3xN2n1TXWAEHh13DUSLdVEU6piWAucTq
         Gg3XShAeLEaK9mhujxjfxDa9T3c11UIhBzi0jMmB++pxRWO9pk0F+cdLbJcHfR/aVnla
         RsYKNYb2d/bz0d+SsK8BHj/AKdbYS0aFy5ZEX5TK90MSHJ8T6ExRR/TunzQXtw8Zpjz5
         TP/g==
X-Forwarded-Encrypted: i=1; AKwUvBze4hrnabniwheXw97HBUIex6hwwSH6KMWr8G93I8oBL6lEGgE2wLBu0ffcxNWyAXjmlb0SUjzWEto=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLHcD1RkCynHM2qobszSQb6f9mhopStgmxHx5xczUE27KWAxNn
	7Q1NuJSdzW2k8XR8Xgupr2FPiZRdTRk/NCOMxGF9UzhIzH990HlAPgiJ3EKb2PdF42g=
X-Gm-Gg: AYBFou0NzKSZfxiq4Vf7PfvkQAfV3reZHFewztcvQhyAzS/RbXhw0+FYTt1yCttMQaX
	O9rYy082mTl5c0+6OvUB8mtEhNEN21zS5w0IrHBh5IQHngdAgsgcfSg2m/Xhd1ASRFcIMOAxE07
	HBoNfvGHl9wIXBeMrdGcTSHGuiydRCZtgWWB74dS1CII4UjXzsPKnj+LZCtBNMYnzqnzNzcKJG/
	NSsaY7bgzv14X/WcDhXRiVZlMyg14SSaRWrMJZDfP3HWN5KFShynidPdm3Sd49hocJPTrsZ+h1W
	YxwpqCJcwHr0+fk1ksE6uOOek8Y3tsRgPG5yhEUkEimkIu6MXn3aWWVx2ynlhAhMHk9yc4QOZLg
	RWvckML2rCuxOEL7WeRQmsHx7y8TOeT4Jrqc8ScBhPLdo8npFuvTVeDRAxffdrELBygcagXjNZs
	HQfAQHjIS3KuNQpKp5QVVp5JNxeVeY/9L/rysGzh43DEeYJYxRJprDImhzFfIo10o/0oUAtD8Jb
	pIc7i3xFpGjkf9A+7ji2I/v8kyhdoHnpb1JXBjIqgZmYZTJ5C8lUr8V5f+j5Q6jXUYTLio=
X-Received: by 2002:a05:620a:2903:b0:93c:2c15:e510 with SMTP id af79cd13be357-93f29d37e3cmr198987285a.37.1792186981243;
        Fri, 16 Oct 2026 14:43:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:43:00 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH 5/6] Documentation: describe atomic whole-device hotplug in daxctl man pages
Date: Fri, 16 Oct 2026 17:42:47 -0400
Message-ID: <20261016214248.443247-6-gourry@gourry.net>
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

Document that online-memory and offline-memory use daxX.Y/state where
available, that offlining always removes the memory blocks and how
that affects reconfigure-device, and the 'hotplug_state' attribute of
'daxctl list'.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/daxctl/daxctl-list.txt               | 5 +++++
 Documentation/daxctl/daxctl-offline-memory.txt     | 5 +++++
 Documentation/daxctl/daxctl-online-memory.txt      | 5 +++++
 Documentation/daxctl/daxctl-reconfigure-device.txt | 5 ++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/daxctl/daxctl-list.txt b/Documentation/daxctl/daxctl-list.txt
index 5a6a98e..a2d0ede 100644
--- a/Documentation/daxctl/daxctl-list.txt
+++ b/Documentation/daxctl/daxctl-list.txt
@@ -22,6 +22,11 @@ list' with no options is equivalent to:
 [verse]
 daxctl list --devices
 
+On kernels that support atomic whole-device hotplug, 'hotplug_state'
+reports /sys/bus/dax/devices/daxX.Y/state for system-ram devices, or
+'inconsistent' if the device's memory blocks disagree with it (e.g.
+after blocks were onlined or offlined individually).
+
 EXAMPLE
 -------
 ----
diff --git a/Documentation/daxctl/daxctl-offline-memory.txt b/Documentation/daxctl/daxctl-offline-memory.txt
index ba06287..61a4301 100644
--- a/Documentation/daxctl/daxctl-offline-memory.txt
+++ b/Documentation/daxctl/daxctl-offline-memory.txt
@@ -41,6 +41,11 @@ to the system-ram mode. If one or more blocks are already offline, attempt to
 offline the remaining blocks. If all blocks were already offline, print a
 message and return success without actually doing anything.
 
+If the kernel supports atomic whole-device hotplug
+(/sys/bus/dax/devices/daxX.Y/state), the device is instead unplugged,
+even if its memory is already offline: the memory is offlined and
+removed in one atomic operation. 'daxctl-online-memory' restores it.
+
 This is complementary to the 'daxctl-online-memory' command, and may be used
 when it is wished to offline the memory sections, but not convert the device
 back to 'devdax' mode.
diff --git a/Documentation/daxctl/daxctl-online-memory.txt b/Documentation/daxctl/daxctl-online-memory.txt
index 08b45cc..adc8517 100644
--- a/Documentation/daxctl/daxctl-online-memory.txt
+++ b/Documentation/daxctl/daxctl-online-memory.txt
@@ -48,6 +48,11 @@ Online the memory sections associated with a device that has been converted
 to the system-ram mode. If one or more blocks are already online, print a
 message about them, and attempt to online the remaining blocks.
 
+If the kernel supports atomic whole-device hotplug
+(/sys/bus/dax/devices/daxX.Y/state), a fully offline device is onlined
+as a whole rather than block by block. An 'unplugged' device is re-added
+and onlined atomically; one with blocks present is unplugged first.
+
 This is complementary to the 'daxctl-reconfigure-device' command, when used with
 the '--no-online' option to skip onlining memory sections immediately after the
 reconfigure. In these scenarios, the memory can be onlined at a later time using
diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 9c3922d..d2b5bbf 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -230,6 +230,8 @@ include::region-option.txt[]
 	By default, memory sections provided by system-ram devices will be
 	brought online automatically and immediately with the 'online_movable'
 	policy. Use this option to disable the automatic onlining behavior.
+	A device unplugged by 'daxctl-offline-memory' has no memory blocks
+	to online; use 'daxctl-online-memory' to restore them.
 
 -C::
 --check-config::
@@ -248,7 +250,8 @@ include::movable-options.txt[]
 	that all the memory sections are first made offline. By default,
 	daxctl won't touch online memory. However with this option, attempt
 	to offline the memory on the NUMA node associated with the dax device
-	before converting it back to "devdax" mode.
+	before converting it back to "devdax" mode. This uses
+	'daxctl-offline-memory', so the device is unplugged where supported.
 
 	- Additionally, if a kernel policy to auto-online blocks is detected,
 	reconfiguration to system-ram fails. With this option, the failure can
-- 
2.53.0-Meta

