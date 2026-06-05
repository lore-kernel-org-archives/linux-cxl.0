Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172E371D13
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669250; cv=none; b=BpIru6NUup+QfgcopdetSdZX9TVJI9QSATylTtHJuXTCRz6r2Y9rPsNIZgPAYKnj14V+0RpeYd6tJlFWtSs7aMVrHBx2my1fYrR+7q0imtgMoE9NNVjV0nrsk8cW1opeLhlPdpkPnSrm7/Lrf8L9Rxg7vTEsoPsJWFdiD9jJqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669250; c=relaxed/simple;
	bh=9oH/HRs/iHPQKjS0tgdCFKqJzLB5akwprs/lFcBOFnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8tmJyEyMudUY32riG0KONdZ5S3SWp9wl4NjVtBCfZFOuFk5A6k80gc056RsLCwb4VERajhcIFbdaDNbKeshpMLgIwnt/RsBRLzJ0zSAI0/bciTB6Eoq4cu8U3xlq8UMIik7zPp6izfhG6xQ21vPKYvyPukhjdG10+ok0TpL24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=L5p0htBP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="L5p0htBP"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51764768c36so28217241cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780669242; x=1781274042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPjdk3b2K3WtKWTm7ufD+t998Fv/FHcBypVVcRg8Qhs=;
        b=L5p0htBPdoM7RVXWAU1ChmkzbM++WJpGhVTa9+zxcmDLP2c63bnmTBoOGUKCP3T1hV
         KtH0VYAz7Bju7v2kOUWkzpMVfNs7cX+tPBKZDachqAdNasWdRw+XdqnDTVvSqMGi0Ni3
         MRTNEKcF6LjXGvemx9HNm34z/BZVr42yCfNtTu9WCeV9Nfdtzdp19545d70ImqmlxC+w
         Vf7Nvjk/0DO8SpBKNJ/tbyJ0M6tZFvtmmPr4EbxF5F/oyKBrlTKQgo26dEldODad8ZOl
         Bo0v4SFm0tewSAD7a55g/pMjDYI8qye0biNtz86DcUbr96gzo/0mT5XKkUYhe6lUalvd
         9MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669242; x=1781274042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPjdk3b2K3WtKWTm7ufD+t998Fv/FHcBypVVcRg8Qhs=;
        b=MP0bor14tCfU09yL5QJYM1GDPKTbvffuf5zdlhRPdr2xQCv61+8A/GJlQQQBoZCv/4
         dz9N+eNV6cTlE+zQWr8WFpINA2+FiJRjHtM/H1pEWfM/ZQ5B9XfeuYy35bBtsWYLGvRJ
         BEzbc46SmYHBsC2Tl4kvAu5IY5pD3PLvePTE63TVEgdKDbBHf1PIOQIb8ELbtpIvmhFK
         vjKRZPP4RpNgaqHi9A8UYT6WjgCTs1ARaUanth+w1O/kCUzGYJXTlk2Tn2s3i+2aEYx5
         3CkV9yOFWDXyGTapBQc3GqEcC2On55aAcX34aCiu/HoRr4VE9QuO34xMqXCr+UtuPSek
         r34A==
X-Forwarded-Encrypted: i=1; AFNElJ+UH02Lv372F2G1lG6AihqUdejCREYxtGpIg/nP0BHEJ3gLqIVVWlNSqDo/352mhcf6wUZ4rHNbyGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3JMBzGt380ZBMEHx+TkHWxTahWaGO4O+XNdt+P5JEHg0Po/3
	ljFJSlZ3OVSDJQLrTsbXoBYC/VlF+CbDXki4e92JdbVpxK175AFOpZi0r14XyubFgME=
X-Gm-Gg: Acq92OEHLucdJI8O2IqE2XzhJryumGmxwIO3DZjVj0w9HaSs1pWviF41uGivoTv5Bc5
	LQnGniYTP8JV/QTyS2CbD2xBbTefmvgMBDfAhgrXSRaGSrjR/AeejxAm+3+mggKozZHVd5Ay4PH
	mKvPCVcphZsA610bZHL2yteHNqyHKieS2eTrcLmeUGdvs7yNMryI5Ovjw0l/+SZpilwc5szBI5c
	I9QLsZIqqbDI1IYGDXgI8Kmt3Nv8IVvmwyCO/gF2gt1kIfgtJt2TY8DA/6OWw7eXHokDyg5awdu
	GQVLw5zMz9yKyv+sqiZSk78+Dt83pGYpMA2QMO9Q/SZFYZn944bSddk1NVVEkP++n03ThyQRc8l
	daniPGKuPi9enqmjHvn7EilCIm3E9HpSQQFMEMSG6OiI7VWcsKVso7cZYGHE24auMhFzz9ssb0d
	7jdtMPj/nqQ2Sx2NKIHjeYz85cpPPFkXiG8tse9Q==
X-Received: by 2002:ac8:57d6:0:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-51795c54424mr55445251cf.37.1780669242085;
        Fri, 05 Jun 2026 07:20:42 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51775dffb14sm81792301cf.28.2026.06.05.07.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 07:20:41 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Alejandro Lucero <alucerop@amd.com>,
	linux-cxl@vger.kernel.org (open list:COMPUTE EXPRESS LINK (CXL)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cxl/test: reject wrapped GET_LOG offsets
Date: Fri,  5 Jun 2026 14:20:31 +0000
Message-ID: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL mock mailbox GET_LOG handler validates the requested CEL slice
with `offset + length > sizeof(mock_cel)`.  Both fields come from the
userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
offset near U32_MAX can wrap the addition to a small value and pass the
bounds check.

The wrapped request then uses the original large offset as the source
address for memcpy(), reading far outside the mock CEL array.

Validate the offset first and compare the length against the remaining
CEL size so the check cannot wrap.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 tools/testing/cxl/test/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 271c7ad8cc32..5dc9601a2a7e 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -584,7 +584,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
 		return -EINVAL;
 	if (length > cxl_mbox->payload_size)
 		return -EINVAL;
-	if (offset + length > sizeof(mock_cel))
+	if (offset > sizeof(mock_cel) || length > sizeof(mock_cel) - offset)
 		return -EINVAL;
 	if (!uuid_equal(&gl->uuid, &uuid))
 		return -EINVAL;
-- 
2.43.0

