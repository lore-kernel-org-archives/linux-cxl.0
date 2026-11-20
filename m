Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158879;
	b=nW/8mRnF6RFFoiQ1YKC7cSxMGB70JDlq7DFftAXzYNaEwyspp3G09a0gqjDY+oPN6rSR
	 sX++pkI9PJDVI05cNfS2utA5zQNfQDrmFaH+1DI98vWf+yt7wXeGwn31y3lHmMT/V6L42
	 MxHdU5JoNIuesMAFeh9wTX5kyQH7kkmnNai/wu0kuw+6b0kKND8TABOC7kIK+nx/CnZKt
	 AB6wqdmPWsOmuO19QHj00mGqtc3AeH+tBil0Yonvre9zu9Dxwl7jk6Sf67VJpEWFemUDr
	 Sbdlbc2koOP2DIaxJd/36AMGLS5Yymn8HKFOy9CApDE4FeqUdTd1SqktIXtPMCVqM6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158879;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=ko2rI/m84wuifSlFG0F9HCrMdpHNkeXhfRjuaunGN+I=;
	b=v9JunrvMQOqRryhRndJ2K0AAW7zfhtbn6o/HeaLfzFpCP2M2kttxiTTao8/Dt3ePMCsP
	 6DC5Oc/V0WTkiN7gT1aG9L908D0uYQf0KEbDkumU1sOXX41UnGmlIxOMZq3MQieTKNFWp
	 0SfVW+esnjhVpZPQVn6hLtEkC1LIpKBnYe4fnlokcwSm77/GQ7s0rX8k4OJmIm44DPYJ7
	 DLcs9GwXbF09LTQeXDr77zx0cESqLBwtJOrZrOtZSVp1JHJ8uHOt0CaaUehQZAzOwj+WD
	 k5Qwx3rdXcQ5L/Ez+IshqNEO27LtKUG3OEk24yQw7jhcYxRYB/Jf4NfiIxx9w2jPzJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=d0itDJgy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com [165.173.182.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEE606A325
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 07:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CEE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=d0itDJgy
ARC-Seal: i=1; a=rsa-sha256; t=1795158869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kll2E6htiHGwXoNz9MG9Krxk1N4BU/lHrnjlzgSiWXCVZtd+ljGD5k4vSqxp2PZkokjShM7dSG4tqQASugQj1A+m0q4zRPmwqfl6thjW7rxx7CdeelsU1mvXATXcBIJFfBpO5grHQmLISTydP7ujfs19iGCR4r7DI1U6O5R2lug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795158869; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ko2rI/m84wuifSlFG0F9HCrMdpHNkeXhfRjuaunGN+I=; 
	b=U0MJWzzQ7xf+NHKtRWaSgv6sW9Uab1uBKN2yNB6otwIRezJ+P6D10VL0OXTwrLPdrL1NPUxuwbOV62rri13hk0+nVkyMxMLUfBvw1dRXEbTLGlIiakTmY2FyQNMR5msAGPXW8qNVkch6iwL8twmJcIg3ddT5digSSEOCwsiVgF4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=d0itDJgy70thTulnStM7EQdg44ixHk4Eg7agy+hrHtdKCpTt3NmBqkIZ8Ry1TzCYenN5IKK7wQQQpNY7NCxAgdK4iKe001vOrECI649tD1ehQOirE3GuDzqq6DeBzip+Xbe043PsJz/gCu8qxyirTAC2qRBEWT0VX3PbuPRYOqA=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=ko2rI/m84wuifSlFG0F9HCrMdpHNkeXhfRjuaunGN+I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795158866495401.6514589598672;
	Thu, 19 Nov 2026 23:14:26 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 2/2] test/cxl-translate.sh: Wait for test completion before checking result
Date: Fri, 20 Nov 2026 15:14:15 +0800
Message-ID: <20261120071415.29279-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120071415.29279-1-ming.li@zohomail.com>
References: <20261120071415.29279-1-ming.li@zohomail.com>
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
Feedback-ID: zu080112278929df0af45451046290d4370000e33f8db55b81370382a5c815a9b2b9e1b6b88fb305bc664796:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

The cxl-translate test emits multiple PASS/FAIL messages while the test
is still running. Checking the results immediately after seeing a
PASS/FAIL message may race with the remaining test execution and lead to
incorrect result accounting.

Use the "CXL translate test completed" message as the completion marker
before collecting PASS/FAIL statistics, since it is printed only after
all test cases have finished.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 test/cxl-translate.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cxl-translate.sh b/test/cxl-translate.sh
index 2fbc310..51d0676 100755
--- a/test/cxl-translate.sh
+++ b/test/cxl-translate.sh
@@ -65,7 +65,7 @@ check_dmesg_results() {
 	local expect_failures=${2:-false} # Optional param, builtin true|false
 	local log nr_pass nr_fail
 
-	log=$(wait_for_expected_log "CXL Translate Test.*(PASS|FAIL)")
+	log=$(wait_for_expected_log "CXL translate test completed")
 
 	nr_pass=$(echo "$log" | grep -c "CXL Translate Test.*PASS") || nr_pass=0
 	nr_fail=$(echo "$log" | grep -c "CXL Translate Test.*FAIL") || nr_fail=0
-- 
2.43.0

