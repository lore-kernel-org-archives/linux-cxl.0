Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795506410;
	b=L83dA9zNupDjp07M2csl4cBBfSTPec3AZd4GwUDggSF8O7U6F83RDvymQZcSkFaDEV5b
	 +wrmeOi/F3bEpOpWDOaggr0DDTaaljRcjlLv+5zWS7q/z7vzc6tZDNuDtiI/SyXNo2YNc
	 LAugqNmMKhxWa3rmKDQkV+TPyLU16IGziYIyFIi1AamH5SGgqycpOiKmhpbS9XBNQVrnd
	 uQQ2cZtIbrNXyyRtBUDIP2fLhkP+v4GjWvk2tDS7kc3ZP0udKh3h6XDVXHNF2qQffJUbR
	 G0JbRtdClnqn5vSQs+WCOmSrwaFrYDRsaf2WkFvKjVhV3IXJQEUQLYCnqHxiLdH1sZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506410;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient;
	bh=kRrqvytXIQh1UN1ficeeyec9hiae0EuEiSNIRhwNrNY=;
	b=eMqpj5SbvqaGr89XnqMWNfFVXEPRWJ9E5u5bWveW9y7+uhH+m5pkoJXuVUxUFxSZOEkY
	 kYAyLQ92camvBXkJ85XFoGqKZfbMbviQxScxT3kKGuMQkO9FwG8l0npeSh5PJzwkyzJsW
	 3iZX34dU6cCeZ/omsA8e4DjyBfAiUF1lwvLKeA4VztTur4wh84JaJ3UU8wJvcxIkklyIT
	 h506OvfLWOhLwYcyajaitRLQ8LstQZa6qsW/AeC8Si5UFJzAoUbppqO45nYHdRA/FRfib
	 9klUVSVggieARX+loVHffib1+QaIOZpVAUqSxkQUPFNC0e7D/EZBxul36cip4sOTRzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Lti9WYiZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82849606A322
	for <linux-cxl@vger.kernel.org>; Tue, 24 Nov 2026 07:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82849606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Lti9WYiZ
ARC-Seal: i=1; a=rsa-sha256; t=1795506396; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z8HIWX/qmAl8yPJCHWXzwkbzAsM4NC3Cx2m1S9y5X0lb83phEPRxE8Q197boz7SrPUeRDo7gcuQTIeQS9SzWiRg/QCHAGk/r12743BijIdRBLGULonGlsK5v2+jeYUHMolu0LsQ1bwQ/n3hv+BpFjy0JnMjQBuLDrqQ0YLq1IbE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795506396; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kRrqvytXIQh1UN1ficeeyec9hiae0EuEiSNIRhwNrNY=; 
	b=axetLnxffrbYqytCuzU3jvQMY+kxhmwvC8vcwVyy0w+nxEkhMtHb9n5Z9qS240Jh2x2MA3LJV2g/EnK1pY6KR9ZomnmyRw79yocILDY9dCSVM8EeIrQVM71rEzzJD55MmauxN6yT4GGTajhlDek0TsdGHzfeGTMSRycKcyO6x0k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Lti9WYiZwMl/u23jjhvQ6F3kNuEQT0piBqANLPLvKKCGJJkHr1DXR0ddFeWSlF91eCPJLau1pVTKrzE1UaAJWhbX+ZpJR9AAJG0ga2yaZ+fiNAvEEDU5k8J/MgCnDlcRFnO3ft7emEYNy5lJQJgjvvN2H/diD320FD8dTxKgY8M=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=kRrqvytXIQh1UN1ficeeyec9hiae0EuEiSNIRhwNrNY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795506394605159.50305626744546;
	Mon, 23 Nov 2026 23:46:34 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: [ndctl PATCH v2 1/1] test/cxl-translate.sh: wait for completion messages in the journal
Date: Tue, 24 Nov 2026 15:46:29 +0800
Message-ID: <20261124074629.425051-1-ming.li@zohomail.com>
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
Feedback-ID: zu08011227332cf9e24f3f58ef7f1b347200008b5552a5a35fb03406bf70eaab91c83b18f0ac60b456318880:ZohoMail
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

Additionally, the table test emits multiple PASS/FAIL messages during
testing. Although the test has completed when modprobe returns,
journalctl may query the journal before journald has recorded all
PASS/FAIL messages. The final message emitted by the table test is "CXL
translate test completed". Use it as the completion marker for the wait
helper so that all PASS/FAIL messages are visible in the journal before
the results are checked.

Fixes: f643715 ("test/cxl-translate.sh: add new cxl-translate.sh unit test")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v2:
* Combine patch 2 with patch 1.
* wait_for_expected_log() returns a status.
* Check log again once after the final sleep in wait_for_expected_log().
* Check the return status of journalctl.
* Adjust commit log.
---
 test/cxl-translate.sh | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/test/cxl-translate.sh b/test/cxl-translate.sh
index b839179..a48c114 100755
--- a/test/cxl-translate.sh
+++ b/test/cxl-translate.sh
@@ -41,12 +41,43 @@ set_log_start_time() {
 	log_start_time=$(date '+%Y-%m-%d %H:%M:%S.%3N')
 }
 
+wait_for_expected_log() {
+	local pattern="$1"
+	local timeout=5
+	local log
+
+	if ! log=$(journalctl --reverse --dmesg --since "$log_start_time"); then
+		return 1
+	fi
+
+	if echo "$log" | grep -Eq "$pattern"; then
+		echo "$log"
+		return 0
+	fi
+
+	while [ $timeout -gt 0 ]; do
+		sleep 1
+		timeout=$((timeout - 1))
+
+		if ! log=$(journalctl --reverse --dmesg --since "$log_start_time"); then
+			return 1
+		fi
+
+		if echo "$log" | grep -Eq "$pattern"; then
+			echo "$log"
+			return 0
+		fi
+	done
+
+	return 1
+}
+
 check_dmesg_results() {
 	local nr_entries=$1
 	local expect_failures=${2:-false} # Optional param, builtin true|false
 	local log nr_pass nr_fail
 
-	log=$(journalctl --reverse --dmesg --since "$log_start_time")
+	log=$(wait_for_expected_log "CXL translate test completed") || err "$LINENO"
 
 	nr_pass=$(echo "$log" | grep -c "CXL Translate Test.*PASS") || nr_pass=0
 	nr_fail=$(echo "$log" | grep -c "CXL Translate Test.*FAIL") || nr_fail=0
@@ -309,10 +340,7 @@ test_internal() {
 	rmmod cxl-translate 2>/dev/null || true
 	modprobe cxl_translate
 
-	local log
-	log=$(journalctl --reverse --dmesg --since "$log_start_time")
-
-	if echo "$log" | grep -q "Internal validation test completed successfully"; then
+	if wait_for_expected_log "Internal validation test completed successfully"; then
 		echo "Internal validation test: PASS"
 	else
 		echo "Internal validation test: FAIL"
-- 
2.43.0

