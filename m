Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11C2144DD
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054919; cv=none; b=Rl4X8fDQTinxBF/2bmKvZJI/uRtSKZ10Xr7582yuBWZUyBCTzLdDrEtqtzC/4/7J+yJcpA58x+Mqb/dNFceJTGhevgIJ4Xt+KqSFc7CGScIbMUtkMcGZXdlL7XqDCStzUUBdspOlEDiP2wJdHYKF8v/fsMuRKZUgaiCg8Ru0ZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054919; c=relaxed/simple;
	bh=1gkvdFh4jhIrw/MBMXml2s/AX8PO3PV1u4aAhoqRtV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx4Ur7cZxFFV2WlBVYC0o31vV4WTr1xLvenUq3HpKb8Eah4GU8zxYXKQ4b0U8UaE2B/mvjdRUelnZU2ytSfAmS9umfkM6Wx6M13J5DLfqaJMHOld1U+IiXYmixN/WOuQhJvKfM+fBUF9xbXffw1Czcy743tK/TdS0i9wB9vIatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UY324YwQ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UY324YwQ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5b2472969so36235985a.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746054914; x=1746659714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qevg+gR/jQXOKEn18MBQyQWDOgs+/lqx3wMxZN8WKs=;
        b=UY324YwQkpa5PE8XyPxuV929zu5EBhgSwBbl9DRzLcDutA0BgRJz5wSR84Fqmi1uR9
         uZ+ExucShUBpu+MfPfauehGPNnUxSAnr0KAo6m3Bse8LFJJZkpnij13ljZG2FbnsLcP8
         M7o9QKcQynqnws0eEUU+rDdz/qyhXaxBHIAGhZ6KrIYmUK8llHIHawO5sjJ4QUUN35pY
         BeEJv1FQLJ0wb5ggUT6/stMqzOqs8+Fpy/tzOIywQA7qbfwzjaFZWCdPtkVlEKWHjelL
         jxDSNK18CHs9aqu/OaYHp3mFxeoos08NsZoixGvJv0LkQjfv2CL8NXP87r1wstJ+l5ui
         MHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746054914; x=1746659714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qevg+gR/jQXOKEn18MBQyQWDOgs+/lqx3wMxZN8WKs=;
        b=fvje7M1Nhnw3C6PMsPxvQy1jHTNcvHprWUvplwgiQsO4CO2zHwTdYrxyNayXqjoMFw
         cgTQ1A3ijsWWQ7kojYOnhbCdFbHM213+hv0QfY8Krn1DRmHPNzKFtpsLMkaa0hUNjHBl
         G51bpRY9URWnW7Ib4D0hAqk/LZN9XSV9Okkl7wyRKF2dBOm4J452M2FTcsQ9zdoYZu47
         eIh4OANRaw7VgPG2W+D/evYOJXsT9MkPscW6sw9KIcbVEuhx8bqWIPNKa9z3m4KSxV4o
         R4lsM9eYHAEDk5WWx+wOBCAzFqFcQCj91i3nlu+ZBC5+MAhBDYjOMGERZyJcqxXYOwhF
         fK9A==
X-Gm-Message-State: AOJu0YzN61Qh4VIaB4xqMHTR8hAM/QLv6BEOW5jnvC/GwQJSA4jmqs9p
	sDqNVR5VHvFCAV23Bmj+szu/aN9zDUYKiUW6RE5ENAsUoMEzUSLyjM9SNwwQvCowdfV1FyAWt2G
	i
X-Gm-Gg: ASbGncut5FhkFE/4pu5M5Fhtx8pwELVvkvaIicAuoil1exkAmbxl7Pm0O4f7p921yHy
	SGmOg9I6WFwlxuKHCHVyvCsQoxNW9EazORsczKStomgvTKqkBfLI1caOhJ+cVK4gW+buoBpcEru
	5K18BwExuE66ZbmEPxJtMvF/aPdJQcE5QxWNsejO9sccu9UpeYPFKupGUIHGvk8oJb3xXnRO2sj
	27wSDe1R+k01YgCMyE/Sn82KTV9cjugHnVIDZGsLb9bgWetNn+o2EjAMsYH8Yj86H2qlIyji+FN
	EB2nHKotP7jQVLhvBMOfgKjyIWY0PXVzw4JrOyg/X+fn4+HWaszBkvmrm3bOqKEvwHp1HHgiLlP
	rD8onNPeUr+goEsKTKzs2lzfttLWj
X-Google-Smtp-Source: AGHT+IGav1geRgSf7A2vLf5AOwcdw9lUMaP9D7RnYvq+QFvpuCaWOqmOKlfgU51P0IinAgHBqb/HUg==
X-Received: by 2002:a05:620a:6183:b0:7c5:5596:8457 with SMTP id af79cd13be357-7cac76d7ab2mr754502485a.57.1746054914481;
        Wed, 30 Apr 2025 16:15:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cacde764c3sm19538485a.33.2025.04.30.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 16:15:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [PATCH FIXUP] cxl: docs - fixup cedt.rst reference in access-coordinates
Date: Wed, 30 Apr 2025 19:15:09 -0400
Message-ID: <20250430231509.1298122-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181048.1197475-1-gourry@gourry.net>
References: <20250430181048.1197475-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove additional acpi/ in path to cedt.rst.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/linux/access-coordinates.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
index 24db5b41716a..77ba9be9af2d 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -25,7 +25,7 @@ asymmetry in properties does not happen and all paths to EPs are equal.
 There can be multiple switches under an RP. There can be multiple RPs under
 a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
 Window Structure (CFMWS) in the
-Documentation/driver-api/cxl/platform/acpi/acpi/cedt.rst.
+Documentation/driver-api/cxl/platform/acpi/cedt.rst.
 
 An example hierarchy:
 
-- 
2.49.0

