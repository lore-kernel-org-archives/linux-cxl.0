Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578482EEE77
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927439; cv=none; b=U9cqLmqMo2AVKYCkCljzYOweENnEj16YOtpizpKUSlhAVmF6sfqKHnTkn4VpqPQz66EIpnxjNg6C05Oq8xjm0L8ZhJMJLOVZlfggoAU6NRwZb8WnGzEHnz6Ra3jm2yCMzThPJ3c1OnYkaHg3Oe66rtI0kIhofD1S7zslDHmCZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927439; c=relaxed/simple;
	bh=kcWiFs0N3bzMN8uvGzUNB6qIGnAbVaWOUEodfqoSoPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k78T0K23SnAdm5dbnHFyXyI2SLaiWmskYlzs79m5q/8PPtMT+A+bgpbOu132Elitmf0wMBX81+zo3t1RX1k5RSH8fgOtcI5Gtrq9dPF2xBpoXJkoUBFbkdYQIgTf+1zxXMjvL1+l+6JI6jfJ5c4xOTC7T3yICWRKZNSPklYH0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2dExhh6; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2dExhh6"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-caf5fee4196so260353a12.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927438; x=1784532238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjU1tHH91CMx72VYa6DswxUTivHn+PJH2Yjz6MHUXUo=;
        b=E2dExhh6pCbOUS+lzn/KgnuyEjTzK8ghaprwMzfI8b/v+Rs8U+9iA0c8uxE7OAYTWb
         tes39BEby8pcuy16ZkqO8pgcaWF59VRXON4uxK5ZIM6jhxA2H76BgxZG7wT6JKfuWqJj
         7GaG16u+K6vL3Pdx/KkdUV2jyxXFJh7S8DQuGAyn+YzVwb1oy1X9AFtEWvp37KZvXiNB
         3QLOOb41GuMqAH7uBt5Vo005BkqGGrXjOPAo5SzGRkIazqRh/35k4jOwdmtYKsINKzJt
         djBBB3WWDBsTv5G9JofUbWqob8KCyDwB+SrWsR736XR6dIcDOHuC/oxFrbwDSvOKfDA/
         9xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927438; x=1784532238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjU1tHH91CMx72VYa6DswxUTivHn+PJH2Yjz6MHUXUo=;
        b=DsWgxKKn/HShbQj+ZxJlJh9tHjZIGhyASumMm7PqaaZDGB+eZfkovz+Z5U6U4ttuNZ
         sqZQLBnd4HUs+mIri3UgkD2ikWTc00yfYaKz0V+uF9W29fktqK2p+hvZLBm69DuHOLsI
         JfLCCoTTPpPimlX2k8TpbNysFYW7ErGz1u9wmlE2qA8tkb02NPJRcqU6db0VI60Mwyt+
         fuTOFcOuDSVzFId1mPsPL3/xeMu89x8UJuJdvGrTSZ6DHhcT2DkkItkGwM79IDGhpkw0
         5al/j//a1hIqI3G8eBOStb2phHebFa2GZb/SdWrnih9iltCQ9micm1N6r9ZeOUbV/qNY
         0SNg==
X-Forwarded-Encrypted: i=1; AHgh+RqN+2lfFo2ObdYplkM37TlfMO1Jnsobh1DFWLtWC6HIMbbICrplSAZzphPSwmZ4N+z4TXPfEKKTqv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU071oe4IDQsjIXr9nt8+5JcPKUkTxg7ATAipOyPbY1VCCjhkP
	q33E1PGxhlKQNfJ9M3AJA3BxweNiUH7xkr8iaJQXd/vEWs1735Px6NrQ
X-Gm-Gg: AfdE7clRQurZd5/TV+owYpXqt9E8y1qXf0wu9V0oXbw8hI+0T07ZRodph8n4h97/XjW
	/9nEX0piUi1Zle7xilJ8OgBZjxMBk8dEm9q5impcjWGTRuwGeCnPT92/bdQIQsa35oU2zpQnDFo
	y4duWg0GJBWerBxmiexzRNjHR0TiAfesBs4fJcTLJXeIIDqlKiVRlT7GoKv8UKaTecvX13XeeC2
	oBRTzg4kNlXR6ChQ0PTRkvCZuiQRRGuMRKNaO1emAP8USL64Cl8gMSOSNbOsmbhKDxH3G2ePpDW
	9xiENd86e/3/Y78+xyJyHC0gdv3hHIQzBtO2ZHyZMvQdS/sn6CBOh65MfcTrx0mOCZGIU840g85
	D0gF9NhaRlt9TVdzKKLQG0ppnsFth8Iv4f6WVyGDDWEVdep5JqbO8J3zg8aSi27M2Idpq4CIPm7
	AwED+PWViunKhC7b5pdiERArqrs093B3c2WHbJkgmxwvc9mBL4s3eCFrqKCJhajtvASJAbo2oyU
	mvIBafgzJvhTeC/XETYFNHl3L5EZZxq02pzX0c=
X-Received: by 2002:a05:6a00:850:b0:848:732b:6b1c with SMTP id d2e1a72fcca58-8488970e4ffmr7648794b3a.60.1783927437631;
        Mon, 13 Jul 2026 00:23:57 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm12070765b3a.8.2026.07.13.00.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:23:57 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	mst@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org,
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH 0/1] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
Date: Mon, 13 Jul 2026 15:23:35 +0800
Message-Id: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

This issue was found by Tencent Security Yunding Lab during CXL
emulation security research, and reported by Haotian Jiang
<jianghaotian.sunday@gmail.com>.

cxl_doe_cdat_rsp() in hw/mem/cxl_type3.c:280-282 (Type3) and
hw/pci-bridge/cxl_upstream.c:160-162 (USP) takes
ent = req->entry_handle (uint16_t, fully guest-controlled, 0..0xFFFF)
and directly indexes cdat->entry[ent] without checking
ent < cdat->entry_len. For a default cxl-type3 with one volatile
memory region, entry_len = 7, so any entry_handle >= 7 reads past
the CDATEntry array into host heap.

The OOB-read base/length is then used in
memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
length field is large.

Per QEMU's security policy (docs/system/security.rst), CXL is
classified as non-virtualization use case, so this is reported as a
normal bug rather than through the security process.

A qtest-based PoC (poc.py) is available for reproduction. Under ASAN
it reports SEGV in cxl_doe_cdat_rsp at cxl_type3.c:281.

Haotian Jiang (1):
  hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle

 hw/mem/cxl_type3.c           | 3 +++
 hw/pci-bridge/cxl_upstream.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.34.1
