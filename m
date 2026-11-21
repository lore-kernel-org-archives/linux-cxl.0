Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262725;
	b=VquhM+rCIuvoe6ly2qVk7jKt/+SdL26b5zXrRYl6O1CNUSvmpBPDC5J1UBca9pn2vBHt
	 r2m3bIWsFe6VaJ1wwEXw0yH0JVN9/8w3l0gs8r2+d7yBHeeWc03pK94LkWxbIh/vyxdq8
	 HCTu53BTz3lRZOBoMcUcyqGUMAvWesWerdjL02G3GAIILy7MQoCoTSmE5RRaNCtXDyW3e
	 w48+Q4nhXktFsCEQtjefrC4V508w0jAQrStIAOCAQuMnY+GFaKEhEQtEn6z94HOP+6vWV
	 8Hmz6oyknfkuoMpBs9Lbx9DbN9beVQZSE3qC3Rjf3H+ZZuAI2Ig1rSmP9ly2X1eHd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GgVA1m9FFgPmu9ov9xNiU46KV5AN9vLfSCEf+vLxJ2A=;
	b=Aed/v5zjMYwo93aq4uy+ULl+rb7FstbeI387cb5HPyCeOXukzA1hkIKNW09dkrzoMLse
	 LCbEeDIDX8NyTaRuZnvu9GkOUd1q/RQ06WFHMgHv90+h3rXfz9GgR27k7yc+mdZZ4emr4
	 +Va3NsPCm5/YHDh4vL+xo9aFaTimQzlrVZOES3AhiFNJsv+zGsunmiaiUDMhcgSCN9egG
	 SWA1Gvvf40HeNIh+gweOJu1tC6my2XuDeKSL/4dFAK4+LROjriDpPlctgNb8OrtaNRu7o
	 HsYayhqjtkgzZu59sazsd+DaaGyNRj2eJBSNJNe6NwtsWfr3kPkhskuLgqDb+ImLfWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ceq02/+a";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C733606A32A
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 12:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C733606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ceq02/+a
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so901222b3a.2
        for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262725; x=1795867525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgVA1m9FFgPmu9ov9xNiU46KV5AN9vLfSCEf+vLxJ2A=;
        b=ceq02/+aPAfQKgTb+IGSk2AlvESaLxCOqgvIT98DzGLMDeCoNyUA5szT5H7ADU9PNO
         T0UzpQkECuQPECTYjDcR7E++2yNpmF/GPJe834mqAGxIyt6JtCBMTq+SwDfPZUzGPXMO
         8TAp7+4IoDLsifE1AIBNTV+L15DMer6m07rzAn00byZyyqqC0GRCODqR6PyjE4NPv0oA
         xzlTjUulqf+vbLkm0n5Gw1nfWseVIh9eKAmIxAUS7g+/0pS2/O8Q/Pc/rTV99ZO95U+U
         y14WjHzw2fLQEf3H2xl/R9pDpRsdqkB8hDjS82SXETG7B5cYuHuHyYIksauTOebZdi8Y
         Fg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262725; x=1795867525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgVA1m9FFgPmu9ov9xNiU46KV5AN9vLfSCEf+vLxJ2A=;
        b=hqjrps1yGk2sBmGkoVdjK8Ha3IRf/JnJdbmQEC3KeXXVNmXnipP8SW/19s8GYwCskS
         sNXoSJ1SRf7IKcIkv7HLCchRKalcqjuMNI6tywAp2pUXh5NtOHybHQXzZ0rapJMxEo7A
         R/ruXwVW+bPuBirMHc4HtCnuMVAMDz7FcvRaUuy4MmTBvqT+ZtXWs512VF+p7uuIFL+d
         3tBv9LXNUo9F+7i6yBRgXDB7f1vH+F8rFRQTYnCPgLGWW4qp64YakTcbxAn4Oeua0w1B
         tzGhpz1HgYh7/lTmuT8mshv47KiWgqHAsx/Qyul3mPLLsY81suVOnLMgfnyrKMEr+1wl
         fN6A==
X-Gm-Message-State: APuU4Z/o/AJZ2cV8DSwRfhrJGTpP5VOxshlDtbHJg2KQGJEk32Zk9io8
	KtKJL1gOFxO5mK/+NForzrNXuu7RNMdmHs3U5hftXSRmdqasRy10bvv6
X-Gm-Gg: AZFdTZddnQd7s4ZEySvhulWYbLiVlhGzjME9dRpjpVN9WVYUuKax9KKNoG4C00+RqU6
	IL1BnZV7gP216/Pecf7yqRyKqsjWBN9uLfBs3M/LqVosYAURLhYlmdkyaCjZhLm7NHL9FMoSgba
	uVan7KfpkrqWVyYaHrw/P1hVJxIJYfoqjecKZc0EDzALt9cYlzh6dl/VNK3uY3OmQSierroHHIW
	RPFbBvVEcQevtVU2JETHUkup28MOZ/Nw76J99Z0uPCvAfxyDHucYT85c4o8mKRB0ZALJmOA0wzy
	Q9IkXAVExgWnzwHAZiykrnab8Ww1zgEgpn4q9J+imDPPNrqHQAVEm1j/WUNnyWl5eHA4Ey3nCjD
	c522M+1fjV6gqTbKG9JTBVZAlcMCs2gBFFEg1ahrMbGSAwieem1r7iSiY5lXtdGUBXnnBhtXT/w
	4b/Sq2AZxV1dlscHO0KiKppvF8XBN3LvA9YUrvqNuk7eOCMAHyRin2fg3hEH9gzsnG4lGb3RHod
	fj5qZo8vAlnr7dpv4MIFUR5/+4g/7KVpCU2VI39YP8SC5venPLR6hVHtfaNCDsCMvXkkg0VnO9O
	BurFSbHYLpaVPtUUmvQn7c5wSdgx/3lSjeEP6sX+HlNO89++TvCyRVMEDkDp7nH5
X-Received: by 2002:a05:6a20:c992:b0:3e1:88d6:60e6 with SMTP id adf61e73a8af0-4014a27f154mr5369152637.10.1795262724938;
        Sat, 21 Nov 2026 04:05:24 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm2857177b3a.1.2026.11.21.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:05:24 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 1/3] test/cxl-update-firmware: Make wait_complete() honor its timeout
Date: Sat, 21 Nov 2026 21:05:04 +0900
Message-Id: <20261121120506.1562043-2-unsung0317@gmail.com>
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

wait_complete() either sleeps and continues or breaks out of the loop,
so the max_wait check after the if/else is never reached. A firmware
update that never completes makes the test hang instead of failing.

Check the timeout before sleeping.

With the timeout enforced, the 15 second limit in
test_nonblocking_update() leaves little margin: the 16 MiB upload there
takes 9-10 seconds against cxl_test in a QEMU guest with lockdep, and
10.1-10.2 seconds with KASAN. Raise it to 30 seconds, about three times
the measured time, which still catches a hang quickly.

Fixes: 813809ed318f ("test/cxl-update-firmware: add a unit test for firmware update")
Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 test/cxl-update-firmware.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/test/cxl-update-firmware.sh b/test/cxl-update-firmware.sh
index f326868..100d15f 100755
--- a/test/cxl-update-firmware.sh
+++ b/test/cxl-update-firmware.sh
@@ -61,17 +61,15 @@ wait_complete()
 	while true; do
 		json="$("$CXL" list -m "$mem" -F)"
 		in_prog="$(jq -r '.[].firmware.fw_update_in_progress' <<< "$json")"
-		if [[ $in_prog == "true" ]]; then
-			sleep 1
-			waited="$((waited + 1))"
-			continue
-		else
+		if [[ $in_prog != "true" ]]; then
 			break
 		fi
 		if (( waited == max_wait )); then
 			echo "completion timeout for $mem"
 			err "$LINENO"
 		fi
+		sleep 1
+		waited="$((waited + 1))"
 	done
 }
 
@@ -149,7 +147,7 @@ test_nonblocking_update()
 	mem="$(find_memdevs 1)"
 	json=$(do_update_fw -F "$file" "$mem")
 	validate_fw_update_in_progress "$json"
-	wait_complete "$mem" 15
+	wait_complete "$mem" 30
 	validate_fw_update_idle "$("$CXL" list -m "$mem" -F)"
 	check_sha "$mem" "$file"
 	rm "$file"
-- 
2.34.1

