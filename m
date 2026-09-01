Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AD346774
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222587; cv=none; b=mZJqHgDkl3iZHR7saaI5/NkA0wlXnJSBaV4wnH41LQztGFSpOZGjQbmmloWSdvxN8oRxgvg8HsUdxFHUB27vLRRSSmBdftttsnpH3LDKMKjRFTc3pl17oyeC6T1EMZpP7X3HqgD4n6agP7nY/+Cc5vKzmaBgfCtF0m8Xx1JPuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222587; c=relaxed/simple;
	bh=QpAlGwUUQwN9PmRY2pagbCFmOWXR7/8V1k/VQFIPngc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKpmGckT0NX4D32H689VGreI6zrgm2LDdbFvShGxL6JDzhJzSZumMvWjDtB4gykCTgJNZlghD2Pb5j6zRE1mOikfmKpnyJ0UmjNFoTtNBHdhYa6bo25hHltYRPSDwGaFt/X8VU6jplgUHzWmQbsPgarOziK4fp2J6hgJ5GYFoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoAY3akO; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoAY3akO"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66e55430869so2552932d50.0
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 17:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222584; x=1788827384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZY/qeOHwo20yfXDG0KXJjSnOELpiuFvVKjI8uslmL+s=;
        b=JoAY3akOnydPz/kgVkSQz/SlNMjUKtgyuuiaeIP7DzCwbwQ0wNomuIJ1CbPZOfNXqf
         CS94lGMfjxrvHCQuEagQEuUtnhe4P5hrgd2juwu7wcviLxz9wntPVlqZNSA3lz/OLcDM
         4ILYPHtj/GQNCit7lEpKUFZLhRBiy/cmG766vc2VVd08s7dxIkAFwu0KB37wxa8Ozwv8
         X/weQjl1k4i1OteclhpdUNGmB+0KiFamcnoR7GkD9Y7ee9mN6GjjgdT+QUgh8u13B7c/
         bZYMvEA6cwjYVUfZOF70cK8pmMKh0fpv+1grwrFJo/FJo9G7gnJA0dGkv44+VAGzk3gB
         Y9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222584; x=1788827384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZY/qeOHwo20yfXDG0KXJjSnOELpiuFvVKjI8uslmL+s=;
        b=dWqJfTGQtMXi8AmDJYAcPz0Ss8QejAI6h0oteGYYGlEddvvaiJ/Gmg1ych8B650L4K
         L3qhdSJxMn7ZRiAtiO6yS/SC+m6/dV6XOgHgdLrZtEItvJQe5fg+2HqXirRj0CMl6KTF
         p5z0aJXpe3/De+lkO8BWXUWJGXAKdoVRCq5Sfg7TD7fkey4BleKU3Mm9/xKFwR/E1BqW
         S/h7S9xH9ASGzdxZD2kBBDnYE3UoKH1C2adLXv+tLoZTi9BW+u3Z3jpmnW5Dyq9MaMZ6
         rn857Z8XOjv0ZL0NRA7S/VcepHydzrufxniOYWZxLFtwx23RiBeTCHkwN4IUztWD8Pv/
         hqqg==
X-Gm-Message-State: AFuF++kp93NbO5LZuhOsWDwcJ8foys6JsLVyD3ghEz/fVgr8YlfWKW6q
	TJ4GtfCKTNCVPcZzMalJkQqbnRuptNoDr8b6+5ePjhL9rwHP34xkdi3QNYKfXA==
X-Gm-Gg: AYBFou0btkrAQmKaG/e3ZueyMlXHaG9jw1murcZ3415bpxrQWaRjmUS9so6dA1QgJCD
	sGtGIlnKMhKrVEVmg9sIVHJwTXwgRSmuMpYhVY2F52Uk8IfsKnQBheLR602781jmmK0wG8ymFgL
	UuLlXAoS2q4REJ5aFASc5qhoRZ4DY8MqhcPvBZ0F2CnD/98zzaAflL0c8aCTOD95i844V/Ib92I
	CzjexMzP1KMkp4rCc2N+qmGfoCPOXhtfvBuV5twYbcd/lDplvbUI8qfjxgZ6mOOh00ZoksvC6/T
	5tEyv+pjW99kAC2UGQXxDWanlxqwKRHgelfIJMZZIs1moyC+54L0EADR8n007ppZnFOrhtdKDxZ
	aAdqG5ajDxD/DYwyoxyYaX6CA8vlb2DQL0woD5LFNUC58kqjHQtwXc7vUjbwsQwrHSX/+eYq2nf
	mdvPWaN3sPQbFuOeqJfxCrtAlz+hX9QK5/DaxtB2yhdc3hy4cXnPGKr22qWb4gl2HcoiTI8qHAO
	FKmMSXLk+xarnILryuZquC8b+a3rKcwBQp3SFXl
X-Received: by 2002:a05:690e:1189:b0:668:db:8c35 with SMTP id 956f58d0204a3-66f874d3934mr1569217d50.20.1788222584014;
        Mon, 31 Aug 2026 17:29:44 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e668ce7ecsm63349177b3.34.2026.08.31.17.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:29:43 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	jic23@kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 3/4] cxl/events: Bound the per-log Get Event Records loop
Date: Mon, 31 Aug 2026 17:26:56 -0700
Message-ID: <20260901002912.958-4-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901002912.958-1-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_mem_get_records_log() re-queries a log until the device reports it
empty. A misbehaving device that never stops reporting records keeps the
event thread stuck in this loop, and there is no cond_resched() to let anything
else on the CPU run.

Cap the passes at 128 and reschedule between them. Each pass gets up to
a full mailbox payload of records from the log, so the cap is a generous
upper bound. Report hitting the cap as an error and let the caller give
up on the log.

Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/cxl/core/mbox.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 02b8c33a74b6..5e49589727d5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1071,6 +1071,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	return cxl_event_retry_rc(&mbox_cmd, rc);
 }
 
+#define CXL_EVENT_LOG_MAX_PASSES 128
+
 static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				   enum cxl_event_log_type type, bool *got_records)
 {
@@ -1079,6 +1081,7 @@ static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_get_event_payload *payload;
 	u8 log_type = type;
+	int passes = 0;
 	u16 nr_rec;
 	int rc = 0;
 
@@ -1134,6 +1137,15 @@ static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				type, rc);
 			break;
 		}
+
+		if (++passes == CXL_EVENT_LOG_MAX_PASSES) {
+			dev_warn_ratelimited(dev,
+				"Event log '%d': Still reporting records after %d passes, giving up",
+				type, passes);
+			rc = -EIO;
+			break;
+		}
+		cond_resched();
 	} while (nr_rec);
 
 	mutex_unlock(&mds->event.log_lock);
-- 
2.43.0

