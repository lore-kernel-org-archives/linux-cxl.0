Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B552309B0;
	Thu, 14 Aug 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197019; cv=none; b=lQJQSrufunRGRcaSYjL9r8g17INRayg4Tqll999KpboaI5XG8ZuTzJ6z92NCDrpJN1QH7jy8w70sGCLZ2GQpdtWJgLU/nGQwD5+4rjtUQvJ6IEue1f1A7Ux8LmJ3IFskAPkmQm3RUU8o6Jzp8vIrPfPop792+cGNknb0Ctzvj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197019; c=relaxed/simple;
	bh=HzhGSOEbP93yW11E2dVFWSxpffOEMSlBt4hcNy8rzUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7HTjDQOCS58z9OcQ8U1qLBeo1C2q5n0UGtTane4pfpjFzDu1GbVFd+DoOf2MfZb+gNnsJAMMjJhu9EywZm8v8T9KgHEXnR0fw0QvryOAXlJI8Z3G5sdtKwuTreTXVhfn0zAf4THO9zIiuS+4VXG749kYKdq9UzCEiDJ1E1bUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bru4Rdi2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bru4Rdi2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e7c3b1so77313a91.3;
        Thu, 14 Aug 2025 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197017; x=1755801817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH+OLX4PVYHaF7paZnuikm/Sd4CSwuIUJmjMyFBnjJY=;
        b=Bru4Rdi2wJnM+hLE80bQPnhQGiwCmQ0QXq9ux0KtQ/K/QZ65kqHdxiMOj2PkkIv72J
         pP8gKDj/M5nyMztzgTRfo2TMMLT4PgEgubIRbIU/z7M8oqOzjX0OMb5b53TUu8EKfA/q
         YasPVbSuvmgZWcwntfCc5rLyudAwHdyhwMHINf/eRm+Mc2qSjzbzwMFa7aYUiiwdKywe
         c+0eCxOLuRPK6k3txgYpzNEtOdaJWg3CBl0vQrXEjZ5fHINvCrS6AjCn+3g8rD2wa1KA
         lO26ZzgWoy2D2CzBUZaeKpV/0hzXIsjtI5IBZVKLSZ8q4Qu6dao/+pNGFQS8cekTNGjH
         KCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197017; x=1755801817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH+OLX4PVYHaF7paZnuikm/Sd4CSwuIUJmjMyFBnjJY=;
        b=jAfvG3yInEQ7tElLLB6dx1OY5Q+wvr+V5M3MUMyeTRGG3GhQ5517y3XIFvfI5al21s
         azjcadaOsH9gu40eqNDYSkCaslmG+ZVVrpd9y6taZ5r5zOv4v13NhPVhglj5iZaw2IiB
         0awlaBthvtdi8FWSBKVYhM+q9zKncCCCSTgn6n05LfIrl8ytK1grif73CrgPU8fQhO6l
         e+xorhoSTzQJg+dNgqGevYb01edKJdQuaRY/zgpWU1J4W2hqQP2Or6lhlK29m1bvd/Zr
         sqNdeT+GZgbMauzJIirg9uJRyIOLhcM2cdSFjdMP7Vd334MKsMbyEbzfFlqJjKJVOQHS
         kqsA==
X-Forwarded-Encrypted: i=1; AJvYcCU65ozkrhV3E84woP8APIHAUeRilkUOSj3lqDjgY6bixVsXUNFH1bZGZLxW2USudCeP9m/6jP8gWgHzK6bXLdRlh8E=@vger.kernel.org, AJvYcCUqUOfovKCyUqBgpAmsAXCgptZu+KA1yEDDd+uD9PXbWeaC0+Q7bvJt/1xwOubfj8jDU+iwQtdAbJQ=@vger.kernel.org, AJvYcCXPokvk3BfpGeuQxWzwBCgzdhm4jghieXD5CCM29dRqS8gvwR8ohIankUp4xeb+MpNdv2ekbvQ7YugYuQ8ef/3CaeSIYCk=@vger.kernel.org, AJvYcCXQiurg3JRMGo0kv7U/kylpiTZ7dx2IHC608pP4nG0VyUR9rBrUavPiaz4PQkIRCXQappNcfuZU7dOkUZZN@vger.kernel.org, AJvYcCXlWIRXw/tlAuiezwa791vyuy1hW7R8DAeVbWbs+dgKL8kofwL71QOY0Zm8YTTH9ow5pHQbQynZ7Bk6@vger.kernel.org
X-Gm-Message-State: AOJu0YxXi/JK40boNgCdGVJMJMfeXJnpy7kQ70wu13wN3CDxUfB5Wiqq
	qOL1SiH14+ld+QiD3lWglX35uDZjxRV02VW8w/VAPTc3zuO10wutMIjH
X-Gm-Gg: ASbGncvrhtgtz81HTkd8NFDPxjgV1cXPcCMJECv1cPcaTvy0EyhFUvRodbaFVZSS6E9
	hoBEFH0pjJ0P598pzJ4hw2l6/Dr11nCSzbZJjy7cApfFfGTMzJ3+KuGxTPuatIq+059DclTo0hT
	TkxK/YKkvsAhniQzBVw3PoVD0J2XzNn1QFqv8BOTT+Vk9/dl4IeiaLy6jZzQzCARpCehH0Fdwx2
	G3d+UQwiHaSf5TE6zTWEalyMcEo1f1ywIBj8eW53rfajnwFVlsQ4FlRY/cybInDGP1CjKZk7j1T
	t6EmqcOE0vNdYGI7aAEAdOFqaVdr2frtlQHGtuBTwDYjc9MaOOCkDP2tnmEm7rk7kU0riIwKr9i
	x8pLpKtRBM/R2KlJo/k5DkO2IlDuk8w==
X-Google-Smtp-Source: AGHT+IHpyIE58Xouwhj6yBGTLqqaBArMNrYcPZiFgWmogKeWrtCsF1xc0DbS3TA1SKqjyLzK1ppp+w==
X-Received: by 2002:a17:90b:33c4:b0:31f:141:448c with SMTP id 98e67ed59e1d1-32327b45d14mr2843144a91.3.1755197016744;
        Thu, 14 Aug 2025 11:43:36 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:2b0c:a05e:ba31:bd42:d797])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330fc5142sm2594991a91.8.2025.08.14.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:43:36 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: alison.schofield@intel.com
Cc: alim.akhtar@samsung.com,
	corbet@lwn.net,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	vishal.l.verma@intel.com,
	vnranganath.20@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] Documentation: Fix driver-api typos
Date: Fri, 15 Aug 2025 00:13:03 +0530
Message-ID: <20250814184304.20448-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aJ4KEKHn351vQXe_@aschofie-mobl2.lan>
References: <aJ4KEKHn351vQXe_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a few spelling mistakes

v2:
* corrected as per suggestions.
* improved the phrasing.

functionalty ==> functionality
in Documentation/driver-api/cxl/devices/device-types.rst

adjascent ==> adjacent
in Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst

succeessful ==> successful
in Documentation/driver-api/thermal/exynos_thermal_emulation.rst

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 .../driver-api/cxl/devices/device-types.rst        |  2 +-
 .../example-configurations/one-dev-per-hb.rst      |  2 +-
 .../thermal/exynos_thermal_emulation.rst           | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
index 923f5d89bc04..7f69dfa4509b 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
 Typically used for initialization, configuration, and I/O access for anything
 other than memory (CXL.mem) or cache (CXL.cache) operations.
 
-The Linux CXL driver exposes access to .io functionalty via the various sysfs
+The Linux CXL driver exposes access to .io functionality via the various sysfs
 interfaces and /dev/cxl/ devices (which exposes direct access to device
 mailboxes).
 
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
index aebda0eb3e17..a4c3fb51ea7d 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
@@ -10,7 +10,7 @@ has a single CXL memory expander with a 4GB of memory.
 Things to note:
 
 * Cross-Bridge interleave is not being used.
-* The expanders are in two separate but adjascent memory regions.
+* The expanders are in two separate but adjacent memory regions.
 * This CEDT/SRAT describes one node per device
 * The expanders have the same performance and will be in the same memory tier.
 
diff --git a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
index c21d10838bc5..c679502f01c7 100644
--- a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
+++ b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
@@ -28,13 +28,13 @@ changed into it.
 delay of changing temperature. However, this node only uses same delay
 of real sensing time, 938us.)
 
-Exynos emulation mode requires synchronous of value changing and
-enabling. It means when you want to update the any value of delay or
-next temperature, then you have to enable emulation mode at the same
-time. (Or you have to keep the mode enabling.) If you don't, it fails to
-change the value to updated one and just use last succeessful value
-repeatedly. That's why this node gives users the right to change
-termerpature only. Just one interface makes it more simply to use.
+Exynos emulation mode requires that value changes and enabling are performed
+synchronously. This means that when you want to update any value, such as the
+delay or the next temperature, you must enable emulation mode at the same
+time (or keep the mode enabled). If you do not, the value will fail to update
+and the last successful value will continue to be used. For this reason,
+this node only allows users to change the temperature. Providing a single
+interface makes it simpler to use.
 
 Disabling emulation mode only requires writing value 0 to sysfs node.
 
-- 
2.43.0

