Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158870;
	b=LEDarePF/BsERFpGRkxPF8Pvf2nso5hVcKl6Nxawu30v57xnnEYi0oRiX2UEB2MmItMZ
	 trIflC7+eYmJOUegrjXmTBi8NH9q8P01UYBeog5wCltBTJOW9TB2WtJ5f9WQ+oYTXOXH4
	 lADvoVKERbid6v1kABDqYt1haxLqiGOkvxyPiZc8HXLjafAVnWGPSphXBBngBvojpABWz
	 iL0C/T6W4H4xLMEUkn+qVTYlOHcJibFbcUM14l0bD4qy3dWzvVkppWHDq02TJlZ+zPTCq
	 o4LjLfvEt3kBlVh2+xj8K+jOpTCw7zRljl0KIC3FWuaUOqyk7s0K/Fd0rw8WbJRWbRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158870;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient;
	bh=NiTHS8J72lC33gkUzIlnCCrKWnsj225AVSsREwBuY5Y=;
	b=JKczvJJ/9wJBuiLpMugdWIKdl5iPJxWvARvbUYgsgeTE4SEd1Uo0T86fOVcyqXr0xJOL
	 Ni7SZYDTjUKkS70wyG7zQART9ixBvfQ1P+B7QS/1wKKnfsCVFhQlekJyayurwHNEdDb2B
	 ZKrZRB9SJYCro/3k1LAZ/z31nI9Z2M+YzsL3T5XnEo6L/jEY68BdSns6x0gtLfp57JWB3
	 KMjuOwdz6QuFZbmk8aiFhrvJvZpuiGF6WNIjQjQs9YeA9v4mVrc/vUYVnCkBnek3FGj8E
	 jEVIZrQmmH+wX75YE6SsLQHNqqiGBNzt/n2NvCCdm8JXH93u01AlcSn7T2cc6TkSUzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=CX4ziiVv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com [165.173.182.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77C606A325
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 07:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A77C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=CX4ziiVv
ARC-Seal: i=1; a=rsa-sha256; t=1795158865; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4E+rMhk7vR6Xk0MqF9aLPS2r7nDiBv2Myp6y0zHbglJ+HSvIbBU32n7fQmDH7bj0w4hqD0Cll2iTSvzdu2jRakXSMua6sUKyUKwrkDDQseELmhxteXSc+cR6px4C6dI3wI3SZMvzVmZ7DJ7+DGr+jIAcOnb7x0xSH0XX4cDkDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795158865; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NiTHS8J72lC33gkUzIlnCCrKWnsj225AVSsREwBuY5Y=; 
	b=bOqBt9/Ey99thjMvtEqKwLcwPHdWzK5G+RRXgxwFwTui5LiI3AlgXop5rT8E8TJYlHCRyry+zCIwiUflZVSIbVFxwQl2++jbKNfAfJ7CqlM57j5Bkv7pXnZ+npXkT5dSQDFAXytKKVp97eHEhfNDXR4R0EBAZMtEz/XA9GWW8Ao=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=CX4ziiVv2gsnmpTEfDNM74L8/VZOdY89frgUXS9q0r1AlxcpZIUD8tz+ziJryrBkX6RO+IawENle/lX9f1Hc9FMR+XrAFk06OkwIDdkykn4me3J9+mQKTqjokSebQqfOM9LVtAwbURWhjKiK3AdZp0Zfge40emzi6gweLDNqbho=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=NiTHS8J72lC33gkUzIlnCCrKWnsj225AVSsREwBuY5Y=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795158862471512.5921658691351;
	Thu, 19 Nov 2026 23:14:22 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 0/2] Fix cxl-translate.sh test failures
Date: Fri, 20 Nov 2026 15:14:13 +0800
Message-ID: <20261120071415.29279-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
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
Feedback-ID: zu080112274857043391eb7a3c854b16ed00009870029a83c27c04f91f7ae688d2f0d3fa6343ec3c54e8736b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

When running cxl-translate.sh repeatedly in my test environment, I can
occasionally reproduce test failures. The failure point varies from run
to run, but the root cause is the same: the test is unable to find the
expected kernel log messages.

Investigation shows that the expected messages are actually present in
dmesg. However, immediately after "modprobe cxl_translate" completes,
"journalctl --reverse --dmesg" may not yet have received all kernel
messages emitted during cxl_translate_init(). This timing gap causes the
test script to miss expected log entries and report false failures.

This patchset addresses the issue in two steps:
Patch 1 adds a helper that retries fetching the expected kernel log
message for up to 5 seconds. This mitigates failures caused by temporary
delays in log visibility through journalctl.

Patch 2 updates the result checking logic for test cases that use a
specific translation table. Instead of treating the appearance of a "CXL
Translate Test.*PASS|FAIL" message as an indication that the test has
finished, it waits for the "CXL translate test completed" message.
During test execution, multiple "CXL Translate Test.*PASS|FAIL" messages
may be emitted as individual checks complete, so the presence of such
messages does not necessarily mean that the entire test has finished.
The completion message provides a reliable indication that all test
cases have completed and all results are available for verification.

Li Ming (2):
  test/cxl-translate.sh: Wait expected log before checking result
  test/cxl-translate.sh: Wait for test completion before checking result

 test/cxl-translate.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.43.0

