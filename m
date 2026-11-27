Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806133;
	b=kqWQGRzrbTuSQ29Nya4RRwQejHxspj2gEP+U91UcKaH6JNcVwAJahP50BrXyIOTcexN3
	 I5Z+lJ97MCVrA2V5sO9qItHPqWT7ziELesTap1yemguADt9iCSr4ObQKVPWamIqyoq9h1
	 0v6wlOzNWjgKt3s2luLd9rOYnDFQRTuR5KKwzojHl/nxEQs0aO1JaTPaLUbpJ/pXFGUtc
	 zuTK+ti3HfKZaIIC476CeYsdAgG2RkUvAWXS7CCvduyyDVIsLuN4r5wWuLFG4CqcaY9zs
	 HY3F0c23m0xABAKz5RDp6CHgtz7WKUhoAfYd3hAz4VtUdKk8j8YrKQbuo33YkA+EUQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zkQBPyKgHhzReYEqUfH52eqklLDsrHQN3rdcMHP01SI=;
	b=h08unqv6XnejCH/1hs/UBZ8+z3EPIIQwna87WJAaU8KE07g6EAFEMDTv4Qal/fbFL6Su
	 1ib77HNst6BCefd8tPamN73N11NxxwOfyPbELP7+jPBrTLs4WabNCU7WnadJV0Tf06qJf
	 UUiXQ1D10Fz8/TZfxIxpyFOej9ETDarjEpfCOxCN6+Xj8lUj2Qxl2KgTnx2r+uyicqvQk
	 7KZ+/EndAdvr+Yittd3O0taQnRcBO4/NYUF/QCkXyAHeRrZh3MLmaQu1K7bzZNnNhEcml
	 x4a/VHI8vV5eN4TtF/StKyXrXKnevD1HF6tp3BRFBzBdIA7TGMoIbsYm9PuvURXJ8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENoUf1Ar;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA14606A326
	for <linux-cxl@vger.kernel.org>; Fri, 27 Nov 2026 19:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA14606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENoUf1Ar
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1aefd1bf74aso4777209c88.1
        for <linux-cxl@vger.kernel.org>; Fri, 27 Nov 2026 11:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795806131; x=1796410931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkQBPyKgHhzReYEqUfH52eqklLDsrHQN3rdcMHP01SI=;
        b=ENoUf1ArcEfIE2J7WrvZgIIMCYa4qWfn/gtvnY4g+FpJfoheJfm9CBabxVkguJTPUP
         YQfjn7Vl3LN6DzpCxX5sW7o/Ng56wA6wxD7Q2pWnbn94mfSHn5DyMQMO5IRoTlGV5Tu8
         Q1/0fcIA69vkPToJSVsdZpA2IXZOFCoHOi89tSVF4pihin3oEpDQiZSI5plyB2rNVkPl
         8HAxisjmU2AreweJcKethZOCv1qYvUvtH5JwBsXSvanho6QP2iyc+g0vEs/40RdCqhcj
         h3RiNO1IlZDS8WBJQTRBBiITDlSwLsfeQlUOSEOCgy0ZToiTU7K6AjUsqfsZdegDpI2k
         2/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806131; x=1796410931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkQBPyKgHhzReYEqUfH52eqklLDsrHQN3rdcMHP01SI=;
        b=CpOpzcXUJe3RKMZIhE2gAbSTLC22BmwUXOze9FpzsEJg/B5E9TITo6rU/mu1o17jBi
         d2NozsfzRmvcalUUddjVPCQimGcrAMH/d8PPT0GjRZLPkoVh6H3CEWQpYvhvGkvwVJHS
         DcO0OUeINUtSeNjhlWNExXf/dFp0+kFQf0tCILylz63Pu1WjsSAhighZDoTt5E3KagJn
         xo9O93tr1ZZ5y+ypLNuJg8chQUUy/uekfhF37mpcl+Q9nNcq4wdjVAHRMbDffTVHF1QD
         AbeEYA1SxcPjg51XlW64v/5XPRPujDi6mtgxmNa1WghBGVbC+6dyifU/dA5al8PeOMJt
         xOEA==
X-Forwarded-Encrypted: i=1; AL+hErG5vvKt0NQyesA3F3eqM3H7pfgVpj8YCke4/N9QgAsjbw7kflXUEnz/UIlwpUpHKTzWa3/bNASs3i4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gJGP9q5Pv3aP2NLXmM43lRi3+6NLqrEIbdlKVvZ1UzQcSWAPC
	71uTCYCBXnS76XAZfaPueFV9Jey2+JacEKf9jjQng4kLbtZBF4sUDd/o
X-Gm-Gg: AZFdTZcBIaOQIYZ+XoLKra0178HivkCXeGmecm7so+ZMjXn2NCI5pgrAtfwr2vODvbT
	Zd+V7AFwzv7YQDgtuvqgtq/slxK+v/rK5My1LdTJlfLRJR4/PB6zCrDhjz58AJAL9h2rmsx8jPA
	OWH4THOgYVZfmiXaATsiJfm7YCkTPaW8hYIy5jCnSUKYvezu+asmzKn51+qeVcKJZ56UOOLhd+n
	URVzCQNLKm0ohLiHNXsSSUsqvglKOl+esUkFZlpK8VR2OfK1SeWofRizyZ90yV2yk6UdMu2KmuC
	N2dm8ctfXhi2lUZ+d6krAAJ61CaWQuUm47A/jdWSVNJO/vswObeyuzFBH4pbySMyOEk6Vn3Wt8G
	n+xzAt1T3xpy95dowE7SN9Hxya+jJlPDMngFnFa9pUb8ye6rT2/f89WcdMfGzpMznfHY51kKSFP
	qgEQueUfab3WliXOV6ELLfzc08h/bwLh2hVcdav1t4fzN/KKOdybfFLxbl3twT2Vas0ENruFLvU
	UAZzwnCRBf368bqeTn+db+kQpdIynYmrVn56zlC9FNS8Z342bc7GNm18QPhmwmtePv3Ou5fgsH0
	DTyvQBjgQ5F3Lu6DcKPO
X-Received: by 2002:a05:7023:a41:b0:1b2:67f9:43cb with SMTP id a92af1059eb24-1b5525e786cmr25527192c88.17.1795806130946;
        Fri, 27 Nov 2026 11:02:10 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm58116574c88.1.2026.11.27.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:02:10 -0800 (PST)
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
Subject: [PATCH v2] docs: Name the memory hotplug online type configs that exist
Date: Fri, 27 Nov 2026 19:02:07 +0000
Message-ID: <20261127190207.245175-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125193039.2437025-1-takano32@gmail.com>
References: <20261125193039.2437025-1-takano32@gmail.com>
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

The default online type is a Kconfig choice, so the symbols it defines are
CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE, _ONLINE_AUTO, _ONLINE_KERNEL and
_ONLINE_MOVABLE.  There is no CONFIG_MHP_DEFAULT_ONLINE_TYPE symbol, but
five files name one.

Where a file lists the config, name the family with a trailing _*.  Where
it names a choice value, spell the whole symbol out: early-boot.rst gave
the zone choices as _NORMAL and _MOVABLE, which are not suffixes.

Verification: a build of the tree defines
CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE and no bare
CONFIG_MHP_DEFAULT_ONLINE_TYPE in include/generated/autoconf.h, and grep
finds no reference to the bare symbol under Documentation/ afterwards.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: Spell the full config names in early-boot.rst.  David Hildenbrand pointed
    out that CONFIG_MHP_DEFAULT_ONLINE_TYPE_* with _ONLINE_KERNEL appended
    does not parse.  The other four files keep the _* form because they list
    the config, not one of its values.

    Written with Hermes Agent, an LLM assistant; the author reviewed the
    wording and the diff.

 Documentation/admin-guide/kernel-parameters.txt      |  2 +-
 Documentation/admin-guide/mm/memory-hotplug.rst      |  2 +-
 Documentation/driver-api/cxl/linux/early-boot.rst    | 12 +++++++-----
 .../driver-api/cxl/linux/memory-hotplug.rst          |  2 +-
 Documentation/driver-api/cxl/linux/overview.rst      |  2 +-
 5 files changed, 11 insertions(+), 9 deletions(-)

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
index 414481f33819..c3a3def3b3c6 100644
--- a/Documentation/driver-api/cxl/linux/early-boot.rst
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -34,7 +34,7 @@ which dictate how memory will be managed by Linux during early boot.
   * Linux Build config option that dictates whether the kernel supports
     Specific Purpose memory.
 
-* CONFIG_MHP_DEFAULT_ONLINE_TYPE
+* CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
 
   * Linux Build config that dictates whether and how Specific Purpose memory
     converted to a dax device should be managed (left as DAX or onlined as
@@ -58,10 +58,12 @@ SystemRAM.  This will expose the memory to the kernel page allocator in
 :code:`ZONE_NORMAL`, making it available for use for most allocations (including
 :code:`struct page` and page tables).
 
-If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
-dictates whether the memory is onlined by default (:code:`_OFFLINE` or
-:code:`_ONLINE_*`), and if online which zone to online this memory to by default
-(:code:`_NORMAL` or :code:`_MOVABLE`).
+If `Specific Purpose` is set and supported,
+:code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE` leaves the memory offline,
+:code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL` onlines it by default to
+:code:`ZONE_NORMAL`, and
+:code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE` onlines it by default to
+:code:`ZONE_MOVABLE`.
 
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

