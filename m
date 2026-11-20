Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158875;
	b=FKSwYzC/dCAeQWzfnozocEsbZNk2EHYabueejDzKbAfGIL1t5LjbJRopRqGvWDijUNYJ
	 uQ7rateGPdnCUcrtn1gh1f+bYC+oriCkZtxQjmX3qK+gif5FQkzanl3foclekq6xQEjoe
	 XiFNH1yE6Ha8c3GhTjFtgsX2JGbNg9Wy70C72DXws8XARlPtoXzKAH9J1s5tDCEGBKMUQ
	 6GoiU4JW+DW8c690zGWcmOTlnJ496Wz78W+AcePQKjrtsl+60VEVB+X3NnCUxPZ/VcC1+
	 jaKZ7abvGpAM+MerLyBGD2O0DA1qwpZQx9RFLKRYUvkGJ9FCNC5limuPmzj/VdhJWHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158875;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=ndY86GtdYDT2LjGY/vUIOFmVag+/FVh8buu94o8eQl0=;
	b=MNIycCEPtJvJKKYUCdoe0lyIOO77l3p8SB1YSN8hQkQ85/pKmtXZ/5qcf9IYJsbmG6Ck
	 ku0Kz4Zgqh1+sJLyTv/lT836Bkd+zNdkMslUkP7VeaUI+sq6kcRgLx1ZJck9jnX4/tTgG
	 vw3YnLdX6jFsDC1kiD3br2UG8zrKo9n+Yhfa0sjp6LOpDbPdPBWYrZvHe/QHDOzBAKrFH
	 8/agx9PGIEDfYVTkZeB4asFjrYPAjQCIBj459v4OSqfj5g+mbNGlBTg/5o/SNlmzgw+FG
	 3JZa5chrnAZLg/Op1y6u63BOBFDEy9yD6n2nkJKtRciV5GjkA4M7nMiMvLsRg10MOLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=K8unEiIZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com [165.173.180.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4C606A320
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 07:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC4C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=K8unEiIZ
ARC-Seal: i=1; a=rsa-sha256; t=1795158867; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ezLG055j4XaObwSpR4NvyEVWYguUZeSTLz1tXazdUi15DJSxSgHm2NZziHTQ9LyE9s1lf89DNOb7T6ZzKFFn2lEmfoAjU9W86dmy0JnWK106k9O9/tI+fQ/6verROaXF6jP6qvVKUAEBEWP1YPL22dCs+Ep2umuhWIvHbeFMG7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795158867; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ndY86GtdYDT2LjGY/vUIOFmVag+/FVh8buu94o8eQl0=; 
	b=a1hq0H6qEyoQ96Jzue/RtUlA52SGRiBYEGgPU8KvMvM6GcGP1UDdYQomSv7chBU48X5oxNmG2lRFVNqAuMNdUG2ySBGBhSeiVqXVtScjK888k88wsqgTADHA0O0Ee10/K9RWn3NIYTFXvuy18jt13kg6uGL0SwT+cWbABCClhdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=K8unEiIZeb1Gcg28ArO0GDRGixRZ/Fj/GDG+LGaXJY31QUutx/dp+haGHT0pq7X5P4n8PxtaXuxocBIv2e30eLtPeUn6CGLqoC5wEseJfn5B1mqyQ2JbiVUh0qlnKzQh+ObTtWNYAy9VHzIfgvD0gXK4GuucfcGTTg/htVnmFq0=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=ndY86GtdYDT2LjGY/vUIOFmVag+/FVh8buu94o8eQl0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795158864526558.4146844757676;
	Thu, 19 Nov 2026 23:14:24 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 1/2] test/cxl-translate.sh: Wait expected log before checking result
Date: Fri, 20 Nov 2026 15:14:14 +0800
Message-ID: <20261120071415.29279-2-ming.li@zohomail.com>
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
Feedback-ID: zu0801122710c07499f829c3b9f3ff43b6000040ced543654ac7c343b299c4754199111aa7df5c95e77dad43:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

The cxl-translate test occasionally fails when verifying kernel log
messages immediately after loading cxl_translate.

Although the expected messages have been emitted by the kernel, they may
not yet be visible through "journalctl --reverse --dmesg" due to the
delay between kernel log generation and journald processing. As a
result, log verification can run before the required messages become
available and report a false failure.

Add a helper to wait for the expected completion messages before
checking test results. This avoids timing-related failures and makes the
test more reliable.

Fixes: f643715 ("test/cxl-translate.sh: add new cxl-translate.sh unit test")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 test/cxl-translate.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/test/cxl-translate.sh b/test/cxl-translate.sh
index b839179..2fbc310 100755
--- a/test/cxl-translate.sh
+++ b/test/cxl-translate.sh
@@ -41,12 +41,31 @@ set_log_start_time() {
 	log_start_time=$(date '+%Y-%m-%d %H:%M:%S.%3N')
 }
 
+wait_for_expected_log() {
+	local pattern="$1"
+	local timeout=5
+
+	while [ $timeout -gt 0 ]; do
+		local log=$(journalctl --reverse --dmesg --since "$log_start_time")
+
+		if echo "$log" | grep -Eq "$pattern";then
+			echo "$log"
+			return
+		fi
+
+		sleep 1
+		timeout=$((timeout - 1))
+	done
+
+	err $LINENO
+}
+
 check_dmesg_results() {
 	local nr_entries=$1
 	local expect_failures=${2:-false} # Optional param, builtin true|false
 	local log nr_pass nr_fail
 
-	log=$(journalctl --reverse --dmesg --since "$log_start_time")
+	log=$(wait_for_expected_log "CXL Translate Test.*(PASS|FAIL)")
 
 	nr_pass=$(echo "$log" | grep -c "CXL Translate Test.*PASS") || nr_pass=0
 	nr_fail=$(echo "$log" | grep -c "CXL Translate Test.*FAIL") || nr_fail=0
@@ -310,7 +329,7 @@ test_internal() {
 	modprobe cxl_translate
 
 	local log
-	log=$(journalctl --reverse --dmesg --since "$log_start_time")
+	log=$(wait_for_expected_log "Internal validation test completed successfully")
 
 	if echo "$log" | grep -q "Internal validation test completed successfully"; then
 		echo "Internal validation test: PASS"
-- 
2.43.0

