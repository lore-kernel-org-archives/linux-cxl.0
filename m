Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635048;
	b=cwU47gEGQCh9IFEm9s11BcYHBHH/IS8IkL9bgygsbkfQivzK1eYbIq0TlOy7++Wx8QIE
	 j87Qp34eEOhb++KW8R/MR+OpUJNxTfgdmYig+ffDAZRGypGbf7vfRMxa9VjQrKInlDUcT
	 0QbjpDc03XEVR2TpkD1TEjj8HZCio21pSv3ATl8W3IxN87FUUaxisNjT33vAjwSYb8j2H
	 P+NqT+s3ig1e4bOwC/MVVPFnbm21E11u5QvxmBSbK/+1edxHndyRMZADs2/R4v07+25Rk
	 gatKX1cfpapinEk57Ohk01XRiahE0V0U3UM9VHECvZM0AKg7XezsyCHHa3FzkZpBdeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4c1FYCoWuV0D5AZnd9JhUkc3urYu3tiqyGnrAo0dVsQ=;
	b=YL7jiJIrn3Pv14vFIDH1eHMeZCmnG2llcOLigqPZj4m3YzhoMz0rMoH9pqOaRTGwb2fp
	 6NCG8ypqkIpHPRDxAdUBNd2bbBDgQ3t47wETUCJ0W5cqhhX4FHHY2PHtP45RFlvgq1Ruy
	 34gFygT3yVFfDVeIptnf8+A4FpEJAURq3W8CHbuFLrctk2Tb4jh5pOVAxgPauqHNy2ion
	 LhD41t/NycD1TOYokckg+trJUSdjhMCTbwgDBQnmsYSoiYtl1aGmKvnTNevCeyHQ1EJYm
	 qHWJVir1tVz43zli0h46DdlOElJSQRjSqI6w12ieOOC4+G9DS9XSD/Xdul+OJWKWqJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdCXUk2b;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46947606A323
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 19:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46947606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdCXUk2b
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04fab527eso47653535ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795635047; x=1796239847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4c1FYCoWuV0D5AZnd9JhUkc3urYu3tiqyGnrAo0dVsQ=;
        b=tdCXUk2bln2JaFny46JeCc5ZMNDw/3+qR+WmADxAJaxlBXAqX0v7O+dGqHDQ7i9OSO
         HbGkyILfSoi2nqfk8zUQWh5tDLUrxLt3p6sOytd4oLf7WVgE71Wp5Lihy5FPwPFaBdLh
         AlZc4yBCwG/sE+NOF4koYCSIT//r7D3Kb041g2LQMvdiJa97tXnZREWzUbqsDTNvvk09
         t3r5BXnhfp4OWgjpsu7ninDi+MrCPp05mwXwwCH3+hMI10yLSwnsYAf2X+Vz71K2i1ps
         +D5udO8qxBudO1hPoqXH+t9LpgyRwdoRTAkmaN3dxj/FOvhXutPMEGExsJqi+wVE5f6D
         R3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635047; x=1796239847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4c1FYCoWuV0D5AZnd9JhUkc3urYu3tiqyGnrAo0dVsQ=;
        b=gLMSdU6hI5BJPi3OhlZrEcFcV8ImhXkRTpoI/zg7sFnrydBg2DUu4GlHPq5x4Uinm9
         2hnhO4DbaWHQ36nKMAtZ8gZnm4PZxMd3FGUSNbj2AnOdWf+0lucorI9mYUSFlC5fUDBd
         tD5N/yP9TvouQxmCSDQYRhAuAVg9XZcSdQJsBfC3LV4SBF7Ksq7tOj/jsMYb3ZSpUn0T
         TQcuiPOUYTV1nZyBWI6/eC4m983gD2uReVduN/L+TIIsHuRl/FCacQG/mA1GjJlOochk
         aUlcOw5bonZ4re+1qNpe11sprxhh9CvFz3ioxTalyR1hzK0yaD5ynrUelfKptDzXGKYx
         afNA==
X-Forwarded-Encrypted: i=1; AL+hErE5rH7Qzkk10NOfg+1urDs+2bksS4qtoZrXDityzUzRY8rgyh/dycMDSEuraSBR32Wk5KeELhr6lCk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XSkkj1H6u5bM4Ow1OlE2aL+bmc/Ox21pZcmNv96SdpQqG/U68
	DGtVQKcbWPEjnV0Wry0k6abTG72h5/vOR/6nq28omw0ig/+3YVw/K05s
X-Gm-Gg: AZFdTZfPbmmkA1DVuuxkC4w+tLW5OOfDokIs+lqQRnUkPXfIw/9fp+//BvMt29wfkWc
	8c0jxV7F1aD6crp12dvKW1tnHuYrWXN5hrkqrBILWZ3AqnsRLamJdVae+fZiUHlg/jHbjai2Qmw
	dnR1XiqKhuVeYLAk8ShZjaXTmtiFdXcphIJ5RgSYLS10vzujXTQeGcR7h2FywQh548y/C8ZR60G
	lG10M8qD96FT369Tb/a9qfJBUxLhkwk2kk0FzEd5+ExXrckMzMjGiaNSpG/lFW53+AHvViwqOWM
	GB18cahKUzSC6YrKJYYMlPQxBpo7GgrzKJbHgyIURY05mqWRIHfgkuyeyeQg7HpFkEj4JSY7MM4
	veC8/ueo5SG7pToTdL4RojbUhrQOcOrQOSGy3IklQi7CYf+yz6OvnJ4z1gAXbkpOZ4bTI6Np7MM
	1QDRytPDGOEOegjG4iiGATXInQfhGWPl3B69QTrhOTqd1SC2dSyrStFggsV0vROVeKyHbRE+qk9
	0QJc4ZuvPmJOuFu05Z/LmwDayQZDUZhp5zJhiBpkPTmKsUDTnwP6E8kaNzj2LTqbdvQttKAME4i
	EHD++pWhp8lyCyxLd+Gb
X-Received: by 2002:a17:903:19cb:b0:2e9:3dd0:c8d with SMTP id d9443c01a7336-2f03f1cf44emr208593395ad.14.1795635047369;
        Wed, 25 Nov 2026 11:30:47 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84425sm93698535ad.6.2026.11.25.11.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:30:46 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] docs: Fix the name of the memory hotplug online type configs
Date: Wed, 25 Nov 2026 19:30:39 +0000
Message-ID: <20261125193039.2437025-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The default online type is a Kconfig choice, so the symbols it defines
are CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE, _ONLINE_AUTO,
_ONLINE_KERNEL and _ONLINE_MOVABLE.  There is no
CONFIG_MHP_DEFAULT_ONLINE_TYPE symbol, but five files name one:

  Documentation/admin-guide/kernel-parameters.txt
  Documentation/admin-guide/mm/memory-hotplug.rst
  Documentation/driver-api/cxl/linux/early-boot.rst
  Documentation/driver-api/cxl/linux/memory-hotplug.rst
  Documentation/driver-api/cxl/linux/overview.rst

Spell the family with a trailing _* so that a reader looking the symbol
up in a .config finds one that exists.

early-boot.rst also gives the zone choices as _NORMAL and _MOVABLE.
The symbols are _ONLINE_KERNEL and _ONLINE_MOVABLE, so write those.

Verification: a build of the tree defines
CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE and no bare
CONFIG_MHP_DEFAULT_ONLINE_TYPE in include/generated/autoconf.h, and
grep finds no reference to the bare symbol under Documentation/ after
the change.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt       | 2 +-
 Documentation/admin-guide/mm/memory-hotplug.rst       | 2 +-
 Documentation/driver-api/cxl/linux/early-boot.rst     | 4 ++--
 Documentation/driver-api/cxl/linux/memory-hotplug.rst | 2 +-
 Documentation/driver-api/cxl/linux/overview.rst       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 176648941aec..8580099b98c1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3948,7 +3948,7 @@ Kernel parameters
 			[KNL] Set the initial state for the memory hotplug
 			onlining policy. If not specified, the default value is
 			set according to the
-			CONFIG_MHP_DEFAULT_ONLINE_TYPE kernel config
+			CONFIG_MHP_DEFAULT_ONLINE_TYPE_* kernel config
 			options.
 			See Documentation/admin-guide/mm/memory-hotplug.rst.
 
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 0207f8725142..c7de458a962f 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -280,7 +280,7 @@ The following files are currently defined:
 		       blocks; configure auto-onlining.
 
 		       The default value depends on the
-		       CONFIG_MHP_DEFAULT_ONLINE_TYPE kernel configuration
+		       CONFIG_MHP_DEFAULT_ONLINE_TYPE_* kernel configuration
 		       options.
 
 		       See the ``state`` property of memory blocks for details.
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
index 414481f33819..be9d5e510f99 100644
--- a/Documentation/driver-api/cxl/linux/early-boot.rst
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -34,7 +34,7 @@ which dictate how memory will be managed by Linux during early boot.
   * Linux Build config option that dictates whether the kernel supports
     Specific Purpose memory.
 
-* CONFIG_MHP_DEFAULT_ONLINE_TYPE
+* CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
 
   * Linux Build config that dictates whether and how Specific Purpose memory
     converted to a dax device should be managed (left as DAX or onlined as
@@ -61,7 +61,7 @@ SystemRAM.  This will expose the memory to the kernel page allocator in
 If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
 dictates whether the memory is onlined by default (:code:`_OFFLINE` or
 :code:`_ONLINE_*`), and if online which zone to online this memory to by default
-(:code:`_NORMAL` or :code:`_MOVABLE`).
+(:code:`_ONLINE_KERNEL` or :code:`_ONLINE_MOVABLE`).
 
 If placed in :code:`ZONE_MOVABLE`, the memory will not be available for most
 kernel allocations (such as :code:`struct page` or page tables).  This may
diff --git a/Documentation/driver-api/cxl/linux/memory-hotplug.rst b/Documentation/driver-api/cxl/linux/memory-hotplug.rst
index af368c2bc9cf..df27520b193f 100644
--- a/Documentation/driver-api/cxl/linux/memory-hotplug.rst
+++ b/Documentation/driver-api/cxl/linux/memory-hotplug.rst
@@ -19,7 +19,7 @@ Default Online Behavior
 The default-online behavior of hotplug memory is dictated by the following,
 in order of precedence:
 
-- :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE` Build Configuration
+- :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*` Build Configuration
 - :code:`memhp_default_state` Boot parameter
 - :code:`/sys/devices/system/memory/auto_online_blocks` value
 
diff --git a/Documentation/driver-api/cxl/linux/overview.rst b/Documentation/driver-api/cxl/linux/overview.rst
index 648beb2c8c83..d567353e1dab 100644
--- a/Documentation/driver-api/cxl/linux/overview.rst
+++ b/Documentation/driver-api/cxl/linux/overview.rst
@@ -17,7 +17,7 @@ are generated.
 
     i) EFI_MEMORY_SP
     ii) CONFIG_EFI_SOFT_RESERVE
-    iii) CONFIG_MHP_DEFAULT_ONLINE_TYPE
+    iii) CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
     iv) nosoftreserve
 
   b) Memory Map Creation

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

