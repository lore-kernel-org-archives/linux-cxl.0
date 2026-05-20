Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CF3EB801
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286786; cv=none; b=D20j2S8GJsqimllIOu6eUuQEeko85KZPhiaq9EvZbaTqa2kj91LiutzEFQRD32MdENl5wAm2fyThW04bAZkb2MUPXxFgoH1WJVbaQ4EUU1shbsrDc5sSQ9MfXAPr9kE6eC+w9/owh8FZGaShT6Z6+T5EPzlyvmkKNSmzS4lc508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286786; c=relaxed/simple;
	bh=E8qCA+z/qV5hoUnYRrNya2UXrUIqsgAfkrpFLTGtC3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qp/Ie8l9li1gNlaGSYmzOKRq4e04pB5mb4+boAALy0bhPXRaIKvRNmf/jOdRcxvaJVrHPOrgkvCRmEVLZN4opYufRWe1v06pNJd8i3WvBdRC2wGdGUqbiIss1o6Q3d7iGKHBC12VdtVsXb0VUvzrqmi2Ru2AOUjKEK0ldnqv2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvD+eb7U; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvD+eb7U"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7e23defbso2757890f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286778; x=1779891578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tScwC89ZMYx6xxDF7a6yXv/8PjnbatWqzNxyKuDAOW4=;
        b=rvD+eb7UkPZ31WCh88zsju7tiz1UVAcVmKjMddBuM8qJ1UxRMtpdBmhCH5qFAebUEw
         Lr4bDHPGI+qgTrh6vDXXMDic2BEnads2PN1/wi8NtAdBEH2u6UfSXgWjEYf+nwlPKw3w
         Jwf5SrEnQSHjQKRBSarbKkGawFf44s2yKwQLn5qUx991MSesFECVe1Ck95e26kFH5Q6k
         perK6mTMloGSI4AajtKTH/zQXI0+/paGOfoXYvIUZZx6LFv67RFhIm9NIvaDp3bN8iuH
         01+yV3bzI07zi8lmotaw8zs5bLd3jm4CmF0zfKGrYyLEzyfT1G+iPZJyAdO2NDwPd847
         03DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286778; x=1779891578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tScwC89ZMYx6xxDF7a6yXv/8PjnbatWqzNxyKuDAOW4=;
        b=VclvvvQyyiqtG4m0GawgKuSe4k7pzemveTtx3Y5/+mzOQKU05yCpI9UnepIgr2LO0M
         wA4lxvuhldMmM7FrxWsP/U99v1O3VrKD1nDyH725MTw6FtIt7VxQzE5QwZ9ZbUm4HHXo
         CB63d6D7ucmBCi+HNN/7KfixIOb5PoJuj/uSlKmMBh1ElXHiOJrw3TS5zP+CCBARCVO0
         wKAPvPBCUuwbj6j3EkkMa76vWyn0yvBd3U76B0dajgA5ZMmWqPoJaVTstLHVaNd4wvDZ
         hjcvw3xykiSra8zOHs2tf7xtSIbiYCcDJ8OujJvxaarii1tNTvHTolAWcEJ3prM0Fmhf
         8LxA==
X-Gm-Message-State: AOJu0YywkU5x/tQfKONdN7J0p+vRYlIBE3hBQbUJ85tsESuN6Akx+udu
	lJmEn/JLUD0A/oetGqvNu9cMUcixr71v1H0ODauLE/NBGXZMtjvQV2dmaGwAuA==
X-Gm-Gg: Acq92OGP8u40HSdXWTJQb8GMECggDx1DThYt+DTCeRCEtQqtKYISPjG/HBgPTvq5A2W
	reDOPsVQC2OsQta6PyY65UAhta/FUFTe7jJVI/ElZM0LUl32LFXP7PqER3S1/lk4KvWnySJnwgZ
	DoNuWeeo1rGVI4vDaa+NAiGWQVfODNgijUFnmElHHYao8tvPHaElbJTBBDLyfmdI1SAxNoDRjbs
	w/aOVoLiImSJtakbPbg2zzqwJ7va5mJIeSjalw1uSlZZGEpw3ZDsxk568xYOcrTrXkQdZqS3gxB
	XFEa8HH8M3vaC50W4ujz0eKpxVu0yYdq3CpQ3Xx0nxOiS/ZrNRIGxBVc73U8mYLx7liDFc14SWB
	bKnZ4wXuh69iKMIkIu8ie+QECTRpPRHdO8/5CVrZ0OByXThj34U9RZXE8/l5tHvd12PbX/2JHWj
	mCzL6nrDo65rjRO9tO7pZHufmSUXCDM0uooF6KCt8fieSUqTSHxwe4Fx6quEmRQ5QPjKKDrbv1
X-Received: by 2002:a5d:5d12:0:b0:45e:8547:f214 with SMTP id ffacd0b85a97d-45e8547f294mr17297252f8f.32.1779286777707;
        Wed, 20 May 2026 07:19:37 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm55387740f8f.32.2026.05.20.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:19:37 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: jic23@kernel.org,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU PATCH 0/2] cxl: fixes for hot-removal of devices
Date: Wed, 20 May 2026 15:16:46 +0100
Message-ID: <20260520141816.3240010-2-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As requested from the discussion in:
https://lore.kernel.org/linux-cxl/20260429135717.3048713-1-joshualant@gmail.com/T/#t

Two bugs have been found when testing cxl topologies for managed
hot-remove of a device:

Patch 1 properly unmaps the backend memory device, allowing it to be
remapped if the removed device is re-added.

Patch 2 sets the power controller present capability in the downstream
port. This is required to notify the device from the guest of removal.

Modifications from linked RFC (patches 3 & 4):

- Originally patch 3 (1 here) unmaps only on exit. It should also unmap in the
error goto in the realize function.
- "Fixes:" tags added to commit messages.

Joshua Lant (2):
  cxl-type3: Properly unmap the memory-backend on device exit
  cxl_downstream: enable power controller present capability.

 hw/mem/cxl_type3.c             | 6 ++++++
 hw/pci-bridge/cxl_downstream.c | 2 ++
 2 files changed, 8 insertions(+)

-- 
2.47.3

