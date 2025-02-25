Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076033DB
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740456629; cv=none; b=nl4YUzHnQajgMBPlsOP4UXdzGwF2OuW8pn6nGNQfkex3zY/VDVOuLFX1LJsfcHmtr6aCw93rAqEKzqFeuJb2bJcs3NlWAYeW31pOLF/4PijMRtz9bVWp8FkGY7X7KVdKOjXgxZaWVvWnMIkLHx5pUSS2OHNe6nc7b/wwpzwV1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740456629; c=relaxed/simple;
	bh=rEEAlkCqPHmB9xK+XowxrxFw3DTxsAD3YGK/+A1+PiU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=laoDozoM4yoYzHvjxi7ZXbI4hhy1RSlB0FCgkln0+mRZoUbB9QD6qqPT695agGJblj1Hc0fGEvRwL4c3+XTe5srbPzRyD1EO95na65dmjbVRx1XqICbbS9SDV5NGHeQ0boUbPYeTVBU0+1Zye37H+GLnrrdUjAIR7K2oBRwycXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZfATYn1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZfATYn1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740456624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rEEAlkCqPHmB9xK+XowxrxFw3DTxsAD3YGK/+A1+PiU=;
	b=YZfATYn1Pd9RHvJ8gKAcdgQ2/Qvu3uU1lT17JiNn9JoZlRuzXrGZ3a3vn4JXhrRTd/bmuB
	Ni0Lw9TUVydqUwkrkLeL7k96w48V8vmDfDmpFG1MeMEDLrRZC5b3aTmh4g4xfVU2sGfKMq
	YN5Xzmlks3+EHE3eJsKHOwjF4mxkd8o=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: ndctl cxl test suite fails in arm64 QEMU
Message-Id: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
Date: Tue, 25 Feb 2025 13:09:57 +0900
To: linux-cxl@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi,

Has anyone noticed the ndctl cxl test suite failures I reported below on =
arm64, QEMU emulation?

https://github.com/pmem/ndctl/issues/278

I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], and =
the latest CXL kernel [2].

[1] https://gitlab.com/jic23/qemu/ cxl-2025-02-20
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/

Thanks,
Itaru.=
