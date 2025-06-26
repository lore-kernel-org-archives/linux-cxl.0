Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBE2248B3
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981868; cv=none; b=W2hMPAd4nDMWFET3Ws4A/AthQoKb3fJt8Cu1e+VEvB1IT7eyZ4nH8IYpwZpbYWBL+Sap8e5uWDUz4dymnd0FId3QccmXAHMajwPT32NZY2XljfQfW2W2F3+OUbVhSbv25xlyDGTj+gNjJpqYmvl3DP/nLARSmudAcS68xlvq900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981868; c=relaxed/simple;
	bh=ebEhPTT+Av6NYkUHFPSfgYacMrz+6nlpF/erKiQlz5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4XVoxFT2ATpKdII1dr5g+fnAzKkKyINAJ0dioioVsW2kq6a2n1wpHM2SPgqv7KBIHti/kGPl2GV14+/HQXGFyR07pMjTReItwFqDUPrcw4VXd9/bjqUbCOxBxOEhGxlYcj3rHoyo7rP2LEX3sNXR195w0jYuHsCbej4SGXLd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7GjWgc1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7GjWgc1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23636167afeso18038345ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750981866; x=1751586666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9A4F/pysQIdrEzx82t2iSqmNp8R/qNKmwZe+pGGDwU=;
        b=T7GjWgc1e8rj7AYF9akNDEfsLbrE/klaG3oljHwscexahd3tHSTVxrsyTCDFAUVGff
         LtoLKoVGH3bs16Dj+Qfhdccvpc64bgxyqN0zi1CNZTTyV5seyfaUvMZfhU0r/4nX9QwD
         wsXFyzJnmk9tHEiHShQ3yWV2cXjiaWohMefeZ+eBe/1iJAdbP+ZVcAUZpcVfiSMavBdM
         TMROU6SvB5IK86ZxruMkqsjsiFRbtzy/nGZt9blWBOOsLU16L+9vNGu7sVVDciXs34+2
         1A8r8zn+t6xfkUc4kWvNeJXZv4ffmTgCpUyvD+LMT/tUwDhKApjV1GuofCW4uK4USSAP
         TVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750981866; x=1751586666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9A4F/pysQIdrEzx82t2iSqmNp8R/qNKmwZe+pGGDwU=;
        b=lubtcg850rwv2oMsawqi2FUza0t4yhgKEDCHYNI/O5eX0c4MIO9B/T6YALMMFONIdg
         J8Uk/xEUsqwEQxgTsfPhENFDcmcmjukVIh+tnYYlZTe97pKRrh8zXxdZqjnFk7aHhhfK
         cFNS6/pqA5bkc2ky9kUbt7Ij3oBm6GYEg6YywhHvV2yvAfaPVs46tY7vAC82cjKiOHxd
         MYc8T0TjXoFXexjCz1psxJBSuMCy8l1pwy9RVfM8+Vj9aHuawXz3zBhlEOYEA9ZfxKrm
         qlYjRpGHNUPQ9R6Ukrz1fRxqYEdYf1rGNgg90yvSncMIZM63WkkuOf/1xddWQqSGvHI/
         YF7g==
X-Forwarded-Encrypted: i=1; AJvYcCUWevANK3l11T9wypyi2Rmm2zdDomwZGkfKBxHaTbTeniskAphfHNVADYWMxTxkQOYNAowQvecal3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdSy2YpnxondryD8d514rGQnhhZd6DMHtt0SD+vtEV/AcO0gD
	Ffz2LTaCHXh77VEQmcuMlsW043gSXADqVtDPAylYf8fYwTUcS9yEN5f4
X-Gm-Gg: ASbGnctgptT2ukYW/LtBkRSkCBiCPyHsjQdF+59VzOZ+K7IIJxA5NTofQ2ifZRAhRto
	sysZJkIhIsooRXlOs24IbWHv+zOk7LNnO3W7sMn7p2SjzVkTgZk1a5F0xFOdoW66qufS/Ec8gz0
	A+gc2+WonmE+vGCsPCaL1mTrEpcTwehVHrDV/qrVoK66FLpaTMBISLkpI22V2rZgTwcgOcIkqDl
	RUVg3LV7jJSzXRNfs9gZN/7/yji9VX2L2nR3SE91X3YOmsLeJlrIFt1S62xl7rb/Sjs2E1C5eGL
	wfDl5iyceErbZG4ONZzTXDVcXoPexab1H+8OzhZoVJXNyER1nZHoxrFzYNzOnfVlVyx8anFpQdu
	UUA1QXGI=
X-Google-Smtp-Source: AGHT+IGG7MtzH54Hxom0e6Qb6sVQmCrOFC7DVeNVIOWZYUX9CuGQ7/yKVByZCMNvJeOhkIeEJND28g==
X-Received: by 2002:a17:903:2c5:b0:234:bca7:2920 with SMTP id d9443c01a7336-23ac45e262dmr22084745ad.24.1750981866158;
        Thu, 26 Jun 2025 16:51:06 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1845sm2081055ad.70.2025.06.26.16.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:51:05 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [HACK QEMU PATCH v1 0/1] CXL MCTP FMAPI Binding Fix for MCTP over i2c/USB
Date: Thu, 26 Jun 2025 23:41:14 +0000
Message-ID: <20250626235102.1902427-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

The FMAPI DCD Management patchset (https://lore.kernel.org/linux-cxl/20250626222743.1766404-1-anisa.su887@gmail.com/T/#t)
is based on upstream, which does not include the i2c MCTP hack or the new MCTP
USB support carried in Jonathan's tree.

The commands are accessible upstream through a switch-cci. Thus, to break the
dependence on the MCTP support patches, the commands are sent separately
from this patch.

This patch is based on Jonathan's latest branch
(https://gitlab.com/jic23/qemu/-/tree/cxl-2025-06-10) and fixes the if condition in
i2c_mctp_cxl.c and dev-mctp.c to allow FMAPI DCD commands to be processed.

For more info, refer to previous thread from v2 of the FMAPI DCD patchset:
https://lore.kernel.org/linux-cxl/20250530152655.00007132@huawei.com/

Anisa Su (1):
  hw/cxl: Fix MCTP binding check

 hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
 hw/cxl/i2c_mctp_cxl.c        |  6 ++-
 hw/usb/dev-mctp.c            |  6 ++-
 include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 77 deletions(-)

-- 
2.47.2

