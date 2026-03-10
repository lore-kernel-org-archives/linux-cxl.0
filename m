Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2A33DEC2
	for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110501; cv=none; b=bDxCP7wxCDofWX811Fi7pASLPyczwGte5Br3F0dj/fCdy1GzHpKgw186GiQGGiHy06HnFWHkSKvpOo6OKUpJ16drzBiIWMPvQLrF4gaGvlnLqsM5+wVd1a9dvHTosbB1gE5l20SFpVsYO5KjRo3foz2sViPLG5eCqP2Mp7Vl6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110501; c=relaxed/simple;
	bh=pM+FoS81WOcr5yKq2Pb2RdxqH9dz2XRct0H73QCPefo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkjRVelIoqsRxisjweDWlwVbPgGdChhdrbq9wf7+fpGgUqCRfbBYr2saGAcEdkwMDoyC0p0xFv//w7khC2gP2VrPVhHAbv7whNlR6TUooiIXTXxK7dBK0T/sc2boxO9FJ+yxOx+2O8HMQmZRJLSbCKjuk+oqzux8Tzh7VPj8i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UUTZF9j8; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UUTZF9j8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773110492; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=o3CX2Sg3PoU2AFf6axIZF6t45CRA6GKKu9tSLCakU40=;
	b=UUTZF9j8Nbm+jUAKoKi2tTUoXmhEbZinq1+N1oS1lfEb8xBTbCW1AMb3j+9dgOpLCC54ePnMTz2xKEfnzHPIXC+8Lvou6gvzUOKb5ZRADilnVoYTXmc5hFWaP5H2D49hpijI28z/KMtIumj23KDCm7S9epciDaIBqXfYwEo4GpE=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X-eAS8E_1773110481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 10:41:32 +0800
From: cp0613@linux.alibaba.com
To: ishal.l.verma@intel.com,
	alison.schofield@intel.com,
	nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [ndctl PATCH 0/2] ndctl: Fix build issues when fwctl is disabled
Date: Tue, 10 Mar 2026 10:41:00 +0800
Message-ID: <20260310024102.25682-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

This patch series addresses two closely related build failures that
occur when the fwctl feature is not enabled in the build configuration
(-Dfwctl=disabled).

The patches fix these problems by:
1. Updating the stub function signature to match its actual usage.
2. Conditionally including fwctl in test dependencies only when enabled.

These changes ensure that ndctl builds cleanly regardless of the fwctl
build option.

Chen Pei (2):
  ndctl: Fix missing key_type parameter in ndctl_dimm_remove_key stub
  ndctl/test: Fix meson configuration error when fwctl is disabled

 ndctl/keys.h     |  3 ++-
 test/meson.build | 31 ++++++++++++++++++-------------
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.43.0

