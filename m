Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F21CC150
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777013; cv=none; b=jg9FihpYoHa5/Dn0p4kRVZqBwtRdcxDiSdhKWCO/y+hKD5PBd1DXdbqiE7102IzbftoFVT2BvuMw1LBlRSgxaV4F4CZHlKiMfCxOlw2x0WhyEukp+FmaUQK4m264AuiZEPIdQ9Uw/Hfpb+uTAKGN8NO+pwIQZxhirJXqesRPlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777013; c=relaxed/simple;
	bh=efV0KgS4fjPQoaPy+I5UejTcEYBAVE12EEodxk+/oBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKy3kiZkyGdzF+s+sHe4EEjBeTPM1JEEyjNFgw6sMdiwo9Aws1jgFX1PugloWFrktCoi400SBXydrlTZ7Ws0WOx0vuwWWQhxPoDXLdoL74TGXpNN68aSyPRfsXVBhbC2/NxE+/bmOTE3v9j2AvNlsyB8YO4EppZctbXAlcXPi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIUgmrSi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIUgmrSi"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6c0ac97232bso47554107b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724777010; x=1725381810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kxqi/l8fPRJoKAG073gIxokKIwiWiOGzRM8T33WeNR0=;
        b=jIUgmrSiPGVokKINLML4O2MXpbBCYf+GF0z4fHXxDGzoV5tbpbYOKmkOTo0vbbeeBt
         WsfSEKpF2wC6Vg3Y1TL9SD6UasZL9ujy0saONAyEatDhHxoAmpsp59rDBxDH3e56dxCo
         0o3KZxSm9saExKtbksTFjJi3hVqh62HMFItMu1vxCbc9MJqaxqnymyS5hcmr5PbzpjAx
         U6Dr/6F9BKInpecjMQOIpNqi6ZtOzc+DjMobvI0GXh5kGjJDSKaySNbz6n7be2ZYWLpU
         ElUZRT8oWjI7DuyNM1nRpauOEsnUbGl9qKao6xMzk/+bTQ0MFK8T0P11tZq4hLzT+4/c
         ZUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777010; x=1725381810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxqi/l8fPRJoKAG073gIxokKIwiWiOGzRM8T33WeNR0=;
        b=fBliiBNV7ZSbMpBe0eDW41tecTRfY2u2UyZSN/KBLmT55lR+Kek41qPon/INwrooVm
         qMnSDMVcZQBepoic+3ZD61pawiiRM93MrSLi569CMgO9xJBTOY4b4KxqfTTU/p+8N/AL
         YOMAQvbtiVM3pQGkbavFc5jq+dvT889598RuqSrqk1YKySwjTXJuL5Zv5tOsHSeFgxv2
         K/JIuPSEWmwtxfXOYT9/4YeS4+EXmCwxpgEkfVKfuFnQFx433QAoxCxeTfTPKtZcRxeI
         ePRVYTGw7slzV7bTkLRje6ldTTQZf8lPoRQabU/rELZWrWrZGj2uWUvRkDZ5fxwjWR2h
         wmgw==
X-Forwarded-Encrypted: i=1; AJvYcCUEmqhLfi4CfpLfr/W2uhiIpvaiWyiU9RNPhF4ZMGCs60RnY8o+hGS6jGJiHNNEmbNpds8KfLaA4b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblIf5zmCpa4A/9cqPlVlE9YJitsvC4bS5KL1+nd9E2MPSBaTb
	U2WF+tPkBTSut+GMFHUk+GvG7zDxwu0R/ePPtpvsmt0hY5uUqSb2
X-Google-Smtp-Source: AGHT+IFrBZvOTLy+1smD6rrcRDOnoxH91v5RK+fw5BtrUMc4IcPi7J75Z8NviyEaiWMDP6tH7FwXow==
X-Received: by 2002:a05:690c:6603:b0:6ac:f8ac:7296 with SMTP id 00721157ae682-6c6242297f7mr166529817b3.1.1724777010433;
        Tue, 27 Aug 2024 09:43:30 -0700 (PDT)
Received: from fan.. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753427sm19658677b3.53.2024.08.27.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:43:30 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 0/2] QEMU DCD emulation support fix
Date: Tue, 27 Aug 2024 09:40:03 -0700
Message-ID: <20240827164304.88876-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

In Ira's latest DCD kernel patchset[1], the More flag support has been
added. While testing it with mainstream Qemu, I identified two issues
with Qemu.

1. For a DC extent add request with more than one extents, the More flag
for the last one is not correctly set.
2. The function cxl_event_insert should only return true for the last event
record in a sequence grouped via More flag so interrupt will only be
triggered once for the sequence not every record.

After the fix of the first issue, the More flag works as expected.
While the test can pass without the second patch which fixes the second issue,
but I think we make sense to notify the OS only when all the records
are put in the event log.

[1] Last DCD kernel patchset: https://lore.kernel.org/linux-cxl/20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com/T/#t

Fan Ni (2):
  hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event
    records
  hw/cxl/cxl_event: Fix interrupt triggering for dynamic capacity events
    grouped via More flag

 hw/cxl/cxl-events.c         | 8 ++++++++
 hw/mem/cxl_type3.c          | 2 +-
 include/hw/cxl/cxl_events.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.43.0

