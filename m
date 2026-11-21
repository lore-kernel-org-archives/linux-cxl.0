Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262731;
	b=t+j7quy90tp0z9VA56C5M/nFZRCrDugD4fG9JYM/KocXUohD8V0sA3ggWDMREKsHK+Pw
	 tnUkisov7gziJcWp+utgkdQ6ZWkPwg9xlh29nJgNR5o26PnQaM9DaW85wqOSfBHmtlzfp
	 LKH8Ni6JCoJCaZb16xKIh54/sWjp8yzP5IddPQ2vd2wF4Q73S6VotquzvMAdJ5A7U+XrD
	 6u3XlL2fOyoAITdl6YSnjrOI5o7H+4Ta20P5oHSskvjbLsrm+ZDBSVp5kYlIYOMqIzAnT
	 htzBY3DiKEDgihAfD7JONk2k93AuF1TLAtVWPScEp5Ok13RSwX1+JfGUBT7UikhOSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xQQHpRs7M9wztbVkihpFgoh4ndj5jkNLjAef2ynID3A=;
	b=BbkyhV+HTsSoZYVFQDbMb9sAlVk94Vso+nxybeAvqWZ5kK20awqB4dq2vVnTn0V+g0RH
	 4+BhhssHyICzUZ7OS14zG7DVvsrula0HMZByGeGMt5klQ11stF5t6ae5KHRDXUChPsRkG
	 WX8ztmJ5QYTCYwMXVkLYeJP20lK7qKbh0GrE7Rys9iies2qYfJFlk68ZgQaltk68MIhs2
	 fJU68x4FIeR/Izi80euM4tsQEDX8Fu+3YkRLwd07FoxSKASZD/T7Sxu8xs7e0uH4zMc01
	 bE1honZxfKQieLXMLHx6AHDflI1ovh9oJGXGTxv2m08v94UXLX8+5dlY6CvFjpUopmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxDY5rB+;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0E606A32C
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 12:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D0E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxDY5rB+
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1259544a12.2
        for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 04:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262731; x=1795867531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQQHpRs7M9wztbVkihpFgoh4ndj5jkNLjAef2ynID3A=;
        b=GxDY5rB+kxvGxuFmaNnk4LfbJdRO++bIb4Ewezu8cmjR12hCjCDCW4LCXe6eRz30BP
         Yq4W5RJhPCjXTOIrwGoFnnE/4nQI0LWirIUkCAXLaD1RSOPIeqnLjrLZ5Ug9cJA4JoYE
         gunhYFpTpnlpOhpOMAH3AGdFPt1ui3YMsPRj5zDajRWFJLqbhu8GdCsZYytGQMp2BXcE
         zoHFE1S4dXIP1QIy3lprTGv9EU8J4mx6XiPLFmjOBaRQHdRiPilMABYAU4HGxz+a5pfi
         du6V7Pwl2qoSEQlnZ/ptvb3JwQrDTqZgZR0lk7zSn0ojUWAGST8Lltvq2RXTvhWptSam
         mulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262731; x=1795867531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQQHpRs7M9wztbVkihpFgoh4ndj5jkNLjAef2ynID3A=;
        b=Gd1WKBo4LoRCKmLXoZSqBP1uSgOxP8g5lR6bwpsvYpHn/ZzBuT1Vpdji9Zkc4bD09N
         bSPS12lwFmmJcXc9lDQiO/K3T0s4JhZny5+HeVH19axOtchWuE4bgeN19s3RSy5BEzDh
         XO3NmcciaFuZERa8rqXatdkn4PbHZNwLXc5PKi22K1MwVWUJrmkHQWf2Mqoesxg1T79h
         MQQk1jyexcb7pPAPecpSXvAsJYsfmoyvWslSDgLFHzY/QSuOhHtorMQdRmv9rkk86PEs
         bEsGevb3gc3vlPJ7iCeYK7weCYa8+aNVrN9+xeA20lZ6lMCdzupk5lUeUDLUINyJo9dH
         Brvw==
X-Gm-Message-State: APuU4Z/ppJQgTymr7KrQQYsD9cXYAzuab2kR/drXYEXIhG+4v2zxlTyv
	6fFGAQ84rpDJJeE0lqj42GZ45VFvIQ/dOl8oBtQkHhCXREL5WtDdspOCpFcrGj/z
X-Gm-Gg: AZFdTZdxxP498BW3N6RyFGj8v3ZiRnQAytPF5M+MfMDqO3Fk7L7IN8iiIlOsSxeCQqo
	agZQnEjbemOLhL9TSfOchuHc1Cb+p77yF0pl6Hwm/JCQ43SxO1WoDmUvnJKWUwZsD/y3smvUnja
	8ZPfV+nYKBYrx481fkYBDGXKQ5EPY44PB7mn/9TxgX6dh18iWB89quf9SKCulv6rFb+jjEyeAse
	qi2Jip9JstboZdzYsyDG/E62CJhwAOLohDKYP6LUvy+nvRv7aMDaCEArXJCph+JY5MDWuI037Lj
	TEjEz3H1tI8yqTcMTFXrUukeaZl1slg6Sdg+JYgYJ1aVTz6nSa+7Ywn+ivkYpeT/EBoFK7njwSG
	2uAkIg/CYgAKfSrQR/6cdjIL5Ge7UQgvxfWwHZGf15gWJJp96VbVW4pUEzSWTK33aE+7V6vpCWR
	YS2zDMHoKvFQVYZvAqlU/BE1L3hpe0IWyCVZ0FhxQWHetiRB9io1BRS+xx/i9txHmsSlH5lDsYQ
	A/YCFGmmTikM91zSW4ubqYJ/Fwa2ZnA8CV8f8Q4DzAeg/GkgeVdiqE6mLvwvRrmklbfbVRY1PxT
	9CEDugatlra36NIJZ/qkpE1LObUzTO26IIr2XzsLmjSDQoBboc1p4vIPZfU9wryV
X-Received: by 2002:a05:6a21:398b:b0:3fa:e66a:fc52 with SMTP id adf61e73a8af0-4014bc5377fmr6568760637.26.1795262730530;
        Sat, 21 Nov 2026 04:05:30 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm2857177b3a.1.2026.11.21.04.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:05:30 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 3/3] cxl/memdev: Fail update-firmware --wait when the upload did not complete
Date: Sat, 21 Nov 2026 21:05:06 +0900
Message-Id: <20261121120506.1562043-4-unsung0317@gmail.com>
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

'cxl update-firmware -F <file> --wait' returns 0 even when the upload
was cancelled or failed, so a script cannot tell a failed update from a
successful one.

When an upload fails or is cancelled before all data is written, the
kernel firmware upload core leaves remaining_size non-zero until the
next upload starts (fw_upload_main() in
drivers/base/firmware_loader/sysfs_upload.c). After waiting, report an
error if remaining_size is still non-zero. This covers a ->prepare()
failure, where remaining_size is the full image size, and a failure or
cancel during the transfer. A failure after the transfer, in the
programming step, still leaves remaining_size at 0 and is not detected;
that would need the loader 'error' attribute, which libcxl does not
read today.

Only check an upload started by the same command. With --wait alone the
value may be left over from an earlier upload, and the command keeps
returning 0 as before.

Add a test that cancels a blocking update and expects it to fail.

Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 Documentation/cxl/cxl-update-firmware.txt |  5 +++++
 cxl/memdev.c                              | 12 ++++++++++
 test/cxl-update-firmware.sh               | 27 +++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/cxl/cxl-update-firmware.txt b/Documentation/cxl/cxl-update-firmware.txt
index b7342aa..5af6520 100644
--- a/Documentation/cxl/cxl-update-firmware.txt
+++ b/Documentation/cxl/cxl-update-firmware.txt
@@ -76,6 +76,11 @@ include::bus-option.txt[]
 	it will initiate a wait on any current in-progress firmware
 	updates, and then return.
 
+	With a firmware-file, the command fails if the upload ends
+	before all of the firmware image was written to the device,
+	for example because it was cancelled or the device could not
+	start the transfer.
+
 include::verbose-option.txt[]
 
 include::../copyright.txt[]
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 7f0d021..fe54258 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -798,6 +798,18 @@ static int action_update_fw(struct cxl_memdev *memdev,
 	if (param.wait) {
 		while (cxl_memdev_fw_update_in_progress(memdev))
 			sleep(1);
+		/*
+		 * The kernel leaves remaining_size non-zero when an upload
+		 * fails or is cancelled before all data is written. Only check
+		 * an upload started here, a stale value may be from an earlier
+		 * one.
+		 */
+		if (param.fw_file && !rc &&
+		    cxl_memdev_fw_update_get_remaining(memdev) > 0) {
+			log_err(&ml, "%s: firmware update did not complete\n",
+				devname);
+			rc = -EIO;
+		}
 	}
 
 	flags = UTIL_JSON_FIRMWARE;
diff --git a/test/cxl-update-firmware.sh b/test/cxl-update-firmware.sh
index e93bb00..d172994 100755
--- a/test/cxl-update-firmware.sh
+++ b/test/cxl-update-firmware.sh
@@ -190,10 +190,37 @@ test_cancel()
 	rm "$file"
 }
 
+test_cancel_blocking()
+{
+	file="$(mk_fw_file 16)"
+	mem="$(find_memdevs 1)"
+	timeout 30 "$CXL" update-firmware -b "$CXL_TEST_BUS" -F "$file" --wait "$mem" &
+	pid=$!
+	waited=0
+	while [[ "$("$CXL" list -m "$mem" -F |
+		   jq -r '.[].firmware.fw_update_in_progress')" != "true" ]]; do
+		if (( waited == 10 )); then
+			err "$LINENO"
+		fi
+		sleep 1
+		waited="$((waited + 1))"
+	done
+	do_update_fw --cancel "$mem"
+	# the cancelled -F --wait must return, and must fail
+	wait_rc=0
+	wait "$pid" || wait_rc="$?"
+	if (( wait_rc == 0 || wait_rc == 124 )); then
+		err "$LINENO"
+	fi
+	validate_fw_update_idle "$("$CXL" list -m "$mem" -F)"
+	rm "$file"
+}
+
 test_blocking_update
 test_nonblocking_update
 test_multiple_memdev
 test_cancel
+test_cancel_blocking
 
 check_dmesg "$LINENO"
 modprobe -r cxl_test
-- 
2.34.1

