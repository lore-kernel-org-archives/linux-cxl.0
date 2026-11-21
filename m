Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262729;
	b=2f3Ut3idInKVbkEUFk1oH4kX5yOQKsuQTZhBpdAkbzxGgr8jJgR5iKYAwdwb9CwIhf+7
	 VXAtTHc1wtIWegO6xM45x8P5yGom/TAE/jFsWexYrm900pDD2wSkXBKLB2TrsStz8wBI0
	 xFr2B7TJSG9lH/1fej9d725m2C3aci+oT7tBFcAepe2RWliRKOzKfcRHmmxKUW3oBk2O6
	 mT7v46zoyumYIJrS7t16LIOxvLfmiey8dDaber6xQ1Kg6y+rZ1FR46CW+jNrKnOQuR3jI
	 pndv/RMcujAW8i/jJAlkj/OrjdAgg0lzjAjBixmHFY4LjOogXFnQaTDrGPscQMv5AFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sJLz5x6oV0KVeJ9JGZQ4MN1uop6g+t3PihmjDeELpBM=;
	b=wngkvNiLlFucdxeHoeukczy28Q/CWQwtcj+qZxXVJwHQT7Xxfizu1oDZELIJX2Bg4KMw
	 fQuwyqSGxEYAoNtQA8un5fGZnpqYBJ6yRFk2Xc4tbcfV4GGjhUhhj/H0WcSa5f7CtI3JN
	 7yJ9SH3AuJKyxVsTVE+4OAXZgrZIPr2lIklAE38eL22V1e+JcZZQqkhEtQ6Y/QUBPH+oF
	 Uymd1OWbf/6VzxIRgH4RO1jEUOiHIKhq9uXvCJeifLNvWn+10qYGxVHged0kRTVndU0RI
	 eR7z4dP5JNA3pDyQLOwjkC4GV0hSgm7A2cZUSczb4zaXscS35ZLCn8uVt0jSRQZYYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gdfT3PCy;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1851606A32C
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 12:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1851606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gdfT3PCy
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1453741b3a.2
        for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262728; x=1795867528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJLz5x6oV0KVeJ9JGZQ4MN1uop6g+t3PihmjDeELpBM=;
        b=gdfT3PCyFrKhsMp9Af/PCrNgG47Y7BxTLFbnaY3/LBtmU6Gq3k4YZ1LpJt9KrFDfpf
         FtRKTfvhetfqs3CEkFF/Gz2AZ4nZ5gFLJNzZdH6uvERYT1Fz5QMmnGLZUSuvct18L5pY
         7qjSwLt0qjEKN0YlPLmC5pX2cIqCeH6tRew67CLZqnkOgYyPqn+9fzmLQTw23miJ8/go
         FYHxTzqWrrKEd1eBTQJ7BtH8Z4ONY0uEmvoOLOXCzMP/ThVXrNqwtBsRGgy0x3HNM0un
         /sQmPK26vjpbuklCnRDDNmzrG89Xb8fpNpFvvKhRpxAjATBS4UmWfRAER7hlaE0uaMnq
         SZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262728; x=1795867528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJLz5x6oV0KVeJ9JGZQ4MN1uop6g+t3PihmjDeELpBM=;
        b=JYXTAV7D3Vul7yjMfiPT/VZH9KP+6wrm06QqvJIJGyBRRY1m2tvXYYZLBLFNG1+vSv
         mTuTyqDtaDaxySjW6iJBFifkutwVJ4Suucq88XWWBIHpBrKy86oYWHgD5Fl5KKuIVHMX
         /FxBWKxgdtGnvMlF79TgubVxCGsxSmyD/3WgWYi0I3AAYgGlDQLwIs2NEn7Qonf6cQxv
         8vvdMfx1+gHBuEcuqTD1doXOPtEIdJt2H27beGnI73t6Ybv8EBGJh0vB8AnX3FAv4983
         HNT5uWaz7nsOz/FS5l9KXHzXBgGDF62SZfa+Gdvh066krEHfbF4tg/SfSAR3xEK6U7hj
         6aLA==
X-Gm-Message-State: APuU4Z8BIyCMSJygO4u7cfaMeDsh1RJOT89uKN6j5FhuGa+wJzUDNAFc
	Eul7ayv3jvYJWXJj52okbDUPZBnrbTKn3j0u/Hv9VTbSMBqPd50dHxKbNJu1MP4k
X-Gm-Gg: AZFdTZdqXcKmFKBoGvDzxGquEAslA4BAH+wT1tAyWf4MsC60d7zD75IcFw/Up9GhJ6y
	hRnN11Sw/7dx2YO8aRIwfeIM7wtxym8mCHh19BxQhoqsmm4CEDKTGV3XUDHC+NL0aPp9jfRobJ3
	WxtEPXKS97b95ma128wB/KSjMkdWx67A8s+qViYiY2E+gtylN7PBZrraYqmMyStNjtu4lZE10JA
	zNQZ1yoV1uYfo5/In46l3u5TKdoxj0hfHvvbuiYmdCSRkItbIFl22t1JDByJ62Db1Sesc3Gfq4l
	J1F0ey45X0S1JfoNovA/TEVjWZ43TrbbVMxFRT4qfhMgZHKXslexUScDP3IiF2Bq8w6uuXtCtFq
	toouK6C5hq39nEMgm7s4CkIrWU0eUMXlU1jiX/MLB7A9NLp2a5dGTVS2rhgLUIWR/bDakDM0aIF
	JKtVRp+SCln7ZN2PtdsiNaB+Pj4l7zSlS6ZZ9pJalSnQca1gx1R2Voo+gKkut6Z7NE9Yjsm3d9e
	ClC7TSKsHxF+aqh4tVTGGc5FiNgIJjRfbKiN0Pdz9VwK5FC4GQMvHeLuTXr8r0tWxQ0N6BBtF4c
	ErDSlMzpxxIXpHX30YSj/ih7FjLWERwW508L+etl8jg=
X-Received: by 2002:a05:6a00:298a:b0:886:31d3:51a2 with SMTP id d2e1a72fcca58-8c87ce31d2dmr5370445b3a.39.1795262728064;
        Sat, 21 Nov 2026 04:05:28 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm2857177b3a.1.2026.11.21.04.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:05:27 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 2/3] cxl/memdev: Stop waiting on remaining_size in update-firmware --wait
Date: Sat, 21 Nov 2026 21:05:05 +0900
Message-Id: <20261121120506.1562043-3-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121120506.1562043-1-unsung0317@gmail.com>
References: <20261121120506.1562043-1-unsung0317@gmail.com>
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

'cxl update-firmware --wait' polls until the firmware loader status is
idle and remaining_size is 0. The kernel firmware upload core leaves
remaining_size unmodified when an upload fails or is cancelled, "to
provide additional information on errors" (fw_upload_main() in
drivers/base/firmware_loader/sysfs_upload.c). After a failed or
cancelled upload, status returns to idle while remaining_size stays
non-zero until the next upload starts, so the loop never exits.

This is easy to hit: start an upload, cancel it with
'cxl update-firmware --cancel' while it is still transferring, then run
'cxl update-firmware --wait'. The same happens after a ->prepare()
failure, where remaining_size is still the full image size, and with a
plain '--wait' on a memdev whose previous upload failed.

Checking remaining_size is not needed to cover the start of an upload
either. Writing 0 to 'loading' calls fw_upload_start(), which sets the
status to receiving before the write returns, so the first poll after
cxl_memdev_update_fw() cannot see a stale idle status.

Wait on the status only, and extend the cancel test to run --wait after
the cancel.

Fixes: 64ad46b4a147 ("cxl: add an update-firmware command")
Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 cxl/memdev.c                | 3 +--
 test/cxl-update-firmware.sh | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/cxl/memdev.c b/cxl/memdev.c
index 6e44d15..7f0d021 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -796,8 +796,7 @@ static int action_update_fw(struct cxl_memdev *memdev,
 	}
 
 	if (param.wait) {
-		while (cxl_memdev_fw_update_in_progress(memdev) ||
-		       cxl_memdev_fw_update_get_remaining(memdev) > 0)
+		while (cxl_memdev_fw_update_in_progress(memdev))
 			sleep(1);
 	}
 
diff --git a/test/cxl-update-firmware.sh b/test/cxl-update-firmware.sh
index 100d15f..e93bb00 100755
--- a/test/cxl-update-firmware.sh
+++ b/test/cxl-update-firmware.sh
@@ -181,6 +181,11 @@ test_cancel()
 	# cancellation is asynchronous, and the result looks the same as idle
 	wait_complete "$mem" 15
 	validate_fw_update_idle "$("$CXL" list -m "$mem" -F)"
+	# A cancel during the transfer leaves remaining_size non-zero,
+	# --wait must still return.
+	json="$(timeout 15 "$CXL" update-firmware -b "$CXL_TEST_BUS" --wait "$mem")" ||
+		err "$LINENO"
+	validate_fw_update_idle "$json"
 	# no need to check_sha
 	rm "$file"
 }
-- 
2.34.1

